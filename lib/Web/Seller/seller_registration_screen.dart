//basic

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sadhana_cart/Seller/seller_bottom_nav_layout.dart';
//
// class SellerRegistrationScreen extends StatefulWidget {
//   final User user;
//
//   SellerRegistrationScreen({required this.user});
//
//   @override
//   _SellerRegistrationScreenState createState() => _SellerRegistrationScreenState();
// }
//
// class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _gstController = TextEditingController();
//   bool _isLoading = false;
//
//   Future<void> _registerSeller() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//
//       try {
//         final userRef = FirebaseFirestore.instance.collection('seller').doc(widget.user.uid);
//
//         // Add seller details to Firestore
//         await userRef.set({
//           'email': widget.user.email,
//           'name': widget.user.displayName,
//           'shopName': _shopNameController.text,
//           'address': _addressController.text,
//           'phone': _phoneController.text,
//           'gstNumber': _gstController.text,
//           'createdAt': FieldValue.serverTimestamp(),
//           'status': 'loggedIn',
//         });
//
//         // Save login status locally
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isLoggedIn', true);
//
//         setState(() => _isLoading = false);
//
//         // Navigate to the home screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
//         );
//       } catch (e) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Seller Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _shopNameController,
//                 decoration: InputDecoration(labelText: 'Shop Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your shop name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _addressController,
//                 decoration: InputDecoration(labelText: 'Address'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your address';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _gstController,
//                 decoration: InputDecoration(labelText: 'GST Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your GST number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _registerSeller,
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//Advanced

//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sadhana_cart/Seller/seller_bottom_nav_layout.dart';
// import 'dart:io';
//
// class SellerRegistrationScreen extends StatefulWidget {
//   final User user;
//
//   SellerRegistrationScreen({required this.user});
//
//   @override
//   _SellerRegistrationScreenState createState() => _SellerRegistrationScreenState();
// }
//
// class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _gstController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();
//   final TextEditingController _bankAccountController = TextEditingController();
//   final TextEditingController _businessTypeController = TextEditingController();
//   bool _isLoading = false;
//   bool _agreeToTerms = false;
//
//   File? _gstCertificate;
//   File? _panCard;
//   File? _bankProof;
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickDocument(String type) async {
//     final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       setState(() {
//         if (type == 'gst') {
//           _gstCertificate = File(file.path);
//         } else if (type == 'pan') {
//           _panCard = File(file.path);
//         } else if (type == 'bank') {
//           _bankProof = File(file.path);
//         }
//       });
//     }
//   }
//
//   Future<String> _uploadFile(File file, String fileName) async {
//     try {
//       final Reference storageReference = FirebaseStorage.instance
//           .ref()
//           .child('seller_documents/${widget.user.uid}/$fileName');
//
//       final UploadTask uploadTask = storageReference.putFile(file);
//       final TaskSnapshot taskSnapshot = await uploadTask;
//       final String downloadURL = await taskSnapshot.ref.getDownloadURL();
//
//       return downloadURL;
//     } catch (e) {
//       print('Error uploading file: $e');
//       throw e;
//     }
//   }
//
//   Future<void> _registerSeller() async {
//     if (_formKey.currentState!.validate()) {
//       if (!_agreeToTerms) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please agree to the terms and conditions')),
//         );
//         return;
//       }
//
//       setState(() => _isLoading = true);
//
//       try {
//         final userRef = FirebaseFirestore.instance.collection('seller').doc(widget.user.uid);
//
//         // Upload documents to Firebase Storage
//         final String gstCertificateUrl = await _uploadFile(_gstCertificate!, 'gst_certificate.jpg');
//         final String panCardUrl = await _uploadFile(_panCard!, 'pan_card.jpg');
//         final String bankProofUrl = await _uploadFile(_bankProof!, 'bank_proof.jpg');
//
//         // Add seller details to Firestore
//         await userRef.set({
//           'email': widget.user.email,
//           'name': widget.user.displayName,
//           'shopName': _shopNameController.text,
//           'address': _addressController.text,
//           'phone': _phoneController.text,
//           'gstNumber': _gstController.text,
//           'panNumber': _panController.text,
//           'bankAccount': _bankAccountController.text,
//           'businessType': _businessTypeController.text,
//           'gstCertificateUrl': gstCertificateUrl,
//           'panCardUrl': panCardUrl,
//           'bankProofUrl': bankProofUrl,
//           'createdAt': FieldValue.serverTimestamp(),
//           'status': 'loggedIn',
//         });
//
//         // Save login status locally
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isLoggedIn', true);
//
//         setState(() => _isLoading = false);
//
//         // Navigate to the home screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
//         );
//       } catch (e) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('Seller Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _shopNameController,
//                 decoration: InputDecoration(labelText: 'Shop Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your shop name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _addressController,
//                 decoration: InputDecoration(labelText: 'Business Address'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your business address';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _gstController,
//                 decoration: InputDecoration(labelText: 'GST Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your GST number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _panController,
//                 decoration: InputDecoration(labelText: 'PAN Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your PAN number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _bankAccountController,
//                 decoration: InputDecoration(labelText: 'Bank Account Number'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your bank account number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _businessTypeController,
//                 decoration: InputDecoration(labelText: 'Business Type (e.g., Individual, Company)'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your business type';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               Text('Upload Documents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               _buildDocumentUpload('GST Certificate', _gstCertificate, 'gst'),
//               _buildDocumentUpload('PAN Card', _panCard, 'pan'),
//               _buildDocumentUpload('Bank Account Proof', _bankProof, 'bank'),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _agreeToTerms,
//                     onChanged: (value) {
//                       setState(() {
//                         _agreeToTerms = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('I agree to the terms and conditions'),
//                 ],
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _registerSeller,
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDocumentUpload(String label, File? file, String type) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label),
//         SizedBox(height: 8),
//         ElevatedButton(
//           onPressed: () => _pickDocument(type),
//           child: Text(file == null ? 'Upload $label' : 'Replace $label'),
//         ),
//         if (file != null) Text('File selected: ${file.path}'),
//         SizedBox(height: 16),
//       ],
//     );
//   }
// }

