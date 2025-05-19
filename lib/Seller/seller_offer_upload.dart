import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class OffersUploadingScreen extends StatefulWidget {
  const OffersUploadingScreen({super.key});

  @override
  State<OffersUploadingScreen> createState() => _OffersUploadingScreenState();
}

class _OffersUploadingScreenState extends State<OffersUploadingScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  String? _sellerId;

  @override
  void initState() {
    super.initState();
    _getCurrentSellerId();
  }

  void _getCurrentSellerId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _sellerId = user.uid;
      });
    }
  }

  Future<void> _pickBanner() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadBanner() async {
    if (_selectedImage == null || _sellerId == null) return;

    setState(() => _isUploading = true);

    try {
      final fileName = basename(_selectedImage!.path);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('seller_offers/$_sellerId/$fileName');

      await storageRef.putFile(_selectedImage!);
      final downloadUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('seller')
          .doc(_sellerId)
          .collection('offers')
          .add({
        'bannerUrl': downloadUrl,
        'uploadedAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Offer banner uploaded successfully!')),
      );

      setState(() {
        _selectedImage = null;
        _isUploading = false;
      });
    } catch (e) {
      print("Upload error: $e");
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Failed to upload banner.')),
      );
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sellerId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Offers Uploading Screen')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Offers Uploading Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_selectedImage != null)
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ElevatedButton.icon(
              onPressed: _pickBanner,
              icon: const Icon(Icons.image),
              label: const Text('Choose a Banner'),
            ),
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  onPressed: _isUploading ? null : _uploadBanner,
                  icon: const Icon(Icons.cloud_upload),
                  label: _isUploading
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                      : const Text('Upload Banner'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
