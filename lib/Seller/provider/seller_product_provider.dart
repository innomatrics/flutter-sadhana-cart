// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class SellerProductProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> _sellerOrders = [];
//   List<Map<String, dynamic>> _filteredOrders = [];
//   DateTime? _startDate;
//   DateTime? _endDate;
//
//   // Getters
//   List<Map<String, dynamic>> get allOrders => _sellerOrders;
//   List<Map<String, dynamic>> get filteredOrders => _filteredOrders;
//   DateTime? get startDate => _startDate;
//   DateTime? get endDate => _endDate;
//
//   // Order count by status
//   int get receivedCount =>
//       _sellerOrders.where((e) => e['status'] == 'recieved').length;
//   int get pendingCount =>
//       _sellerOrders.where((e) => e['status'] == 'pending').length;
//   int get shippedCount =>
//       _sellerOrders.where((e) => e['status'] == 'shipped').length;
//   int get canceledCount =>
//       _sellerOrders.where((e) => e['status'] == 'canceled').length;
//
//   // Filtered by status
//   List<Map<String, dynamic>> get filteredReceived =>
//       _filteredOrders.where((e) => e['status'] == 'recieved').toList();
//   List<Map<String, dynamic>> get filteredPending =>
//       _filteredOrders.where((e) => e['status'] == 'pending').toList();
//   List<Map<String, dynamic>> get filteredShipped =>
//       _filteredOrders.where((e) => e['status'] == 'shipped').toList();
//   List<Map<String, dynamic>> get filteredCanceled =>
//       _filteredOrders.where((e) => e['status'] == 'canceled').toList();
//
//   // Fetch orders for current seller
//   Future<void> fetchSellerOrders(BuildContext context) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;
//
//       final customerSnapshot =
//       await FirebaseFirestore.instance.collection('customers').get();
//       List<Map<String, dynamic>> tempOrders = [];
//
//       for (var customerDoc in customerSnapshot.docs) {
//         final orderSnapshot = await customerDoc.reference
//             .collection('orders')
//             .where('productSellerId', isEqualTo: user.uid)
//             .get();
//
//         tempOrders.addAll(orderSnapshot.docs.map((doc) => doc.data()));
//       }
//
//       _sellerOrders = tempOrders;
//       _filteredOrders = List.from(tempOrders);
//       notifyListeners();
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${e.toString()}')),
//         );
//       }
//     }
//   }
//
//   List<Map<String, dynamic>> filterOrdersByStatus(String status) {
//     return _filteredOrders.where((order) => order['status'] == status).toList();
//   }
//
//   // Filter by date
//   void filterByDate(DateTime start, DateTime end) {
//     _startDate = start;
//     _endDate = end;
//
//     _filteredOrders = _sellerOrders.where((order) {
//       if (order['timestamp'] == null) return false;
//
//       final date = (order['timestamp'] as Timestamp).toDate();
//       return date.isAfter(start.subtract(const Duration(days: 1))) &&
//           date.isBefore(end.add(const Duration(days: 1)));
//     }).toList();
//
//     notifyListeners();
//   }
//
//   // Pick Start Date
//   Future<void> pickStartDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _startDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//
//     if (picked != null) {
//       _startDate = picked;
//       if (_endDate != null && _endDate!.isBefore(picked)) {
//         _endDate = null;
//       }
//       if (_startDate != null && _endDate != null) {
//         filterByDate(_startDate!, _endDate!);
//       }
//       notifyListeners();
//     }
//   }
//
//   // Pick End Date
//   Future<void> pickEndDate(BuildContext context) async {
//     if (_startDate == null) return;
//
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _endDate ?? _startDate!,
//       firstDate: _startDate!,
//       lastDate: DateTime.now(),
//     );
//
//     if (picked != null) {
//       _endDate = picked;
//       if (_startDate != null && _endDate != null) {
//         filterByDate(_startDate!, _endDate!);
//       }
//       notifyListeners();
//     }
//   }
//
//   // Reset filters
//   void resetFilters() {
//     _startDate = null;
//     _endDate = null;
//     _filteredOrders = List.from(_sellerOrders);
//     notifyListeners();
//   }
//
//   // Format timestamp to readable string
//   String formatTimestamp(Timestamp timestamp) {
//     final date = timestamp.toDate();
//     return DateFormat('dd/MM/yyyy, hh:mm a').format(date);
//   }
// }

// updated

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
      _sellerOrders.where((e) => e['status'] == 'Received').length;
  int get pendingCount =>
      _sellerOrders.where((e) => e['status'] == 'Pending').length;
  int get shippedCount =>
      _sellerOrders.where((e) => e['status'] == 'Shipped').length;
  int get canceledCount =>
      _sellerOrders.where((e) => e['status'] == 'Canceled').length;

  // Filtered by status
  List<Map<String, dynamic>> get filteredReceived =>
      _filteredOrders.where((e) => e['status'] == 'Received').toList();
  List<Map<String, dynamic>> get filteredPending =>
      _filteredOrders.where((e) => e['status'] == 'Pending').toList();
  List<Map<String, dynamic>> get filteredShipped =>
      _filteredOrders.where((e) => e['status'] == 'Shipped').toList();
  List<Map<String, dynamic>> get filteredCanceled =>
      _filteredOrders.where((e) => e['status'] == 'Canceled').toList();

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

  //changes status

  List<String> orderStatus = ['Received', 'Pending', 'Shipped', 'Canceled'];

  String? selectedStatus;

  void setSelectedStatus(String? status) {
    selectedStatus = status;
    notifyListeners();
  }

  Future<bool> sellerChangeOrderStatus({
    required BuildContext context,
    required String orderId,
    required String customerId,
    required String status,
  }) async {
    try {
      final DocumentReference orderRef = FirebaseFirestore.instance
          .collection("customers")
          .doc(customerId)
          .collection("orders")
          .doc(orderId);

      final DocumentSnapshot doc = await orderRef.get();
      if (doc.exists) {
        await orderRef.update({"status": status});
        final int index =
            _sellerOrders.indexWhere((e) => e['orderId'] == orderId);
        if (index != -1) {
          _sellerOrders[index]['status'] = status;
          _filteredOrders = _sellerOrders;
          notifyListeners();
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
      return false;
    }
  }

//widgets
  Widget statusDropDown(
      {required Size size,
      required String orderId,
      required String customerId,
      required bool isLoading}) {
    return Consumer<SellerProductProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Select Status",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.deepPurple, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.deepPurple, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              items: provider.orderStatus
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              value: provider.selectedStatus,
              onChanged: (value) {
                provider.setSelectedStatus(value);
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.07,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Colors.deepPurple,
                    width: 1.5,
                  ),
                ),
                onPressed: () async {
                  isLoading = true;
                  notifyListeners();
                  final bool isSuccess = await provider.sellerChangeOrderStatus(
                    context: context,
                    orderId: orderId,
                    customerId: customerId,
                    status: provider.selectedStatus!,
                  );

                  if (isSuccess) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Status updated successfully'),
                        ),
                      );
                      Navigator.pop(context);
                      isLoading = false;
                      notifyListeners();
                    }
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
