import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/orders_list_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Orders')),
        body: const Center(child: Text('Please do order.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: OrdersList(userId: user.uid),
    );
  }
}

