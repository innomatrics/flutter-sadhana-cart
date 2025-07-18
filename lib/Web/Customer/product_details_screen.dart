// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/customer_bottom_navigationber_layout.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Customer/place_order_screen.dart';
// import 'package:video_player/video_player.dart';
//
// class ProductDetailsPage extends StatefulWidget {
//   final Map<String, dynamic> product;
//
//   const ProductDetailsPage({
//     required this.product,
//   });
//
//   @override
//   _ProductDetailsPageState createState() => _ProductDetailsPageState();
// }
//
// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   late List<Widget> mediaItems; // List to hold images and videos
//   late VideoPlayerController _videoController;
//   bool _isVideoPlaying = false;
//   bool _isVideoInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize media items (images and videos)
//     mediaItems = _buildMediaItems();
//   }
//
//   @override
//   void dispose() {
//     // Dispose of the video controller when the widget is disposed
//     _videoController?.dispose();
//     super.dispose();
//   }
//
//   // Build media items (images and videos)
//   List<Widget> _buildMediaItems() {
//     List<Widget> items = [];
//
//     // Add images to the list
//     if (widget.product['images'] != null) {
//       for (var imageUrl in widget.product['images']) {
//         items.add(
//           Container(
//             width: double.infinity, // Take full width
//             child: AspectRatio(
//               aspectRatio: 16 / 9, // Adjust aspect ratio as needed
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.contain, // Ensure the image is fully visible
//               ),
//             ),
//           ),
//         );
//       }
//     }
//
//     // Add videos to the list
//     if (widget.product['videos'] != null) {
//       for (var videoUrl in widget.product['videos']) {
//         items.add(
//           Container(
//             width: double.infinity, // Take full width
//             child: _buildVideoPlayer(videoUrl),
//           ),
//         );
//       }
//     }
//
//     return items;
//   }
//
//   // Build a video player widget
//   Widget _buildVideoPlayer(String videoUrl) {
//     _videoController = VideoPlayerController.network(videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           _isVideoInitialized = true; // Video is initialized
//         });
//         _videoController.setVolume(0); // Mute the video by default
//         _videoController.play(); // Start playing the video immediately
//         _isVideoPlaying = true;
//       });
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           if (_videoController.value.isPlaying) {
//             _videoController.pause();
//             _isVideoPlaying = false;
//           } else {
//             _videoController.play();
//             _isVideoPlaying = true;
//           }
//         });
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           AspectRatio(
//             aspectRatio: _videoController.value.aspectRatio,
//             child: VideoPlayer(_videoController),
//           ),
//           if (!_isVideoPlaying && _isVideoInitialized)
//             const Icon(
//               Icons.play_arrow,
//               size: 50,
//               color: Colors.white,
//             ),
//           if (!_isVideoInitialized)
//             const CircularProgressIndicator(), // Show loading indicator while initializing
//           // Video player controls
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: VideoProgressIndicator(
//               _videoController,
//               allowScrubbing: true,
//               colors: const VideoProgressColors(
//                 playedColor: Colors.red,
//                 bufferedColor: Colors.grey,
//                 backgroundColor: Colors.black54,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             right: 10,
//             child: IconButton(
//               icon: Icon(
//                 _videoController.value.volume == 0
//                     ? Icons.volume_off
//                     : Icons.volume_up,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _videoController.setVolume(
//                     _videoController.value.volume == 0 ? 1 : 0,
//                   );
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Check if the customer is logged in and add the product to Firestore cart
//   Future<void> _addToCart(BuildContext context) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
//
//       // Check if the customer document exists
//       final docSnapshot = await userRef.get();
//       if (!docSnapshot.exists) {
//         await userRef.set({
//           'email': user.email,
//           'name': user.displayName,
//           'createdAt': FieldValue.serverTimestamp(),
//           'status': 'loggedIn', // Store loggedIn status
//         });
//       } else {
//         await userRef.update({'status': 'loggedIn'}); // Update status to loggedIn if user exists
//       }
//
//       // Add the product to the cart collection
//       await userRef.collection('cart').add(widget.product);
//
//       // Show a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Added to Cart'),
//           duration: Duration(seconds: 1),
//         ),
//       );
//     } else {
//       // Navigate to the CustomerSigninScreen if the user is not logged in
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => CustomerSigninScreen()),
//       );
//     }
//   }
//
//   // Check if the customer is logged in and navigate to PlaceOrderScreen
//   Future<void> _buyNow(BuildContext context) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
//
//       // Check if the customer document exists
//       final docSnapshot = await userRef.get();
//       if (!docSnapshot.exists) {
//         await userRef.set({
//           'email': user.email,
//           'name': user.displayName,
//           'createdAt': FieldValue.serverTimestamp(),
//           'status': 'loggedIn', // Store loggedIn status
//         });
//       } else {
//         await userRef.update({'status': 'loggedIn'}); // Update status to loggedIn if user exists
//       }
//
//       // Navigate to the PlaceOrderScreen
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (_) => PlaceOrderScreen(product: widget.product),
//       //   ),
//       // );
//     } else {
//       // Navigate to the CustomerSigninScreen if the user is not logged in
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => CustomerSigninScreen()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Carousel Slider for images and videos
//             if (mediaItems.isNotEmpty)
//               CarouselSlider(
//                 items: mediaItems,
//                 options: CarouselOptions(
//                   height: 300, // Set carousel height
//                   autoPlay: false, // Auto-play the carousel
//                   enlargeCenterPage: true, // Enlarge the center item
//                   viewportFraction: 1, // Show one item at a time
//                 ),
//               ),
//             SizedBox(height: 16),
//             // Product Name
//             Text(
//               widget.product['name'],
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             // Price and Offer Price
//             Row(
//               children: [
//                 Text(
//                   '₹${widget.product['productDetails']?['Offer Price'] ?? 'N/A'}', // Fetch from productDetails
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   '₹${widget.product['productDetails']?['Price'] ?? 'N/A'}', // Fetch from productDetails
//                   style: TextStyle(
//                     fontSize: 16,
//                     decoration: TextDecoration.lineThrough,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             // Brand Name
//             if (widget.product['brandName'] != null)
//               Text(
//                 '${widget.product['brandName']}',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             SizedBox(height: 16),
//             // Additional Fields (Add more fields as needed)
//             if (widget.product['description'] != null)
//               Text(
//                 'Description: ${widget.product['description']}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black87,
//                 ),
//               ),
//             SizedBox(height: 16),
//             // Display all fields from productDetails except Price and OfferPrice
//             if (widget.product['productDetails'] != null)
//               ...widget.product['productDetails'].entries.map((entry) {
//                 if (entry.key != 'Price' && entry.key != 'OfferPrice') {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: Text(
//                       '${entry.key}: ${entry.value}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   );
//                 }
//                 return SizedBox.shrink(); // Skip Price and OfferPrice
//               }).toList(),
//             SizedBox(height: 32), // Add spacing before buttons
//             // Buy Now and Add to Cart buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Handle Buy Now action
//                       _buyNow(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange, // Button color
//                       padding: EdgeInsets.symmetric(vertical: 16), // Button padding
//                     ),
//                     child: Text(
//                       'Buy Now',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16), // Spacing between buttons
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       // Add the product to the cart after checking login status
//                       await _addToCart(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green, // Button color
//                       padding: EdgeInsets.symmetric(vertical: 16), // Button padding
//                     ),
//                     child: Text(
//                       'Add to Cart',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
