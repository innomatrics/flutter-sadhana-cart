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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sadhana_cart/Seller/hold_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SellerRegistrationScreen extends StatefulWidget {
  const SellerRegistrationScreen({super.key});

  @override
  _SellerRegistrationScreenState createState() =>
      _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  bool _isLoading = false;
  bool _agreeToTerms = false;

  File? _gstCertificate;
  File? _panCard;
  File? _bankProof;

  late User _user;

  final ImagePicker _picker = ImagePicker();

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
    } else {
      // Handle the case where the user is not logged in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user logged in.')),
      );
      Navigator.pop(context); // Go back to the previous screen
    }
  }

  Future<void> _pickDocument(String type) async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        if (type == 'gst') {
          _gstCertificate = File(file.path);
        } else if (type == 'pan') {
          _panCard = File(file.path);
        } else if (type == 'bank') {
          _bankProof = File(file.path);
        }
      });
    }
  }

  Future<String> _uploadFile(File file, String fileName) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('seller_documents/${_user.uid}/$fileName');

      final UploadTask uploadTask = storageReference.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadURL = await taskSnapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      rethrow;
    }
  }

  Future<void> _registerSeller() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please agree to the terms and conditions')),
        );
        return;
      }

      setState(() => _isLoading = true);

      try {
        final userRef =
            FirebaseFirestore.instance.collection('seller').doc(_user.uid);

        // Upload documents to Firebase Storage
        final String gstCertificateUrl =
            await _uploadFile(_gstCertificate!, 'gst_certificate.jpg');
        final String panCardUrl = await _uploadFile(_panCard!, 'pan_card.jpg');
        final String bankProofUrl =
            await _uploadFile(_bankProof!, 'bank_proof.jpg');

        // Add seller details to Firestore

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
          'gstCertificateUrl': gstCertificateUrl,
          'panCardUrl': panCardUrl,
          'bankProofUrl': bankProofUrl,
          'createdAt': FieldValue.serverTimestamp(),
          'status': 'pending', // Set status to pending
        });

        // Save login status locally
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        setState(() => _isLoading = false);

        // Navigate to the Hold Screen
        // Inside _registerSeller method in SellerRegistrationScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HoldScreen(), // No need to pass the user
          ),
        );
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Seller Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Your existing form fields and widgets
              TextFormField(
                controller: _shopNameController,
                decoration: const InputDecoration(labelText: 'Shop Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your shop name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration:
                    const InputDecoration(labelText: 'Business Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _gstController,
                decoration: const InputDecoration(labelText: 'GST Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your GST number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _panController,
                decoration: const InputDecoration(labelText: 'PAN Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your PAN number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bankAccountController,
                decoration:
                    const InputDecoration(labelText: 'Bank Account Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bank account number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _businessTypeController,
                decoration: const InputDecoration(
                    labelText: 'Business Type (e.g., Individual, Company)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Upload Documents',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildDocumentUpload('GST Certificate', _gstCertificate, 'gst'),
              _buildDocumentUpload('PAN Card', _panCard, 'pan'),
              _buildDocumentUpload('Bank Account Proof', _bankProof, 'bank'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                  ),
                  const Text('I agree to the terms and conditions'),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _registerSeller,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentUpload(String label, File? file, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (file != null)
          Image.file(
            file,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _pickDocument(type),
          child: Text(file == null ? 'Upload $label' : 'Replace $label'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
