import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BrandUploadScreen extends StatefulWidget {
  const BrandUploadScreen({super.key});

  @override
  _BrandUploadScreenState createState() => _BrandUploadScreenState();
}

class _BrandUploadScreenState extends State<BrandUploadScreen> {
  final TextEditingController _brandNameController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadBrand() async {
    if (_brandNameController.text.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter brand name and select an image')),
      );
      return;
    }

    final brandName = _brandNameController.text.trim();
    final storageRef =
        FirebaseStorage.instance.ref().child('brands').child('$brandName.jpg');

    try {
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('brands').add({
        'name': brandName,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Brand uploaded successfully')),
      );

      _brandNameController.clear();
      setState(() {
        _selectedImage = null;
      });
    } catch (e) {
      print('Upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload brand')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Brand')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_selectedImage != null)
              CircleAvatar(
                backgroundImage: FileImage(_selectedImage!),
                radius: 50,
              ),
            TextField(
              controller: _brandNameController,
              decoration: const InputDecoration(labelText: 'Brand Name'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: const Text('Select from Gallery'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadBrand,
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
