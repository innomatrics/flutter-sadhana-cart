/// Logic is good ui not good
library;

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Customer/payment_method_screen.dart';
//
// class AddressFormScreen extends StatefulWidget {
//   final String productId;
//   final int quantity; // Add quantity parameter
//
//
//   const AddressFormScreen({Key? key,
//     required this.productId,
//     required this.quantity, // Add to constructor
//   }) : super(key: key);
//
//   @override
//   _AddressFormScreenState createState() => _AddressFormScreenState();
// }
//
// class _AddressFormScreenState extends State<AddressFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, dynamic> addressDetails = {
//     'fullName': '',
//     'addressLine1': '',
//     'addressLine2': '',
//     'city': '',
//     'state': '',
//     'postalCode': '',
//   };
//
//   Future<void> _saveAddressAndNavigate(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//
//       try {
//         User? user = FirebaseAuth.instance.currentUser;
//         if (user == null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//           );
//           return;
//         }
//
//         String customerId = user.uid;
//
//         // Save address details to the customer's document
//         await FirebaseFirestore.instance
//             .collection('customers')
//             .doc(customerId)
//             .update({
//           'address': addressDetails,
//         });
//
//         // Navigate to Payment Method Selection Screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentMethodSelectionScreen(
//               productId: widget.productId,
//               quantity: widget.quantity, // Pass the quantity forward
//             ),
//           ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save address: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter Address'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Full Name'),
//                 onSaved: (value) {
//                   addressDetails['fullName'] = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your full name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Address Line 1'),
//                 onSaved: (value) {
//                   addressDetails['addressLine1'] = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your address';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Address Line 2'),
//                 onSaved: (value) {
//                   addressDetails['addressLine2'] = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'City'),
//                 onSaved: (value) {
//                   addressDetails['city'] = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your city';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'State'),
//                 onSaved: (value) {
//                   addressDetails['state'] = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your state';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Postal Code'),
//                 onSaved: (value) {
//                   addressDetails['postalCode'] = value;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your postal code';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _saveAddressAndNavigate(context);
//                 },
//                 child: Text('Next'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

