// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:video_player/video_player.dart';
// // import 'dart:io';
// //
// // class UploadItemScreen extends StatefulWidget {
// //   const UploadItemScreen({super.key});
// //
// //   @override
// //   _UploadItemScreenState createState() => _UploadItemScreenState();
// // }
// //
// // class _UploadItemScreenState extends State<UploadItemScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _shopNameController = TextEditingController();
// //   final TextEditingController _brandNameController = TextEditingController();
// //   final TextEditingController _descriptionController = TextEditingController();
// //   final TextEditingController _expectedDeliveryController = TextEditingController(); // New controller
// //
// //
// //   final ImagePicker _picker = ImagePicker();
// //   String? selectedShowCashonDelivery = "No";
// //   final List<File> _selectedImages = [];
// //   final List<File> _selectedVideos = [];
// //   final List<String> showCashonDelivery = ["Yes", "No"];
// //
// //   bool _isUploading = false;
// //
// //   // Dropdown for categories
// //   String? _selectedCategory;
// //   final List<String> _categories = [
// //     'Electronics',
// //     'Clothing',
// //     'Footwear',
// //     'Accessories',
// //     'Home Appliances',
// //     'Books',
// //     'Others',
// //   ];
// //
// //   // List to store key-value pairs for product details
// //   final List<Map<String, String>> _productDetailsList = [];
// //
// //   // Get the current user
// //   User? getCurrentUser() {
// //     return FirebaseAuth.instance.currentUser;
// //   }
// //
// //   // Pick images from gallery
// //   Future<void> _pickImages() async {
// //     final List<XFile> pickedFiles = await _picker.pickMultiImage();
// //     setState(() {
// //       _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
// //     });
// //   }
// //
// //   // Pick videos from gallery
// //   Future<void> _pickVideos() async {
// //     final XFile? pickedFile =
// //     await _picker.pickVideo(source: ImageSource.gallery);
// //     if (pickedFile != null) {
// //       setState(() {
// //         _selectedVideos.add(File(pickedFile.path));
// //       });
// //     }
// //   }
// //
// //   // Upload files to Firebase Storage
// //   Future<List<String>> _uploadFiles(List<File> files, String folderName) async {
// //     List<String> downloadUrls = [];
// //     try {
// //       final uploadTasks = files.map((file) async {
// //         String fileName = DateTime.now().millisecondsSinceEpoch.toString();
// //         Reference ref =
// //         FirebaseStorage.instance.ref().child('$folderName/$fileName');
// //         await ref.putFile(file);
// //         return await ref.getDownloadURL();
// //       }).toList();
// //
// //       downloadUrls = await Future.wait(uploadTasks);
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Failed to upload files: $e')),
// //       );
// //     }
// //     return downloadUrls;
// //   }
// //
// //   // Add a new key-value pair for product details
// //   void _addProductDetail() {
// //     setState(() {
// //       _productDetailsList.add({'key': '', 'value': ''});
// //     });
// //   }
// //
// //   // Remove a key-value pair for product details
// //   void _removeProductDetail(int index) {
// //     setState(() {
// //       _productDetailsList.removeAt(index);
// //     });
// //   }
// //
// //   // Upload item to Firestore
// //   Future<void> _uploadItem() async {
// //     if (_formKey.currentState!.validate()) {
// //       setState(() {
// //         _isUploading = true;
// //       });
// //
// //       try {
// //         User? user = getCurrentUser();
// //         if (user == null) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('No user is logged in!')),
// //           );
// //           return;
// //         }
// //
// //         if (_selectedCategory == null) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Please select a category')),
// //           );
// //           return;
// //         }
// //
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Uploading item...')),
// //         );
// //
// //         // Upload images and videos
// //         List<String> imageUrls =
// //         await _uploadFiles(_selectedImages, 'item_images');
// //         List<String> videoUrls =
// //         await _uploadFiles(_selectedVideos, 'item_videos');
// //
// //         // Convert product details list to a map
// //         Map<String, dynamic> productDetailsMap = {};
// //         for (var detail in _productDetailsList) {
// //           productDetailsMap[detail['key']!] = detail['value'];
// //         }
// //         final productRef = FirebaseFirestore.instance
// //             .collection('seller')
// //             .doc(user.uid)
// //             .collection(_selectedCategory!)
// //             .doc();
// //
// //         final productId = productRef.id;
// //         // Save item details to Firestore
// //         await FirebaseFirestore.instance
// //             .collection('seller')
// //             .doc(user.uid)
// //             .collection(_selectedCategory!)
// //             .add({
// //           'name': _nameController.text,
// //           'category': _selectedCategory,
// //           'shopName': _shopNameController.text,
// //           'isShowCashOnDelivery': selectedShowCashonDelivery,
// //           'brandName': _brandNameController.text,
// //           'productSellerId': user.uid,
// //           'expectedDelivery': _expectedDeliveryController.text, // New field
// //           'productId': productId,
// //           'description': _descriptionController.text,
// //           'productDetails': productDetailsMap, // Store as a map
// //           'images': imageUrls,
// //           'videos': videoUrls,
// //           'timestamp': FieldValue.serverTimestamp(),
// //         });
// //
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Item uploaded successfully!')),
// //         );
// //
// //         // Clear form and media
// //         _formKey.currentState!.reset();
// //         setState(() {
// //           _selectedImages.clear();
// //           _selectedVideos.clear();
// //           _selectedCategory = null;
// //           _productDetailsList.clear();
// //           _isUploading = false;
// //         });
// //       } catch (e) {
// //         print('Error uploading item: $e');
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Failed to upload item: $e')),
// //         );
// //         setState(() {
// //           _isUploading = false;
// //         });
// //       }
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     selectedShowCashonDelivery = "No";
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Card(
// //                 elevation: 4,
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Column(
// //                     children: [
// //                       TextFormField(
// //                         controller: _nameController,
// //                         decoration: InputDecoration(
// //                           labelText: 'Item Name',
// //                           prefixIcon: Icon(Icons.label),
// //                           border: OutlineInputBorder(),
// //                         ),
// //                         validator: (value) =>
// //                         value!.isEmpty ? 'Please enter the item name' : null,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       DropdownButtonFormField<String>(
// //                         value: _selectedCategory,
// //                         decoration: InputDecoration(
// //                           labelText: 'Category',
// //                           prefixIcon: Icon(Icons.category),
// //                           border: OutlineInputBorder(),
// //                         ),
// //                         items: _categories.map((String category) {
// //                           return DropdownMenuItem<String>(
// //                             value: category,
// //                             child: Text(category),
// //                           );
// //                         }).toList(),
// //                         onChanged: (value) {
// //                           setState(() {
// //                             _selectedCategory = value;
// //                           });
// //                         },
// //                         validator: (value) =>
// //                         value == null ? 'Please select a category' : null,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       TextFormField(
// //                         controller: _shopNameController,
// //                         decoration: InputDecoration(
// //                           labelText: 'Shop Name',
// //                           prefixIcon: Icon(Icons.store),
// //                           border: OutlineInputBorder(),
// //                         ),
// //                         validator: (value) =>
// //                         value!.isEmpty ? 'Please enter the shop name' : null,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       TextFormField(
// //                         controller: _brandNameController,
// //                         decoration: InputDecoration(
// //                           labelText: 'Brand Name',
// //                           prefixIcon: Icon(Icons.branding_watermark),
// //                           border: OutlineInputBorder(),
// //                         ),
// //                         validator: (value) =>
// //                         value!.isEmpty ? 'Please enter the brand name' : null,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       TextFormField(
// //                         controller: _expectedDeliveryController, // New field
// //                         decoration: InputDecoration(
// //                           labelText: 'Expected Delivery',
// //                           prefixIcon: Icon(Icons.delivery_dining),
// //                           border: OutlineInputBorder(),
// //                           hintText: 'e.g., 3-5 days, 1 week',
// //                         ),
// //                         validator: (value) =>
// //                         value!.isEmpty ? 'Please enter expected delivery time' : null,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       TextFormField(
// //                         controller: _descriptionController,
// //                         decoration: InputDecoration(
// //                           labelText: 'Description',
// //                           prefixIcon: Icon(Icons.description),
// //                           border: OutlineInputBorder(),
// //                         ),
// //                         maxLines: 3,
// //                         validator: (value) =>
// //                         value!.isEmpty ? 'Please enter the description' : null,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               const Text('Product Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //               ..._productDetailsList.map((detail) {
// //                 int index = _productDetailsList.indexOf(detail);
// //                 return Card(
// //                   elevation: 2,
// //                   margin: const EdgeInsets.only(bottom: 16),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(16.0),
// //                     child: Row(
// //                       children: [
// //                         Expanded(
// //                           child: TextFormField(
// //                             decoration: InputDecoration(
// //                               labelText: 'Key',
// //                               border: OutlineInputBorder(),
// //                             ),
// //                             onChanged: (value) {
// //                               setState(() {
// //                                 _productDetailsList[index]['key'] = value;
// //                               });
// //                             },
// //                             validator: (value) =>
// //                             value!.isEmpty ? 'Please enter a key' : null,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 16),
// //                         Expanded(
// //                           child: TextFormField(
// //                             decoration: InputDecoration(
// //                               labelText: 'Value',
// //                               border: OutlineInputBorder(),
// //                             ),
// //                             onChanged: (value) {
// //                               setState(() {
// //                                 _productDetailsList[index]['value'] = value;
// //                               });
// //                             },
// //                             validator: (value) =>
// //                             value!.isEmpty ? 'Please enter a value' : null,
// //                           ),
// //                         ),
// //                         IconButton(
// //                           icon: const Icon(Icons.remove_circle, color: Colors.red),
// //                           onPressed: () => _removeProductDetail(index),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               }),
// //               _showCashonDelivery(),
// //               const SizedBox(height: 16),
// //               ElevatedButton.icon(
// //                 onPressed: _addProductDetail,
// //                 icon: const Icon(Icons.add_circle_outline, color: Colors.white),
// //                 label: const Text(
// //                   'Add Product Detail',
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
// //                 ),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.blueAccent,
// //                   elevation: 6,
// //                   shadowColor: Colors.blueAccent.withOpacity(0.4),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
// //                 ).copyWith(
// //                   overlayColor: MaterialStateProperty.resolveWith<Color?>(
// //                         (Set<MaterialState> states) {
// //                       if (states.contains(MaterialState.pressed)) return Colors.blue.shade700;
// //                       return null;
// //                     },
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               const Text('Selected Images:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //               _selectedImages.isNotEmpty
// //                   ? Wrap(
// //                 spacing: 8.0,
// //                 children: _selectedImages
// //                     .map((file) => ClipRRect(
// //                   borderRadius: BorderRadius.circular(8.0),
// //                   child: Image.file(
// //                     file,
// //                     width: 100,
// //                     height: 100,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ))
// //                     .toList(),
// //               )
// //                   : const Text('No images selected.'),
// //               const SizedBox(height: 16),
// //
// //               ElevatedButton.icon(
// //                 onPressed: _pickImages,
// //                 icon: const Icon(Icons.add_circle_outline, color: Colors.white),
// //                 label: const Text(
// //                   'Pick Images',
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
// //                 ),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.blueAccent,
// //                   elevation: 6,
// //                   shadowColor: Colors.blueAccent.withOpacity(0.4),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
// //                 ).copyWith(
// //                   overlayColor: MaterialStateProperty.resolveWith<Color?>(
// //                         (Set<MaterialState> states) {
// //                       if (states.contains(MaterialState.pressed)) return Colors.blue.shade700;
// //                       return null;
// //                     },
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               const Text('Selected Videos:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //               _selectedVideos.isNotEmpty
// //                   ? Wrap(
// //                 spacing: 8.0,
// //                 children: _selectedVideos
// //                     .map((file) => VideoThumbnail(file: file))
// //                     .toList(),
// //               )
// //                   : const Text('No videos selected.'),
// //               const SizedBox(height: 16),
// //               ElevatedButton.icon(
// //                 onPressed: _pickVideos,
// //                 icon: const Icon(Icons.add_circle_outline, color: Colors.white),
// //                 label: const Text(
// //                   'Pick Videos',
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
// //                 ),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.blueAccent,
// //                   elevation: 6,
// //                   shadowColor: Colors.blueAccent.withOpacity(0.4),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
// //                 ).copyWith(
// //                   overlayColor: MaterialStateProperty.resolveWith<Color?>(
// //                         (Set<MaterialState> states) {
// //                       if (states.contains(MaterialState.pressed)) return Colors.blue.shade700;
// //                       return null;
// //                     },
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               _isUploading
// //                   ? const Center(child: CircularProgressIndicator())
// //                   : ElevatedButton(
// //                 onPressed: _uploadItem,
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.green,
// //                   minimumSize: const Size(double.infinity, 50),
// //                 ),
// //                 child: const Text('Upload Item'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _showCashonDelivery() {
// //     final items = showCashonDelivery
// //         .map((item) => DropdownMenuItem(
// //       value: item,
// //       child: Text(item),
// //     ))
// //         .toList();
// //     return DropdownButtonFormField<String>(
// //       value: selectedShowCashonDelivery, // <-- FIXED
// //       decoration: const InputDecoration(labelText: 'Cash on Delivery'),
// //       items: items,
// //       onChanged: (String? val) {
// //         setState(() {
// //           selectedShowCashonDelivery = val!;
// //         });
// //       },
// //       validator: (value) =>
// //       value == null ? 'Please select cash on delivery option' : null,
// //     );
// //   }
// // }
// //
// // // Widget to display video thumbnails and play videos
// // class VideoThumbnail extends StatefulWidget {
// //   final File file;
// //
// //   const VideoThumbnail({super.key, required this.file});
// //
// //   @override
// //   _VideoThumbnailState createState() => _VideoThumbnailState();
// // }
// //
// // class _VideoThumbnailState extends State<VideoThumbnail> {
// //   late VideoPlayerController _controller;
// //   bool _isPlaying = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = VideoPlayerController.file(widget.file)
// //       ..initialize().then((_) {
// //         setState(() {});
// //       });
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// //
// //   void _togglePlay() {
// //     setState(() {
// //       if (_controller.value.isPlaying) {
// //         _controller.pause();
// //         _isPlaying = false;
// //       } else {
// //         _controller.play();
// //         _isPlaying = true;
// //       }
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: _togglePlay,
// //       child: Stack(
// //         alignment: Alignment.center,
// //         children: [
// //           Container(
// //             width: 100,
// //             height: 100,
// //             color: Colors.grey[300],
// //             child: _controller.value.isInitialized
// //                 ? AspectRatio(
// //               aspectRatio: _controller.value.aspectRatio,
// //               child: VideoPlayer(_controller),
// //             )
// //                 : const Center(child: CircularProgressIndicator()),
// //           ),
// //           Icon(
// //             _isPlaying ? Icons.pause : Icons.play_arrow,
// //             size: 50,
// //             color: Colors.white,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// //  web

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// // import 'package:image_picker_web/image_picker_web.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_player_web/video_player_web.dart';
// import 'dart:html' as html;
// import 'dart:typed_data';

// class WebUploadItemScreen extends StatefulWidget {
//   const WebUploadItemScreen({super.key});

//   @override
//   _WebUploadItemScreenState createState() => _WebUploadItemScreenState();
// }

// class _WebUploadItemScreenState extends State<WebUploadItemScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _shopNameController = TextEditingController();
//   final TextEditingController _brandNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _expectedDeliveryController =
//       TextEditingController();

//   String? selectedShowCashonDelivery = "No";
//   final List<Uint8List> _selectedImages = [];
//   final List<Uint8List> _selectedVideos = [];
//   final List<String> showCashonDelivery = ["Yes", "No"];

//   bool _isUploading = false;

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

//   // List to store key-value pairs for product details
//   final List<Map<String, String>> _productDetailsList = [];

//   // Get the current user
//   User? getCurrentUser() {
//     return FirebaseAuth.instance.currentUser;
//   }

//   // Pick images from gallery - web version
//   Future<void> _pickImages() async {
//     final images = await ImagePickerWeb.getMultiImagesAsBytes();
//     if (images != null) {
//       setState(() {
//         _selectedImages.addAll(images);
//       });
//     }
//   }

//   // Pick videos from gallery - web version
//   Future<void> _pickVideos() async {
//     final video = await ImagePickerWeb.getVideoAsBytes();
//     if (video != null) {
//       setState(() {
//         _selectedVideos.add(video);
//       });
//     }
//   }

//   // Upload files to Firebase Storage - web version
//   Future<List<String>> _uploadFiles(
//       List<Uint8List> files, String folderName) async {
//     List<String> downloadUrls = [];
//     try {
//       for (var file in files) {
//         String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//         Reference ref =
//             FirebaseStorage.instance.ref().child('$folderName/$fileName');
//         await ref.putData(file);
//         downloadUrls.add(await ref.getDownloadURL());
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to upload files: $e')),
//       );
//     }
//     return downloadUrls;
//   }

//   // Add a new key-value pair for product details
//   void _addProductDetail() {
//     setState(() {
//       _productDetailsList.add({'key': '', 'value': ''});
//     });
//   }

//   // Remove a key-value pair for product details
//   void _removeProductDetail(int index) {
//     setState(() {
//       _productDetailsList.removeAt(index);
//     });
//   }

//   // Upload item to Firestore
//   Future<void> _uploadItem() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isUploading = true;
//       });

//       try {
//         User? user = getCurrentUser();
//         if (user == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('No user is logged in!')),
//           );
//           return;
//         }

//         if (_selectedCategory == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Please select a category')),
//           );
//           return;
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Uploading item...')),
//         );

//         // Upload images and videos
//         List<String> imageUrls =
//             await _uploadFiles(_selectedImages, 'item_images');
//         List<String> videoUrls =
//             await _uploadFiles(_selectedVideos, 'item_videos');

//         // Convert product details list to a map with trimmed keys and values
//         Map<String, dynamic> productDetailsMap = {};
//         for (var detail in _productDetailsList) {
//           final key = detail['key']?.trim() ?? '';
//           final value = detail['value']?.trim() ?? '';
//           if (key.isNotEmpty) {
//             // Only add non-empty keys
//             productDetailsMap[key] = value;
//           }
//         }

//         final productRef = FirebaseFirestore.instance
//             .collection('seller')
//             .doc(user.uid)
//             .collection(_selectedCategory!)
//             .doc();

//         final productId = productRef.id;

//         // Save item details to Firestore with trimmed values
//         await productRef.set({
//           'name': _nameController.text.trim(),
//           'category': _selectedCategory,
//           'shopName': _shopNameController.text.trim(),
//           'isShowCashOnDelivery': selectedShowCashonDelivery,
//           'brandName': _brandNameController.text.trim(),
//           'productSellerId': user.uid,
//           'expectedDelivery': _expectedDeliveryController.text.trim(),
//           'productId': productId,
//           'description': _descriptionController.text.trim(),
//           'productDetails': productDetailsMap,
//           'images': imageUrls,
//           'videos': videoUrls,
//           'timestamp': FieldValue.serverTimestamp(),
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Item uploaded successfully!')),
//         );

//         // Clear form and media
//         _formKey.currentState!.reset();
//         setState(() {
//           _selectedImages.clear();
//           _selectedVideos.clear();
//           _selectedCategory = null;
//           _productDetailsList.clear();
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

//   @override
//   void initState() {
//     super.initState();
//     selectedShowCashonDelivery = "No";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepOrange.shade100,
//       appBar: AppBar(
//         title: const Text('Upload Product'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 800),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Card(
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: _nameController,
//                             decoration: const InputDecoration(
//                               labelText: 'Item Name',
//                               prefixIcon: Icon(Icons.label),
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               final trimmedValue = value?.trim() ?? '';
//                               return trimmedValue.isEmpty
//                                   ? 'Please enter the item name'
//                                   : null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           DropdownButtonFormField<String>(
//                             value: _selectedCategory,
//                             decoration: const InputDecoration(
//                               labelText: 'Category',
//                               prefixIcon: Icon(Icons.category),
//                               border: OutlineInputBorder(),
//                             ),
//                             items: _categories.map((String category) {
//                               return DropdownMenuItem<String>(
//                                 value: category,
//                                 child: Text(category),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedCategory = value;
//                               });
//                             },
//                             validator: (value) => value == null
//                                 ? 'Please select a category'
//                                 : null,
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: _shopNameController,
//                             decoration: const InputDecoration(
//                               labelText: 'Shop Name',
//                               prefixIcon: Icon(Icons.store),
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               final trimmedValue = value?.trim() ?? '';
//                               return trimmedValue.isEmpty
//                                   ? 'Please enter the shop name'
//                                   : null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: _brandNameController,
//                             decoration: const InputDecoration(
//                               labelText: 'Brand Name',
//                               prefixIcon: Icon(Icons.branding_watermark),
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               final trimmedValue = value?.trim() ?? '';
//                               return trimmedValue.isEmpty
//                                   ? 'Please enter the brand name'
//                                   : null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: _expectedDeliveryController,
//                             decoration: const InputDecoration(
//                               labelText: 'Expected Delivery',
//                               prefixIcon: Icon(Icons.delivery_dining),
//                               border: OutlineInputBorder(),
//                               hintText: 'e.g., 3-5 days, 1 week',
//                             ),
//                             validator: (value) {
//                               final trimmedValue = value?.trim() ?? '';
//                               return trimmedValue.isEmpty
//                                   ? 'Please enter expected delivery time'
//                                   : null;
//                             },
//                           ),
//                           const SizedBox(height: 16),
//                           TextFormField(
//                             controller: _descriptionController,
//                             decoration: const InputDecoration(
//                               labelText: 'Description',
//                               prefixIcon: Icon(Icons.description),
//                               border: OutlineInputBorder(),
//                             ),
//                             maxLines: 3,
//                             validator: (value) {
//                               final trimmedValue = value?.trim() ?? '';
//                               return trimmedValue.isEmpty
//                                   ? 'Please enter the description'
//                                   : null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text('Product Details:',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   ..._productDetailsList.map((detail) {
//                     int index = _productDetailsList.indexOf(detail);
//                     return Card(
//                       elevation: 2,
//                       margin: const EdgeInsets.only(bottom: 16),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TextFormField(
//                                 decoration: const InputDecoration(
//                                   labelText: 'Key',
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _productDetailsList[index]['key'] =
//                                         value.trim();
//                                   });
//                                 },
//                                 validator: (value) {
//                                   final trimmedValue = value?.trim() ?? '';
//                                   return trimmedValue.isEmpty
//                                       ? 'Please enter a key'
//                                       : null;
//                                 },
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: TextFormField(
//                                 decoration: const InputDecoration(
//                                   labelText: 'Value',
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _productDetailsList[index]['value'] =
//                                         value.trim();
//                                   });
//                                 },
//                                 validator: (value) {
//                                   final trimmedValue = value?.trim() ?? '';
//                                   return trimmedValue.isEmpty
//                                       ? 'Please enter a value'
//                                       : null;
//                                 },
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.remove_circle,
//                                   color: Colors.red),
//                               onPressed: () => _removeProductDetail(index),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                   _showCashonDelivery(),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: _addProductDetail,
//                     icon: const Icon(Icons.add_circle_outline,
//                         color: Colors.white),
//                     label: const Text(
//                       'Add Product Detail',
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepOrange,
//                       elevation: 6,
//                       shadowColor: Colors.deepOrange.withOpacity(0.4),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 14),
//                     ).copyWith(
//                       overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.pressed))
//                             return Colors.deepOrange;
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text('Selected Images:',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   _selectedImages.isNotEmpty
//                       ? Wrap(
//                           spacing: 8.0,
//                           children: _selectedImages
//                               .map((bytes) => ClipRRect(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     child: Image.memory(
//                                       bytes,
//                                       width: 100,
//                                       height: 100,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ))
//                               .toList(),
//                         )
//                       : const Text('No images selected.'),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: _pickImages,
//                     icon: const Icon(Icons.add_circle_outline,
//                         color: Colors.white),
//                     label: const Text(
//                       'Pick Images',
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepOrange,
//                       elevation: 6,
//                       shadowColor: Colors.deepOrange.withOpacity(0.4),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 14),
//                     ).copyWith(
//                       overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.pressed))
//                             return Colors.deepOrange;
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text('Selected Videos:',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   _selectedVideos.isNotEmpty
//                       ? Wrap(
//                           spacing: 8.0,
//                           children: _selectedVideos
//                               .map((bytes) => VideoThumbnail(bytes: bytes))
//                               .toList(),
//                         )
//                       : const Text('No videos selected.'),
//                   const SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: _pickVideos,
//                     icon: const Icon(Icons.add_circle_outline,
//                         color: Colors.white),
//                     label: const Text(
//                       'Pick Videos',
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepOrange,
//                       elevation: 6,
//                       shadowColor: Colors.deepOrange.withOpacity(0.4),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 14),
//                     ).copyWith(
//                       overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                         (Set<MaterialState> states) {
//                           if (states.contains(MaterialState.pressed))
//                             return Colors.deepOrange;
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   _isUploading
//                       ? const Center(child: CircularProgressIndicator())
//                       : SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: _uploadItem,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               minimumSize: const Size(double.infinity, 50),
//                             ),
//                             child: const Text(
//                               'Upload Item',
//                               style: TextStyle(color: Colors.deepOrange),
//                             ),
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _showCashonDelivery() {
//     final items = showCashonDelivery
//         .map((item) => DropdownMenuItem(
//               value: item,
//               child: Text(item),
//             ))
//         .toList();
//     return DropdownButtonFormField<String>(
//       value: selectedShowCashonDelivery,
//       decoration: const InputDecoration(labelText: 'Cash on Delivery'),
//       items: items,
//       onChanged: (String? val) {
//         setState(() {
//           selectedShowCashonDelivery = val!;
//         });
//       },
//       validator: (value) =>
//           value == null ? 'Please select cash on delivery option' : null,
//     );
//   }
// }

// class VideoThumbnail extends StatefulWidget {
//   final Uint8List bytes;

//   const VideoThumbnail({super.key, required this.bytes});

//   @override
//   _VideoThumbnailState createState() => _VideoThumbnailState();
// }

// class _VideoThumbnailState extends State<VideoThumbnail> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     final blob = html.Blob([widget.bytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     _controller = VideoPlayerController.network(url)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

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
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   )
//                 : const Center(child: CircularProgressIndicator()),
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





// // updating the ui for web




// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:image_picker_web/image_picker_web.dart';
// // import 'package:video_player_web/video_player_web.dart';
// // import 'dart:html' as html;
// // import 'dart:typed_data';
// // import 'package:flutter_animate/flutter_animate.dart';
// //
// // class WebUploadItemScreen extends StatefulWidget {
// //   const WebUploadItemScreen({super.key});
// //
// //   @override
// //   _WebUploadItemScreenState createState() => _WebUploadItemScreenState();
// // }
// //
// // class _WebUploadItemScreenState extends State<WebUploadItemScreen> with SingleTickerProviderStateMixin {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _shopNameController = TextEditingController();
// //   final TextEditingController _brandNameController = TextEditingController();
// //   final TextEditingController _descriptionController = TextEditingController();
// //   final TextEditingController _expectedDeliveryController = TextEditingController();
// //
// //   String? selectedShowCashonDelivery = "No";
// //   final List<Uint8List> _selectedImages = [];
// //   final List<Uint8List> _selectedVideos = [];
// //   final List<String> showCashonDelivery = ["Yes", "No"];
// //
// //   bool _isUploading = false;
// //   late AnimationController _animationController;
// //   int _currentStep = 0;
// //
// //   // Color Scheme
// //   final Color primaryColor = const Color(0xFFE65100); // Deep Orange 900
// //   final Color secondaryColor = const Color(0xFFFFA726); // Orange 300
// //   final Color backgroundColor = const Color(0xFFF5F5F5);
// //   final Color cardColor = Colors.white;
// //   final Color textColor = const Color(0xFF424242);
// //
// //   // Dropdown for categories
// //   String? _selectedCategory;
// //   final List<String> _categories = [
// //     'Electronics',
// //     'Clothing',
// //     'Footwear',
// //     'Accessories',
// //     'Home Appliances',
// //     'Books',
// //     'Others',
// //   ];
// //
// //   // List to store key-value pairs for product details
// //   final List<Map<String, String>> _productDetailsList = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     selectedShowCashonDelivery = "No";
// //     _animationController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 500),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }
// //
// //
// //
// //   // Get the current user
// //   User? getCurrentUser() {
// //     return FirebaseAuth.instance.currentUser;
// //   }
// //
// //   // Pick images from gallery - web version
// //   Future<void> _pickImages() async {
// //     final images = await ImagePickerWeb.getMultiImagesAsBytes();
// //     if (images != null) {
// //       setState(() {
// //         _selectedImages.addAll(images);
// //       });
// //     }
// //   }
// //
// //   // Pick videos from gallery - web version
// //   Future<void> _pickVideos() async {
// //     final video = await ImagePickerWeb.getVideoAsBytes();
// //     if (video != null) {
// //       setState(() {
// //         _selectedVideos.add(video);
// //       });
// //     }
// //   }
// //
// //   // Upload files to Firebase Storage - web version
// //   Future<List<String>> _uploadFiles(List<Uint8List> files, String folderName) async {
// //     List<String> downloadUrls = [];
// //     try {
// //       for (var file in files) {
// //         String fileName = DateTime.now().millisecondsSinceEpoch.toString();
// //         Reference ref = FirebaseStorage.instance.ref().child('$folderName/$fileName');
// //         await ref.putData(file);
// //         downloadUrls.add(await ref.getDownloadURL());
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Failed to upload files: $e')),
// //       );
// //     }
// //     return downloadUrls;
// //   }
// //
// //   // Add a new key-value pair for product details
// //   void _addProductDetail() {
// //     setState(() {
// //       _productDetailsList.add({'key': '', 'value': ''});
// //     });
// //   }
// //
// //   // Remove a key-value pair for product details
// //   void _removeProductDetail(int index) {
// //     setState(() {
// //       _productDetailsList.removeAt(index);
// //     });
// //   }
// //
// //   // Upload item to Firestore
// //   Future<void> _uploadItem() async {
// //     if (_formKey.currentState!.validate()) {
// //       setState(() {
// //         _isUploading = true;
// //       });
// //
// //       try {
// //         User? user = getCurrentUser();
// //         if (user == null) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('No user is logged in!')),
// //           );
// //           return;
// //         }
// //
// //         if (_selectedCategory == null) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Please select a category')),
// //           );
// //           return;
// //         }
// //
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Uploading item...')),
// //         );
// //
// //         // Upload images and videos
// //         List<String> imageUrls = await _uploadFiles(_selectedImages, 'item_images');
// //         List<String> videoUrls = await _uploadFiles(_selectedVideos, 'item_videos');
// //
// //         // Convert product details list to a map with trimmed keys and values
// //         Map<String, dynamic> productDetailsMap = {};
// //         for (var detail in _productDetailsList) {
// //           final key = detail['key']?.trim() ?? '';
// //           final value = detail['value']?.trim() ?? '';
// //           if (key.isNotEmpty) { // Only add non-empty keys
// //             productDetailsMap[key] = value;
// //           }
// //         }
// //
// //         final productRef = FirebaseFirestore.instance
// //             .collection('seller')
// //             .doc(user.uid)
// //             .collection(_selectedCategory!)
// //             .doc();
// //
// //         final productId = productRef.id;
// //
// //         // Save item details to Firestore with trimmed values
// //         await productRef.set({
// //           'name': _nameController.text.trim(),
// //           'category': _selectedCategory,
// //           'shopName': _shopNameController.text.trim(),
// //           'isShowCashOnDelivery': selectedShowCashonDelivery,
// //           'brandName': _brandNameController.text.trim(),
// //           'productSellerId': user.uid,
// //           'expectedDelivery': _expectedDeliveryController.text.trim(),
// //           'productId': productId,
// //           'description': _descriptionController.text.trim(),
// //           'productDetails': productDetailsMap,
// //           'images': imageUrls,
// //           'videos': videoUrls,
// //           'timestamp': FieldValue.serverTimestamp(),
// //         });
// //
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Item uploaded successfully!')),
// //         );
// //
// //         // Clear form and media
// //         _formKey.currentState!.reset();
// //         setState(() {
// //           _selectedImages.clear();
// //           _selectedVideos.clear();
// //           _selectedCategory = null;
// //           _productDetailsList.clear();
// //           _isUploading = false;
// //         });
// //       } catch (e) {
// //         print('Error uploading item: $e');
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Failed to upload item: $e')),
// //         );
// //         setState(() {
// //           _isUploading = false;
// //         });
// //       }
// //     }
// //   }
// //
// //   // ... [Keep all your existing methods like getCurrentUser, _pickImages, etc.] ...
// //
// //   Widget _buildStepIndicator() {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: List.generate(3, (index) {
// //         return Container(
// //           width: 12,
// //           height: 12,
// //           margin: const EdgeInsets.symmetric(horizontal: 4),
// //           decoration: BoxDecoration(
// //             shape: BoxShape.circle,
// //             color: _currentStep == index ? primaryColor : Colors.grey[300],
// //           ),
// //         ).animate().scale(duration: 300.ms);
// //       }),
// //     );
// //   }
// //
// //   Widget _buildAnimatedForm() {
// //     return AnimatedSwitcher(
// //       duration: const Duration(milliseconds: 500),
// //       switchInCurve: Curves.easeInOut,
// //       switchOutCurve: Curves.easeInOut,
// //       child: _currentStep == 0 ? _buildBasicInfoForm() :
// //       _currentStep == 1 ? _buildMediaForm() :
// //       _buildReviewForm(),
// //     );
// //   }
// //
// //   Widget _buildBasicInfoForm() {
// //     return Column(
// //       children: [
// //         _buildInputField(
// //           controller: _nameController,
// //           label: 'Product Name',
// //           icon: Icons.shopping_bag,
// //           validator: (value) {
// //             final trimmedValue = value?.trim() ?? '';
// //             return trimmedValue.isEmpty ? 'Please enter the product name' : null;
// //           },
// //         ),
// //         const SizedBox(height: 20),
// //         _buildDropdownField(
// //           value: _selectedCategory,
// //           items: _categories,
// //           label: 'Category',
// //           icon: Icons.category,
// //           validator: (value) => value == null ? 'Please select a category' : null,
// //           onChanged: (value) => setState(() => _selectedCategory = value),
// //         ),
// //         const SizedBox(height: 20),
// //         _buildInputField(
// //           controller: _shopNameController,
// //           label: 'Shop Name',
// //           icon: Icons.store,
// //           validator: (value) {
// //             final trimmedValue = value?.trim() ?? '';
// //             return trimmedValue.isEmpty ? 'Please enter the shop name' : null;
// //           },
// //         ),
// //         const SizedBox(height: 20),
// //         _buildInputField(
// //           controller: _brandNameController,
// //           label: 'Brand Name',
// //           icon: Icons.branding_watermark,
// //           validator: (value) {
// //             final trimmedValue = value?.trim() ?? '';
// //             return trimmedValue.isEmpty ? 'Please enter the brand name' : null;
// //           },
// //         ),
// //       ],
// //     ).animate().fadeIn(duration: 500.ms);
// //   }
// //
// //   Widget _buildMediaForm() {
// //     return Column(
// //       children: [
// //         // Image Upload Section
// //         _buildUploadSection(
// //           title: 'Product Images',
// //           buttonText: 'Add Images',
// //           onPressed: _pickImages,
// //           items: _selectedImages
// //               .map((bytes) => _buildImageThumbnail(bytes))
// //               .toList(),
// //           emptyText: 'No images selected',
// //         ),
// //         const SizedBox(height: 30),
// //         // Video Upload Section
// //         _buildUploadSection(
// //           title: 'Product Videos',
// //           buttonText: 'Add Videos',
// //           onPressed: _pickVideos,
// //           items: _selectedVideos
// //               .map((bytes) => _buildVideoThumbnail(bytes))
// //               .toList(),
// //           emptyText: 'No videos selected',
// //         ),
// //       ],
// //     ).animate().fadeIn(duration: 500.ms);
// //   }
// //
// //   Widget _buildReviewForm() {
// //     return Column(
// //       children: [
// //         _buildReviewCard('Product Name', _nameController.text.trim()),
// //         _buildReviewCard('Category', _selectedCategory ?? 'Not selected'),
// //         _buildReviewCard('Shop Name', _shopNameController.text.trim()),
// //         _buildReviewCard('Brand Name', _brandNameController.text.trim()),
// //         _buildReviewCard('Expected Delivery', _expectedDeliveryController.text.trim()),
// //         _buildReviewCard('Description', _descriptionController.text.trim()),
// //         if (_productDetailsList.isNotEmpty) ...[
// //           const SizedBox(height: 20),
// //           Text('Product Details', style: TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //             color: textColor,
// //           )),
// //           ..._productDetailsList.map((detail) =>
// //               _buildReviewCard(detail['key'] ?? '', detail['value'] ?? '')
// //           ),
// //         ],
// //         const SizedBox(height: 20),
// //         _buildCashOnDeliveryReview(),
// //       ],
// //     ).animate().fadeIn(duration: 500.ms);
// //   }
// //
// //   Widget _buildInputField({
// //     required TextEditingController controller,
// //     required String label,
// //     required IconData icon,
// //     required String? Function(String?)? validator,
// //   }) {
// //     return TextFormField(
// //       controller: controller,
// //       decoration: InputDecoration(
// //         labelText: label,
// //         labelStyle: TextStyle(color: textColor),
// //         prefixIcon: Icon(icon, color: primaryColor),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10),
// //           borderSide: BorderSide(color: primaryColor),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10),
// //           borderSide: BorderSide(color: primaryColor, width: 2),
// //         ),
// //       ),
// //       style: TextStyle(color: textColor),
// //       validator: validator,
// //     );
// //   }
// //
// //   Widget _buildDropdownField({
// //     required String? value,
// //     required List<String> items,
// //     required String label,
// //     required IconData icon,
// //     required String? Function(String?)? validator,
// //     required void Function(String?)? onChanged,
// //   }) {
// //     return DropdownButtonFormField<String>(
// //       value: value,
// //       decoration: InputDecoration(
// //         labelText: label,
// //         labelStyle: TextStyle(color: textColor),
// //         prefixIcon: Icon(icon, color: primaryColor),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10),
// //           borderSide: BorderSide(color: primaryColor),
// //         ),
// //       ),
// //       items: items.map((String item) {
// //         return DropdownMenuItem<String>(
// //           value: item,
// //           child: Text(item, style: TextStyle(color: textColor)),
// //         );
// //       }).toList(),
// //       onChanged: onChanged,
// //       validator: validator,
// //       dropdownColor: cardColor,
// //       style: TextStyle(color: textColor),
// //     );
// //   }
// //
// //   Widget _buildUploadSection({
// //     required String title,
// //     required String buttonText,
// //     required VoidCallback onPressed,
// //     required List<Widget> items,
// //     required String emptyText,
// //   }) {
// //     return Card(
// //       elevation: 4,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(15),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(title, style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.bold,
// //               color: primaryColor,
// //             )),
// //             const SizedBox(height: 16),
// //             if (items.isEmpty)
// //               Text(emptyText, style: TextStyle(color: Colors.grey))
// //             else
// //               Wrap(
// //                 spacing: 12,
// //                 runSpacing: 12,
// //                 children: items,
// //               ),
// //             const SizedBox(height: 16),
// //             Center(
// //               child: ElevatedButton.icon(
// //                 onPressed: onPressed,
// //                 icon: Icon(Icons.add, color: Colors.white),
// //                 label: Text(buttonText, style: const TextStyle(color: Colors.white)),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: primaryColor,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildImageThumbnail(Uint8List bytes) {
// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(10),
// //       child: Image.memory(
// //         bytes,
// //         width: 100,
// //         height: 100,
// //         fit: BoxFit.cover,
// //       ),
// //     ).animate().scale(duration: 300.ms);
// //   }
// //
// //   Widget _buildVideoThumbnail(Uint8List bytes) {
// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(10),
// //       child: Container(
// //         width: 100,
// //         height: 100,
// //         color: Colors.grey[200],
// //         child: const Center(
// //           child: Icon(Icons.videocam, size: 40, color: Colors.grey),
// //         ),
// //       ),
// //     ).animate().scale(duration: 300.ms);
// //   }
// //
// //   Widget _buildReviewCard(String title, String value) {
// //     return Card(
// //       elevation: 2,
// //       margin: const EdgeInsets.symmetric(vertical: 8),
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text('$title: ', style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               color: primaryColor,
// //             )),
// //             Expanded(
// //               child: Text(value, style: TextStyle(color: textColor)),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ).animate().fadeIn(delay: 100.ms);
// //   }
// //
// //   Widget _buildCashOnDeliveryReview() {
// //     return Card(
// //       elevation: 2,
// //       margin: const EdgeInsets.symmetric(vertical: 8),
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Row(
// //           children: [
// //             Text('Cash on Delivery: ', style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               color: primaryColor,
// //             )),
// //             Text(selectedShowCashonDelivery ?? 'Not selected',
// //                 style: TextStyle(color: textColor)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       appBar: AppBar(
// //         title: const Text('Upload New Product'),
// //         centerTitle: true,
// //         backgroundColor: primaryColor,
// //         elevation: 0,
// //         shape: const RoundedRectangleBorder(
// //           borderRadius: BorderRadius.vertical(
// //             bottom: Radius.circular(20),
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(20),
// //         child: Center(
// //           child: ConstrainedBox(
// //             constraints: const BoxConstraints(maxWidth: 800),
// //             child: Column(
// //               children: [
// //                 _buildStepIndicator(),
// //                 const SizedBox(height: 30),
// //                 Card(
// //                   elevation: 6,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(30.0),
// //                     child: Form(
// //                       key: _formKey,
// //                       child: Column(
// //                         children: [
// //                           Text(
// //                             _currentStep == 0 ? 'Basic Information' :
// //                             _currentStep == 1 ? 'Media Upload' : 'Review Details',
// //                             style: TextStyle(
// //                               fontSize: 24,
// //                               fontWeight: FontWeight.bold,
// //                               color: primaryColor,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 30),
// //                           _buildAnimatedForm(),
// //                           const SizedBox(height: 40),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               if (_currentStep > 0)
// //                                 ElevatedButton(
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _currentStep--;
// //                                     });
// //                                   },
// //                                   style: ElevatedButton.styleFrom(
// //                                     backgroundColor: Colors.grey[300],
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(10),
// //                                     ),
// //                                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //                                   ),
// //                                   child: Text('Back', style: TextStyle(color: textColor)),
// //                                 )
// //                               else
// //                                 const SizedBox(width: 100),
// //                               if (_currentStep < 2)
// //                                 ElevatedButton(
// //                                   onPressed: () {
// //                                     if (_formKey.currentState!.validate()) {
// //                                       setState(() {
// //                                         _currentStep++;
// //                                       });
// //                                     }
// //                                   },
// //                                   style: ElevatedButton.styleFrom(
// //                                     backgroundColor: primaryColor,
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(10),
// //                                     ),
// //                                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //                                   ),
// //                                   child: const Text('Next', style: TextStyle(color: Colors.white)),
// //                                 )
// //                               else
// //                                 ElevatedButton(
// //                                   onPressed: _isUploading ? null : _uploadItem,
// //                                   style: ElevatedButton.styleFrom(
// //                                     backgroundColor: primaryColor,
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(10),
// //                                     ),
// //                                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //                                   ),
// //                                   child: _isUploading
// //                                       ? const SizedBox(
// //                                     width: 20,
// //                                     height: 20,
// //                                     child: CircularProgressIndicator(
// //                                       strokeWidth: 2,
// //                                       valueColor: AlwaysStoppedAnimation(Colors.white),
// //                                     ),
// //                                   )
// //                                       : const Text('Submit', style: TextStyle(color: Colors.white)),
// //                                 ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //

