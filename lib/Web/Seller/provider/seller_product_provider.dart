import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellerProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _sellerOrders = [];
  List<Map<String, dynamic>> _filteredOrders = [];
  DateTime? _startDate;
  DateTime? _endDate;

  // Getters
  List<Map<String, dynamic>> get allOrders => _sellerOrders;
  List<Map<String, dynamic>> get filteredOrders => _filteredOrders;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  // Order count by status
  int get receivedCount =>
      _sellerOrders.where((e) => e['status'] == 'recieved').length;
  int get pendingCount =>
      _sellerOrders.where((e) => e['status'] == 'pending').length;
  int get shippedCount =>
      _sellerOrders.where((e) => e['status'] == 'shipped').length;
  int get canceledCount =>
      _sellerOrders.where((e) => e['status'] == 'canceled').length;

  // Filtered by status
  List<Map<String, dynamic>> get filteredReceived =>
      _filteredOrders.where((e) => e['status'] == 'recieved').toList();
  List<Map<String, dynamic>> get filteredPending =>
      _filteredOrders.where((e) => e['status'] == 'pending').toList();
  List<Map<String, dynamic>> get filteredShipped =>
      _filteredOrders.where((e) => e['status'] == 'shipped').toList();
  List<Map<String, dynamic>> get filteredCanceled =>
      _filteredOrders.where((e) => e['status'] == 'canceled').toList();

  // Fetch orders for current seller
  Future<void> fetchSellerOrders(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final customerSnapshot =
      await FirebaseFirestore.instance.collection('customers').get();
      List<Map<String, dynamic>> tempOrders = [];

      for (var customerDoc in customerSnapshot.docs) {
        final orderSnapshot = await customerDoc.reference
            .collection('orders')
            .where('productSellerId', isEqualTo: user.uid)
            .get();

        tempOrders.addAll(orderSnapshot.docs.map((doc) => doc.data()));
      }

      _sellerOrders = tempOrders;
      _filteredOrders = List.from(tempOrders);
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  List<Map<String, dynamic>> filterOrdersByStatus(String status) {
    return _filteredOrders.where((order) => order['status'] == status).toList();
  }

  // Filter by date
  void filterByDate(DateTime start, DateTime end) {
    _startDate = start;
    _endDate = end;

    _filteredOrders = _sellerOrders.where((order) {
      if (order['timestamp'] == null) return false;

      final date = (order['timestamp'] as Timestamp).toDate();
      return date.isAfter(start.subtract(const Duration(days: 1))) &&
          date.isBefore(end.add(const Duration(days: 1)));
    }).toList();

    notifyListeners();
  }

  // Pick Start Date
  Future<void> pickStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _startDate = picked;
      if (_endDate != null && _endDate!.isBefore(picked)) {
        _endDate = null;
      }
      if (_startDate != null && _endDate != null) {
        filterByDate(_startDate!, _endDate!);
      }
      notifyListeners();
    }
  }

  // Pick End Date
  Future<void> pickEndDate(BuildContext context) async {
    if (_startDate == null) return;

    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!,
      firstDate: _startDate!,
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _endDate = picked;
      if (_startDate != null && _endDate != null) {
        filterByDate(_startDate!, _endDate!);
      }
      notifyListeners();
    }
  }

  // Reset filters
  void resetFilters() {
    _startDate = null;
    _endDate = null;
    _filteredOrders = List.from(_sellerOrders);
    notifyListeners();
  }

  // Format timestamp to readable string
  String formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return DateFormat('dd/MM/yyyy, hh:mm a').format(date);
  }
}
