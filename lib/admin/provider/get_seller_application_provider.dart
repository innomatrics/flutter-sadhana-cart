import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetSellerApplicationProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _listofApplications = [];
  final Map<String, List<Map<String, dynamic>>> _filteredByStatus = {
    'pending': [],
    'approved': [],
    'rejected': [],
  };

  List<Map<String, dynamic>> get listofApplications => _listofApplications;
  List<Map<String, dynamic>> get filterPending => _filteredByStatus['pending']!;
  List<Map<String, dynamic>> get filterAccepted =>
      _filteredByStatus['approved']!;
  List<Map<String, dynamic>> get filterRejected =>
      _filteredByStatus['rejected']!;

  Future<List<Map<String, dynamic>>> fetchAllRequests(
      {required BuildContext context}) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('seller').get();
      _listofApplications.clear();
      _listofApplications.addAll(
        snapshot.docs.map((e) => e.data()),
      );

      // to Clear old filtered lists
      for (var key in _filteredByStatus.keys) {
        _filteredByStatus[key] = [];
      }

      // to Categorize applications
      for (var app in _listofApplications) {
        final status = (app['status'] ?? '').toString().toLowerCase();
        if (_filteredByStatus.containsKey(status)) {
          _filteredByStatus[status]!.add(app);
        }
      }
      notifyListeners();
    } on FirebaseException catch (e) {
      if (context.mounted) _showError(context, e.message);
    } catch (e) {
      if (context.mounted) _showError(context, e.toString());
    }

    return _listofApplications;
  }

  Future<List<Map<String, dynamic>>> getApplicationsByStatus(
      String status) async {
    final key = status.toLowerCase();
    return _filteredByStatus[key] ?? [];
  }

  void _showError(BuildContext context, String? message) {
    if (context.mounted && message != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
