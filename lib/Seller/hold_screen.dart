import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Seller/seller_bottom_nav_layout.dart';
import 'package:sadhana_cart/Seller/seller_registration_screen.dart';

class HoldScreen extends StatefulWidget {
  const HoldScreen({super.key});

  @override
  _HoldScreenState createState() => _HoldScreenState();
}

class _HoldScreenState extends State<HoldScreen> {
  late StreamSubscription<DocumentSnapshot> _subscription;
  late User _user;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });
      _listenForStatusUpdates();
    } else {
      // Handle the case where the user is not logged in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user logged in.')),
      );
      Navigator.pop(context); // Go back to the previous screen
    }
  }

  void _listenForStatusUpdates() {
    _subscription = FirebaseFirestore.instance
        .collection('seller')
        .doc(_user.uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final status = snapshot['status'];
        if (status == 'approved') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
          );
        } else if (status == 'rejected') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SellerRegistrationScreen()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hold Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your request is sent to the admin.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Admin will review your details and approve or reject your request within 24 hours.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}