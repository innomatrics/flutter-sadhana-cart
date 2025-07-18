import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sadhana_cart/Seller/helper/picked_pdf_result.dart';
import 'package:sadhana_cart/Seller/hold_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class SellerRegistrationScreen extends StatefulWidget {
  const SellerRegistrationScreen({super.key});

  @override
  _SellerRegistrationScreenState createState() =>
      _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
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

  PdfPageImage? _gstCertificateThumbnail;
  PdfPageImage? _bankProofThumbnail;

  late User _user;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _user = user;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user logged in.')),
      );
      Navigator.pop(context);
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

  Future<void> _pickPanCard() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _panCard = File(image.path);
      });
    }
  }

  Future<String> _uploadFile(File file, String fileName) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('seller_documents/${_user.uid}/$fileName');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Upload failed: $e');
      rethrow;
    }
  }

  Future<void> _registerSeller() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to the terms')),
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

        setState(() => _isLoading = false);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HoldScreen()),
        );
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
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
      appBar: AppBar(title: const Text('Seller Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_shopNameController, 'Shop Name'),
              _buildTextField(_addressController, 'Business Address'),
              _buildTextField(_phoneController, 'Phone Number',
                  keyboardType: TextInputType.phone),
              _buildTextField(_gstController, 'GST Number'),
              _buildTextField(_panController, 'PAN Number'),
              _buildTextField(_bankAccountController, 'Bank Account',
                  keyboardType: TextInputType.number),
              _buildTextField(_businessTypeController, 'Business Type'),
              const SizedBox(height: 24),
              const Text('Upload Documents',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildDocumentUpload('GST Certificate', _gstCertificate, 'gst',
                  () async {
                final picked = await pickPdfFile();
                if (picked != null) {
                  setState(() {
                    _gstCertificate = picked.file;
                    _gstCertificateThumbnail = picked.thumbnail;
                  });
                }
              }, thumbnail: _gstCertificateThumbnail),
              _buildDocumentUpload('PAN Card', _panCard, 'pan', () async {
                await _pickPanCard(); // only image picker
              }),
              _buildDocumentUpload('Bank Proof', _bankProof, 'bank', () async {
                final picked = await pickPdfFile();
                if (picked != null) {
                  setState(() {
                    _bankProof = picked.file;
                    _bankProofThumbnail = picked.thumbnail;
                  });
                }
              }, thumbnail: _bankProofThumbnail),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (val) =>
                        setState(() => _agreeToTerms = val ?? false),
                  ),
                  const Text('I agree to the terms and conditions'),
                ],
              ),
              const SizedBox(height: 20),
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

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Enter $label' : null,
      ),
    );
  }
}
