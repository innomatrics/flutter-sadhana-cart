// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'payment_method_screen.dart'; // Import the PaymentMethodScreen
//
// class PlaceOrderScreen extends StatefulWidget {
//   final Map<String, dynamic> product;
//
//   const PlaceOrderScreen({
//     required this.product,
//   });
//
//   @override
//   _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
// }
//
// class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _fullNameController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _pincodeController = TextEditingController();
//   final _stateController = TextEditingController();
//   final _cityController = TextEditingController();
//   String _addressType = 'Home';
//
//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneNumberController.dispose();
//     _addressController.dispose();
//     _pincodeController.dispose();
//     _stateController.dispose();
//     _cityController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _saveAddress() async {
//     if (_formKey.currentState!.validate()) {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
//
//         // Save the address details to Firestore
//         await userRef.collection('deliveryAddresses').add({
//           'fullName': _fullNameController.text,
//           'phoneNumber': _phoneNumberController.text,
//           'address': _addressController.text,
//           'pincode': _pincodeController.text,
//           'state': _stateController.text,
//           'city': _cityController.text,
//           'country': 'India',
//           'addressType': _addressType,
//           'createdAt': FieldValue.serverTimestamp(),
//         });
//
//         // Navigate to the PaymentMethodScreen and pass the product details
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => PaymentMethodScreen(
//               product: widget.product, // Pass the entire product
//               name: widget.product['name'],
//               image: widget.product['images'] != null && widget.product['images'].isNotEmpty
//                   ? widget.product['images'][0]
//                   : null,
//               brandName: widget.product['brandName'],
//               price: widget.product['productDetails']?['Price'] ?? 'N/A',
//               offerPrice: widget.product['productDetails']?['OfferPrice'] ?? 'N/A',
//               quantity: widget.product['productDetails']?['Quantity'] ?? 'N/A',
//             ),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Fetch the first image URL from the product's images list
//     final imageUrl = widget.product['images'] != null && widget.product['images'].isNotEmpty
//         ? widget.product['images'][0]
//         : null;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Place Order'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             if (imageUrl != null)
//               Container(
//                 height: 200, // Set a fixed height for the image
//                 width: double.infinity, // Take full width
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   image: DecorationImage(
//                     image: NetworkImage(imageUrl),
//                     fit: BoxFit.cover, // Ensure the image fits the container
//                   ),
//                 ),
//               ),
//             SizedBox(height: 16),
//
//             // Brand Name
//             Text(
//               widget.product['brandName'],
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[700],
//               ),
//             ),
//             SizedBox(height: 4),
//
//             // Product Name
//             Text(
//               widget.product['name'],
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//
//             // Prices
//             Row(
//               children: [
//                 Text(
//                   '₹${widget.product['productDetails']?['OfferPrice'] ?? 'N/A'}', // Fetch from productDetails
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   '₹${widget.product['productDetails']?['Price'] ?? 'N/A'}', // Fetch from productDetails
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.red,
//                     decoration: TextDecoration.lineThrough, // Strike-through effect
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   '₹${widget.product['productDetails']?['Quantity'] ?? 'N/A'}', // Fetch from productDetails
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             // Address Form
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _fullNameController,
//                     decoration: InputDecoration(labelText: 'Full Name'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your full name';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _phoneNumberController,
//                     decoration: InputDecoration(labelText: 'Phone Number'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your phone number';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _addressController,
//                     decoration: InputDecoration(labelText: 'Address'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your address';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _pincodeController,
//                     decoration: InputDecoration(labelText: 'Pincode'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your pincode';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _stateController,
//                     decoration: InputDecoration(labelText: 'State'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your state';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _cityController,
//                     decoration: InputDecoration(labelText: 'City'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your city';
//                       }
//                       return null;
//                     },
//                   ),
//                   DropdownButtonFormField<String>(
//                     value: _addressType,
//                     decoration: InputDecoration(labelText: 'Address Type'),
//                     items: ['Home', 'Work'].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _addressType = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _saveAddress,
//                     child: Text('Continue'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// testing


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'payment_method_screen.dart'; // Import the PaymentMethodScreen
//
// class PlaceOrderScreen extends StatefulWidget {
//   final Map<String, dynamic> product;
//
//   const PlaceOrderScreen({
//     required this.product,
//   });
//
//   @override
//   _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
// }
//
// class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _fullNameController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _pincodeController = TextEditingController();
//   final _stateController = TextEditingController();
//   final _cityController = TextEditingController();
//   String _addressType = 'Home';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPreviousAddress();
//   }
//
//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneNumberController.dispose();
//     _addressController.dispose();
//     _pincodeController.dispose();
//     _stateController.dispose();
//     _cityController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _fetchPreviousAddress() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
//       final querySnapshot = await userRef.collection('deliveryAddresses').orderBy('createdAt', descending: true).limit(1).get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         final lastAddress = querySnapshot.docs.first.data();
//         setState(() {
//           _fullNameController.text = lastAddress['fullName'];
//           _phoneNumberController.text = lastAddress['phoneNumber'];
//           _addressController.text = lastAddress['address'];
//           _pincodeController.text = lastAddress['pincode'];
//           _stateController.text = lastAddress['state'];
//           _cityController.text = lastAddress['city'];
//           _addressType = lastAddress['addressType'] ?? 'Home';
//         });
//       }
//     }
//   }
//
//   Future<void> _saveAddress() async {
//     if (_formKey.currentState!.validate()) {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
//
//         await userRef.collection('deliveryAddresses').add({
//           'fullName': _fullNameController.text,
//           'phoneNumber': _phoneNumberController.text,
//           'address': _addressController.text,
//           'pincode': _pincodeController.text,
//           'state': _stateController.text,
//           'city': _cityController.text,
//           'country': 'India',
//           'addressType': _addressType,
//           'createdAt': FieldValue.serverTimestamp(),
//         });
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => PaymentMethodScreen(
//               product: widget.product,
//               name: widget.product['name'],
//               image: widget.product['images'] != null && widget.product['images'].isNotEmpty
//                   ? widget.product['images'][0]
//                   : null,
//               brandName: widget.product['brandName'],
//               price: widget.product['productDetails']?['Price'] ?? 'N/A',
//               offerPrice: widget.product['productDetails']?['OfferPrice'] ?? 'N/A',
//               quantity: widget.product['productDetails']?['Quantity'] ?? 'N/A',
//             ),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final imageUrl = widget.product['images'] != null && widget.product['images'].isNotEmpty
//         ? widget.product['images'][0]
//         : null;
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Place Order')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (imageUrl != null)
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   image: DecorationImage(
//                     image: NetworkImage(imageUrl),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             SizedBox(height: 16),
//             Text(widget.product['brandName'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700])),
//             SizedBox(height: 4),
//             Text(widget.product['name'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Text('₹${widget.product['productDetails']?['OfferPrice'] ?? 'N/A'}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
//                 SizedBox(width: 8),
//                 Text('₹${widget.product['productDetails']?['Price'] ?? 'N/A'}', style: TextStyle(fontSize: 18, color: Colors.red, decoration: TextDecoration.lineThrough)),
//                 SizedBox(width: 8),
//                 Text('Qty: ${widget.product['productDetails']?['Quantity'] ?? 'N/A'}', style: TextStyle(fontSize: 18, color: Colors.grey)),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(controller: _fullNameController, decoration: InputDecoration(labelText: 'Full Name'), validator: (value) => value!.isEmpty ? 'Please enter your full name' : null),
//                   TextFormField(controller: _phoneNumberController, decoration: InputDecoration(labelText: 'Phone Number'), validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null),
//                   TextFormField(controller: _addressController, decoration: InputDecoration(labelText: 'Address'), validator: (value) => value!.isEmpty ? 'Please enter your address' : null),
//                   TextFormField(controller: _pincodeController, decoration: InputDecoration(labelText: 'Pincode'), validator: (value) => value!.isEmpty ? 'Please enter your pincode' : null),
//                   TextFormField(controller: _stateController, decoration: InputDecoration(labelText: 'State'), validator: (value) => value!.isEmpty ? 'Please enter your state' : null),
//                   TextFormField(controller: _cityController, decoration: InputDecoration(labelText: 'City'), validator: (value) => value!.isEmpty ? 'Please enter your city' : null),
//                   DropdownButtonFormField<String>(
//                     value: _addressType,
//                     decoration: InputDecoration(labelText: 'Address Type'),
//                     items: ['Home', 'Work'].map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
//                     onChanged: (value) => setState(() => _addressType = value!),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _fetchPreviousAddress,
//                     child: Text('Use Previous Address'),
//                   ),
//                   SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: _saveAddress,
//                     child: Text('Continue'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
