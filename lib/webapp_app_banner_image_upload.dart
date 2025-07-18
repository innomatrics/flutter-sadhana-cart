import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class WebBannerUploadPage extends StatefulWidget {
  const WebBannerUploadPage({super.key});

  @override
  State<WebBannerUploadPage> createState() => _WebBannerUploadPageState();
}

class _WebBannerUploadPageState extends State<WebBannerUploadPage> {
  Uint8List? _imageBytes;
  String? _fileName;
  final TextEditingController _titleController = TextEditingController();
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes!;
        _fileName = result.files.single.name;
      });
    }
  }

  Future<void> _uploadBanner() async {
    if (_imageBytes == null || _titleController.text.trim().isEmpty) return;

    setState(() => _isUploading = true);

    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'adm/banners/${DateTime.now().millisecondsSinceEpoch}_$_fileName');

      final uploadTask = await storageRef.putData(_imageBytes!);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Assuming a single document ID like "main" under adm
      final adminDocId = "main"; // you can customize this as needed

      await FirebaseFirestore.instance
          .collection('adm')
          .doc(adminDocId)
          .collection('banners')
          .add({
        'title': _titleController.text.trim(),
        'imageUrl': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Banner uploaded successfully!')),
      );

      setState(() {
        _imageBytes = null;
        _fileName = null;
        _titleController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Upload New Banner',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Banner Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              _imageBytes != null
                  ? Column(
                      children: [
                        Image.memory(_imageBytes!, height: 150),
                        const SizedBox(height: 10),
                        Text(_fileName ?? ''),
                      ],
                    )
                  : const Text('No image selected'),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadBanner,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload Banner'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
