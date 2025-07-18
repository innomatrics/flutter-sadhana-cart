

// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// // import 'dart:html';
// // import 'dart:js' as js;
// //
// // class WebPayment extends StatefulWidget {
// //   const WebPayment({super.key});
// //
// //   @override
// //   _WebPaymentState createState() => _WebPaymentState();
// // }
// //
// // class _WebPaymentState extends State<WebPayment> {
// //   late Razorpay _razorpay;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _razorpay = Razorpay();
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
// //     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _razorpay.clear(); // Clear Razorpay instance when not needed
// //     super.dispose();
// //   }
// //
// //   void _handlePaymentSuccess(PaymentSuccessResponse response) {
// //     _showDialog(
// //       title: "Payment Successful",
// //       message: "Payment ID: ${response.paymentId}",
// //       isSuccess: true,
// //     );
// //   }
// //
// //   void _handlePaymentError(PaymentFailureResponse response) {
// //     _showDialog(
// //       title: "Payment Failed",
// //       message: "Error: ${response.message}",
// //       isSuccess: false,
// //     );
// //   }
// //
// //   void _handleExternalWallet(ExternalWalletResponse response) {
// //     _showDialog(
// //       title: "External Wallet Selected",
// //       message: "Wallet: ${response.walletName}",
// //       isSuccess: true,
// //     );
// //   }
// //
// //   void _openCheckout() async {
// //     var options = {
// //       'key': 'rzp_test_0JqfNU3fC2HG7Z', // Replace with your Razorpay key
// //       'amount': 10000, // Amount in paise (10000 = ₹100)
// //       'name': 'Sadhan Cart',
// //       'description': 'Payment for your order',
// //       'theme': {'color': '#ff2291'},
// //       'prefill': {
// //         'contact': '9999999999',
// //         'email': 'test@example.com',
// //       },
// //       'retry': {'enabled': true, 'max_count': 3},
// //     };
// //
// //     try {
// //       _razorpay.open(options);
// //     } catch (e) {
// //       debugPrint("Error: $e");
// //       _showDialog(
// //         title: "Error",
// //         message: "An error occurred while opening the payment gateway.",
// //         isSuccess: false,
// //       );
// //     }
// //   }
// //
// //   void openRazorpayCheckout() {
// //     final options = js.JsObject.jsify({
// //       'key': 'rzp_test_0JqfNU3fC2HG7Z',
// //       'amount': 10000,
// //       'name': 'Sadhana Cart',
// //       'description': 'Payment for your order',
// //       'handler': js.allowInterop((response) {
// //         window.alert('Payment Successful\nPayment ID: ${response['razorpay_payment_id']}');
// //       }),
// //       'prefill': {
// //         'contact': '9999999999',
// //         'email': 'test@example.com',
// //       }
// //     });
// //
// //     final rzp = js.JsObject(js.context['Razorpay'], [options]);
// //     rzp.callMethod('open');
// //   }
// //
// //   void _showDialog({required String title, required String message, required bool isSuccess}) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text(title),
// //         content: Text(message),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text("OK"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Payment Screen"),
// //         backgroundColor: Colors.deepOrange,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Text(
// //               "Make a Payment",
// //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 20),
// //             const Text(
// //               "Pay securely with Razorpay for your journey.",
// //               textAlign: TextAlign.center,
// //               style: TextStyle(fontSize: 16, color: Colors.grey),
// //             ),
// //             const SizedBox(height: 30),
// //             ElevatedButton(
// //               onPressed: kIsWeb ? openRazorpayCheckout : _openCheckout,
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.deepOrange,
// //                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //               ),
// //               child: const Text(
// //                 "Pay with Razorpay",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// /// Updating the ui





// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'dart:html';
// import 'dart:js' as js;

// class WebPayment extends StatefulWidget {
//   const WebPayment({super.key});

//   @override
//   _WebPaymentState createState() => _WebPaymentState();
// }

// class _WebPaymentState extends State<WebPayment> with SingleTickerProviderStateMixin {
//   late Razorpay _razorpay;
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );

//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );

//     _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     _controller.dispose();
//     super.dispose();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     _showDialog(
//       title: "Payment Successful",
//       message: "Payment ID: ${response.paymentId}",
//       isSuccess: true,
//     );
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     _showDialog(
//       title: "Payment Failed",
//       message: "Error: ${response.message}",
//       isSuccess: false,
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     _showDialog(
//       title: "External Wallet Selected",
//       message: "Wallet: ${response.walletName}",
//       isSuccess: true,
//     );
//   }

//   void _openCheckout() {
//     var options = {
//       'key': 'rzp_test_0JqfNU3fC2HG7Z',
//       'amount': 10000,
//       'name': 'Sadhana Cart',
//       'description': 'Payment for your order',
//       'theme': {'color': '#ff5722'},
//       'prefill': {
//         'contact': '9999999999',
//         'email': 'test@example.com',
//       },
//       'retry': {'enabled': true, 'max_count': 3},
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint("Error: $e");
//       _showDialog(
//         title: "Error",
//         message: "An error occurred while opening the payment gateway.",
//         isSuccess: false,
//       );
//     }
//   }

//   void openRazorpayCheckout() {
//     final options = js.JsObject.jsify({
//       'key': 'rzp_test_0JqfNU3fC2HG7Z',
//       'amount': 10000,
//       'name': 'Sadhana Cart',
//       'description': 'Payment for your order',
//       'handler': js.allowInterop((response) {
//         window.alert('Payment Successful\nPayment ID: ${response['razorpay_payment_id']}');
//       }),
//       'prefill': {
//         'contact': '9999999999',
//         'email': 'test@example.com',
//       }
//     });

//     final rzp = js.JsObject(js.context['Razorpay'], [options]);
//     rzp.callMethod('open');
//   }

//   void _showDialog({required String title, required String message, required bool isSuccess}) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isWeb = kIsWeb;

//     return Scaffold(
//       backgroundColor: Colors.deepOrange.shade100,


//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFFF7043), Color(0xFFFFAB91)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: SlideTransition(
//               position: _slideAnimation,
//               child: Container(
//                 constraints: const BoxConstraints(maxWidth: 500),
//                 padding: const EdgeInsets.all(30),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.white.withOpacity(0.3)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 20,
//                       spreadRadius: 5,
//                       offset: Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.payment, size: 60, color: Colors.white),
//                     const SizedBox(height: 20),
//                     const Text(
//                       "Secure Payment",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Pay securely with Razorpay for your journey.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                     const SizedBox(height: 30),
//                     ElevatedButton.icon(
//                       onPressed: isWeb ? openRazorpayCheckout : _openCheckout,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepOrange,
//                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 10,
//                         shadowColor: Colors.deepOrangeAccent,
//                       ),
//                       icon: const Icon(Icons.lock_open, color: Colors.white),
//                       label: const Text(
//                         "Pay with Razorpay",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
