import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class WebLogoUploadPage extends StatefulWidget {
  const WebLogoUploadPage({super.key});

  @override
  State<WebLogoUploadPage> createState() => _WebLogoUploadPageState();
}

class _WebLogoUploadPageState extends State<WebLogoUploadPage> {
  Uint8List? _imageBytes;
  String? _fileName;
  bool _isUploading = false;

  Future<void> _pickLogo() async {
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

  Future<void> _uploadLogo() async {
    if (_imageBytes == null) return;

    setState(() => _isUploading = true);

    try {
      // Upload to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('adm/logos/${DateTime.now().millisecondsSinceEpoch}_$_fileName');

      final uploadTask = await storageRef.putData(_imageBytes!);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Save in Firestore under adm > main > logos
      await FirebaseFirestore.instance
          .collection('adm')
          .doc('main')
          .collection('logos')
          .add({
        'imageUrl': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logo uploaded successfully!')),
      );

      setState(() {
        _imageBytes = null;
        _fileName = null;
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
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Upload Logo',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  : const Text('No logo selected'),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Choose Logo'),
                onPressed: _pickLogo,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _isUploading ? null : _uploadLogo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload Logo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
