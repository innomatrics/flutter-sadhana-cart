import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditItemScreen extends StatefulWidget {
  final DocumentSnapshot item;

  const EditItemScreen({super.key, required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _productDetailsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<String> _imageUrls = [];
  List<String> _videoUrls = [];
  final List<File> _newImages = [];
  final List<File> _newVideos = [];

  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _loadItemData();
  }

  void _loadItemData() {
    // Initialize controllers with existing data
    _nameController.text = widget.item['name'];
    _shopNameController.text = widget.item['shopName'];
    _brandNameController.text = widget.item['brandName'];
    _descriptionController.text = widget.item['description'];
    _productDetailsController.text = widget.item['productDetails'];
    _priceController.text = widget.item['price'].toString();
    _offerPriceController.text = widget.item['offerPrice'].toString();
    _imageUrls = List.from(widget.item['images']);
    _videoUrls = List.from(widget.item['videos']);
  }

  Future<void> _pickImage(int index) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newImages.add(File(pickedFile.path));
        _imageUrls[index] = pickedFile.path; // Show the new image in the UI
      });
    }
  }

  Future<void> _pickVideo(int index) async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newVideos.add(File(pickedFile.path));
        _videoUrls[index] = pickedFile.path; // Show the new video in the UI
      });
    }
  }

  Future<void> _updateItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUpdating = true;
      });

      try {
        // Upload new images and videos
        final List<String> updatedImageUrls = await _uploadFiles(_newImages, 'item_images');
        final List<String> updatedVideoUrls = await _uploadFiles(_newVideos, 'item_videos');

        // Replace old URLs with new URLs
        for (int i = 0; i < _imageUrls.length; i++) {
          if (_imageUrls[i].startsWith('/')) {
            _imageUrls[i] = updatedImageUrls.removeAt(0);
          }
        }

        for (int i = 0; i < _videoUrls.length; i++) {
          if (_videoUrls[i].startsWith('/')) {
            _videoUrls[i] = updatedVideoUrls.removeAt(0);
          }
        }

        // Update item in Firestore
        await FirebaseFirestore.instance
            .collection('seller')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(widget.item['category'])
            .doc(widget.item.id)
            .update({
          'name': _nameController.text,
          'shopName': _shopNameController.text,
          'brandName': _brandNameController.text,
          'description': _descriptionController.text,
          'productDetails': _productDetailsController.text,
          'price': double.parse(_priceController.text),
          'offerPrice': double.parse(_offerPriceController.text),
          'images': _imageUrls,
          'videos': _videoUrls,
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item updated successfully!')),
        );

        // Fetch updated data from Firestore
        final updatedItem = await FirebaseFirestore.instance
            .collection('seller')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(widget.item['category'])
            .doc(widget.item.id)
            .get();

        // Update UI with the new data
        setState(() {
          _isUpdating = false;
          _newImages.clear();
          _newVideos.clear();
          _imageUrls = List.from(updatedItem['images']);
          _videoUrls = List.from(updatedItem['videos']);
        });
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update item: $e')),
        );
      } finally {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  Future<List<String>> _uploadFiles(List<File> files, String folderName) async {
    List<String> downloadUrls = [];
    for (var file in files) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('$folderName/$fileName');
      await ref.putFile(file);
      String url = await ref.getDownloadURL();
      downloadUrls.add(url);
    }
    return downloadUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter the item name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _shopNameController,
                decoration: const InputDecoration(labelText: 'Shop Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter the shop name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _brandNameController,
                decoration: const InputDecoration(labelText: 'Brand Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter the brand name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) =>
                value!.isEmpty ? 'Please enter the description' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _productDetailsController,
                decoration: const InputDecoration(labelText: 'Product Details'),
                maxLines: 5,
                validator: (value) =>
                value!.isEmpty ? 'Please enter the product details' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Please enter the price' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _offerPriceController,
                decoration: const InputDecoration(labelText: 'Offer Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Please enter the offer price' : null,
              ),
              const SizedBox(height: 16),
              const Text(
                'Images:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: _imageUrls.asMap().entries.map((entry) {
                  final index = entry.key;
                  final imageUrl = entry.value;

                  return GestureDetector(
                    onTap: () => _pickImage(index),
                    child: imageUrl.startsWith('/')
                        ? Image.file(
                      File(imageUrl),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, size: 100);
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Videos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: _videoUrls.asMap().entries.map((entry) {
                  final index = entry.key;
                  final videoUrl = entry.value;

                  return GestureDetector(
                    onTap: () => _pickVideo(index),
                    child: videoUrl.startsWith('/')
                        ? Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                    )
                        : Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isUpdating ? null : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _isUpdating ? null : _updateItem,
                    child: _isUpdating
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Update Changes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// check once


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io';
//
// class EditItemScreen extends StatefulWidget {
//   final DocumentSnapshot item;
//
//   EditItemScreen({required this.item});
//
//   @override
//   _EditItemScreenState createState() => _EditItemScreenState();
// }
//
// class _EditItemScreenState extends State<EditItemScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _brandNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _productDetailsController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _offerPriceController = TextEditingController();
//
//   final ImagePicker _picker = ImagePicker();
//   List<String> _imageUrls = [];
//   List<String> _videoUrls = [];
//   List<File> _newImages = [];
//   List<File> _newVideos = [];
//
//   bool _isUpdating = false;
//
//   late Stream<DocumentSnapshot> _itemStream;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadItemData();
//
//     // Set up a stream to listen for real-time updates
//     _itemStream = FirebaseFirestore.instance
//         .collection('seller')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection(widget.item['category'])
//         .doc(widget.item.id)
//         .snapshots();
//   }
//
//   void _loadItemData() {
//     // Initialize controllers with existing data
//     _nameController.text = widget.item['name'];
//     _shopNameController.text = widget.item['shopName'];
//     _brandNameController.text = widget.item['brandName'];
//     _descriptionController.text = widget.item['description'];
//     _productDetailsController.text = widget.item['productDetails'];
//     _priceController.text = widget.item['price'].toString();
//     _offerPriceController.text = widget.item['offerPrice'].toString();
//     _imageUrls = List.from(widget.item['images']);
//     _videoUrls = List.from(widget.item['videos']);
//   }
//
//   Future<void> _pickImage(int index) async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _newImages.add(File(pickedFile.path));
//         _imageUrls[index] = pickedFile.path; // Show the new image in the UI
//       });
//     }
//   }
//
//   Future<void> _pickVideo(int index) async {
//     final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _newVideos.add(File(pickedFile.path));
//         _videoUrls[index] = pickedFile.path; // Show the new video in the UI
//       });
//     }
//   }
//
//   Future<void> _updateItem() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isUpdating = true;
//       });
//
//       try {
//         // Upload new images and videos
//         final List<String> updatedImageUrls = await _uploadFiles(_newImages, 'item_images');
//         final List<String> updatedVideoUrls = await _uploadFiles(_newVideos, 'item_videos');
//
//         // Replace old URLs with new URLs
//         for (int i = 0; i < _imageUrls.length; i++) {
//           if (_imageUrls[i].startsWith('/')) {
//             _imageUrls[i] = updatedImageUrls.removeAt(0);
//           }
//         }
//
//         for (int i = 0; i < _videoUrls.length; i++) {
//           if (_videoUrls[i].startsWith('/')) {
//             _videoUrls[i] = updatedVideoUrls.removeAt(0);
//           }
//         }
//
//         // Update item in Firestore
//         await FirebaseFirestore.instance
//             .collection('seller')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection(widget.item['category'])
//             .doc(widget.item.id)
//             .update({
//           'name': _nameController.text,
//           'shopName': _shopNameController.text,
//           'brandName': _brandNameController.text,
//           'description': _descriptionController.text,
//           'productDetails': _productDetailsController.text,
//           'price': double.parse(_priceController.text),
//           'offerPrice': double.parse(_offerPriceController.text),
//           'images': _imageUrls,
//           'videos': _videoUrls,
//         });
//
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Item updated successfully!')),
//         );
//       } catch (e) {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update item: $e')),
//         );
//       } finally {
//         setState(() {
//           _isUpdating = false;
//         });
//       }
//     }
//   }
//
//   Future<List<String>> _uploadFiles(List<File> files, String folderName) async {
//     List<String> downloadUrls = [];
//     for (var file in files) {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference ref = FirebaseStorage.instance
//           .ref()
//           .child('$folderName/$fileName');
//       await ref.putFile(file);
//       String url = await ref.getDownloadURL();
//       downloadUrls.add(url);
//     }
//     return downloadUrls;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Item'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: _itemStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('No data found.'));
//           }
//
//           final itemData = snapshot.data!.data() as Map<String, dynamic>;
//
//           // Update UI with the latest data
//           _nameController.text = itemData['name'];
//           _shopNameController.text = itemData['shopName'];
//           _brandNameController.text = itemData['brandName'];
//           _descriptionController.text = itemData['description'];
//           _productDetailsController.text = itemData['productDetails'];
//           _priceController.text = itemData['price'].toString();
//           _offerPriceController.text = itemData['offerPrice'].toString();
//           _imageUrls = List.from(itemData['images']);
//           _videoUrls = List.from(itemData['videos']);
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: InputDecoration(labelText: 'Item Name'),
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter the item name' : null,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _shopNameController,
//                     decoration: InputDecoration(labelText: 'Shop Name'),
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter the shop name' : null,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _brandNameController,
//                     decoration: InputDecoration(labelText: 'Brand Name'),
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter the brand name' : null,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(labelText: 'Description'),
//                     maxLines: 3,
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter the description' : null,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _productDetailsController,
//                     decoration: InputDecoration(labelText: 'Product Details'),
//                     maxLines: 5,
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter the product details' : null,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _priceController,
//                     decoration: InputDecoration(labelText: 'Price'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter the price' : null,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _offerPriceController,
//                     decoration: InputDecoration(labelText: 'Offer Price'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) =>
//                     value!.isEmpty ? 'Please enter the offer price' : null,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Images:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8.0,
//                     children: _imageUrls.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final imageUrl = entry.value;
//
//                       return GestureDetector(
//                         onTap: () => _pickImage(index),
//                         child: imageUrl.startsWith('/')
//                             ? Image.file(
//                           File(imageUrl),
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         )
//                             : Image.network(
//                           imageUrl,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Icon(Icons.image, size: 100);
//                           },
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Videos:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8.0,
//                     children: _videoUrls.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final videoUrl = entry.value;
//
//                       return GestureDetector(
//                         onTap: () => _pickVideo(index),
//                         child: videoUrl.startsWith('/')
//                             ? Container(
//                           width: 100,
//                           height: 100,
//                           color: Colors.grey[300],
//                           child: Icon(
//                             Icons.play_arrow,
//                             size: 50,
//                             color: Colors.white,
//                           ),
//                         )
//                             : Container(
//                           width: 100,
//                           height: 100,
//                           color: Colors.grey[300],
//                           child: Icon(
//                             Icons.play_arrow,
//                             size: 50,
//                             color: Colors.white,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: _isUpdating ? null : () => Navigator.of(context).pop(),
//                         child: Text('Cancel'),
//                       ),
//                       ElevatedButton(
//                         onPressed: _isUpdating ? null : _updateItem,
//                         child: _isUpdating
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text('Update Changes'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }