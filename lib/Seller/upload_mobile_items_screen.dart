import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

class UploadMobilesItemsScreen extends StatefulWidget {
  const UploadMobilesItemsScreen({super.key});

  @override
  _UploadMobilesItemsScreenState createState() =>
      _UploadMobilesItemsScreenState();
}

class _UploadMobilesItemsScreenState extends State<UploadMobilesItemsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _shopName = '';
  String _brandName = '';
  String _category = '';
  String _description = '';
  String _operatingSystem = '';
  String _ram = '';
  String _rom = '';
  String _processor = '';
  String _rearCamera = '';
  String _frontCamera = '';
  String _display = '';
  String _battery = '';
  String _networkType = '';
  String _simType = '';
  String _expandableStorage = '';
  String _audioJack = '';
  String _quickCharging = '';
  String _warranty = '';
  String _summary = '';
  String _otherDetails = '';
  final List<Map<String, dynamic>> _colors = [];
  final ImagePicker _picker = ImagePicker();

  User? _user;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser; // Get the current user

    // Trigger fade-in after a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  void _addColor() {
    setState(() {
      _colors.add({
        'color': '',
        'sizes': [], // List to hold sizes, prices, and offer prices
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
        'price': 0.0, // Original price
        'offerPrice': 0.0, // Offer price
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
        Reference ref =
            FirebaseStorage.instance.ref().child('items/images/$fileName');
        await ref.putFile(file);
        String url = await ref.getDownloadURL();
        imageUrls.add(url);
      }
      _colors[i]['images'] = imageUrls;

      // Upload videos for this color
      List<String> videoUrls = [];
      for (var file in _colors[i]['videos']) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref =
            FirebaseStorage.instance.ref().child('items/videos/$fileName');
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
            .collection(
                'Mobiles') // Creating a 'Electronics' subcollection for the seller
            .add({
          'name': _name,
          'category': _category,
          'shop Name': _shopName,
          'Brand Name': _brandName,
          'description': _description,
          'operatingSystem': _operatingSystem,
          'ram': _ram,
          'rom': _rom,
          'processor': _processor,
          'rearCamera': _rearCamera,
          'frontCamera': _frontCamera,
          'display': _display,
          'battery': _battery,
          'networkType': _networkType,
          'simType': _simType,
          'expandableStorage': _expandableStorage,
          'audioJack': _audioJack,
          'quickCharging': _quickCharging,
          'warranty': _warranty,
          'summary': _summary,
          'otherDetails': _otherDetails,
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
        const SnackBar(
            content: Text('Please complete the form and upload media.')),
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
                // Existing fields (Item Name, Category, Shop Name, Brand Name, Description)
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Item Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the item name' : null,
                  onSaved: (value) => _name = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the category' : null,
                  onSaved: (value) => _category = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Shop Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the Shop Name' : null,
                  onSaved: (value) => _shopName = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Brand Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the Brand Name' : null,
                  onSaved: (value) => _brandName = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter the description' : null,
                  onSaved: (value) => _description = value!,
                ),
                const SizedBox(height: 16),

                // New fields for electronics
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Operating System'),
                  onSaved: (value) => _operatingSystem = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'RAM'),
                  onSaved: (value) => _ram = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'ROM'),
                  onSaved: (value) => _rom = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Processor'),
                  onSaved: (value) => _processor = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Rear Camera'),
                  onSaved: (value) => _rearCamera = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Front Camera'),
                  onSaved: (value) => _frontCamera = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Display'),
                  onSaved: (value) => _display = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Battery'),
                  onSaved: (value) => _battery = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Network Type'),
                  onSaved: (value) => _networkType = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'SIM Type'),
                  onSaved: (value) => _simType = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Expandable Storage'),
                  onSaved: (value) => _expandableStorage = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Audio Jack'),
                  onSaved: (value) => _audioJack = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Quick Charging'),
                  onSaved: (value) => _quickCharging = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Warranty'),
                  onSaved: (value) => _warranty = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Summary'),
                  onSaved: (value) => _summary = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Other Details'),
                  onSaved: (value) => _otherDetails = value!,
                ),
                const SizedBox(height: 16),

                // Existing color and size fields
                const Text('Colors and Prices'),
                const SizedBox(height: 16),
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
                              decoration: InputDecoration(
                                labelText: 'Color',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _colors.removeAt(colorIndex);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete_sweep,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                              onChanged: (value) =>
                                  _colors[colorIndex]['color'] = value,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Sizes, Quantities, and Prices'),
                      const SizedBox(height: 16),
                      ...color['sizes'].asMap().entries.map((sizeEntry) {
                        int sizeIndex = sizeEntry.key;
                        Map<String, dynamic> size = sizeEntry.value;

                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Size'),
                                    onChanged: (value) => _colors[colorIndex]
                                        ['sizes'][sizeIndex]['size'] = value,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Quantity'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => _colors[colorIndex]
                                            ['sizes'][sizeIndex]['quantity'] =
                                        int.tryParse(value) ?? 0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Price'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => _colors[colorIndex]
                                            ['sizes'][sizeIndex]['price'] =
                                        double.tryParse(value) ?? 0.0,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Offer Price'),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => _colors[colorIndex]
                                            ['sizes'][sizeIndex]['offerPrice'] =
                                        double.tryParse(value) ?? 0.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (_colors[colorIndex]['sizes'][sizeIndex]
                                    ['offerPrice'] >
                                0)
                              Row(
                                children: [
                                  Text(
                                    'Rs ${_colors[colorIndex]['sizes'][sizeIndex]['price']}',
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Rs ${_colors[colorIndex]['sizes'][sizeIndex]['offerPrice']}',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 16),
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
                      _colors[colorIndex]['images'].isNotEmpty
                          ? Wrap(
                              spacing: 8.0,
                              children: _colors[colorIndex]['images']
                                  .map<Widget>((file) => Image.file(
                                        file,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ))
                                  .toList(),
                            )
                          : Container(),
                      const SizedBox(height: 16),
                      _colors[colorIndex]['videos'].isNotEmpty
                          ? Wrap(
                              spacing: 8.0,
                              children: _colors[colorIndex]['videos']
                                  .map<Widget>((file) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VideoPlayerScreen(videoFile: file),
                                      ),
                                    );
                                  },
                                  child: Container(
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
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: _isVisible ? 1.0 : 0.0,
                  curve: Curves.easeInOut,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x3ff08cb0b),
                      minimumSize: const Size(600, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _uploadItem,
                    child: const Text(
                      'Upload Item',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
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
