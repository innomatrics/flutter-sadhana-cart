// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/customer_address_form.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
//
// class CartTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       // If the user is not logged in, show a message or navigate to the login screen
//       return Center(
//         child: Text(
//           'Please log in to view your cart',
//           style: TextStyle(fontSize: 18),
//         ),
//       );
//     }
//
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('customers')
//             .doc(user.uid)
//             .collection('cart')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text(
//                 'Your cart is empty',
//                 style: TextStyle(fontSize: 18),
//               ),
//             );
//           }
//
//           final cartItems = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               final product = cartItems[index].data() as Map<String, dynamic>;
//               return Container(
//                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Product Image and Details
//                     Row(
//                       children: [
//                         // Product Image
//                         if (product['images'] != null && product['images'].isNotEmpty)
//                           Image.network(
//                             product['images'][0],
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         SizedBox(width: 16),
//                         // Product Details
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 product['name'],
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 '₹${product['offerPrice']}',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.green,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     // Buttons for Delete and Place Order
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Delete Button
//                         ElevatedButton(
//                           onPressed: () async {
//                             // Remove the product from the cart
//                             await FirebaseFirestore.instance
//                                 .collection('customers')
//                                 .doc(user.uid)
//                                 .collection('cart')
//                                 .doc(cartItems[index].id)
//                                 .delete();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red, // Button color
//                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           ),
//                           child: Text(
//                             'Delete',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         // Place Order Button
//                         ElevatedButton(
//                           onPressed: () async {
//                             try {
//                               User? user = FirebaseAuth.instance.currentUser;
//                               if (user == null) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//                                 );
//                                 return;
//                               }
//
//                               String customerId = user.uid;
//
//                               // Fetch customer document
//                               DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//                                   .collection('customers')
//                                   .doc(customerId)
//                                   .get();
//
//                               if (!customerSnapshot.exists || customerSnapshot['status'] != 'loggedIn') {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//                                 );
//                                 return;
//                               }
//
//                               // Fetch all product IDs from the cart collection
//                               QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//                                   .collection('customers')
//                                   .doc(customerId)
//                                   .collection('cart')
//                                   .get();
//
//                               List<String> productIds = cartSnapshot.docs
//                                   .map((doc) => doc['productId'].toString())
//                                   .toList();
//
//                               print("Product IDs in cart: $productIds");
//
//                               // Navigate to Address Form Screen with the first productId
//                               if (productIds.isNotEmpty) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => AddressFormScreen(productId: productIds.first),
//                                   ),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('No products in cart')),
//                                 );
//                               }
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Failed to proceed: $e')),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           ),
//                           child: Text(
//                             'Place Order',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

