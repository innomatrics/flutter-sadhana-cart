/// only footwear placing order successfully
library;

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
//
// class PaymentMethodSelectionScreen extends StatefulWidget {
//   final String productId;
//   final int quantity;
//
//   const PaymentMethodSelectionScreen({
//     Key? key,
//     required this.productId,
//     required this.quantity,
//   }) : super(key: key);
//
//   @override
//   State<PaymentMethodSelectionScreen> createState() => _PaymentMethodSelectionScreenState();
// }
//
// class _PaymentMethodSelectionScreenState extends State<PaymentMethodSelectionScreen>
//     with SingleTickerProviderStateMixin {
//   bool isLoading = false;
//   double opacity = 0.0;
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
//
//     Future.delayed(Duration(milliseconds: 300), () {
//       setState(() {
//         opacity = 1.0;
//       });
//       _controller.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _placeOrder(BuildContext context) async {
//     setState(() => isLoading = true);
//
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       String customerId = user.uid;
//
//       DocumentSnapshot customerSnapshot =
//       await FirebaseFirestore.instance.collection('customers').doc(customerId).get();
//
//       if (!customerSnapshot.exists || customerSnapshot['status'] != 'loggedIn') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       QuerySnapshot addressSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('addresses')
//           .orderBy('timestamp', descending: true)
//           .limit(1)
//           .get();
//
//       if (addressSnapshot.docs.isEmpty) {
//         _showSnackBar('Please add an address before placing order');
//         return;
//       }
//
//       Map<String, dynamic> addressDetails =
//       addressSnapshot.docs.first.data() as Map<String, dynamic>;
//
//       QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('orders')
//           .where('productId', isEqualTo: widget.productId)
//           .get();
//
//       if (orderSnapshot.docs.isNotEmpty) {
//         _showSnackBar('Product already ordered');
//         return;
//       }
//
//       QuerySnapshot sellersSnapshot =
//       await FirebaseFirestore.instance.collection('seller').get();
//
//       for (var sellerDoc in sellersSnapshot.docs) {
//         String sellerId = sellerDoc.id;
//         String category = 'Footwear';
//
//         DocumentReference productRef = FirebaseFirestore.instance
//             .collection('seller')
//             .doc(sellerId)
//             .collection(category)
//             .doc(widget.productId);
//
//         DocumentSnapshot productSnapshot = await productRef.get();
//
//         if (productSnapshot.exists) {
//           Map<String, dynamic> productInfo =
//           productSnapshot.data() as Map<String, dynamic>;
//
//           int currentQuantity = int.tryParse(
//               productInfo['productDetails']['Quantity'].toString()) ??
//               0;
//
//           if (currentQuantity < widget.quantity) {
//             _showSnackBar('Only $currentQuantity items available');
//             return;
//           }
//
//           await FirebaseFirestore.instance.runTransaction((transaction) async {
//             DocumentSnapshot updatedSnapshot = await transaction.get(productRef);
//             if (!updatedSnapshot.exists) return;
//
//             int updatedQuantity = int.tryParse(
//                 updatedSnapshot['productDetails']['Quantity'].toString()) ??
//                 0;
//
//             if (updatedQuantity >= widget.quantity) {
//               transaction.update(productRef, {
//                 'productDetails.Quantity':
//                 (updatedQuantity - widget.quantity).toString(),
//               });
//             } else {
//               throw Exception('Not enough stock available');
//             }
//           });
//
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(customerId)
//               .collection('orders')
//               .add({
//             'productId': widget.productId,
//             'name': productInfo['name'],
//             'brandName': productInfo['brandName'],
//             'category': category,
//             'description': productInfo['description'],
//             'images': productInfo['images'],
//             'videos': productInfo['videos'],
//             'Color': productInfo['productDetails']['Color'],
//             'Size': productInfo['productDetails']['Size'],
//             'Offer Price': productInfo['productDetails']['Offer Price'],
//             'Price': productInfo['productDetails']['Price'],
//             'shopName': productInfo['productDetails']['shopName'],
//             'addressDetails': addressDetails,
//             'paymentMethod': 'Cash on Delivery',
//             'quantity': widget.quantity,
//             'totalAmount': (int.tryParse(
//                 productInfo['productDetails']['Offer Price']?.toString() ??
//                     productInfo['productDetails']['Price'].toString()) ??
//                 0) *
//                 widget.quantity,
//             'timestamp': FieldValue.serverTimestamp(),
//           });
//
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(customerId)
//               .collection('cart')
//               .where('productId', isEqualTo: widget.productId)
//               .get()
//               .then((querySnapshot) {
//             for (var doc in querySnapshot.docs) {
//               doc.reference.delete();
//             }
//           });
//
//           _showSnackBar('Order placed successfully for ${widget.quantity} items');
//           Navigator.popUntil(context, (route) => route.isFirst);
//           return;
//         }
//       }
//
//       _showSnackBar('Product not found');
//     } catch (e) {
//       _showSnackBar('Failed to place order: $e');
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(16),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Select Payment Method'),
//       //   backgroundColor: Colors.deepPurple,
//       //   centerTitle: true,
//       //   elevation: 4,
//       // ),
//       appBar: AppBar(
//         title: Text(widget.productId),
//       ),
//       body: Stack(
//         children: [
//           AnimatedOpacity(
//             duration: Duration(milliseconds: 600),
//             opacity: opacity,
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildOptionCard(
//                       context,
//                       icon: Icons.payment,
//                       label: 'Pay Now (Coming Soon)',
//                       color: Colors.blueGrey.shade300,
//                       onTap: () {},
//                       enabled: false,
//                     ),
//                     SizedBox(height: 20),
//                     _buildOptionCard(
//                       context,
//                       icon: Icons.local_shipping,
//                       label: 'Cash on Delivery',
//                       color: Colors.deepPurple,
//                       onTap: () => _placeOrder(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.4),
//               child: Center(
//                 child: CircularProgressIndicator(color: Colors.deepPurple),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOptionCard(
//       BuildContext context, {
//         required IconData icon,
//         required String label,
//         required Color color,
//         required VoidCallback onTap,
//         bool enabled = true,
//       }) {
//     return GestureDetector(
//       onTap: enabled ? onTap : null,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//         padding: EdgeInsets.all(24),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: enabled ? color : Colors.grey.shade300,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 12,
//               offset: Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 28, color: Colors.white),
//             SizedBox(width: 20),
//             Expanded(
//               child: Text(
//                 label,
//                 style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
//               ),
//             ),
//             Icon(Icons.arrow_forward_ios, color: Colors.white70),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// updated to place all categories order successfull and ui not good

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Customer/pay_through_razor_pay.dart';
// import 'package:sadhana_cart/Web/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Web/Customer/pay_through_razor_pay.dart';
//
// class WebPaymentMethodSelectionScreen extends StatefulWidget {
//   final String productId;
//   final int quantity;
//   final String isShowCashonDelivery;
//   final String selledId;
//
//   const WebPaymentMethodSelectionScreen(
//       {super.key,
//       required this.productId,
//       required this.quantity,
//       required this.isShowCashonDelivery,
//       required this.selledId});
//
//   @override
//   State<WebPaymentMethodSelectionScreen> createState() =>
//       _WebPaymentMethodSelectionScreenState();
// }
//
// class _WebPaymentMethodSelectionScreenState
//     extends State<WebPaymentMethodSelectionScreen>
//     with SingleTickerProviderStateMixin {
//   bool isLoading = false;
//   double opacity = 0.0;
//   late AnimationController _controller;
//   final List<String> _categories = [
//     'Footwear',
//     'Clothing',
//     'Electronics',
//     'Accessories',
//     'Home Appliances',
//     'Books',
//     'Others'
//   ]; // Add all your categories here
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 800));
//
//     Future.delayed(const Duration(milliseconds: 300), () {
//       setState(() {
//         opacity = 1.0;
//       });
//       _controller.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _placeOrder(BuildContext context) async {
//     setState(() => isLoading = true);
//
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
//         );
//         return;
//       }
//
//       String customerId = user.uid;
//
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .get();
//
//       if (!customerSnapshot.exists ||
//           customerSnapshot['status'] != 'loggedIn') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
//         );
//         return;
//       }
//
//       QuerySnapshot addressSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('addresses')
//           .orderBy('timestamp', descending: true)
//           .limit(1)
//           .get();
//
//       if (addressSnapshot.docs.isEmpty) {
//         _showSnackBar('Please add an address before placing order');
//         return;
//       }
//
//       Map<String, dynamic> addressDetails =
//           addressSnapshot.docs.first.data() as Map<String, dynamic>;
//
//       QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('orders')
//           .where('productId', isEqualTo: widget.productId)
//           .get();
//
//       if (orderSnapshot.docs.isNotEmpty) {
//         _showSnackBar('Product already ordered');
//         return;
//       }
//
//       QuerySnapshot sellersSnapshot =
//           await FirebaseFirestore.instance.collection('seller').get();
//
//       bool productFound = false;
//       String foundCategory = '';
//       Map<String, dynamic>? productInfo;
//
//       // Search through all categories for all sellers
//       for (var sellerDoc in sellersSnapshot.docs) {
//         String sellerId = sellerDoc.id;
//
//         for (String category in _categories) {
//           DocumentReference productRef = FirebaseFirestore.instance
//               .collection('seller')
//               .doc(sellerId)
//               .collection(category)
//               .doc(widget.productId);
//
//           DocumentSnapshot productSnapshot = await productRef.get();
//
//           if (productSnapshot.exists) {
//             productInfo = productSnapshot.data() as Map<String, dynamic>;
//             foundCategory = category;
//             productFound = true;
//             break;
//           }
//         }
//         if (productFound) break;
//       }
//
//       if (!productFound || productInfo == null) {
//         _showSnackBar('Product not found in any category');
//         return;
//       }
//
//       // Check quantity
//       int currentQuantity =
//           int.tryParse(productInfo['productDetails']['Quantity'].toString()) ??
//               0;
//
//       if (currentQuantity < widget.quantity) {
//         _showSnackBar('Only $currentQuantity items available');
//         return;
//       }
//
//       // Process the order
//       DocumentReference productRef = FirebaseFirestore.instance
//           .collection('seller')
//           .doc(sellersSnapshot.docs.first.id) // Using first seller found
//           .collection(foundCategory)
//           .doc(widget.productId);
//
//       await FirebaseFirestore.instance.runTransaction((transaction) async {
//         DocumentSnapshot updatedSnapshot = await transaction.get(productRef);
//         if (!updatedSnapshot.exists) return;
//
//         int updatedQuantity = int.tryParse(
//                 updatedSnapshot['productDetails']['Quantity'].toString()) ??
//             0;
//
//         if (updatedQuantity >= widget.quantity) {
//           transaction.update(productRef, {
//             'productDetails.Quantity':
//                 (updatedQuantity - widget.quantity).toString(),
//           });
//         } else {
//           throw Exception('Not enough stock available');
//         }
//       });
//
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('orders')
//           .add({
//         'productId': widget.productId,
//         'name': productInfo['name'],
//         'brandName': productInfo['brandName'],
//         'category': foundCategory,
//         'description': productInfo['description'],
//         'images': productInfo['images'],
//         'videos': productInfo['videos'],
//         'Color': productInfo['productDetails']['Color'],
//         'Size': productInfo['productDetails']['Size'],
//         'Offer Price': productInfo['productDetails']['Offer Price'],
//         'Price': productInfo['productDetails']['Price'],
//         'isShowCashOnDelivery': productInfo['productDetails']
//             ['isShowCashOnDelivery'],
//         'status': 'pending',
//         'shopName': productInfo['productDetails']['shopName'],
//         'productSellerId': widget.selledId,
//         'addressDetails': addressDetails,
//         'paymentMethod': 'Cash on Delivery',
//         'quantity': widget.quantity,
//         'totalAmount': (int.tryParse(
//                     productInfo['productDetails']['Offer Price']?.toString() ??
//                         productInfo['productDetails']['Price'].toString()) ??
//                 0) *
//             widget.quantity,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .where('productId', isEqualTo: widget.productId)
//           .get()
//           .then((querySnapshot) {
//         for (var doc in querySnapshot.docs) {
//           doc.reference.delete();
//         }
//       });
//
//       _showSnackBar('Order placed successfully for ${widget.quantity} items');
//       Navigator.popUntil(context, (route) => route.isFirst);
//     } catch (e) {
//       _showSnackBar('Failed to place order: ${e.toString()}');
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Select Payment Method',
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//         elevation: 4,
//       ),
//       body: Stack(
//         children: [
//           AnimatedOpacity(
//             duration: const Duration(milliseconds: 600),
//             opacity: opacity,
//             child: Center(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // _buildOptionCard(
//                     //   context,
//                     //   icon: Icons.payment,
//                     //   label: 'Pay Now (Coming Soon)',
//                     //   color: Colors.blueGrey.shade300,
//                     //   onTap: () {},
//                     //   enabled: false,
//                     // ),
//
//                     _buildOptionCard(
//                       context,
//                       icon: Icons.payment,
//                       label: 'Pay Now',
//                       color: Colors.blueGrey.shade300,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const WebPayment()),
//                         );
//                       },
//                       enabled: true, // Changed to true to make it clickable
//                     ),
//                     const SizedBox(height: 20),
//                     // widget.isShowCashonDelivery == "Yes"
//                     //     ?
//                     widget.isShowCashonDelivery == "Yes"
//                         ? _buildOptionCard(
//                             context,
//                             icon: Icons.local_shipping,
//                             label: 'Cash on Delivery',
//                             color: Colors.deepPurple,
//                             onTap: () => _placeOrder(context),
//                           )
//                         : const SizedBox.shrink()
//                     // : const SizedBox.shrink()
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.4),
//               child: const Center(
//                 child: CircularProgressIndicator(color: Colors.deepPurple),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOptionCard(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//     bool enabled = true,
//   }) {
//     return GestureDetector(
//       onTap: enabled ? onTap : null,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//         padding: const EdgeInsets.all(24),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: enabled ? color : Colors.grey.shade300,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 28, color: Colors.white),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Text(
//                 label,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//             const Icon(Icons.arrow_forward_ios, color: Colors.white70),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// Updating ui

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/Web/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Web/Customer/pay_through_razor_pay.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sadhana_cart/Web/Customer/pay_through_razor_pay.dart';
// import 'package:sadhana_cart/Web/Customer/pay_through_razor_pay.dart';