/// updating the ui

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Customer/payment_method_screen.dart';
//
// class AddressFormScreen extends StatefulWidget {
//   final String productId;
//   final int quantity;
//
//   const AddressFormScreen({
//     Key? key,
//     required this.productId,
//     required this.quantity,
//   }) : super(key: key);
//
//   @override
//   _AddressFormScreenState createState() => _AddressFormScreenState();
// }
//
// class _AddressFormScreenState extends State<AddressFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, dynamic> addressDetails = {
//     'fullName': '',
//     'addressLine1': '',
//     'addressLine2': '',
//     'city': '',
//     'state': '',
//     'postalCode': '',
//   };
//
//   Future<void> _saveAddressAndNavigate(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//
//       try {
//         User? user = FirebaseAuth.instance.currentUser;
//         if (user == null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//           );
//           return;
//         }
//
//         String customerId = user.uid;
//
//         // Add timestamp to address details
//         addressDetails['timestamp'] = FieldValue.serverTimestamp();
//
//         // Get reference to customer's addresses subcollection
//         CollectionReference addressesRef = FirebaseFirestore.instance
//             .collection('customers')
//             .doc(customerId)
//             .collection('addresses');
//
//         // Add new address
//         await addressesRef.add(addressDetails);
//
//         // Get all addresses
//         QuerySnapshot addressesSnapshot = await addressesRef
//             .orderBy('timestamp', descending: true)
//             .get();
//
//         // If more than 3 addresses, delete the oldest ones
//         if (addressesSnapshot.docs.length > 3) {
//           List<DocumentSnapshot> addresses = addressesSnapshot.docs;
//           for (int i = 3; i < addresses.length; i++) {
//             await addressesRef.doc(addresses[i].id).delete();
//           }
//         }
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentMethodSelectionScreen(
//               productId: widget.productId,
//               quantity: widget.quantity,
//             ),
//           ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save address: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String customerId = user?.uid ?? '';
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar:AppBar(
//         title: const Text(
//           'Enter Address',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const Text(
//                     'Shipping Information',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepPurple,
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   _buildTextField(
//                     label: 'Full Name',
//                     onSaved: (value) => addressDetails['fullName'] = value,
//                     validator: (value) =>
//                     value == null || value.isEmpty
//                         ? 'Please enter your full name'
//                         : null,
//                   ),
//                   _buildTextField(
//                     label: 'Delivery Address',
//                     onSaved: (value) => addressDetails['addressLine1'] = value,
//                     validator: (value) =>
//                     value == null || value.isEmpty
//                         ? 'Please enter your address'
//                         : null,
//                     maxLines: 5, // 👈 Make this field taller
//                   ),
//                   _buildTextField(
//                     label: 'City',
//                     onSaved: (value) => addressDetails['city'] = value,
//                     validator: (value) =>
//                     value == null || value.isEmpty
//                         ? 'Please enter your city'
//                         : null,
//                   ),
//                   _buildTextField(
//                     label: 'State',
//                     onSaved: (value) => addressDetails['state'] = value,
//                     validator: (value) =>
//                     value == null || value.isEmpty
//                         ? 'Please enter your state'
//                         : null,
//                   ),
//                   _buildTextField(
//                     label: 'Postal Code',
//                     onSaved: (value) => addressDetails['postalCode'] = value,
//                     validator: (value) =>
//                     value == null || value.isEmpty
//                         ? 'Please enter your postal code'
//                         : null,
//                   ),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () => _saveAddressAndNavigate(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Next',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton.icon(
//                         onPressed: user != null
//                             ? () {
//                           showDialog(
//                             context: context,
//                             builder: (context) => AddressSelectionDialog(
//                               customerId: customerId,
//                               onAddressSelected: (selectedAddress) {
//                                 setState(() {
//                                   addressDetails['fullName'] = selectedAddress['fullName'];
//                                   addressDetails['addressLine1'] = selectedAddress['addressLine1'];
//                                   addressDetails['addressLine2'] = selectedAddress['addressLine2'];
//                                   addressDetails['city'] = selectedAddress['city'];
//                                   addressDetails['state'] = selectedAddress['state'];
//                                   addressDetails['postalCode'] = selectedAddress['postalCode'];
//                                 });
//                               },
//                             ),
//                           );
//                         }
//                             : null,
//                         icon: const Icon(Icons.history, color: Colors.deepPurple),
//                         label: const Text(
//                           'Saved Addresses',
//                           style: TextStyle(color: Colors.deepPurple),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   Widget _buildTextField({
//     required String label,
//     required FormFieldSetter<String> onSaved,
//     required FormFieldValidator<String> validator,
//     int maxLines = 1,
//   }) {
//     String initialValue = '';
//     switch (label) {
//       case 'Full Name':
//         initialValue = addressDetails['fullName'] ?? '';
//         break;
//       case 'Delivery Address':
//         initialValue = addressDetails['addressLine1'] ?? '';
//         break;
//       case 'City':
//         initialValue = addressDetails['city'] ?? '';
//         break;
//       case 'State':
//         initialValue = addressDetails['state'] ?? '';
//         break;
//       case 'Postal Code':
//         initialValue = addressDetails['postalCode'] ?? '';
//         break;
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         initialValue: initialValue,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           labelText: label,
//           alignLabelWithHint: maxLines > 1,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         onSaved: onSaved,
//         validator: validator,
//       ),
//     );
//   }
// }
// class AddressSelectionDialog extends StatelessWidget {
//   final String customerId;
//   final Function(Map<String, dynamic>) onAddressSelected;
//
//   const AddressSelectionDialog({
//     Key? key,
//     required this.customerId,
//     required this.onAddressSelected,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               'Select Saved Address',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             const SizedBox(height: 16),
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('customers')
//                   .doc(customerId)
//                   .collection('addresses')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Text('No saved addresses found'),
//                   );
//                 }
//
//                 return Column(
//                   children: [
//                     ...snapshot.data!.docs.map((doc) {
//                       var address = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(12),
//                           onTap: () {
//                             onAddressSelected(address);
//                             Navigator.pop(context);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 if (address['fullName'] != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 4),
//                                     child: Text(
//                                       address['fullName'],
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 if (address['addressLine1'] != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 2),
//                                     child: Text(address['addressLine1']),
//                                   ),
//                                 if (address['addressLine2'] != null &&
//                                     address['addressLine2'].isNotEmpty)
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 2),
//                                     child: Text(address['addressLine2']),
//                                   ),
//                                 if (address['city'] != null ||
//                                     address['state'] != null ||
//                                     address['postalCode'] != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 4),
//                                     child: Text(
//                                       [
//                                         address['city'],
//                                         address['state'],
//                                         address['postalCode']
//                                       ].where((e) => e != null && e.isNotEmpty).join(', '),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     const SizedBox(height: 8),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('Cancel'),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// update ++

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Customer/payment_method_screen.dart';
// import 'package:sadhana_cart/Web/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Web/Customer/payment_method_screen.dart';
//
// class WebAddressFormScreen extends StatefulWidget {
//   final String productId;
//   final int quantity;
//   final String isShowCashOnDelivery;
//   final String sellerId;
//
//   const WebAddressFormScreen(
//       {super.key,
//       required this.productId,
//       required this.quantity,
//       required this.isShowCashOnDelivery,
//       required this.sellerId});
//
//   @override
//   _WebAddressFormScreenState createState() => _WebAddressFormScreenState();
// }
//
// class _WebAddressFormScreenState extends State<WebAddressFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, dynamic> addressDetails = {
//     'fullName': '',
//     'addressLine1': '',
//     'city': '',
//     'state': '',
//     'postalCode': '',
//   };
//
//   // Controllers for text fields
//   late TextEditingController fullNameController;
//   late TextEditingController addressLine1Controller;
//   late TextEditingController cityController;
//   late TextEditingController stateController;
//   late TextEditingController postalCodeController;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with empty values
//     fullNameController = TextEditingController();
//     addressLine1Controller = TextEditingController();
//     cityController = TextEditingController();
//     stateController = TextEditingController();
//     postalCodeController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     // Clean up controllers
//     fullNameController.dispose();
//     addressLine1Controller.dispose();
//     cityController.dispose();
//     stateController.dispose();
//     postalCodeController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _saveAddressAndNavigate(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       // Update addressDetails from controllers before saving
//       addressDetails['fullName'] = fullNameController.text;
//       addressDetails['addressLine1'] = addressLine1Controller.text;
//       addressDetails['city'] = cityController.text;
//       addressDetails['state'] = stateController.text;
//       addressDetails['postalCode'] = postalCodeController.text;
//
//       _formKey.currentState!.save();
//
//       try {
//         User? user = FirebaseAuth.instance.currentUser;
//         if (user == null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const WebCustomerSigninScreen()),
//           );
//           return;
//         }
//
//         String customerId = user.uid;
//
//         // Add timestamp to address details
//         addressDetails['timestamp'] = FieldValue.serverTimestamp();
//
//         // Get reference to customer's addresses subcollection
//         CollectionReference addressesRef = FirebaseFirestore.instance
//             .collection('customers')
//             .doc(customerId)
//             .collection('addresses');
//
//         // Add new address
//         await addressesRef.add(addressDetails);
//
//         // Get all addresses
//         QuerySnapshot addressesSnapshot =
//             await addressesRef.orderBy('timestamp', descending: true).get();
//
//         // If more than 3 addresses, delete the oldest ones
//         if (addressesSnapshot.docs.length > 3) {
//           List<DocumentSnapshot> addresses = addressesSnapshot.docs;
//           for (int i = 3; i < addresses.length; i++) {
//             await addressesRef.doc(addresses[i].id).delete();
//           }
//         }
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebPaymentMethodSelectionScreen(
//               productId: widget.productId,
//               quantity: widget.quantity,
//               isShowCashonDelivery: widget.isShowCashOnDelivery,
//               selledId: widget.sellerId,
//             ),
//           ),
//         );
//         log(" customer address form : ${widget.sellerId}");
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save address: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String customerId = user?.uid ?? '';
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       // appBar: AppBar(
//       //   title: const Text(
//       //     'Enter Address',
//       //     style: TextStyle(fontWeight: FontWeight.bold),
//       //   ),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.deepPurple,
//       // ),
//       appBar: AppBar(
//         title: Text(widget.productId),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Card(
//           elevation: 4,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const Text(
//                     'Shipping Information',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepPurple,
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   _buildTextField(
//                     label: 'Full Name',
//                     controller: fullNameController,
//                     onSaved: (value) => addressDetails['fullName'] = value,
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Please enter your full name'
//                         : null,
//                   ),
//                   _buildTextField(
//                     label: 'Delivery Address',
//                     controller: addressLine1Controller,
//                     onSaved: (value) => addressDetails['addressLine1'] = value,
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Please enter your address'
//                         : null,
//                     maxLines: 3,
//                   ),
//                   _buildTextField(
//                     label: 'City',
//                     controller: cityController,
//                     onSaved: (value) => addressDetails['city'] = value,
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Please enter your city'
//                         : null,
//                   ),
//                   _buildTextField(
//                     label: 'State',
//                     controller: stateController,
//                     onSaved: (value) => addressDetails['state'] = value,
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Please enter your state'
//                         : null,
//                   ),
//                   _buildTextField(
//                     label: 'Postal Code',
//                     controller: postalCodeController,
//                     onSaved: (value) => addressDetails['postalCode'] = value,
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Please enter your postal code'
//                         : null,
//                   ),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () => _saveAddressAndNavigate(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Next',
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton.icon(
//                         onPressed: user != null
//                             ? () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AddressSelectionDialog(
//                                     customerId: customerId,
//                                     onAddressSelected: (selectedAddress) {
//                                       setState(() {
//                                         // Update controllers with selected address
//                                         fullNameController.text =
//                                             selectedAddress['fullName'] ?? '';
//                                         addressLine1Controller.text =
//                                             selectedAddress['addressLine1'] ??
//                                                 '';
//                                         cityController.text =
//                                             selectedAddress['city'] ?? '';
//                                         stateController.text =
//                                             selectedAddress['state'] ?? '';
//                                         postalCodeController.text =
//                                             selectedAddress['postalCode'] ?? '';
//                                       });
//                                     },
//                                   ),
//                                 );
//                               }
//                             : null,
//                         icon:
//                             const Icon(Icons.history, color: Colors.deepPurple),
//                         label: const Text(
//                           'Saved Addresses',
//                           style: TextStyle(color: Colors.deepPurple),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required FormFieldSetter<String> onSaved,
//     required FormFieldValidator<String> validator,
//     int maxLines = 1,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           labelText: label,
//           alignLabelWithHint: maxLines > 1,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         onSaved: onSaved,
//         validator: validator,
//       ),
//     );
//   }
// }
//
// class AddressSelectionDialog extends StatelessWidget {
//   final String customerId;
//   final Function(Map<String, dynamic>) onAddressSelected;
//
//   const AddressSelectionDialog({
//     super.key,
//     required this.customerId,
//     required this.onAddressSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               'Select Saved Address',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             const SizedBox(height: 16),
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('customers')
//                   .doc(customerId)
//                   .collection('addresses')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Text('No saved addresses found'),
//                   );
//                 }
//
//                 return Column(
//                   children: [
//                     ...snapshot.data!.docs.map((doc) {
//                       var address = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           side: BorderSide(color: Colors.grey.shade300),
//                         ),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(12),
//                           onTap: () {
//                             onAddressSelected(address);
//                             Navigator.pop(context);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 if (address['fullName'] != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 4),
//                                     child: Text(
//                                       address['fullName'],
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 if (address['addressLine1'] != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(bottom: 2),
//                                     child: Text(address['addressLine1']),
//                                   ),
//                                 if (address['city'] != null ||
//                                     address['state'] != null ||
//                                     address['postalCode'] != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 4),
//                                     child: Text(
//                                       [
//                                         address['city'],
//                                         address['state'],
//                                         address['postalCode']
//                                       ]
//                                           .where(
//                                               (e) => e != null && e.isNotEmpty)
//                                           .join(', '),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                     const SizedBox(height: 8),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('Cancel'),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




//



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_cart/Web/Customer/customer_signin.dart';
import 'package:sadhana_cart/Web/Customer/payment_method_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WebAddressFormScreen extends StatefulWidget {
  final String productId;
  final int quantity;
  final String isShowCashOnDelivery;
  final String sellerId;

  const WebAddressFormScreen({
    super.key,
    required this.productId,
    required this.quantity,
    required this.isShowCashOnDelivery,
    required this.sellerId,
  });

  @override
  _WebAddressFormScreenState createState() => _WebAddressFormScreenState();
}

class _WebAddressFormScreenState extends State<WebAddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> addressDetails = {
    'fullName': '',
    'addressLine1': '',
    'city': '',
    'state': '',
    'postalCode': '',
  };

  late TextEditingController fullNameController;
  late TextEditingController addressLine1Controller;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController postalCodeController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    addressLine1Controller = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    postalCodeController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    addressLine1Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  Future<void> _saveAddressAndNavigate(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      addressDetails['fullName'] = fullNameController.text;
      addressDetails['addressLine1'] = addressLine1Controller.text;
      addressDetails['city'] = cityController.text;
      addressDetails['state'] = stateController.text;
      addressDetails['postalCode'] = postalCodeController.text;

      _formKey.currentState!.save();

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
              const WebCustomerSigninScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
          return;
        }

        String customerId = user.uid;
        addressDetails['timestamp'] = FieldValue.serverTimestamp();

        CollectionReference addressesRef = FirebaseFirestore.instance
            .collection('customers')
            .doc(customerId)
            .collection('addresses');

        await addressesRef.add(addressDetails);

        QuerySnapshot addressesSnapshot =
        await addressesRef.orderBy('timestamp', descending: true).get();

        if (addressesSnapshot.docs.length > 3) {
          List<DocumentSnapshot> addresses = addressesSnapshot.docs;
          for (int i = 3; i < addresses.length; i++) {
            await addressesRef.doc(addresses[i].id).delete();
          }
        }

        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                WebPaymentMethodSelectionScreen(
                  productId: widget.productId,
                  quantity: widget.quantity,
                  isShowCashonDelivery: widget.isShowCashOnDelivery,
                  selledId: widget.sellerId,
                ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save address: $e'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String customerId = user?.uid ?? '';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Animated Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepOrange[700]!,
                    Colors.deepOrange[500]!,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 60,
                    color: Colors.white,
                  )
                      .animate()
                      .scale(duration: 800.ms)
                      .then(delay: 200.ms)
                      .shake(),
                  const SizedBox(height: 20),
                  const Text(
                    'Shipping Information',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .then(delay: 100.ms)
                      .slide(),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter your delivery address',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Form Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(
                              label: 'Full Name',
                              icon: Icons.person,
                              controller: fullNameController,
                              onSaved: (value) =>
                              addressDetails['fullName'] = value,
                              validator: (value) => value == null ||
                                  value.isEmpty
                                  ? 'Please enter your full name'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              label: 'Delivery Address',
                              icon: Icons.home,
                              controller: addressLine1Controller,
                              onSaved: (value) =>
                              addressDetails['addressLine1'] = value,
                              validator: (value) => value == null ||
                                  value.isEmpty
                                  ? 'Please enter your address'
                                  : null,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    label: 'City',
                                    icon: Icons.location_city,
                                    controller: cityController,
                                    onSaved: (value) =>
                                    addressDetails['city'] = value,
                                    validator: (value) => value == null ||
                                        value.isEmpty
                                        ? 'Please enter your city'
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildTextField(
                                    label: 'State',
                                    icon: Icons.map,
                                    controller: stateController,
                                    onSaved: (value) =>
                                    addressDetails['state'] = value,
                                    validator: (value) => value == null ||
                                        value.isEmpty
                                        ? 'Please enter your state'
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              label: 'Postal Code',
                              icon: Icons.markunread_mailbox,
                              controller: postalCodeController,
                              onSaved: (value) =>
                              addressDetails['postalCode'] = value,
                              validator: (value) => value == null ||
                                  value.isEmpty
                                  ? 'Please enter your postal code'
                                  : null,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (user != null)
                                  TextButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AddressSelectionDialog(
                                              customerId: customerId,
                                              onAddressSelected:
                                                  (selectedAddress) {
                                                setState(() {
                                                  fullNameController.text =
                                                      selectedAddress['fullName'] ??
                                                          '';
                                                  addressLine1Controller.text =
                                                      selectedAddress[
                                                      'addressLine1'] ??
                                                          '';
                                                  cityController.text =
                                                      selectedAddress['city'] ?? '';
                                                  stateController.text =
                                                      selectedAddress['state'] ?? '';
                                                  postalCodeController.text =
                                                      selectedAddress[
                                                      'postalCode'] ??
                                                          '';
                                                });
                                              },
                                            ),
                                      );
                                    },
                                    icon: const Icon(Icons.history,
                                        color: Colors.deepOrange),
                                    label: const Text(
                                      'Saved Addresses',
                                      style: TextStyle(color: Colors.deepOrange),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(delay: 300.ms)
                                      .then(delay: 100.ms)
                                      .shakeX(),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () => _saveAddressAndNavigate(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrange,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 4,
                                  ),
                                  child: const Text(
                                    'Continue to Payment',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                    .animate()
                                    .scale(delay: 400.ms)
                                    .then(delay: 100.ms)
                                    .shakeY(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        alignLabelWithHint: maxLines > 1,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 20),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: const TextStyle(color: Colors.deepOrange),
      ),
      style: const TextStyle(color: Colors.black87),
      onSaved: onSaved,
      validator: validator,
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1);
  }
}

class AddressSelectionDialog extends StatelessWidget {
  final String customerId;
  final Function(Map<String, dynamic>) onAddressSelected;

  const AddressSelectionDialog({
    super.key,
    required this.customerId,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      child: Animate(
        effects: [
          ScaleEffect(duration: 300.ms),
          FadeEffect(duration: 300.ms),
        ],
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Saved Address',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange[700],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('customers')
                    .doc(customerId)
                    .collection('addresses')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'No saved addresses found',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      ...snapshot.data!.docs.map((doc) {
                        var address = doc.data() as Map<String, dynamic>;
                        return Animate(
                          effects: [FadeEffect(), SlideEffect()],
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                  color: Colors.deepOrange.withOpacity(0.2),
                                  width: 1),
                            ),
                            elevation: 2,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                onAddressSelected(address);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (address['fullName'] != null)
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person,
                                                size: 18,
                                                color: Colors.deepOrange),
                                            const SizedBox(width: 8),
                                            Text(
                                              address['fullName'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (address['addressLine1'] != null)
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.home,
                                                size: 18,
                                                color: Colors.deepOrange),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                address['addressLine1'],
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (address['city'] != null ||
                                        address['state'] != null ||
                                        address['postalCode'] != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                size: 18,
                                                color: Colors.deepOrange),
                                            const SizedBox(width: 8),
                                            Text(
                                              [
                                                address['city'],
                                                address['state'],
                                                address['postalCode']
                                              ]
                                                  .where((e) =>
                                              e != null && e.isNotEmpty)
                                                  .join(', '),
                                              style: const TextStyle(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}