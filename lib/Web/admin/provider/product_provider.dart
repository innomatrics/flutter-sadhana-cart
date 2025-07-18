import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _allProducts = [];
  List<dynamic> _sellerName = [];
  List<Map<String, dynamic>> _productBySeller = [];
  List<Map<String, dynamic>> _allOrder = [];
  List<Map<String, dynamic>> _filterOrders = [];

  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  List<Map<String, dynamic>> get allOrder => _allOrder;
  List<Map<String, dynamic>> get filterOrders => _filterOrders;
  List<Map<String, dynamic>> get productBySeller => _productBySeller;
  List<Map<String, dynamic>> get allProducts => _allProducts;
  List<dynamic> get sellerName => _sellerName;

//order length
  int get recievedOrder =>
      _allOrder.where((e) => e['status'] == 'pending').toList().length;
  int get pendingOrder =>
      _allOrder.where((e) => e['status'] == 'recieved').toList().length;
  int get shippedOrder =>
      _allOrder.where((e) => e['status'] == 'shipped').toList().length;
  int get canceledOrder =>
      _allOrder.where((e) => e['status'] == 'canceled').toList().length;

  //functions

  Future<List<Map<String, dynamic>>> getAllSellerProducts(
      {required BuildContext context}) async {
    try {
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('seller');
      final QuerySnapshot querySnapshot = await collectionReference.get();

      _allProducts = querySnapshot.docs
          .map((e) => e.data() as Map<String, dynamic>)
          .toList();
      _sellerName = _allProducts.map((e) => e['name']).toList();
      notifyListeners();
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    return _allProducts;
  }

  Future<List<Map<String, dynamic>>> getProductsBySeller({
    required BuildContext context,
    required String sellerId,
  }) async {
    final List<Map<String, dynamic>> allProducts = [];
    try {
      final List<String> subCollections = [
        'Clothing',
        'Electronics',
        'Footwear',
        'Accessories',
        'Home Appliances',
        'Books',
        'Vegetables'
      ];

      final CollectionReference sellerRef =
          FirebaseFirestore.instance.collection('seller');

      for (final subcategory in subCollections) {
        final QuerySnapshot querySnapshot =
            await sellerRef.doc(sellerId).collection(subcategory).get();

        final products = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        allProducts.addAll(products);
      }

      _productBySeller = allProducts;

      notifyListeners();
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    return _productBySeller;
  }

  Future<bool> adminDeleteSellerProduct({
    required BuildContext context,
    required String productId,
  }) async {
    try {
      final List<String> subCollections = [
        'Clothing',
        'Electronics',
        'Footwear',
        'Accessories',
        'Home Appliances',
        'Books',
        'Vegetables'
      ];

      final sellerCollection = FirebaseFirestore.instance.collection('seller');
      final sellerDocs = await sellerCollection.get();

      for (final sellerDoc in sellerDocs.docs) {
        final sellerDocRef = sellerDoc.reference;

        for (final subCollection in subCollections) {
          final subCollectionRef = sellerDocRef.collection(subCollection);

          final querySnapshot = await subCollectionRef
              .where('productId', isEqualTo: productId)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            for (final doc in querySnapshot.docs) {
              await doc.reference.delete();
            }

            // Remove from in-memory lists
            _allProducts
                .removeWhere((product) => product['productId'] == productId);
            _productBySeller
                .removeWhere((product) => product['productId'] == productId);

            notifyListeners();
            return true;
          }
        }
      }

      // If no document was found
      return false;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Firebase error')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    return false;
  }

  Future<List<Map<String, dynamic>>> getOrders(
      {required BuildContext context}) async {
    try {
      final customerCollection =
          FirebaseFirestore.instance.collection('customers');
      final customerDocs = await customerCollection.get();

      List<QueryDocumentSnapshot> allOrders = [];

      for (final customerDoc in customerDocs.docs) {
        final ordersSnapshot =
            await customerDoc.reference.collection('orders').get();
        allOrders.addAll(ordersSnapshot.docs);
      }
      _allOrder =
          allOrders.map((e) => e.data() as Map<String, dynamic>).toList();
      _filterOrders = List<Map<String, dynamic>>.from(_allOrder);
      notifyListeners();
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    return _allOrder;
  }

  void filterOrdersbyDateTime(DateTime startDate, DateTime endDate) {
    if (_allOrder.isEmpty) return;

    if (startDate.isAfter(endDate)) {
      // If start is after end, return empty or show error
      _filterOrders = [];
      notifyListeners();
      return;
    }

    _filterOrders = _allOrder.where((order) {
      if (!order.containsKey('timestamp')) return false;

      try {
        final Timestamp timestamp = order['timestamp'];
        final orderDate = timestamp.toDate();

        return orderDate
                .isAfter(startDate.subtract(const Duration(seconds: 1))) &&
            orderDate.isBefore(endDate.add(const Duration(days: 1)));
      } catch (e) {
        return false;
      }
    }).toList();

    notifyListeners();
  }

  void pickStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _startDate = picked;
      notifyListeners();
    }
  }

  void pickEndDate(BuildContext context) async {
    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please pick a start date first")),
      );
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate!.add(const Duration(days: 1)),
      firstDate: _startDate!,
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _endDate = picked;
      filterOrdersbyDateTime(_startDate!, _endDate!);
      notifyListeners();
    }
  }

  void resetFilter() {
    _startDate = null;
    _endDate = null;
    _filterOrders = List<Map<String, dynamic>>.from(_allOrder);
    notifyListeners();
  }

  String formatTime({required Timestamp timestamp}) {
    final date = timestamp.toDate();
    final formatedDate = DateFormat("dd/MM/yyyy, HH:mm").format(date);
    return formatedDate;
  }
}
