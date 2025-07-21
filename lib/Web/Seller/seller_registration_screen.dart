import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdfx/pdfx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sadhana_cart/Seller/hold_screen.dart';

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

  Uint8List? _gstBytes;
  Uint8List? _panBytes;
  Uint8List? _bankBytes;

  PdfPageImage? _gstThumb;
  PdfPageImage? _bankThumb;

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
      final bytes = await image.readAsBytes();
      setState(() {
        _panBytes = bytes;
      });
    }
  }

  Future<void> _pickPdfOrImage(
      void Function(Uint8List bytes, PdfPageImage? thumbnail) onPicked) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      final bytes = result.files.single.bytes!;
      PdfPageImage? thumb;
      final name = result.files.single.name.toLowerCase();
      if (name.endsWith('.pdf')) {
        try {
          final doc = await PdfDocument.openData(bytes);
          final page = await doc.getPage(1);
          thumb = await page.render(
              width: page.width,
              height: page.height,
              format: PdfPageImageFormat.png);
          await page.close();
          await doc.close();
        } catch (_) {}
      }
      onPicked(bytes, thumb);
    }
  }

  Future<String> _uploadFileFromBytes(Uint8List bytes, String fileName) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('seller_documents/${_user.uid}/$fileName');
      final uploadTask = await ref.putData(bytes);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _registerSeller() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms ||
          _gstBytes == null ||
          _panBytes == null ||
          _bankBytes == null) {
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

        final gstUrl =
            await _uploadFileFromBytes(_gstBytes!, 'gst_certificate');
        final panUrl = await _uploadFileFromBytes(_panBytes!, 'pan_card');
        final bankUrl = await _uploadFileFromBytes(_bankBytes!, 'bank_proof');

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

  Widget _buildDocumentUpload(String label, Uint8List? fileBytes,
      VoidCallback onTap, PdfPageImage? thumbnail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (fileBytes != null)
          thumbnail != null
              ? Image.memory(thumbnail.bytes,
                  height: 100, width: 100, fit: BoxFit.cover)
              : Image.memory(fileBytes,
                  height: 100, width: 100, fit: BoxFit.cover),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onTap,
          child: Text(fileBytes == null ? 'Upload $label' : 'Replace $label'),
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
                          "Business Type", _businessTypeController),
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
                      _buildDocumentUpload("GST Certificate", _gstBytes, () {
                        _pickPdfOrImage((bytes, thumb) {
                          setState(() {
                            _gstBytes = bytes;
                            _gstThumb = thumb;
                          });
                        });
                      }, _gstThumb),
                      _buildDocumentUpload(
                          "PAN Card", _panBytes, _pickPanCard, null),
                      _buildDocumentUpload("Bank Proof", _bankBytes, () {
                        _pickPdfOrImage((bytes, thumb) {
                          setState(() {
                            _bankBytes = bytes;
                            _bankThumb = thumb;
                          });
                        });
                      }, _bankThumb),
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
                      ElevatedButton(
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