//ad

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:sadhana_cart/Seller/hold_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sadhana_cart/Seller/seller_bottom_nav_layout.dart';
// import 'dart:io';
//
// class SellerRegistrationScreen extends StatefulWidget {
//   final User user;
//
//   SellerRegistrationScreen({required this.user});
//
//   @override
//   _SellerRegistrationScreenState createState() => _SellerRegistrationScreenState();
// }
//
// class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _gstController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();
//   final TextEditingController _bankAccountController = TextEditingController();
//   final TextEditingController _businessTypeController = TextEditingController();
//   bool _isLoading = false;
//   bool _agreeToTerms = false;
//
//   File? _gstCertificate;
//   File? _panCard;
//   File? _bankProof;
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickDocument(String type) async {
//     final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       setState(() {
//         if (type == 'gst') {
//           _gstCertificate = File(file.path);
//         } else if (type == 'pan') {
//           _panCard = File(file.path);
//         } else if (type == 'bank') {
//           _bankProof = File(file.path);
//         }
//       });
//     }
//   }
//
//   Future<String> _uploadFile(File file, String fileName) async {
//     try {
//       final Reference storageReference = FirebaseStorage.instance
//           .ref()
//           .child('seller_documents/${widget.user.uid}/$fileName');
//
//       final UploadTask uploadTask = storageReference.putFile(file);
//       final TaskSnapshot taskSnapshot = await uploadTask;
//       final String downloadURL = await taskSnapshot.ref.getDownloadURL();
//
//       return downloadURL;
//     } catch (e) {
//       print('Error uploading file: $e');
//       throw e;
//     }
//   }
//
//   Future<void> _registerSeller() async {
//     if (_formKey.currentState!.validate()) {
//       if (!_agreeToTerms) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please agree to the terms and conditions')),
//         );
//         return;
//       }
//
//       setState(() => _isLoading = true);
//
//       try {
//         final userRef = FirebaseFirestore.instance.collection('seller').doc(widget.user.uid);
//
//         // Upload documents to Firebase Storage
//         final String gstCertificateUrl = await _uploadFile(_gstCertificate!, 'gst_certificate.jpg');
//         final String panCardUrl = await _uploadFile(_panCard!, 'pan_card.jpg');
//         final String bankProofUrl = await _uploadFile(_bankProof!, 'bank_proof.jpg');
//
//         // Add seller details to Firestore
//         await userRef.set({
//           'email': widget.user.email,
//           'name': widget.user.displayName,
//           'shopName': _shopNameController.text,
//           'address': _addressController.text,
//           'phone': _phoneController.text,
//           'gstNumber': _gstController.text,
//           'panNumber': _panController.text,
//           'bankAccount': _bankAccountController.text,
//           'businessType': _businessTypeController.text,
//           'gstCertificateUrl': gstCertificateUrl,
//           'panCardUrl': panCardUrl,
//           'bankProofUrl': bankProofUrl,
//           'createdAt': FieldValue.serverTimestamp(),
//           'status': 'loggedIn',
//         });
//
//         // Save login status locally
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isLoggedIn', true);
//
//         setState(() => _isLoading = false);
//
//         // Navigate to the home screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => HoldScreen()),
//         );
//       } catch (e) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('Seller Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _shopNameController,
//                 decoration: InputDecoration(labelText: 'Shop Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your shop name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _addressController,
//                 decoration: InputDecoration(labelText: 'Business Address'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your business address';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _gstController,
//                 decoration: InputDecoration(labelText: 'GST Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your GST number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _panController,
//                 decoration: InputDecoration(labelText: 'PAN Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your PAN number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _bankAccountController,
//                 decoration: InputDecoration(labelText: 'Bank Account Number'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your bank account number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _businessTypeController,
//                 decoration: InputDecoration(labelText: 'Business Type (e.g., Individual, Company)'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your business type';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               Text('Upload Documents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               _buildDocumentUpload('GST Certificate', _gstCertificate, 'gst'),
//               _buildDocumentUpload('PAN Card', _panCard, 'pan'),
//               _buildDocumentUpload('Bank Account Proof', _bankProof, 'bank'),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _agreeToTerms,
//                     onChanged: (value) {
//                       setState(() {
//                         _agreeToTerms = value ?? false;
//                       });
//                     },
//                   ),
//                   Text('I agree to the terms and conditions'),
//                 ],
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _registerSeller,
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDocumentUpload(String label, File? file, String type) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 8),
//         if (file != null)
//           Image.file(
//             file,
//             height: 100,
//             width: 100,
//             fit: BoxFit.cover,
//           ),
//         SizedBox(height: 8),
//         ElevatedButton(
//           onPressed: () => _pickDocument(type),
//           child: Text(file == null ? 'Upload $label' : 'Replace $label'),
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }
// }

