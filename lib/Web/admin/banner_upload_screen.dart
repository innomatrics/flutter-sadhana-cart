// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// class BannerUploadScreen extends StatefulWidget {
//   @override
//   _BannerUploadScreenState createState() => _BannerUploadScreenState();
// }
//
// class _BannerUploadScreenState extends State<BannerUploadScreen> {
//   File? _bannerImage;
//   final TextEditingController _percentageController = TextEditingController();
//   bool _isUploading = false;
//   final String _adminDocId = 'admin_document'; // Replace with your actual admin doc ID
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _bannerImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   Future<void> _uploadBanner() async {
//     if (_bannerImage == null || _percentageController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select an image and enter percentage')),
//       );
//       return;
//     }
//
//     setState(() {
//       _isUploading = true;
//     });
//
//     try {
//       // Upload image to Firebase Storage
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('banners/${DateTime.now().millisecondsSinceEpoch}.jpg');
//       await storageRef.putFile(_bannerImage!);
//       final imageUrl = await storageRef.getDownloadURL();
//
//       // Save data to Firestore in the banners subcollection
//       await FirebaseFirestore.instance
//           .collection('admin')
//           .doc(_adminDocId)
//           .collection('banners')
//           .add({
//         'imageUrl': imageUrl,
//         'percentage': int.parse(_percentageController.text),
//         'createdAt': FieldValue.serverTimestamp(),
//         'isActive': true, // You can use this to enable/disable banners later
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Banner uploaded successfully!')),
//       );
//
//       setState(() {
//         _bannerImage = null;
//         _percentageController.clear();
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error uploading banner: $e')),
//       );
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _percentageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Banner'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Banner Image'),
//             ),
//             SizedBox(height: 16),
//             if (_bannerImage != null)
//               Image.file(
//                 _bannerImage!,
//                 height: 150,
//                 fit: BoxFit.cover,
//               ),
//             SizedBox(height: 24),
//             TextField(
//               controller: _percentageController,
//               decoration: InputDecoration(
//                 labelText: 'Percentage',
//                 hintText: 'Enter percentage (e.g., 10, 20, 30)',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: _isUploading ? null : _uploadBanner,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 padding: EdgeInsets.symmetric(vertical: 16),
//               ),
//               child: _isUploading
//                   ? CircularProgressIndicator(color: Colors.white)
//                   : Text(
//                 'Upload Banner',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BannerUploadScreen extends StatefulWidget {
  @override
  _BannerUploadScreenState createState() => _BannerUploadScreenState();
}

class _BannerUploadScreenState extends State<BannerUploadScreen> {
  File? _bannerImage;
  final TextEditingController _percentageController = TextEditingController();
  bool _isUploading = false;
  final String _adminDocId = 'admin_document'; // Replace with your actual admin doc ID
  String? _selectedCategory;

  final List<String> _categories = [
    'Clothing',
    'Electronics',
    'Footwear',
    'Accessories',
    'Home Appliances',
    'Books',
    'Vegetables'
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _bannerImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadBanner() async {
    if (_bannerImage == null ||
        _percentageController.text.isEmpty ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields: image, percentage, and category')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('banners/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_bannerImage!);
      final imageUrl = await storageRef.getDownloadURL();

      // Save data to Firestore in the banners subcollection
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(_adminDocId)
          .collection('banners')
          .add({
        'imageUrl': imageUrl,
        'percentage': int.parse(_percentageController.text),
        'category': _selectedCategory,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Banner uploaded successfully!')),
      );

      setState(() {
        _bannerImage = null;
        _percentageController.clear();
        _selectedCategory = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading banner: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  void dispose() {
    _percentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Banner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Banner Image'),
            ),
            SizedBox(height: 16),
            if (_bannerImage != null)
              Image.file(
                _bannerImage!,
                height: 150,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 24),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  hint: Text('Select a category'),
                  isExpanded: true,
                  items: _categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _percentageController,
              decoration: InputDecoration(
                labelText: 'Percentage',
                hintText: 'Enter percentage (e.g., 10, 20, 30)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadBanner,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isUploading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                'Upload Banner',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}