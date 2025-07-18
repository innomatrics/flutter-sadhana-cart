
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CancelationRelatedFaqsUploadScreen extends StatefulWidget {
  const CancelationRelatedFaqsUploadScreen({super.key});

  @override
  State<CancelationRelatedFaqsUploadScreen> createState() => _CancelationRelatedFaqsUploadScreenState();
}

class _CancelationRelatedFaqsUploadScreenState extends State<CancelationRelatedFaqsUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController();
  final List<File> _uploadedImages = [];
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = false;

  // Pick images from gallery
  Future<void> _pickImages() async {
    try {
      final pickedFiles = await _imagePicker.pickMultiImage();
      setState(() {
        _uploadedImages.addAll(pickedFiles.map((image) => File(image.path)));
      });
        } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking images: $e')),
      );
    }
  }

  // Remove an image from the list
  void _removeImage(int index) {
    setState(() {
      _uploadedImages.removeAt(index);
    });
  }

  // Save FAQ to Firestore and upload images to Storage
  Future<void> _saveFaq() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final docRef = FirebaseFirestore.instance
          .collection('admin')
          .doc('cancelation_related')
          .collection('faqs')
          .doc();

      await docRef.set({
        'question': _questionController.text,
        'answer': _answerController.text,
        'video_link': _videoLinkController.text.isNotEmpty ? _videoLinkController.text : null,
        'created_at': FieldValue.serverTimestamp(),
      });

      if (_uploadedImages.isNotEmpty) {
        List<String> imageUrls = [];
        for (File image in _uploadedImages) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference storageRef =
          FirebaseStorage.instance.ref().child('cancelation_related_images/$fileName');
          await storageRef.putFile(image);
          String imageUrl = await storageRef.getDownloadURL();
          imageUrls.add(imageUrl);
        }
        await docRef.update({
          'images': imageUrls,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('FAQ saved successfully')),
      );

      _questionController.clear();
      _answerController.clear();
      _videoLinkController.clear();
      setState(() {
        _uploadedImages.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving FAQ: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Fetch FAQs for viewing
  void _viewFAQs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc('cancelation_related')
          .collection('faqs')
          .get();

      List<Map<String, dynamic>> faqs = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'question': doc['question'] ?? 'No question available',
          'answer': doc['answer'] ?? 'No answer available',
          'video_link': doc.data().containsKey('video_link') && doc['video_link'] != null
              ? doc['video_link']
              : null,
          'images': doc.data().containsKey('images') && doc['images'] is List
              ? doc['images']
              : [],
        };
      }).toList();

      // TODO: Uncomment and update with actual navigation to FAQ view screen
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => AdmnViewBusCanclFaqs(faqs: faqs),
      //   ),
      // );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('FAQs fetched successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching FAQs: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Cancelation Related FAQs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              // Question Input
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  labelStyle: TextStyle(color: Colors.blueAccent.shade700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Answer Input
              TextFormField(
                controller: _answerController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Answer',
                  labelStyle: TextStyle(color: Colors.blueAccent.shade700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an answer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16 ),
              // Video Link Input
              TextFormField(
                controller: _videoLinkController,
                decoration: InputDecoration(
                  labelText: 'YouTube Video Link (optional)',
                  labelStyle: TextStyle(color: Colors.blueAccent.shade700),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Image Preview
              if (_uploadedImages.isNotEmpty) ...[
                const Text(
                  'Uploaded Images:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _uploadedImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _uploadedImages[index],
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () => _removeImage(index),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
              // Upload Images Button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _pickImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                icon: const Icon(Icons.image),
                label: const Text(
                  'Upload Images',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              // Save FAQ Button
              ElevatedButton(
                onPressed: _isLoading ? null : _saveFaq,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: _isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  'Save FAQ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              // View FAQs Button
              ElevatedButton(
                onPressed: _isLoading ? null : _viewFAQs,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'View FAQs',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _videoLinkController.dispose();
    super.dispose();
  }
}