// Android

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:sadhana_cart/Seller/hold_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';
//
// class WebSellerRegistrationScreen extends StatefulWidget {
//   const WebSellerRegistrationScreen({super.key});
//
//   @override
//   _WebSellerRegistrationScreenState createState() =>
//       _WebSellerRegistrationScreenState();
// }
//
// class _WebSellerRegistrationScreenState extends State<WebSellerRegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _gstController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();
//   final TextEditingController _bankAccountController = TextEditingController();
//   final TextEditingController _businessTypeController = TextEditingController();
//   bool _isLoading = false;
//   bool _agreeToTerms = false;
//
//   File? _gstCertificate;
//   File? _panCard;
//   File? _bankProof;
//
//   late User _user;
//
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUser();
//   }
//
//   void _getCurrentUser() {
//     final User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         _user = user;
//       });
//     } else {
//       // Handle the case where the user is not logged in
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No user logged in.')),
//       );
//       Navigator.pop(context); // Go back to the previous screen
//     }
//   }
//
//   Future<void> _pickDocument(String type) async {
//     final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       setState(() {
//         if (type == 'gst') {
//           _gstCertificate = File(file.path);
//         } else if (type == 'pan') {
//           _panCard = File(file.path);
//         } else if (type == 'bank') {
//           _bankProof = File(file.path);
//         }
//       });
//     }
//   }
//
//   Future<String> _uploadFile(File file, String fileName) async {
//     try {
//       final Reference storageReference = FirebaseStorage.instance
//           .ref()
//           .child('seller_documents/${_user.uid}/$fileName');
//
//       final UploadTask uploadTask = storageReference.putFile(file);
//       final TaskSnapshot taskSnapshot = await uploadTask;
//       final String downloadURL = await taskSnapshot.ref.getDownloadURL();
//
//       return downloadURL;
//     } catch (e) {
//       print('Error uploading file: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> _registerSeller() async {
//     if (_formKey.currentState!.validate()) {
//       if (!_agreeToTerms) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text('Please agree to the terms and conditions')),
//         );
//         return;
//       }
//
//       setState(() => _isLoading = true);
//
//       try {
//         final userRef =
//             FirebaseFirestore.instance.collection('seller').doc(_user.uid);
//
//         // Upload documents to Firebase Storage
//         final String gstCertificateUrl =
//             await _uploadFile(_gstCertificate!, 'gst_certificate.jpg');
//         final String panCardUrl = await _uploadFile(_panCard!, 'pan_card.jpg');
//         final String bankProofUrl =
//             await _uploadFile(_bankProof!, 'bank_proof.jpg');
//
//         // Add seller details to Firestore
//
//         await userRef.set({
//           'email': _user.email,
//           'name': _user.displayName,
//           'shopName': _shopNameController.text,
//           'address': _addressController.text,
//           'phone': _phoneController.text,
//           'gstNumber': _gstController.text,
//           'panNumber': _panController.text,
//           'bankAccount': _bankAccountController.text,
//           'businessType': _businessTypeController.text,
//           'sellerId': _user.uid,
//           'gstCertificateUrl': gstCertificateUrl,
//           'panCardUrl': panCardUrl,
//           'bankProofUrl': bankProofUrl,
//           'createdAt': FieldValue.serverTimestamp(),
//           'status': 'pending', // Set status to pending
//         });
//
//         // Save login status locally
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isLoggedIn', true);
//
//         setState(() => _isLoading = false);
//
//         // Navigate to the Hold Screen
//         // Inside _registerSeller method in SellerRegistrationScreen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => const HoldScreen(), // No need to pass the user
//           ),
//         );
//       } catch (e) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text('Seller Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // Your existing form fields and widgets
//               TextFormField(
//                 controller: _shopNameController,
//                 decoration: const InputDecoration(labelText: 'Shop Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your shop name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _addressController,
//                 decoration:
//                     const InputDecoration(labelText: 'Business Address'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your business address';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _gstController,
//                 decoration: const InputDecoration(labelText: 'GST Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your GST number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _panController,
//                 decoration: const InputDecoration(labelText: 'PAN Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your PAN number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _bankAccountController,
//                 decoration:
//                     const InputDecoration(labelText: 'Bank Account Number'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your bank account number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _businessTypeController,
//                 decoration: const InputDecoration(
//                     labelText: 'Business Type (e.g., Individual, Company)'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your business type';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               const Text('Upload Documents',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               _buildDocumentUpload('GST Certificate', _gstCertificate, 'gst'),
//               _buildDocumentUpload('PAN Card', _panCard, 'pan'),
//               _buildDocumentUpload('Bank Account Proof', _bankProof, 'bank'),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _agreeToTerms,
//                     onChanged: (value) {
//                       setState(() {
//                         _agreeToTerms = value ?? false;
//                       });
//                     },
//                   ),
//                   const Text('I agree to the terms and conditions'),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _registerSeller,
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDocumentUpload(String label, File? file, String type) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         if (file != null)
//           Image.file(
//             file,
//             height: 100,
//             width: 100,
//             fit: BoxFit.cover,
//           ),
//         const SizedBox(height: 8),
//         ElevatedButton(
//           onPressed: () => _pickDocument(type),
//           child: Text(file == null ? 'Upload $label' : 'Replace $label'),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

