import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';


// class ClothingsDeleteScreen extends StatefulWidget {
//   final String userId;
//
//   ClothingsDeleteScreen({required this.userId});
//
//   @override
//   _ClothingsDeleteScreenState createState() => _ClothingsDeleteScreenState();
// }
//
// class _ClothingsDeleteScreenState extends State<ClothingsDeleteScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> _footwears = [];
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchFootwears();
//   }
//
//   Future<void> _fetchFootwears() async {
//     try {
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('seller')
//           .doc(widget.userId)
//           .collection('Clothings')
//           .get();
//
//       List<Map<String, dynamic>> footwears = [];
//       querySnapshot.docs.forEach((doc) {
//         var data = doc.data() as Map<String, dynamic>;
//         footwears.add({
//           'id': doc.id,
//           'name': data['name'],
//           'category': data['category'],
//           'shopName': data['shop Name'],
//           'brandName': data['Brand Name'],
//           'description': data['description'],
//           'colors': data['colors'], // List of colors with images, videos, sizes
//         });
//       });
//
//       setState(() {
//         _footwears = footwears;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching Clothings: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Clothings Edit Screen'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _footwears.isEmpty
//           ? Center(child: Text('No clothings found.'))
//           : ListView.builder(
//         itemCount: _footwears.length,
//         itemBuilder: (context, index) {
//           var footwear = _footwears[index];
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Name: ${footwear['name']}',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text('Category: ${footwear['category']}'),
//                   Text('Shop Name: ${footwear['shopName']}'),
//                   Text('Brand Name: ${footwear['brandName']}'),
//                   Text('Description: ${footwear['description']}'),
//                   SizedBox(height: 16),
//                   // Display colors, images, videos, and sizes
//                   ...footwear['colors'].map<Widget>((colorData) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Color: ${colorData['color']}',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 8),
//                         // Display images
//                         if (colorData['images'] != null && colorData['images'].isNotEmpty)
//                           Column(
//                             children: colorData['images'].map<Widget>((image) {
//                               return Image.network(
//                                 image,
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               );
//                             }).toList(),
//                           ),
//                         // Display videos
//                         if (colorData['videos'] != null && colorData['videos'].isNotEmpty)
//                           Column(
//                             children: colorData['videos'].map<Widget>((video) {
//                               return Text('Video: $video');
//                             }).toList(),
//                           ),
//                         // Display sizes
//                         if (colorData['sizes'] != null && colorData['sizes'].isNotEmpty)
//                           Column(
//                             children: colorData['sizes'].map<Widget>((size) {
//                               return Text(
//                                 'Size: ${size['size']}, Quantity: ${size['quantity']}, Price: Rs ${size['price']}',
//                               );
//                             }).toList(),
//                           ),
//                         SizedBox(height: 16),
//                       ],
//                     );
//                   }).toList(),
//                   // Add Edit Button
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => EditClothingScreen(
//                               userId: widget.userId,
//                               clothingId: footwear['id'],
//                               clothingData: footwear,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Text('Edit'),
//                     ),
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

class FootwearsEditScreen extends StatefulWidget {
  final String userId;

  const FootwearsEditScreen({super.key, required this.userId});

  @override
  _FootwearsEditScreenState createState() => _FootwearsEditScreenState();
}

class _FootwearsEditScreenState extends State<FootwearsEditScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _footwears = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFootwears();
  }

  Future<void> _fetchFootwears() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('seller')
          .doc(widget.userId)
          .collection('Footwear')
          .get();

      List<Map<String, dynamic>> footwears = [];
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        footwears.add({
          'id': doc.id,
          'name': data['name'],
          'category': data['category'],
          'shopName': data['shop Name'],
          'brandName': data['Brand Name'],
          'description': data['description'],
          'colors': data['colors'],
        });
      }

      setState(() {
        _footwears = footwears;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching Footwears: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToEditScreen(Map<String, dynamic> footwear) async {
    // Navigate to EditClothingScreen and wait for it to return
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditClothingScreen(
          userId: widget.userId,
          clothingId: footwear['id'],
          clothingData: footwear,
        ),
      ),
    );

    // Refresh the data after returning from EditClothingScreen
    _fetchFootwears();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Footwears Edit Screen'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _footwears.isEmpty
          ? const Center(child: Text('No Footwears found.'))
          : ListView.builder(
        itemCount: _footwears.length,
        itemBuilder: (context, index) {
          var footwear = _footwears[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${footwear['name']}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Category: ${footwear['category']}'),
                  Text('Shop Name: ${footwear['shopName']}'),
                  Text('Brand Name: ${footwear['brandName']}'),
                  Text('Description: ${footwear['description']}'),
                  const SizedBox(height: 16),
                  ...footwear['colors'].map<Widget>((colorData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Color: ${colorData['color']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (colorData['images'] != null && colorData['images'].isNotEmpty)
                          Column(
                            children: colorData['images'].map<Widget>((image) {
                              return Image.network(
                                image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              );
                            }).toList(),
                          ),
                        if (colorData['videos'] != null && colorData['videos'].isNotEmpty)
                          Column(
                            children: colorData['videos'].map<Widget>((video) {
                              return Text('Video: $video');
                            }).toList(),
                          ),
                        if (colorData['sizes'] != null && colorData['sizes'].isNotEmpty)
                          Column(
                            children: colorData['sizes'].map<Widget>((size) {
                              return Text(
                                'Size: ${size['size']}, Quantity: ${size['quantity']}, Price: Rs ${size['price']}',
                              );
                            }).toList(),
                          ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => _navigateToEditScreen(footwear),
                      child: const Text('Edit'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
class EditClothingScreen extends StatefulWidget {
  final String userId;
  final String clothingId;
  final Map<String, dynamic> clothingData;

  const EditClothingScreen({super.key, 
    required this.userId,
    required this.clothingId,
    required this.clothingData,
  });

  @override
  _EditClothingScreenState createState() => _EditClothingScreenState();
}

class _EditClothingScreenState extends State<EditClothingScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _shopNameController;
  late TextEditingController _brandNameController;
  late TextEditingController _descriptionController;
  List<Map<String, dynamic>> _colors = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.clothingData['name']);
    _categoryController = TextEditingController(text: widget.clothingData['category']);
    _shopNameController = TextEditingController(text: widget.clothingData['shopName']);
    _brandNameController = TextEditingController(text: widget.clothingData['brandName']);
    _descriptionController = TextEditingController(text: widget.clothingData['description']);
    _colors = List.from(widget.clothingData['colors']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _shopNameController.dispose();
    _brandNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<String> _uploadImage(File imageFile, String clothingId, String colorIndex, String imageIndex) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('footwear_images/$clothingId/$colorIndex/$imageIndex.jpg');

      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadURL = await taskSnapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> _deleteImage(String imageUrl) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageReference.delete();
    } catch (e) {
      print('Error deleting image: $e');
      rethrow;
    }
  }

  Future<void> _pickVideo(int colorIndex, int videoIndex) async {
    final XFile? videoFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (videoFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uploading video...')),
      );

      try {
        final String downloadURL = await _uploadVideo(
          File(videoFile.path),
          widget.clothingId,
          colorIndex.toString(),
          videoIndex.toString(),
        );

        setState(() {
          _colors[colorIndex]['videos'][videoIndex] = downloadURL;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload video: $e')),
        );
      }
    }
  }

  Future<String> _uploadVideo(File videoFile, String clothingId, String colorIndex, String videoIndex) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('footwear_videos/$clothingId/$colorIndex/$videoIndex.mp4');

      final UploadTask uploadTask = storageReference.putFile(videoFile);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadURL = await taskSnapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading video: $e');
      rethrow;
    }
  }

  Future<void> _pickImage(int colorIndex, int imageIndex) async {
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uploading image...')),
      );

      try {
        // Get the old image URL
        final String oldImageUrl = _colors[colorIndex]['images'][imageIndex];

        // Delete the old image from Firebase Storage
        if (oldImageUrl.isNotEmpty) {
          await _deleteImage(oldImageUrl);
        }

        // Upload the new image to Firebase Storage
        final String downloadURL = await _uploadImage(
          File(imageFile.path),
          widget.clothingId,
          colorIndex.toString(),
          imageIndex.toString(),
        );

        // Update the _colors list with the new image URL
        setState(() {
          _colors[colorIndex]['images'][imageIndex] = downloadURL;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    }
  }

  // Future<void> _updateClothing() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       await FirebaseFirestore.instance
  //           .collection('seller')
  //           .doc(widget.userId)
  //           .collection('Clothings')
  //           .doc(widget.clothingId)
  //           .update({
  //         'name': _nameController.text,
  //         'category': _categoryController.text,
  //         'shop Name': _shopNameController.text,
  //         'Brand Name': _brandNameController.text,
  //         'description': _descriptionController.text,
  //         'colors': _colors,
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Clothing updated successfully')),
  //       );
  //
  //       Navigator.pop(context);
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error updating clothing: $e')),
  //       );
  //     }
  //   }
  // }

  Future<void> _updateClothing() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('seller')
            .doc(widget.userId)
            .collection('Footwear')
            .doc(widget.clothingId)
            .update({
          'name': _nameController.text,
          'category': _categoryController.text,
          'shop Name': _shopNameController.text,
          'Brand Name': _brandNameController.text,
          'description': _descriptionController.text,
          'colors': _colors,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Footwears updated successfully')),
        );

        // Return to the previous screen
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating clothing: $e')),
        );
      }
    }
  }

  Widget _buildColorFields(int colorIndex) {
    var colorData = _colors[colorIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: colorData['color'],
          decoration: const InputDecoration(labelText: 'Color'),
          onChanged: (value) {
            setState(() {
              _colors[colorIndex]['color'] = value;
            });
          },
        ),
        const SizedBox(height: 8),
        if (colorData['images'] != null && colorData['images'].isNotEmpty)
          Column(
            children: colorData['images'].map<Widget>((image) {
              int imageIndex = colorData['images'].indexOf(image);
              return GestureDetector(
                onTap: () => _pickImage(colorIndex, imageIndex),
                child: Image.network(
                  image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
        if (colorData['videos'] != null && colorData['videos'].isNotEmpty)
          Column(
            children: colorData['videos'].map<Widget>((video) {
              int videoIndex = colorData['videos'].indexOf(video);
              return GestureDetector(
                onTap: () => _pickVideo(colorIndex, videoIndex),
                child: Text('Video: $video'),
              );
            }).toList(),
          ),
        if (colorData['sizes'] != null && colorData['sizes'].isNotEmpty)
          Column(
            children: colorData['sizes'].map<Widget>((size) {
              int sizeIndex = colorData['sizes'].indexOf(size);
              return Column(
                children: [
                  TextFormField(
                    initialValue: size['size'],
                    decoration: const InputDecoration(labelText: 'Size'),
                    onChanged: (value) {
                      setState(() {
                        _colors[colorIndex]['sizes'][sizeIndex]['size'] = value;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: size['quantity'].toString(),
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    onChanged: (value) {
                      setState(() {
                        _colors[colorIndex]['sizes'][sizeIndex]['quantity'] = int.parse(value);
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: size['price'].toString(),
                    decoration: const InputDecoration(labelText: 'Price'),
                    onChanged: (value) {
                      setState(() {
                        _colors[colorIndex]['sizes'][sizeIndex]['price'] = double.parse(value);
                      });
                    },
                  ),
                ],
              );
            }).toList(),
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Edit Footwears'),
        // actions: [
        // IconButton(
        //   icon: Icon(Icons.save),
        //   onPressed: _updateClothing,
        // ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _shopNameController,
                decoration: const InputDecoration(labelText: 'Shop Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a shop name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _brandNameController,
                decoration: const InputDecoration(labelText: 'Brand Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a brand name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ..._colors.map<Widget>((colorData) {
                int colorIndex = _colors.indexOf(colorData);
                return _buildColorFields(colorIndex);
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateClothing,
                child: const Text('Update'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