/// good but not deleting the products products fronm the cart after order placing successfully
library;

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/customer_address_form.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
//
// class CartTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return Center(
//         child: Text(
//           'Please log in to view your cart',
//           style: TextStyle(fontSize: 18),
//         ),
//       );
//     }
//
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('customers')
//             .doc(user.uid)
//             .collection('cart')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text(
//                 'Your cart is empty',
//                 style: TextStyle(fontSize: 18),
//               ),
//             );
//           }
//
//           final cartItems = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               final product = cartItems[index].data() as Map<String, dynamic>;
//               final productDetails = product['productDetails'] ?? {};
//               final price = productDetails['Price'] ?? '0';
//               final offerPrice = productDetails['Offer Price'] ?? price; // Fallback to price if no offer
//
//               return Container(
//                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Product Image and Details
//                     Row(
//                       children: [
//                         // Product Image
//                         if (product['images'] != null && product['images'].isNotEmpty)
//                           Image.network(
//                             product['images'][0],
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         SizedBox(width: 16),
//                         // Product Details
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 product['name'] ?? 'No Name',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               // Price and Offer Price
//                               if (offerPrice != price)
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '₹$offerPrice',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       '₹$price',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                         decoration: TextDecoration.lineThrough,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               else
//                                 Text(
//                                   '₹$price',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               // SizedBox(height: 4),
//                               // if (productDetails['Size'] != null)
//                               //   Text(
//                               //     'Size: ${productDetails['Size']}',
//                               //     style: TextStyle(
//                               //       fontSize: 14,
//                               //       color: Colors.grey,
//                               //     ),
//                               //   ),
//                               // if (productDetails['Color'] != null)
//                               //   Text(
//                               //     'Color: ${productDetails['Color']}',
//                               //     style: TextStyle(
//                               //       fontSize: 14,
//                               //       color: Colors.grey,
//                               //     ),
//                               //   ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     // Buttons for Delete and Place Order
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Delete Button
//                         ElevatedButton(
//                           onPressed: () async {
//                             await FirebaseFirestore.instance
//                                 .collection('customers')
//                                 .doc(user.uid)
//                                 .collection('cart')
//                                 .doc(cartItems[index].id)
//                                 .delete();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           ),
//                           child: Text(
//                             'Delete',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         // Place Order Button
//                         ElevatedButton(
//                           onPressed: () => _proceedToCheckout(context, user.uid),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           ),
//                           child: Text(
//                             'Place Order',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> _proceedToCheckout(BuildContext context, String customerId) async {
//     try {
//       // Fetch customer document
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .get();
//
//       if (!customerSnapshot.exists || customerSnapshot['status'] != 'loggedIn') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Fetch all product IDs from the cart collection
//       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .get();
//
//       if (cartSnapshot.docs.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No products in cart')),
//         );
//         return;
//       }
//
//       // Navigate to Address Form Screen with the first productId
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AddressFormScreen(
//             productId: cartSnapshot.docs.first['productId'],
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to proceed: $e')),
//       );
//     }
//   }
// }

import 'dart:developer';

/// Everything is good but quantity increasing more then actual quantity

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/customer_address_form.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
//
// class CartTab extends StatelessWidget {
//   const CartTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return const Center(
//         child: Text(
//           'Please log in to view your cart',
//           style: TextStyle(fontSize: 18),
//         ),
//       );
//     }
//
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('customers')
//             .doc(user.uid)
//             .collection('cart')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Text(
//                 'Your cart is empty',
//                 style: TextStyle(fontSize: 18),
//               ),
//             );
//           }
//
//           final cartItems = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               final product = cartItems[index].data() as Map<String, dynamic>;
//               final productDetails = product['productDetails'] as Map<String, dynamic>? ?? {};
//
// // Handle prices that might be in productDetails or at top level
//               final priceString = (product['Price'] ?? productDetails['Price'])?.toString() ?? '0';
//               final offerPriceString = (product['Offer Price'] ?? productDetails['Offer Price'])?.toString() ?? priceString;
//
// // Remove commas from prices like "5,899" and convert to double
//               final price = double.tryParse(priceString.replaceAll(',', '')) ?? 0;
//               final offerPrice = double.tryParse(offerPriceString.replaceAll(',', '')) ?? price;
//
//               final quantity = product['quantity'] ?? 1;
//               final totalPrice = offerPrice * quantity;
//
//               return Container(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Product Image and Details
//                     Row(
//                       children: [
//                         // Product Image
//                         if (product['images'] != null &&
//                             product['images'].isNotEmpty)
//                           Image.network(
//                             product['images'][0],
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         const SizedBox(width: 16),
//                         // Product Details
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 product['name'] ?? 'No Name',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               if (offerPrice != price)
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '₹$offerPrice',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       '₹$price',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                         decoration: TextDecoration.lineThrough,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               else
//                                 Text(
//                                   '₹$price',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Total: ₹${offerPrice * quantity}',
//                                 style: const TextStyle(
//                                     fontSize: 14, color: Colors.black87),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Quantity Control and Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Quantity Buttons
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.remove_circle_outline),
//                               onPressed: () {
//                                 if (quantity > 1) {
//                                   FirebaseFirestore.instance
//                                       .collection('customers')
//                                       .doc(user.uid)
//                                       .collection('cart')
//                                       .doc(cartItems[index].id)
//                                       .update({'quantity': quantity - 1});
//                                 }
//                               },
//                             ),
//                             Text(
//                               quantity.toString(),
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.add_circle_outline),
//                               onPressed: () {
//                                 FirebaseFirestore.instance
//                                     .collection('customers')
//                                     .doc(user.uid)
//                                     .collection('cart')
//                                     .doc(cartItems[index].id)
//                                     .update({'quantity': quantity + 1});
//                               },
//                             ),
//                           ],
//                         ),
//
//                         // Delete Button
//                         ElevatedButton(
//                           onPressed: () async {
//                             await FirebaseFirestore.instance
//                                 .collection('customers')
//                                 .doc(user.uid)
//                                 .collection('cart')
//                                 .doc(cartItems[index].id)
//                                 .delete();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                           ),
//                           child: const Text(
//                             'Delete',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//
//                         // Place Order Button
//                         ElevatedButton(
//                           onPressed: () =>
//                               _proceedToCheckout(context, user.uid),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                           ),
//                           child: const Text(
//                             'Place Order',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   ///in cart screen order placing button not working
//
//
//   // Future<void> _proceedToCheckout(
//   //     BuildContext context, String customerId) async {
//   //   try {
//   //     // Fetch customer document
//   //     DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(customerId)
//   //         .get();
//   //
//   //     if (!customerSnapshot.exists ||
//   //         customerSnapshot['status'] != 'loggedIn') {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Fetch all products from the cart collection
//   //     QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(customerId)
//   //         .collection('cart')
//   //         .get();
//   //
//   //     if (cartSnapshot.docs.isEmpty) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('No products in cart')),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Get the first cart item with its quantity
//   //     final firstCartItem = cartSnapshot.docs.first;
//   //     final productId = firstCartItem['productId'];
//   //     final quantity = firstCartItem['quantity'] ?? 1;
//   //     final isShowCashOnDelivery =
//   //         firstCartItem['isShowCashOnDelivery'] ?? true;
//   //     final sellerId = firstCartItem['productSellerId'];
//   //     log(sellerId.toString());
//   //
//   //     // Navigate to Address Form Screen with both productId and quantity
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => AddressFormScreen(
//   //           productId: productId,
//   //           quantity: quantity, // Pass the quantity here
//   //           isShowCashOnDelivery: isShowCashOnDelivery,
//   //           sellerId: sellerId,
//   //         ),
//   //       ),
//   //     );
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to proceed: $e')),
//   //     );
//   //   }
//   // }
//
//
//   Future<void> _proceedToCheckout(
//       BuildContext context, String customerId) async {
//     try {
//       // Fetch all products from the cart collection
//       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .get();
//
//       if (cartSnapshot.docs.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No products in cart')),
//         );
//         return;
//       }
//
//       // Navigate to the product details screen using the first cart item
//       final firstCartItem = cartSnapshot.docs.first;
//       final productId = firstCartItem['productId']; // Ensure this key exists in cart items
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ParticularProductDetailsScreen(
//             productId: productId,
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to proceed: $e')),
//       );
//     }
//   }
//
// }
//


/// Fixing



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/customer_address_form.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
//
// class CartTab extends StatelessWidget {
//   const CartTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return const Center(
//         child: Text(
//           'Please log in to view your cart',
//           style: TextStyle(fontSize: 18),
//         ),
//       );
//     }
//
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('customers')
//             .doc(user.uid)
//             .collection('cart')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Text(
//                 'Your cart is empty',
//                 style: TextStyle(fontSize: 18),
//               ),
//             );
//           }
//
//           final cartItems = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               final product = cartItems[index].data() as Map<String, dynamic>;
//               final productDetails = product['productDetails'] as Map<String, dynamic>? ?? {};
//
//               // Handle prices
//               final priceString = (product['Price'] ?? productDetails['Price'])?.toString() ?? '0';
//               final offerPriceString = (product['Offer Price'] ?? productDetails['Offer Price'])?.toString() ?? priceString;
//               final price = double.tryParse(priceString.replaceAll(',', '')) ?? 0;
//               final offerPrice = double.tryParse(offerPriceString.replaceAll(',', '')) ?? price;
//
//               final quantity = product['quantity'] ?? 1;
//               final availableQuantity = int.tryParse((product['Quantity'] ?? productDetails['Quantity'] ?? '0').toString()) ?? 0;
//               final totalPrice = offerPrice * quantity;
//
//               return Container(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Product Image and Details (unchanged)
//                     Row(
//                       children: [
//                         if (product['images'] != null &&
//                             product['images'].isNotEmpty)
//                           Image.network(
//                             product['images'][0],
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 product['name'] ?? 'No Name',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               if (offerPrice != price)
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '₹$offerPrice',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       '₹$price',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                         decoration: TextDecoration.lineThrough,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               else
//                                 Text(
//                                   '₹$price',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Total: ₹${offerPrice * quantity}',
//                                 style: const TextStyle(
//                                     fontSize: 14, color: Colors.black87),
//                               ),
//                               Text(
//                                 'Available: $availableQuantity',
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Quantity Control and Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Quantity Buttons
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.remove_circle_outline),
//                               onPressed: () {
//                                 if (quantity > 1) {
//                                   FirebaseFirestore.instance
//                                       .collection('customers')
//                                       .doc(user.uid)
//                                       .collection('cart')
//                                       .doc(cartItems[index].id)
//                                       .update({'quantity': quantity - 1});
//                                 }
//                               },
//                             ),
//                             Text(
//                               quantity.toString(),
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.add_circle_outline),
//                               onPressed: () async {
//                                 if (quantity < availableQuantity) {
//                                   await FirebaseFirestore.instance
//                                       .collection('customers')
//                                       .doc(user.uid)
//                                       .collection('cart')
//                                       .doc(cartItems[index].id)
//                                       .update({'quantity': quantity + 1});
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text('Maximum available quantity reached'),
//                                       duration: Duration(seconds: 2),
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//
//                         // Delete Button
//                         ElevatedButton(
//                           onPressed: () async {
//                             await FirebaseFirestore.instance
//                                 .collection('customers')
//                                 .doc(user.uid)
//                                 .collection('cart')
//                                 .doc(cartItems[index].id)
//                                 .delete();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                           ),
//                           child: const Text(
//                             'Delete',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//
//                         // Place Order Button
//                         ElevatedButton(
//                           onPressed: () =>
//                               _proceedToCheckout(context, user.uid),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                           ),
//                           child: const Text(
//                             'Place Order',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   ///in cart screen order placing button not working
//
//
//   // Future<void> _proceedToCheckout(
//   //     BuildContext context, String customerId) async {
//   //   try {
//   //     // Fetch customer document
//   //     DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(customerId)
//   //         .get();
//   //
//   //     if (!customerSnapshot.exists ||
//   //         customerSnapshot['status'] != 'loggedIn') {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Fetch all products from the cart collection
//   //     QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(customerId)
//   //         .collection('cart')
//   //         .get();
//   //
//   //     if (cartSnapshot.docs.isEmpty) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('No products in cart')),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Get the first cart item with its quantity
//   //     final firstCartItem = cartSnapshot.docs.first;
//   //     final productId = firstCartItem['productId'];
//   //     final quantity = firstCartItem['quantity'] ?? 1;
//   //     final isShowCashOnDelivery =
//   //         firstCartItem['isShowCashOnDelivery'] ?? true;
//   //     final sellerId = firstCartItem['productSellerId'];
//   //     log(sellerId.toString());
//   //
//   //     // Navigate to Address Form Screen with both productId and quantity
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => AddressFormScreen(
//   //           productId: productId,
//   //           quantity: quantity, // Pass the quantity here
//   //           isShowCashOnDelivery: isShowCashOnDelivery,
//   //           sellerId: sellerId,
//   //         ),
//   //       ),
//   //     );
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to proceed: $e')),
//   //     );
//   //   }
//   // }
//
//
//   Future<void> _proceedToCheckout(
//       BuildContext context, String customerId) async {
//     try {
//       // Fetch all products from the cart collection
//       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .get();
//
//       if (cartSnapshot.docs.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No products in cart')),
//         );
//         return;
//       }
//
//       // Navigate to the product details screen using the first cart item
//       final firstCartItem = cartSnapshot.docs.first;
//       final productId = firstCartItem['productId']; // Ensure this key exists in cart items
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ParticularProductDetailsScreen(
//             productId: productId,
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to proceed: $e')),
//       );
//     }
//   }
//
// }


/// MI  place order issue



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/customer_address_form.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
//
// class CartTab extends StatefulWidget {
//   const CartTab({super.key});
//
//   @override
//   State<CartTab> createState() => _CartTabState();
// }
//
// class _CartTabState extends State<CartTab> {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return const Center(
//         child: Text(
//           'Please log in to view your cart',
//           style: TextStyle(fontSize: 18),
//         ),
//       );
//     }
//
//
//
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('customers')
//             .doc(user.uid)
//             .collection('cart')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Text(
//                 'Your cart is empty',
//                 style: TextStyle(fontSize: 18),
//               ),
//             );
//           }
//
//           final cartItems = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: cartItems.length,
//             itemBuilder: (context, index) {
//               final product = cartItems[index].data() as Map<String, dynamic>;
//               final productDetails = product['productDetails'] as Map<String, dynamic>? ?? {};
//
//               // Handle prices
//               final priceString = (product['Price'] ?? productDetails['Price'])?.toString() ?? '0';
//               final offerPriceString = (product['Offer Price'] ?? productDetails['Offer Price'])?.toString() ?? priceString;
//               final price = double.tryParse(priceString.replaceAll(',', '')) ?? 0;
//               final offerPrice = double.tryParse(offerPriceString.replaceAll(',', '')) ?? price;
//
//               final quantity = product['quantity'] ?? 1;
//               final availableQuantity = int.tryParse((product['Quantity'] ?? productDetails['Quantity'] ?? '0').toString()) ?? 0;
//               final totalPrice = offerPrice * quantity;
//
//               return Container(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Product Image and Details (unchanged)
//                     Row(
//                       children: [
//                         if (product['images'] != null &&
//                             product['images'].isNotEmpty)
//                           Image.network(
//                             product['images'][0],
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 product['name'] ?? 'No Name',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               if (offerPrice != price)
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '₹$offerPrice',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       '₹$price',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                         decoration: TextDecoration.lineThrough,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               else
//                                 Text(
//                                   '₹$price',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Total: ₹${offerPrice * quantity}',
//                                 style: const TextStyle(
//                                     fontSize: 14, color: Colors.black87),
//                               ),
//                               Text(
//                                 'Available: $availableQuantity',
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Quantity Control and Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Quantity Buttons
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.remove_circle_outline),
//                               onPressed: () {
//                                 if (quantity > 1) {
//                                   FirebaseFirestore.instance
//                                       .collection('customers')
//                                       .doc(user.uid)
//                                       .collection('cart')
//                                       .doc(cartItems[index].id)
//                                       .update({'quantity': quantity - 1});
//                                 }
//                               },
//                             ),
//                             Text(
//                               quantity.toString(),
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.add_circle_outline),
//                               onPressed: () async {
//                                 if (quantity < availableQuantity) {
//                                   await FirebaseFirestore.instance
//                                       .collection('customers')
//                                       .doc(user.uid)
//                                       .collection('cart')
//                                       .doc(cartItems[index].id)
//                                       .update({'quantity': quantity + 1});
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text('Maximum available quantity reached'),
//                                       duration: Duration(seconds: 2),
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//
//                         // Delete Button
//                         ElevatedButton(
//                           onPressed: () async {
//                             await FirebaseFirestore.instance
//                                 .collection('customers')
//                                 .doc(user.uid)
//                                 .collection('cart')
//                                 .doc(cartItems[index].id)
//                                 .delete();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                           ),
//                           child: const Text(
//                             'Delete',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//
//                         // Place Order Button
//                         ElevatedButton(
//                           onPressed: () =>
//                               _proceedToCheckout(context, user.uid),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                           ),
//                           child: const Text(
//                             'Place Order',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   ///in cart screen order placing button not working
//
//
//   // Future<void> _proceedToCheckout(
//   //     BuildContext context, String customerId) async {
//   //   try {
//   //     // Fetch customer document
//   //     DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(customerId)
//   //         .get();
//   //
//   //     if (!customerSnapshot.exists ||
//   //         customerSnapshot['status'] != 'loggedIn') {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Fetch all products from the cart collection
//   //     QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(customerId)
//   //         .collection('cart')
//   //         .get();
//   //
//   //     if (cartSnapshot.docs.isEmpty) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('No products in cart')),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Get the first cart item with its quantity
//   //     final firstCartItem = cartSnapshot.docs.first;
//   //     final productId = firstCartItem['productId'];
//   //     final quantity = firstCartItem['quantity'] ?? 1;
//   //     final isShowCashOnDelivery =
//   //         firstCartItem['isShowCashOnDelivery'] ?? true;
//   //     final sellerId = firstCartItem['productSellerId'];
//   //     log(sellerId.toString());
//   //
//   //     // Navigate to Address Form Screen with both productId and quantity
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => AddressFormScreen(
//   //           productId: productId,
//   //           quantity: quantity, // Pass the quantity here
//   //           isShowCashOnDelivery: isShowCashOnDelivery,
//   //           sellerId: sellerId,
//   //         ),
//   //       ),
//   //     );
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to proceed: $e')),
//   //     );
//   //   }
//   // }
//
//
//   Future<void> _proceedToCheckout(
//       BuildContext context, String customerId) async {
//     try {
//       // Fetch all products from the cart collection
//       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .get();
//
//       if (cartSnapshot.docs.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('No products in cart')),
//         );
//         return;
//       }
//
//       // Navigate to the product details screen using the first cart item
//       final firstCartItem = cartSnapshot.docs.first;
//       final productId = firstCartItem['productId']; // Ensure this key exists in cart items
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ParticularProductDetailsScreen(
//             productId: productId,
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to proceed: $e')),
//       );
//     }
//   }
// }
//



// Fixed place order issue



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/customer_address_form.dart';
import 'package:sadhana_cart/Customer/customer_signin.dart';
import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
import 'package:sadhana_cart/Web/Customer/particular_product_details_screen.dart';
class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(
        child: Text(
          'Please log in to view your cart',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customers')
            .doc(user.uid)
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final cartItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index].data() as Map<String, dynamic>;
              final productDetails = product['productDetails'] as Map<String, dynamic>? ?? {};
              final productId = cartItems[index].id;

              // Handle prices
              final priceString = (product['Price'] ?? productDetails['Price'])?.toString() ?? '0';
              final offerPriceString = (product['Offer Price'] ?? productDetails['Offer Price'])?.toString() ?? priceString;
              final price = double.tryParse(priceString.replaceAll(',', '')) ?? 0;
              final offerPrice = double.tryParse(offerPriceString.replaceAll(',', '')) ?? price;

              final quantity = product['quantity'] ?? 1;
              final availableQuantity = int.tryParse((product['Quantity'] ?? productDetails['Quantity'] ?? '0').toString()) ?? 0;
              final totalPrice = offerPrice * quantity;

              // Convert boolean to string if needed
              final cashOnDelivery = product['isShowCashOnDelivery'] ?? false;
              final cashOnDeliveryString = cashOnDelivery.toString();

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image and Details (unchanged)
                    Row(
                      children: [
                        if (product['images'] != null && product['images'].isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebParticularProductDetailsScreen(
                                    productId: productId,
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              product['images'][0],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebParticularProductDetailsScreen(
                                        productId: productId,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  product['name'] ?? 'No Name',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (offerPrice != price)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '₹$offerPrice',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '₹$price',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  '₹$price',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              const SizedBox(height: 4),
                              Text(
                                'Total: ₹${offerPrice * quantity}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                              Text(
                                'Available: $availableQuantity',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Quantity Control and Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Quantity Buttons (unchanged)
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                if (quantity > 1) {
                                  FirebaseFirestore.instance
                                      .collection('customers')
                                      .doc(user.uid)
                                      .collection('cart')
                                      .doc(cartItems[index].id)
                                      .update({'quantity': quantity - 1});
                                }
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () async {
                                if (quantity < availableQuantity) {
                                  await FirebaseFirestore.instance
                                      .collection('customers')
                                      .doc(user.uid)
                                      .collection('cart')
                                      .doc(cartItems[index].id)
                                      .update({'quantity': quantity + 1});
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Maximum available quantity reached'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),

                        // Delete Button (unchanged)
                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('customers')
                                .doc(user.uid)
                                .collection('cart')
                                .doc(cartItems[index].id)
                                .delete();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Place Order Button - Updated to pass correct types
                        ElevatedButton(
                          onPressed: () => _proceedToCheckout(
                            context,
                            user.uid,
                            productId,
                            cashOnDeliveryString, // Now passing as String
                            product['productSellerId'] ?? '',
                            quantity,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Text(
                            'Place Order',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _proceedToCheckout(
      BuildContext context,
      String customerId,
      String productId,
      String isShowCashOnDelivery, // Changed to String
      String sellerId,
      int quantity,
      ) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressFormScreen(
            productId: productId,
            quantity: quantity,
            isShowCashOnDelivery: isShowCashOnDelivery,
            sellerId: sellerId,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to proceed: $e')),
      );
    }
  }
}






