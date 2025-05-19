// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io';
//
// class UploadItemScreen extends StatefulWidget {
//   @override
//   _UploadItemScreenState createState() => _UploadItemScreenState();
// }
//
// class _UploadItemScreenState extends State<UploadItemScreen> {
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
//   List<File> _selectedImages = [];
//   List<File> _selectedVideos = [];
//
//   bool _isUploading = false;
//
//   // Dropdown for categories
//   String? _selectedCategory;
//   final List<String> _categories = [
//     'Electronics',
//     'Clothing',
//     'Footwear',
//     'Accessories',
//     'Home Appliances',
//     'Books',
//     'Others',
//   ];
//
//   // Get the current user
//   User? getCurrentUser() {
//     return FirebaseAuth.instance.currentUser;
//   }
//
//   Future<void> _pickImages() async {
//     final List<XFile>? pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
//       });
//     }
//   }
//
//   Future<void> _pickVideos() async {
//     final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedVideos.add(File(pickedFile.path));
//       });
//     }
//   }
//
//   Future<List<String>> _uploadFiles(List<File> files, String folderName) async {
//     List<String> downloadUrls = [];
//     try {
//       // Upload files in parallel
//       final uploadTasks = files.map((file) async {
//         String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//         Reference ref = FirebaseStorage.instance
//             .ref()
//             .child('$folderName/$fileName');
//         await ref.putFile(file);
//         return await ref.getDownloadURL();
//       }).toList();
//
//       // Wait for all uploads to complete
//       downloadUrls = await Future.wait(uploadTasks);
//     } catch (e) {
//       print('Error uploading files: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to upload files: $e')),
//       );
//     }
//     return downloadUrls;
//   }
//
//   Future<void> _uploadItem() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isUploading = true;
//       });
//
//       try {
//         // Get the current user
//         User? user = getCurrentUser();
//         if (user == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('No user is logged in!')),
//           );
//           return;
//         }
//
//         // Check if a category is selected
//         if (_selectedCategory == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Please select a category')),
//           );
//           return;
//         }
//
//         // Show upload started message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Uploading item...')),
//         );
//
//         // Upload images and videos to Firebase Storage in parallel
//         List<String> imageUrls = await _uploadFiles(_selectedImages, 'item_images');
//         List<String> videoUrls = await _uploadFiles(_selectedVideos, 'item_videos');
//
//         // Save item details to Firestore under the selected category
//         await FirebaseFirestore.instance
//             .collection('seller')
//             .doc(user.uid)
//             .collection(_selectedCategory!) // Use the selected category
//             .add({
//           'name': _nameController.text,
//           'category': _selectedCategory,
//           'shopName': _shopNameController.text,
//           'brandName': _brandNameController.text,
//           'description': _descriptionController.text,
//           'productDetails': _productDetailsController.text,
//           'price': double.parse(_priceController.text),
//           'offerPrice': double.parse(_offerPriceController.text),
//           'images': imageUrls,
//           'videos': videoUrls,
//           'timestamp': FieldValue.serverTimestamp(),
//         });
//
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Item uploaded successfully!')),
//         );
//
//         // Clear form and media
//         _formKey.currentState!.reset();
//         setState(() {
//           _selectedImages.clear();
//           _selectedVideos.clear();
//           _selectedCategory = null;
//           _isUploading = false;
//         });
//       } catch (e) {
//         print('Error uploading item: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to upload item: $e')),
//         );
//         setState(() {
//           _isUploading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Item Name'),
//                 validator: (value) =>
//                 value!.isEmpty ? 'Please enter the item name' : null,
//               ),
//               SizedBox(height: 16),
//               // Dropdown for categories
//               DropdownButtonFormField<String>(
//                 value: _selectedCategory,
//                 decoration: InputDecoration(labelText: 'Category'),
//                 items: _categories.map((String category) {
//                   return DropdownMenuItem<String>(
//                     value: category,
//                     child: Text(category),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedCategory = value;
//                   });
//                 },
//                 validator: (value) =>
//                 value == null ? 'Please select a category' : null,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _shopNameController,
//                 decoration: InputDecoration(labelText: 'Shop Name'),
//                 validator: (value) =>
//                 value!.isEmpty ? 'Please enter the shop name' : null,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _brandNameController,
//                 decoration: InputDecoration(labelText: 'Brand Name'),
//                 validator: (value) =>
//                 value!.isEmpty ? 'Please enter the brand name' : null,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//                 validator: (value) =>
//                 value!.isEmpty ? 'Please enter the description' : null,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _productDetailsController,
//                 decoration: InputDecoration(labelText: 'Product Details'),
//                 maxLines: 5,
//                 validator: (value) =>
//                 value!.isEmpty ? 'Please enter the product details' : null,
//               ),
//               SizedBox(height: 16),
//               // Price and Offer Price fields
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _priceController,
//                       decoration: InputDecoration(labelText: 'Price'),
//                       keyboardType: TextInputType.number,
//                       validator: (value) =>
//                       value!.isEmpty ? 'Please enter the price' : null,
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _offerPriceController,
//                       decoration: InputDecoration(labelText: 'Offer Price'),
//                       keyboardType: TextInputType.number,
//                       validator: (value) =>
//                       value!.isEmpty ? 'Please enter the offer price' : null,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Text('Selected Images:'),
//               _selectedImages.isNotEmpty
//                   ? Wrap(
//                 spacing: 8.0,
//                 children: _selectedImages
//                     .map((file) => Image.file(
//                   file,
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ))
//                     .toList(),
//               )
//                   : Text('No images selected.'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _pickImages,
//                 child: Text('Pick Images'),
//               ),
//               SizedBox(height: 16),
//               Text('Selected Videos:'),
//               _selectedVideos.isNotEmpty
//                   ? Wrap(
//                 spacing: 8.0,
//                 children: _selectedVideos
//                     .map((file) => VideoThumbnail(file: file)) // Only pass file
//                     .toList(),
//               )
//                   : Text('No videos selected.'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _pickVideos,
//                 child: Text('Pick Videos'),
//               ),
//               SizedBox(height: 20),
//               _isUploading
//                   ? Center(child: CircularProgressIndicator())
//                   : ElevatedButton(
//                 onPressed: _uploadItem,
//                 child: Text('Upload Item'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Widget to display video thumbnails and play videos
// class VideoThumbnail extends StatefulWidget {
//   final File file;
//
//   VideoThumbnail({required this.file}); // Remove videoUrl parameter
//
//   @override
//   _VideoThumbnailState createState() => _VideoThumbnailState();
// }
//
// class _VideoThumbnailState extends State<VideoThumbnail> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(widget.file)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlay() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _togglePlay,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             color: Colors.grey[300],
//             child: _controller.value.isInitialized
//                 ? AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             )
//                 : Center(child: CircularProgressIndicator()),
//           ),
//           Icon(
//             _isPlaying ? Icons.pause : Icons.play_arrow,
//             size: 50,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }

