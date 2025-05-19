import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    _cartItems.add(product);
    notifyListeners(); // Notify listeners to update the UI
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners(); // Notify listeners to update the UI
  }
}