// web

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sadhana_cart/Seller/helper/picked_pdf_result.dart';
import 'package:sadhana_cart/Seller/hold_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class WebSellerRegistrationScreen extends StatefulWidget {
  const WebSellerRegistrationScreen({super.key});

  @override
  State<WebSellerRegistrationScreen> createState() =>
      _WebSellerRegistrationScreenState();
}

class _WebSellerRegistrationScreenState
    extends State<WebSellerRegistrationScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _gstController = TextEditingController();
  final _panController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _businessTypeController = TextEditingController();

  bool _isLoading = false;
  bool _agreeToTerms = false;

  File? _gstCertificate;
  File? _panCard;
  File? _bankProof;

  //thumbnail
  PdfPageImage? _gst;
  PdfPageImage? _bank;

  late User _user;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void _getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() => _user = user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user logged in.')),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _pickPanCard() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _panCard = File(image.path);
      });
    }
  }

  Future<PdfPageImage?> _generatePdfThumbnail({required File file}) async {
    try {
      final doc = await PdfDocument.openFile(file.path);
      final page = await doc.getPage(1);
      final pageImage = await page.render(
        width: page.width,
        height: page.height,
        format: PdfPageImageFormat.png,
      );
      await page.close();
      return pageImage;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PDF preview: $e')),
      );
      return null;
    }
  }

  Future<PickedPdfResult?> pickPdfFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final isPdf = file.path.toLowerCase().endsWith('.pdf');
        final thumbnail =
            isPdf ? await _generatePdfThumbnail(file: file) : null;
        return PickedPdfResult(file: file, thumbnail: thumbnail);
      }

      return null;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking file: $e')),
        );
      }
      return null;
    }
  }

  Future<String> _uploadFile(File? file, String fileName) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('seller_documents/${_user.uid}/$fileName');
      final task = ref.putFile(file!);
      final snapshot = await task;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _registerSeller() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms ||
          _gstCertificate == null ||
          _panCard == null ||
          _bankProof == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please fill all fields and upload documents.')),
        );
        return;
      }

      setState(() => _isLoading = true);

      try {
        final userRef =
            FirebaseFirestore.instance.collection('seller').doc(_user.uid);
        final gstUrl = await _uploadFile(_gstCertificate!, 'gst_certificate');
        final panUrl = await _uploadFile(_panCard!, 'pan_card');
        final bankUrl = await _uploadFile(_bankProof!, 'bank_proof');

        await userRef.set({
          'email': _user.email,
          'name': _user.displayName,
          'shopName': _shopNameController.text,
          'address': _addressController.text,
          'phone': _phoneController.text,
          'gstNumber': _gstController.text,
          'panNumber': _panController.text,
          'bankAccount': _bankAccountController.text,
          'businessType': _businessTypeController.text,
          'sellerId': _user.uid,
          'gstCertificateUrl': gstUrl,
          'panCardUrl': panUrl,
          'bankProofUrl': bankUrl,
          'createdAt': FieldValue.serverTimestamp(),
          'status': 'pending',
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HoldScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }

      setState(() => _isLoading = false);
    }
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter $label' : null,
      ),
    );
  }

  Widget _buildDocumentUpload(
    String label,
    File? file,
    String type,
    VoidCallback onTap, {
    PdfPageImage? thumbnail,
  }) {
    final isPdf = file != null && file.path.toLowerCase().endsWith('.pdf');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (file != null)
          isPdf
              ? (thumbnail != null
                  ? Image.memory(thumbnail.bytes,
                      height: 100, width: 100, fit: BoxFit.cover)
                  : const Icon(Icons.picture_as_pdf,
                      size: 80, color: Colors.red))
              : Image.file(file, height: 100, width: 100, fit: BoxFit.cover),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onTap,
          child: Text(file == null ? 'Upload $label' : 'Replace $label'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Seller Registration',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              width: 800,
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Business Information",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      const SizedBox(height: 20),
                      _buildInputField("Shop Name", _shopNameController),
                      _buildInputField("Business Address", _addressController),
                      _buildInputField("Phone Number", _phoneController,
                          type: TextInputType.phone),
                      _buildInputField("GST Number", _gstController),
                      _buildInputField("PAN Number", _panController),
                      _buildInputField(
                          "Bank Account Number", _bankAccountController,
                          type: TextInputType.number),
                      _buildInputField(
                          "Business Type (e.g., Individual, Company)",
                          _businessTypeController),
                      const SizedBox(height: 20),
                      const Divider(),
                      const Text(
                        "Upload Documents",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      const SizedBox(height: 10),
                      _buildDocumentUpload(
                          "GST Certificate", _gstCertificate, 'gst', () async {
                        final picker = await pickPdfFile();
                        if (picker != null && picker.file.path.isNotEmpty) {
                          setState(() {
                            _gstCertificate = File(picker.file.path);
                            _gst = picker.thumbnail;
                          });
                        }
                      }),
                      _buildDocumentUpload(
                          "PAN Card", _panCard, 'pan', () => _pickPanCard()),
                      _buildDocumentUpload("Bank Proof", _bankProof, 'bank',
                          () async {
                        final pickedFile = await pickPdfFile();
                        if (pickedFile != null &&
                            pickedFile.file.path.isNotEmpty) {
                          setState(() {
                            _bankProof = File(pickedFile.file.path);
                            _bank = pickedFile.thumbnail;
                          });
                        }
                      }),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged: (v) =>
                                setState(() => _agreeToTerms = v ?? false),
                            activeColor: Colors.deepOrange,
                          ),
                          const Text("I agree to the terms and conditions"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _registerSeller,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text("Register",
                                  style: TextStyle(fontSize: 18)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