// price and offer price are optional

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class UploadItemScreen extends StatefulWidget {
  const UploadItemScreen({super.key});

  @override
  _UploadItemScreenState createState() => _UploadItemScreenState();
}

class _UploadItemScreenState extends State<UploadItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  String? selectedShowCashonDelivery = "No";
  final List<File> _selectedImages = [];
  final List<File> _selectedVideos = [];
  final List<String> showCashonDelivery = ["Yes", "No"];

  bool _isUploading = false;

  // Dropdown for categories
  String? _selectedCategory;
  final List<String> _categories = [
    'Electronics',
    'Clothing',
    'Footwear',
    'Accessories',
    'Home Appliances',
    'Books',
    'Others',
  ];

  // List to store key-value pairs for product details
  final List<Map<String, String>> _productDetailsList = [];

  // Get the current user
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  // Pick images from gallery
  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
    });
  }

  // Pick videos from gallery
  Future<void> _pickVideos() async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedVideos.add(File(pickedFile.path));
      });
    }
  }

  // Upload files to Firebase Storage
  Future<List<String>> _uploadFiles(List<File> files, String folderName) async {
    List<String> downloadUrls = [];
    try {
      final uploadTasks = files.map((file) async {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref =
            FirebaseStorage.instance.ref().child('$folderName/$fileName');
        await ref.putFile(file);
        return await ref.getDownloadURL();
      }).toList();

      downloadUrls = await Future.wait(uploadTasks);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload files: $e')),
      );
    }
    return downloadUrls;
  }

  // Add a new key-value pair for product details
  void _addProductDetail() {
    setState(() {
      _productDetailsList.add({'key': '', 'value': ''});
    });
  }

  // Remove a key-value pair for product details
  void _removeProductDetail(int index) {
    setState(() {
      _productDetailsList.removeAt(index);
    });
  }

  // Upload item to Firestore
  Future<void> _uploadItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUploading = true;
      });

      try {
        User? user = getCurrentUser();
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user is logged in!')),
          );
          return;
        }

        if (_selectedCategory == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a category')),
          );
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Uploading item...')),
        );

        // Upload images and videos
        List<String> imageUrls =
            await _uploadFiles(_selectedImages, 'item_images');
        List<String> videoUrls =
            await _uploadFiles(_selectedVideos, 'item_videos');

        // Convert product details list to a map
        Map<String, dynamic> productDetailsMap = {};
        for (var detail in _productDetailsList) {
          productDetailsMap[detail['key']!] = detail['value'];
        }
        final productRef = FirebaseFirestore.instance
            .collection('seller')
            .doc(user.uid)
            .collection(_selectedCategory!)
            .doc();

        final productId = productRef.id;
        // Save item details to Firestore
        await FirebaseFirestore.instance
            .collection('seller')
            .doc(user.uid)
            .collection(_selectedCategory!)
            .add({
          'name': _nameController.text,
          'category': _selectedCategory,
          'shopName': _shopNameController.text,
          'isShowCashOnDelivery': selectedShowCashonDelivery,
          'brandName': _brandNameController.text,
          'productSellerId': user.uid,
          'productId': productId,
          'description': _descriptionController.text,
          'productDetails': productDetailsMap, // Store as a map
          'images': imageUrls,
          'videos': videoUrls,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item uploaded successfully!')),
        );

        // Clear form and media
        _formKey.currentState!.reset();
        setState(() {
          _selectedImages.clear();
          _selectedVideos.clear();
          _selectedCategory = null;
          _productDetailsList.clear();
          _isUploading = false;
        });
      } catch (e) {
        print('Error uploading item: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload item: $e')),
        );
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    selectedShowCashonDelivery = "No";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
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
              const Text('Product Details:'),
              ..._productDetailsList.map((detail) {
                int index = _productDetailsList.indexOf(detail);
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Key'),
                        onChanged: (value) {
                          setState(() {
                            _productDetailsList[index]['key'] = value;
                          });
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a key' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Value'),
                        onChanged: (value) {
                          setState(() {
                            _productDetailsList[index]['value'] = value;
                          });
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a value' : null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => _removeProductDetail(index),
                    ),
                  ],
                );
              }),
              _showCashonDelivery(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addProductDetail,
                child: const Text('Add Product Detail'),
              ),
              const SizedBox(height: 16),
              const Text('Selected Images:'),
              _selectedImages.isNotEmpty
                  ? Wrap(
                      spacing: 8.0,
                      children: _selectedImages
                          .map((file) => Image.file(
                                file,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                    )
                  : const Text('No images selected.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImages,
                child: const Text('Pick Images'),
              ),
              const SizedBox(height: 16),
              const Text('Selected Videos:'),
              _selectedVideos.isNotEmpty
                  ? Wrap(
                      spacing: 8.0,
                      children: _selectedVideos
                          .map((file) => VideoThumbnail(file: file))
                          .toList(),
                    )
                  : const Text('No videos selected.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickVideos,
                child: const Text('Pick Videos'),
              ),
              const SizedBox(height: 20),
              _isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _uploadItem,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Upload Item'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showCashonDelivery() {
    final items = showCashonDelivery
        .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ))
        .toList();
    return DropdownButtonFormField<String>(
      value: selectedShowCashonDelivery, // <-- FIXED
      decoration: const InputDecoration(labelText: 'Cash on Delivery'),
      items: items,
      onChanged: (String? val) {
        setState(() {
          selectedShowCashonDelivery = val!;
        });
      },
      validator: (value) =>
          value == null ? 'Please select cash on delivery option' : null,
    );
  }
}

// Widget to display video thumbnails and play videos
class VideoThumbnail extends StatefulWidget {
  final File file;

  const VideoThumbnail({super.key, required this.file});

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.grey[300],
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            size: 50,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
