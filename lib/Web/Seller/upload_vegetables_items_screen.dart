import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

class UploadVegetablesItemsScreen extends StatefulWidget {
  const UploadVegetablesItemsScreen({super.key});

  @override
  _UploadVegetablesItemsScreenState createState() =>
      _UploadVegetablesItemsScreenState();
}

class _UploadVegetablesItemsScreenState extends State<UploadVegetablesItemsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _shopName = '';
  String _brandName = '';
  String _category = '';
  String _description = '';
  final List<Map<String, dynamic>> _colors = [];
  final ImagePicker _picker = ImagePicker();

  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser; // Get the current user
  }

  void _addColor() {
    setState(() {
      _colors.add({
        'color': '',
        'sizes': [], // List to hold sizes and their prices
        'images': [], // List to hold images specific to this color
        'videos': [], // List to hold videos specific to this color
      });
    });
  }

  void _addSize(int colorIndex) {
    setState(() {
      _colors[colorIndex]['sizes'].add({
        'size': '',
        'quantity': 0,
        'price': 0.0, // Add price field for each size
      });
    });
  }

  Future<void> _pickImages(int colorIndex) async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _colors[colorIndex]['images'].addAll(
        pickedFiles.map((file) => File(file.path)),
      );
    });
    }

  Future<void> _pickVideos(int colorIndex) async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _colors[colorIndex]['videos'].add(File(pickedFile.path));
      });
    }
  }

  Future<void> _uploadMedia() async {
    for (int i = 0; i < _colors.length; i++) {
      // Upload images for this color
      List<String> imageUrls = [];
      for (var file in _colors[i]['images']) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = FirebaseStorage.instance.ref().child('items/images/$fileName');
        await ref.putFile(file);
        String url = await ref.getDownloadURL();
        imageUrls.add(url);
      }
      _colors[i]['images'] = imageUrls;

      // Upload videos for this color
      List<String> videoUrls = [];
      for (var file in _colors[i]['videos']) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = FirebaseStorage.instance.ref().child('items/videos/$fileName');
        await ref.putFile(file);
        String url = await ref.getDownloadURL();
        videoUrls.add(url);
      }
      _colors[i]['videos'] = videoUrls;
    }
  }

  Future<void> _uploadItem() async {
    if (_formKey.currentState!.validate() && _colors.isNotEmpty) {
      _formKey.currentState!.save();

      try {
        // Ensure the user is logged in
        if (_user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No seller is logged in!')),
          );
          return;
        }

        // Upload media (both images and videos) for each color
        await _uploadMedia();

        // Save item under the logged-in seller's collection
        await FirebaseFirestore.instance
            .collection('seller')
            .doc(_user!.uid) // Using the seller's UID as document ID
            .collection('Clothings') // Creating a 'Clothings' subcollection for the seller
            .add({
          'name': _name,
          'category': _category,
          'shop Name': _shopName,
          'Brand Name': _brandName,
          'description': _description,
          'colors': _colors,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item uploaded successfully!')),
        );

        _formKey.currentState!.reset();
        setState(() {
          _colors.clear();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload item: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form and upload media.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Item')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Item Name'),
                  validator: (value) => value!.isEmpty ? 'Please enter the item name' : null,
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) => value!.isEmpty ? 'Please enter the category' : null,
                  onSaved: (value) => _category = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Shop Name'),
                  validator: (value) => value!.isEmpty ? 'Please enter the Shop Name' : null,
                  onSaved: (value) => _shopName = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Brand Name'),
                  validator: (value) => value!.isEmpty ? 'Please enter the Brand Name' : null,
                  onSaved: (value) => _brandName = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) => value!.isEmpty ? 'Please enter the description' : null,
                  onSaved: (value) => _description = value!,
                ),
                const SizedBox(height: 16),
                const Text('Colors and Prices'),
                ..._colors.asMap().entries.map((entry) {
                  int colorIndex = entry.key;
                  Map<String, dynamic> color = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Color'),
                              onChanged: (value) => _colors[colorIndex]['color'] = value,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _colors.removeAt(colorIndex);
                              });
                            },
                          ),
                        ],
                      ),
                      const Text('Sizes, Quantities, and Prices'),
                      ...color['sizes'].asMap().entries.map((sizeEntry) {
                        int sizeIndex = sizeEntry.key;
                        Map<String, dynamic> size = sizeEntry.value;

                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Size'),
                                onChanged: (value) => _colors[colorIndex]['sizes'][sizeIndex]['size'] = value,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Quantity'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => _colors[colorIndex]['sizes'][sizeIndex]['quantity'] = int.tryParse(value) ?? 0,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Price'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => _colors[colorIndex]['sizes'][sizeIndex]['price'] = double.tryParse(value) ?? 0.0,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      ElevatedButton(
                        onPressed: () => _addSize(colorIndex),
                        child: const Text('Add Size'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _pickImages(colorIndex),
                        child: Text('Pick Images for ${color['color']}'),
                      ),
                      const SizedBox(height: 16),
                      // Display the selected images for this color
                      _colors[colorIndex]['images'].isNotEmpty
                          ? Wrap(
                        spacing: 8.0,
                        children: _colors[colorIndex]['images']
                            .map<Widget>((file) => Image.file(file, width: 100, height: 100, fit: BoxFit.cover))
                            .toList(),
                      )
                          : Container(),
                      const SizedBox(height: 16),
                      // Display the selected videos for this color
                      _colors[colorIndex]['videos'].isNotEmpty
                          ? Wrap(
                        spacing: 8.0,
                        children: _colors[colorIndex]['videos']
                            .map<Widget>((file) {
                          return GestureDetector(
                            onTap: () {
                              // You can add logic to play video here or navigate to a new screen to play the video
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(videoFile: file),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Icon(Icons.play_arrow, size: 50, color: Colors.white),
                            ),
                          );
                        })
                            .toList(),
                      )
                          : Container(),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _pickVideos(colorIndex),
                        child: Text('Pick Videos for ${color['color']}'),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
                ElevatedButton(
                  onPressed: _addColor,
                  child: const Text('Add Color'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadItem,
                  child: const Text('Upload Item'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// VideoPlayerScreen to play the selected video
class VideoPlayerScreen extends StatelessWidget {
  final File videoFile;
  const VideoPlayerScreen({super.key, required this.videoFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Play Video')),
      body: Center(
        child: videoFile.existsSync()
            ? VideoPlayerWidget(videoFile: videoFile)
            : const Text('Video file not found!'),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;
  const VideoPlayerWidget({super.key, required this.videoFile});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}