class WebPaymentMethodSelectionScreen extends StatefulWidget {
  final String productId;
  final int quantity;
  final String isShowCashonDelivery;
  final String selledId;

  const WebPaymentMethodSelectionScreen({
    super.key,
    required this.productId,
    required this.quantity,
    required this.isShowCashonDelivery,
    required this.selledId,
  });

  @override
  State<WebPaymentMethodSelectionScreen> createState() =>
      _WebPaymentMethodSelectionScreenState();
}

class _WebPaymentMethodSelectionScreenState
    extends State<WebPaymentMethodSelectionScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final List<String> _categories = [
    'Footwear',
    'Clothing',
    'Electronics',
    'Accessories',
    'Home Appliances',
    'Books',
    'Others'
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  //
  // Future<void> _placeOrder(BuildContext context) async {
  //   setState(() => isLoading = true);
  //
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
  //       );
  //       return;
  //     }
  //
  //     String customerId = user.uid;
  //
  //     DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .get();
  //
  //     if (!customerSnapshot.exists ||
  //         customerSnapshot['status'] != 'loggedIn') {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
  //       );
  //       return;
  //     }
  //
  //     QuerySnapshot addressSnapshot = await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .collection('addresses')
  //         .orderBy('timestamp', descending: true)
  //         .limit(1)
  //         .get();
  //
  //     if (addressSnapshot.docs.isEmpty) {
  //       _showSnackBar('Please add an address before placing order');
  //       return;
  //     }
  //
  //     Map<String, dynamic> addressDetails =
  //     addressSnapshot.docs.first.data() as Map<String, dynamic>;
  //
  //     QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .collection('orders')
  //         .where('productId', isEqualTo: widget.productId)
  //         .get();
  //
  //     if (orderSnapshot.docs.isNotEmpty) {
  //       _showSnackBar('Product already ordered');
  //       return;
  //     }
  //
  //     QuerySnapshot sellersSnapshot =
  //     await FirebaseFirestore.instance.collection('seller').get();
  //
  //     bool productFound = false;
  //     String foundCategory = '';
  //     Map<String, dynamic>? productInfo;
  //
  //     for (var sellerDoc in sellersSnapshot.docs) {
  //       String sellerId = sellerDoc.id;
  //
  //       for (String category in _categories) {
  //         DocumentReference productRef = FirebaseFirestore.instance
  //             .collection('seller')
  //             .doc(sellerId)
  //             .collection(category)
  //             .doc(widget.productId);
  //
  //         DocumentSnapshot productSnapshot = await productRef.get();
  //
  //         if (productSnapshot.exists) {
  //           productInfo = productSnapshot.data() as Map<String, dynamic>;
  //           foundCategory = category;
  //           productFound = true;
  //           break;
  //         }
  //       }
  //       if (productFound) break;
  //     }
  //
  //     if (!productFound || productInfo == null) {
  //       _showSnackBar('Product not found in any category');
  //       return;
  //     }
  //
  //     int currentQuantity =
  //         int.tryParse(productInfo['productDetails']['Quantity'].toString()) ??
  //             0;
  //
  //     if (currentQuantity < widget.quantity) {
  //       _showSnackBar('Only $currentQuantity items available');
  //       return;
  //     }
  //
  //     DocumentReference productRef = FirebaseFirestore.instance
  //         .collection('seller')
  //         .doc(sellersSnapshot.docs.first.id)
  //         .collection(foundCategory)
  //         .doc(widget.productId);
  //
  //     await FirebaseFirestore.instance.runTransaction((transaction) async {
  //       DocumentSnapshot updatedSnapshot = await transaction.get(productRef);
  //       if (!updatedSnapshot.exists) return;
  //
  //       int updatedQuantity = int.tryParse(
  //           updatedSnapshot['productDetails']['Quantity'].toString()) ??
  //           0;
  //
  //       if (updatedQuantity >= widget.quantity) {
  //         transaction.update(productRef, {
  //           'productDetails.Quantity':
  //           (updatedQuantity - widget.quantity).toString(),
  //         });
  //       } else {
  //         throw Exception('Not enough stock available');
  //       }
  //     });
  //
  //     await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .collection('orders')
  //         .add({
  //       'productId': widget.productId,
  //       'name': productInfo['name'],
  //       'brandName': productInfo['brandName'],
  //       'category': foundCategory,
  //       'description': productInfo['description'],
  //       'images': productInfo['images'],
  //       'videos': productInfo['videos'],
  //       'Color': productInfo['productDetails']['Color'],
  //       'Size': productInfo['productDetails']['Size'],
  //       'Offer Price': productInfo['productDetails']['Offer Price'],
  //       'Price': productInfo['productDetails']['Price'],
  //       'isShowCashOnDelivery': productInfo['productDetails']
  //       ['isShowCashOnDelivery'],
  //       'status': 'pending',
  //       'shopName': productInfo['productDetails']['shopName'],
  //       'productSellerId': widget.selledId,
  //       'addressDetails': addressDetails,
  //       'paymentMethod': 'Cash on Delivery',
  //       'quantity': widget.quantity,
  //       'totalAmount': (int.tryParse(
  //           productInfo['productDetails']['Offer Price']?.toString() ??
  //               productInfo['productDetails']['Price'].toString()) ??
  //           0) *
  //           widget.quantity,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //
  //     await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .collection('cart')
  //         .where('productId', isEqualTo: widget.productId)
  //         .get()
  //         .then((querySnapshot) {
  //       for (var doc in querySnapshot.docs) {
  //         doc.reference.delete();
  //       }
  //     });
  //
  //     _showSnackBar('Order placed successfully for ${widget.quantity} items');
  //     Navigator.popUntil(context, (route) => route.isFirst);
  //   } catch (e) {
  //     _showSnackBar('Failed to place order: ${e.toString()}');
  //   } finally {
  //     setState(() => isLoading = false);
  //   }
  // }

  // order id is storing

  // Future<void> _placeOrder(BuildContext context) async {
  //   setState(() => isLoading = true);
  //
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
  //       );
  //       return;
  //     }
  //
  //     String customerId = user.uid;
  //
  //     DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .get();
  //
  //     if (!customerSnapshot.exists || customerSnapshot['status'] != 'loggedIn') {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
  //       );
  //       return;
  //     }
  //
  //     QuerySnapshot addressSnapshot = await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .collection('addresses')
  //         .orderBy('timestamp', descending: true)
  //         .limit(1)
  //         .get();
  //
  //     if (addressSnapshot.docs.isEmpty) {
  //       _showSnackBar('Please add an address before placing order');
  //       return;
  //     }
  //
  //     Map<String, dynamic> addressDetails =
  //     addressSnapshot.docs.first.data() as Map<String, dynamic>;
  //
  //     QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .collection('orders')
  //         .where('productId', isEqualTo: widget.productId)
  //         .get();
  //
  //     if (orderSnapshot.docs.isNotEmpty) {
  //       _showSnackBar('Product already ordered');
  //       return;
  //     }
  //
  //     QuerySnapshot sellersSnapshot =
  //     await FirebaseFirestore.instance.collection('seller').get();
  //
  //     bool productFound = false;
  //     String foundCategory = '';
  //     Map<String, dynamic>? productInfo;
  //
  //     // Search through all categories for all sellers
  //     for (var sellerDoc in sellersSnapshot.docs) {
  //       String sellerId = sellerDoc.id;
  //
  //       for (String category in _categories) {
  //         DocumentReference productRef = FirebaseFirestore.instance
  //             .collection('seller')
  //             .doc(sellerId)
  //             .collection(category)
  //             .doc(widget.productId);
  //
  //         DocumentSnapshot productSnapshot = await productRef.get();
  //
  //         if (productSnapshot.exists) {
  //           productInfo = productSnapshot.data() as Map<String, dynamic>;
  //           foundCategory = category;
  //           productFound = true;
  //           break;
  //         }
  //       }
  //       if (productFound) break;
  //     }
  //
  //     if (!productFound || productInfo == null) {
  //       _showSnackBar('Product not found in any category');
  //       return;
  //     }
  //
  //     // Check quantity
  //     int currentQuantity =
  //         int.tryParse(productInfo['productDetails']['Quantity'].toString()) ?? 0;
  //
  //     if (currentQuantity < widget.quantity) {
  //       _showSnackBar('Only $currentQuantity items available');
  //       return;
  //     }
  //
  //     // Generate a unique order ID
  //     String orderId = FirebaseFirestore.instance.collection('orders').doc().id;
  //
  //     // Process the order
  //     DocumentReference productRef = FirebaseFirestore.instance
  //         .collection('seller')
  //         .doc(sellersSnapshot.docs.first.id) // Using first seller found
  //         .collection(foundCategory)
  //         .doc(widget.productId);
  //
  //     await FirebaseFirestore.instance.runTransaction((transaction) async {
  //       DocumentSnapshot updatedSnapshot = await transaction.get(productRef);
  //       if (!updatedSnapshot.exists) return;
  //
  //       int updatedQuantity = int.tryParse(
  //           updatedSnapshot['productDetails']['Quantity'].toString()) ??
  //           0;
  //
  //       if (updatedQuantity >= widget.quantity) {
  //         transaction.update(productRef, {
  //           'productDetails.Quantity':
  //           (updatedQuantity - widget.quantity).toString(),
  //         });
  //       } else {
  //         throw Exception('Not enough stock available');
  //       }
  //     });
  //
  //     // Create the order document with the generated orderId
  //     DocumentReference orderRef = FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .collection('orders')
  //         .doc(orderId);
  //
  //     await orderRef.set({
  //       'orderId': orderId, // Store the order ID in the document
  //       'productId': widget.productId,
  //       'name': productInfo['name'],
  //       'brandName': productInfo['brandName'],
  //       'expectedDelivery': productInfo['expectedDelivery'],
  //       'category': foundCategory,
  //       'description': productInfo['description'],
  //       'images': productInfo['images'],
  //       'videos': productInfo['videos'],
  //       'Color': productInfo['productDetails']['Color'],
  //       'Size': productInfo['productDetails']['Size'],
  //       'Offer Price': productInfo['productDetails']['Offer Price'],
  //       'Price': productInfo['productDetails']['Price'],
  //       'isShowCashOnDelivery': productInfo['productDetails']
  //       ['isShowCashOnDelivery'],
  //       'status': 'pending',
  //       'shopName': productInfo['productDetails']['shopName'],
  //       'productSellerId': widget.selledId,
  //       'addressDetails': addressDetails,
  //       'paymentMethod': 'Cash on Delivery',
  //       'quantity': widget.quantity,
  //       'totalAmount': (int.tryParse(
  //           productInfo['productDetails']['Offer Price']?.toString() ??
  //               productInfo['productDetails']['Price'].toString()) ??
  //           0) *
  //           widget.quantity,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //
  //     await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .collection('cart')
  //         .where('productId', isEqualTo: widget.productId)
  //         .get()
  //         .then((querySnapshot) {
  //       for (var doc in querySnapshot.docs) {
  //         doc.reference.delete();
  //       }
  //     });
  //
  //     _showSnackBar('Order placed successfully for ${widget.quantity} items');
  //     Navigator.popUntil(context, (route) => route.isFirst);
  //   } catch (e) {
  //     _showSnackBar('Failed to place order: ${e.toString()}');
  //   } finally {
  //     setState(() => isLoading = false);
  //   }
  // }

  // order id and customer id also storing

  Future<void> _placeOrder(BuildContext context) async {
    setState(() => isLoading = true);

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const WebCustomerSigninScreen()),
        );
        return;
      }

      String customerId = user.uid;

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .get();

      if (!customerSnapshot.exists ||
          customerSnapshot['status'] != 'loggedIn') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const WebCustomerSigninScreen()),
        );
        return;
      }

      QuerySnapshot addressSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('addresses')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (addressSnapshot.docs.isEmpty) {
        _showSnackBar('Please add an address before placing order');
        return;
      }

      Map<String, dynamic> addressDetails =
          addressSnapshot.docs.first.data() as Map<String, dynamic>;

      QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('orders')
          .where('productId', isEqualTo: widget.productId)
          .get();

      if (orderSnapshot.docs.isNotEmpty) {
        _showSnackBar('Product already ordered');
        return;
      }

      QuerySnapshot sellersSnapshot =
          await FirebaseFirestore.instance.collection('seller').get();

      bool productFound = false;
      String foundCategory = '';
      Map<String, dynamic>? productInfo;

      // Search through all categories for all sellers
      for (var sellerDoc in sellersSnapshot.docs) {
        String sellerId = sellerDoc.id;

        for (String category in _categories) {
          DocumentReference productRef = FirebaseFirestore.instance
              .collection('seller')
              .doc(sellerId)
              .collection(category)
              .doc(widget.productId);

          DocumentSnapshot productSnapshot = await productRef.get();

          if (productSnapshot.exists) {
            productInfo = productSnapshot.data() as Map<String, dynamic>;
            foundCategory = category;
            productFound = true;
            break;
          }
        }
        if (productFound) break;
      }

      if (!productFound || productInfo == null) {
        _showSnackBar('Product not found in any category');
        return;
      }

      // Check quantity
      int currentQuantity =
          int.tryParse(productInfo['productDetails']['Quantity'].toString()) ??
              0;

      if (currentQuantity < widget.quantity) {
        _showSnackBar('Only $currentQuantity items available');
        return;
      }

      // Generate a unique order ID
      String orderId = FirebaseFirestore.instance.collection('orders').doc().id;

      // Process the order
      DocumentReference productRef = FirebaseFirestore.instance
          .collection('seller')
          .doc(sellersSnapshot.docs.first.id) // Using first seller found
          .collection(foundCategory)
          .doc(widget.productId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot updatedSnapshot = await transaction.get(productRef);
        if (!updatedSnapshot.exists) return;

        int updatedQuantity = int.tryParse(
                updatedSnapshot['productDetails']['Quantity'].toString()) ??
            0;

        if (updatedQuantity >= widget.quantity) {
          transaction.update(productRef, {
            'productDetails.Quantity':
                (updatedQuantity - widget.quantity).toString(),
          });
        } else {
          throw Exception('Not enough stock available');
        }
      });

      // Create the order document with the generated orderId
      DocumentReference orderRef = FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('orders')
          .doc(orderId);

      await orderRef.set({
        'orderId': orderId, // Store the order ID in the document
        'customerId': customerId, // Store the customer ID in the document
        'productId': widget.productId,
        'name': productInfo['name'],
        'brandName': productInfo['brandName'],
        'expectedDelivery': productInfo['expectedDelivery'],
        'category': foundCategory,
        'description': productInfo['description'],
        'images': productInfo['images'],
        'videos': productInfo['videos'],
        'Color': productInfo['productDetails']['Color'],
        'Size': productInfo['productDetails']['Size'],
        'Offer Price': productInfo['productDetails']['Offer Price'],
        'Price': productInfo['productDetails']['Price'],
        'isShowCashOnDelivery': productInfo['productDetails']
            ['isShowCashOnDelivery'],
        'status': 'pending',
        'shopName': productInfo['productDetails']['shopName'],
        'productSellerId': widget.selledId,
        'addressDetails': addressDetails,
        'paymentMethod': 'Cash on Delivery',
        'quantity': widget.quantity,
        'totalAmount': (int.tryParse(
                    productInfo['productDetails']['Offer Price']?.toString() ??
                        productInfo['productDetails']['Price'].toString()) ??
                0) *
            widget.quantity,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('cart')
          .where('productId', isEqualTo: widget.productId)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });

      _showSnackBar('Order placed successfully for ${widget.quantity} items');
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      _showSnackBar('Failed to place order: ${e.toString()}');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // Background decoration
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepOrange.withOpacity(0.1),
              ),
            ),
          ),

          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepOrange.withOpacity(0.1),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width > 800 ? size.width * 0.15 : 24,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with back button
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.deepOrange,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Select Payment Method',
                          style: TextStyle(
                            fontSize: size.width > 600 ? 28 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Payment options with animations
                    AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 500),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            _buildPaymentOption(
                              context,
                              icon: Icons.payment_rounded,
                              title: 'Pay Now',
                              subtitle: 'Secure online payment',
                              color: Colors.deepOrange,
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   PageRouteBuilder(
                                //     pageBuilder: (context, animation, secondaryAnimation) =>
                                //     const WebPayment(),
                                //     transitionsBuilder:
                                //         (context, animation, secondaryAnimation, child) {
                                //       return FadeTransition(
                                //         opacity: animation,
                                //         child: child,
                                //       );
                                //     },
                                //   ),
                                // );
                              },
                            ),
                            const SizedBox(height: 20),
                            if (widget.isShowCashonDelivery == "Yes")
                              _buildPaymentOption(
                                context,
                                icon: Icons.local_shipping_rounded,
                                title: 'Cash on Delivery',
                                subtitle: 'Pay when you receive the product',
                                color: Colors.orange[800]!,
                                onTap: () => _placeOrder(context),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Additional info
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Summary',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange[800],
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildSummaryRow('Product ID:', widget.productId),
                              _buildSummaryRow(
                                  'Quantity:', '${widget.quantity}'),
                              _buildSummaryRow(
                                'Payment Options:',
                                widget.isShowCashonDelivery == "Yes"
                                    ? 'Online Payment & Cash on Delivery'
                                    : 'Online Payment Only',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Processing your order...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange[800],
            ),
          ),
        ],
      ),
    );
  }
}
