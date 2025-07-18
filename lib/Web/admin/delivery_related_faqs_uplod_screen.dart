// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
//
//
// class DeliveryRelatedFaqsUplodScreen extends StatefulWidget {
//   @override
//   State<DeliveryRelatedFaqsUplodScreen> createState() => _DeliveryRelatedFaqsUplodScreenState();
// }
//
// class _DeliveryRelatedFaqsUplodScreenState extends State<DeliveryRelatedFaqsUplodScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _questionController = TextEditingController();
//   final TextEditingController _answerController = TextEditingController();
//   final TextEditingController _videoLinkController = TextEditingController(); // Controller for YouTube link
//
//   List<File> _uploadedImages = [];
//   final ImagePicker _imagePicker = ImagePicker(); // Same picker for images
//
//   // Function to pick images
//   Future<void> _pickImages() async {
//     final pickedFiles = await _imagePicker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _uploadedImages = pickedFiles.map((image) => File(image.path)).toList();
//       });
//     }
//   }
//
//   // Function to save FAQ to Firestore and Storage
//   Future<void> _saveFaq() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     // Save Question, Answer, and Video Link
//     final docRef = FirebaseFirestore.instance
//         .collection('admin')
//         .doc('delivery_related')
//         .collection('faqs')
//         .doc();
//
//     await docRef.set({
//       'question': _questionController.text,
//       'answer': _answerController.text,
//       'video_link': _videoLinkController.text, // Save YouTube link
//       'created_at': FieldValue.serverTimestamp(),
//     });
//
//     // Upload images to Firebase Storage if any images are uploaded
//     if (_uploadedImages.isNotEmpty) {
//       for (File image in _uploadedImages) {
//         String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//         Reference storageRef =
//         FirebaseStorage.instance.ref().child('delivery_related_images/$fileName');
//         await storageRef.putFile(image);
//         String imageUrl = await storageRef.getDownloadURL();
//         await docRef.update({
//           'images': FieldValue.arrayUnion([imageUrl]),
//         });
//       }
//     }
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('FAQ saved successfully')),
//     );
//
//     // Clear form after saving
//     _questionController.clear();
//     _answerController.clear();
//     _videoLinkController.clear(); // Clear video link input
//     setState(() {
//       _uploadedImages.clear();
//     });
//   }
//
//   void _viewFAQs() async {
//     // Fetch FAQs from Firestore
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('admin')
//         .doc('delivery_related')
//         .collection('faqs')
//         .get();
//
//     List<Map<String, dynamic>> faqs = querySnapshot.docs.map((doc) {
//       // Check if 'video_link' exists and is a string, otherwise set it as null or a default message
//       final videoLink = doc.data().containsKey('video_link') && doc['video_link'] != null
//           ? doc['video_link']
//           : 'No video link available'; // Default message if video link doesn't exist
//
//       // Check if 'images' exists and is a list, otherwise provide an empty list
//       return {
//         'id': doc.id,
//         'question': doc['question'] ?? 'No question available',
//         'answer': doc['answer'] ?? 'No answer available',
//         'video_link': videoLink, // Fetch YouTube link or default message
//         'images': doc.data().containsKey('images') && doc['images'] is List ? doc['images'] : [],
//       };
//     }).toList();
//
//     // Navigator.of(context).push(
//     //   MaterialPageRoute(
//     //     builder: (context) => AdmnViewBusCanclFaqs(faqs: faqs),
//     //   ),
//     // );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200], // Light background
//       appBar: AppBar(
//         backgroundColor: Colors.redAccent.shade700,
//         title: Text('Delivery Related FAQs',style: TextStyle(color: Colors.white),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               SizedBox(height: 35,),
//               // Question Text Box
//               TextFormField(
//                 controller: _questionController,
//                 decoration: InputDecoration(
//                   labelText: 'Question',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a question';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               // Answer Text Box (Bigger)
//               TextFormField(
//                 controller: _answerController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   labelText: 'Answer',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an answer';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               // Video Link Text Box
//               TextFormField(
//                 controller: _videoLinkController,
//                 decoration: InputDecoration(
//                   labelText: 'YouTube Video Link (optional)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16),
//               // Display Uploaded Images
//               if (_uploadedImages.isNotEmpty) ...[
//                 Text('Uploaded Images:'),
//                 SizedBox(height: 10),
//                 Wrap(
//                   children: _uploadedImages
//                       .map((image) => Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Image.file(
//                       image,
//                       width: 100,
//                       height: 100,
//                     ),
//                   ))
//                       .toList(),
//                 ),
//               ],
//               // Upload Images Button
//               Container(
//                 height: 45,
//                 width: 350,
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.redAccent.shade700,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       )
//                   ),
//                   onPressed: _pickImages,
//                   icon: Icon(Icons.image,color: Colors.white,),
//                   label: Text('Upload Images',style: TextStyle(color: Colors.white),),
//                 ),
//               ),
//               SizedBox(height: 16),
//               // Save Button
//               Container(
//                 height: 45,
//                 width: 350,
//                 child: ElevatedButton(
//                     onPressed: _saveFaq,
//                     child: Text('Save FAQ',style: TextStyle(color: Colors.white),),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent.shade700,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadiusDirectional.circular(8),
//                         )
//                     )
//                 ),
//               ),
//               SizedBox(height: 16),
//               Container(
//                 height: 45,
//                 width: 350,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.redAccent.shade700,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadiusDirectional.circular(8),
//                       )
//                   ),
//                   onPressed: _viewFAQs,
//                   child: Text('View FAQs',style: TextStyle(color: Colors.white),),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class ServicesScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> services = [
//     {'name': 'Delivery', 'icon': Icons.delivery_dining},
//     {'name': 'Login', 'icon': Icons.login},
//     {'name': 'Refund', 'icon': Icons.money_off},
//     {'name': 'Payment', 'icon': Icons.payment},
//     {'name': 'Return', 'icon': Icons.assignment_return},
//     {'name': 'Pickup', 'icon': Icons.local_shipping},
//     {'name': 'Cancellation', 'icon': Icons.cancel},
//     {'name': 'Grocery', 'icon': Icons.shopping_cart},
//     {'name': 'Two Wheelers', 'icon': Icons.two_wheeler},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: Text('Our Services'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//         elevation: 4,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           itemCount: services.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 0.9,
//           ),
//           itemBuilder: (context, index) {
//             final service = services[index];
//             return _ServiceTile(
//               icon: service['icon'],
//               label: service['name'],
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('${service['name']} tapped!')),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class _ServiceTile extends StatefulWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//
//   const _ServiceTile({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   State<_ServiceTile> createState() => _ServiceTileState();
// }
//
// class _ServiceTileState extends State<_ServiceTile> {
//   double _scale = 1.0;
//
//   void _onTapDown(_) {
//     setState(() {
//       _scale = 0.95;
//     });
//   }
//
//   void _onTapUp(_) {
//     setState(() {
//       _scale = 1.0;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       onTapDown: _onTapDown,
//       onTapUp: _onTapUp,
//       onTapCancel: () => setState(() => _scale = 1.0),
//       child: AnimatedScale(
//         scale: _scale,
//         duration: Duration(milliseconds: 150),
//         child: Material(
//           elevation: 5,
//           borderRadius: BorderRadius.circular(16),
//           color: Colors.white,
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // Prevent overflow
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(widget.icon, size: 36, color: Colors.blueAccent),
//                 SizedBox(height: 10),
//                 Text(
//                   widget.label,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//
// class ServicesScreen extends StatelessWidget {
//   // List of services with their names and corresponding icons
//   final List<Map<String, dynamic>> services = [
//     {'name': 'Delivery', 'icon': Icons.delivery_dining, 'color': Colors.blue},
//     {'name': 'Login', 'icon': Icons.login, 'color': Colors.green},
//     {'name': 'Refund', 'icon': Icons.money_off, 'color': Colors.red},
//     {'name': 'Payment', 'icon': Icons.payment, 'color': Colors.purple},
//     {'name': 'Return', 'icon': Icons.assignment_return, 'color': Colors.orange},
//     {'name': 'Pickup', 'icon': Icons.local_shipping, 'color': Colors.teal},
//     {'name': 'Cancellation', 'icon': Icons.cancel, 'color': Colors.pink},
//     {'name': 'Grocery', 'icon': Icons.shopping_cart, 'color': Colors.amber},
//     {'name': 'Two Wheelers', 'icon': Icons.two_wheeler, 'color': Colors.indigo},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.blue.shade50, Colors.white],
//           ),
//         ),
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 200.0,
//               floating: false,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text(
//                   'Services',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 10.0,
//                         color: Colors.black26,
//                         offset: Offset(2.0, 2.0),
//                       ),
//                     ],
//                   ),
//                 ),
//                 background: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [Colors.blue.shade700, Colors.blue.shade400],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: AnimationLimiter(
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 12,
//                       mainAxisSpacing: 12,
//                       childAspectRatio: 0.85,
//                     ),
//                     itemCount: services.length,
//                     itemBuilder: (context, index) {
//                       return AnimationConfiguration.staggeredGrid(
//                         position: index,
//                         duration: Duration(milliseconds: 375),
//                         columnCount: 3,
//                         child: ScaleAnimation(
//                           child: FadeInAnimation(
//                             child: ServiceCard(
//                               service: services[index],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ServiceCard extends StatefulWidget {
//   final Map<String, dynamic> service;
//
//   const ServiceCard({Key? key, required this.service}) : super(key: key);
//
//   @override
//   _ServiceCardState createState() => _ServiceCardState();
// }
//
// class _ServiceCardState extends State<ServiceCard> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 200),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => _controller.forward(),
//       onTapUp: (_) => _controller.reverse(),
//       onTapCancel: () => _controller.reverse(),
//       onTap: () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('${widget.service['name']} tapped!'),
//             backgroundColor: widget.service['color'],
//           ),
//         );
//       },
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Colors.white,
//                   widget.service['color'].withOpacity(0.1),
//                 ],
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Hero(
//                   tag: widget.service['name'],
//                   child: Icon(
//                     widget.service['icon'],
//                     size: 48,
//                     color: widget.service['color'],
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   widget.service['name'],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade800,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DeliveryRelatedFaqsUplodScreen extends StatefulWidget {
  const DeliveryRelatedFaqsUplodScreen({super.key});

  @override
  State<DeliveryRelatedFaqsUplodScreen> createState() =>
      _DeliveryRelatedFaqsUplodScreenState();
}

class _DeliveryRelatedFaqsUplodScreenState
    extends State<DeliveryRelatedFaqsUplodScreen> {
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
          .doc('delivery_related')
          .collection('faqs')
          .doc();

      await docRef.set({
        'question': _questionController.text,
        'answer': _answerController.text,
        'video_link': _videoLinkController.text.isNotEmpty
            ? _videoLinkController.text
            : null,
        'created_at': FieldValue.serverTimestamp(),
      });

      if (_uploadedImages.isNotEmpty) {
        List<String> imageUrls = [];
        for (File image in _uploadedImages) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('delivery_related_images/$fileName');
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
          .doc('delivery_related')
          .collection('faqs')
          .get();

      List<Map<String, dynamic>> faqs = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'question': doc['question'] ?? 'No question available',
          'answer': doc['answer'] ?? 'No answer available',
          'video_link':
              doc.data().containsKey('video_link') && doc['video_link'] != null
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
          'Delivery Related FAQs',
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
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2),
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
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2),
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
              const SizedBox(height: 16),
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
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2),
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
