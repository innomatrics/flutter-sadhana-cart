// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:video_player/video_player.dart';
//
// class ParticularProductDetailsScreen extends StatefulWidget {
//   final String productId;
//
//   const ParticularProductDetailsScreen({Key? key, required this.productId}) : super(key: key);
//
//   @override
//   _ParticularProductDetailsScreenState createState() => _ParticularProductDetailsScreenState();
// }
//
// class _ParticularProductDetailsScreenState extends State<ParticularProductDetailsScreen> {
//   late Future<Map<String, dynamic>> _productDetails;
//   late List<VideoPlayerController> _videoControllers;
//
//   @override
//   void initState() {
//     super.initState();
//     _productDetails = _fetchProductDetails();
//     _videoControllers = [];
//   }
//
//   @override
//   void dispose() {
//     // Dispose all video controllers to free up resources
//     for (var controller in _videoControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   Future<Map<String, dynamic>> _fetchProductDetails() async {
//     try {
//       // Fetch all sellers
//       QuerySnapshot sellersSnapshot = await FirebaseFirestore.instance
//           .collection('seller')
//           .get();
//
//       // Iterate through each seller
//       for (var sellerDoc in sellersSnapshot.docs) {
//         String sellerId = sellerDoc.id;
//
//         // Fetch all categories for the seller
//         var categories = ['Footwear', 'Clothing', 'Electronics', 'Accessories', 'Home Appliances', 'Books', 'Others'];
//
//         for (var category in categories) {
//           // Fetch the product document from the category subcollection
//           DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
//               .collection('seller')
//               .doc(sellerId)
//               .collection(category)
//               .doc(widget.productId)
//               .get();
//
//           if (productSnapshot.exists) {
//             // Return the product details if found
//             return productSnapshot.data() as Map<String, dynamic>;
//           }
//         }
//       }
//
//       // If no product is found, throw an exception
//       throw Exception('Product not found');
//     } catch (e) {
//       throw Exception('Failed to fetch product details: $e');
//     }
//   }
//
//   void _initializeVideoControllers(List<String> videoUrls) {
//     for (var videoUrl in videoUrls) {
//       // Declare and initialize the controller
//       VideoPlayerController controller = VideoPlayerController.network(videoUrl);
//
//       // Initialize the controller and add it to the list
//       controller.initialize().then((_) {
//         // Mute the video
//         controller.setVolume(0);
//         // Start playing the video in a loop
//         controller.setLooping(true);
//         controller.play();
//         setState(() {});
//       });
//
//       // Add the controller to the list
//       _videoControllers.add(controller);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.productId),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _productDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No product details found.'));
//           }
//
//           Map<String, dynamic> productDetails = snapshot.data!;
//           List<String> images = List<String>.from(productDetails['images'] ?? []);
//           List<String> videos = List<String>.from(productDetails['videos'] ?? []);
//           Map<String, dynamic> productInfo = productDetails['productDetails'] ?? {};
//
//           // Initialize video controllers if not already initialized
//           if (_videoControllers.isEmpty && videos.isNotEmpty) {
//             _initializeVideoControllers(videos);
//           }
//
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Carousel Slider for Images and Videos
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 300,
//                     autoPlay: true,
//                     aspectRatio: 16 / 9,
//                     viewportFraction: 1.0,
//                   ),
//                   items: [
//                     ...images.map((imageUrl) {
//                       return Image.network(
//                         imageUrl,
//                         fit: BoxFit.cover,
//                       );
//                     }).toList(),
//                     ..._videoControllers.map((controller) {
//                       return controller.value.isInitialized
//                           ? AspectRatio(
//                         aspectRatio: controller.value.aspectRatio,
//                         child: VideoPlayer(controller),
//                       )
//                           : Center(child: CircularProgressIndicator());
//                     }).toList(),
//                   ],
//                 ),
//                 // Product Details
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         productDetails['name'] ?? 'No Name',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text(
//                             '₹${productInfo['Offer Price'] ?? '0'}',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             '₹${productInfo['Price'] ?? '0'}',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Brand: ${productDetails['brandName'] ?? 'No Brand'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Color: ${productInfo['Color'] ?? 'No Color'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Size: ${productInfo['Size'] ?? 'No Size'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Shop: ${productDetails['shopName'] ?? 'No Shop'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Description: ${productDetails['description'] ?? 'No Description'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       // Add to Cart and Buy Now Buttons
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch buttons to full width
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 print('Added to Cart: ${productDetails['name']}');
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue, // Button color
//                                 padding: EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: Text(
//                                 'Add to Cart',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16), // Space between buttons
//                             ElevatedButton(
//                               onPressed: () {
//                                 print('Buy Now: ${productDetails['name']}');
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green, // Button color
//                                 padding: EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: Text(
//                                 'Buy Now',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// add to cart and buy now functionalities im adding quantity also becoming -1

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:video_player/video_player.dart';
//
// class ParticularProductDetailsScreen extends StatefulWidget {
//   final String productId;
//
//   const ParticularProductDetailsScreen({Key? key, required this.productId}) : super(key: key);
//
//   @override
//   _ParticularProductDetailsScreenState createState() => _ParticularProductDetailsScreenState();
// }
//
// class _ParticularProductDetailsScreenState extends State<ParticularProductDetailsScreen> {
//   late Future<Map<String, dynamic>> _productDetails;
//   late List<VideoPlayerController> _videoControllers;
//
//   @override
//   void initState() {
//     super.initState();
//     _productDetails = _fetchProductDetails();
//     _videoControllers = [];
//   }
//
//   @override
//   void dispose() {
//     // Dispose all video controllers to free up resources
//     for (var controller in _videoControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   Future<Map<String, dynamic>> _fetchProductDetails() async {
//     try {
//       // Fetch all sellers
//       QuerySnapshot sellersSnapshot = await FirebaseFirestore.instance
//           .collection('seller')
//           .get();
//
//       // Iterate through each seller
//       for (var sellerDoc in sellersSnapshot.docs) {
//         String sellerId = sellerDoc.id;
//
//         // Fetch all categories for the seller
//         var categories = ['Footwear', 'Clothing', 'Electronics', 'Accessories', 'Home Appliances', 'Books', 'Others'];
//
//         for (var category in categories) {
//           // Fetch the product document from the category subcollection
//           DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
//               .collection('seller')
//               .doc(sellerId)
//               .collection(category)
//               .doc(widget.productId)
//               .get();
//
//           if (productSnapshot.exists) {
//             // Return the product details if found
//             return productSnapshot.data() as Map<String, dynamic>;
//           }
//         }
//       }
//
//       // If no product is found, throw an exception
//       throw Exception('Product not found');
//     } catch (e) {
//       throw Exception('Failed to fetch product details: $e');
//     }
//   }
//
//   void _initializeVideoControllers(List<String> videoUrls) {
//     for (var videoUrl in videoUrls) {
//       // Declare and initialize the controller
//       VideoPlayerController controller = VideoPlayerController.network(videoUrl);
//
//       // Initialize the controller and add it to the list
//       controller.initialize().then((_) {
//         // Mute the video
//         controller.setVolume(0);
//         // Start playing the video in a loop
//         controller.setLooping(true);
//         controller.play();
//         setState(() {});
//       });
//
//       // Add the controller to the list
//       _videoControllers.add(controller);
//     }
//   }
//
//   Future<void> _addToCart(Map<String, dynamic> productDetails) async {
//     try {
//       // Get the current user from Firebase Auth
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user == null) {
//         // If no user is logged in, navigate to the sign-in screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Use the user's UID as the customerId
//       String customerId = user.uid;
//
//       // Fetch the customer's document
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .get();
//
//       if (!customerSnapshot.exists) {
//         // If the customer document does not exist, navigate to the sign-in screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Check if the customer is logged in
//       String status = customerSnapshot['status'];
//       if (status != 'loggedIn') {
//         // If the customer is not logged in, navigate to the sign-in screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Check if the product already exists in the cart
//       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .where('productId', isEqualTo: widget.productId)
//           .get();
//
//       if (cartSnapshot.docs.isNotEmpty) {
//         // If the product already exists in the cart, show a message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Product already in cart')),
//         );
//         return;
//       }
//
//       // Add the product to the cart
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .add({
//         'productId': widget.productId,
//         'name': productDetails['name'],
//         'brandName': productDetails['brandName'],
//         'productDetails': productDetails['productDetails'],
//         'images': productDetails['images'],
//         'videos': productDetails['videos'],
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       // Show a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Product added to cart')),
//       );
//     } catch (e) {
//       // Handle errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to add product to cart: $e')),
//       );
//     }
//   }
//
//   Future<void> _buyNow(Map<String, dynamic> productDetails) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       String customerId = user.uid;
//
//       // Fetch customer document
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .get();
//
//       if (!customerSnapshot.exists || customerSnapshot['status'] != 'loggedIn') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Check if product is already ordered
//       QuerySnapshot orderSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('orders')
//           .where('productId', isEqualTo: widget.productId)
//           .get();
//
//       if (orderSnapshot.docs.isNotEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Product already ordered')),
//         );
//         return;
//       }
//
//       // Find the product in the seller's collection
//       QuerySnapshot sellersSnapshot = await FirebaseFirestore.instance
//           .collection('seller')
//           .get();
//
//       for (var sellerDoc in sellersSnapshot.docs) {
//         String sellerId = sellerDoc.id;
//         String category = productDetails['category']; // Use category directly
//
//         DocumentReference productRef = FirebaseFirestore.instance
//             .collection('seller')
//             .doc(sellerId)
//             .collection(category)
//             .doc(widget.productId);
//
//         DocumentSnapshot productSnapshot = await productRef.get();
//
//         if (productSnapshot.exists) {
//           Map<String, dynamic> productInfo =
//           productSnapshot.data() as Map<String, dynamic>;
//
//           // ✅ Convert Quantity from String to Integer
//           int currentQuantity =
//               int.tryParse(productInfo['productDetails']['Quantity'].toString()) ?? 0;
//
//           if (currentQuantity <= 0) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Product is out of stock')),
//             );
//             return;
//           }
//
//           // ✅ Update Quantity inside a Transaction to avoid race conditions
//           await FirebaseFirestore.instance.runTransaction((transaction) async {
//             DocumentSnapshot updatedSnapshot = await transaction.get(productRef);
//             if (!updatedSnapshot.exists) return;
//
//             int updatedQuantity =
//                 int.tryParse(updatedSnapshot['productDetails']['Quantity'].toString()) ?? 0;
//
//             if (updatedQuantity > 0) {
//               transaction.update(productRef, {
//                 'productDetails.Quantity': (updatedQuantity - 1).toString(),
//               });
//             }
//           });
//
//           // ✅ Add to Customer's Orders
//           await FirebaseFirestore.instance
//               .collection('customers')
//               .doc(customerId)
//               .collection('orders')
//               .add({
//             'productId': widget.productId,
//             'name': productDetails['name'],
//             'brandName': productDetails['brandName'],
//             'category': productDetails['category'],
//             'description': productDetails['description'],
//             'images': productDetails['images'],
//             'videos': productDetails['videos'],
//             'Color': productDetails['productDetails']['Color'],
//             'Size': productDetails['productDetails']['Size'],
//             'Offer Price': productDetails['productDetails']['Offer Price'],
//             'Price': productDetails['productDetails']['Price'],
//             'shopName': productDetails['productDetails']['shopName'],
//             'timestamp': FieldValue.serverTimestamp(),
//           });
//
//           // ✅ Show success message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Order placed successfully')),
//           );
//           return;
//         }
//       }
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Product not found')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to place order: $e')),
//       );
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.productId),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _productDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No product details found.'));
//           }
//
//           Map<String, dynamic> productDetails = snapshot.data!;
//           List<String> images = List<String>.from(productDetails['images'] ?? []);
//           List<String> videos = List<String>.from(productDetails['videos'] ?? []);
//           Map<String, dynamic> productInfo = productDetails['productDetails'] ?? {};
//
//           // Initialize video controllers if not already initialized
//           if (_videoControllers.isEmpty && videos.isNotEmpty) {
//             _initializeVideoControllers(videos);
//           }
//
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Carousel Slider for Images and Videos
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 300,
//                     autoPlay: true,
//                     aspectRatio: 16 / 9,
//                     viewportFraction: 1.0,
//                   ),
//                   items: [
//                     ...images.map((imageUrl) {
//                       return Image.network(
//                         imageUrl,
//                         fit: BoxFit.cover,
//                       );
//                     }).toList(),
//                     ..._videoControllers.map((controller) {
//                       return controller.value.isInitialized
//                           ? AspectRatio(
//                         aspectRatio: controller.value.aspectRatio,
//                         child: VideoPlayer(controller),
//                       )
//                           : Center(child: CircularProgressIndicator());
//                     }).toList(),
//                   ],
//                 ),
//                 // Product Details
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         productDetails['name'] ?? 'No Name',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text(
//                             '₹${productInfo['Offer Price'] ?? '0'}',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             '₹${productInfo['Price'] ?? '0'}',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Brand: ${productDetails['brandName'] ?? 'No Brand'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Color: ${productInfo['Color'] ?? 'No Color'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Size: ${productInfo['Size'] ?? 'No Size'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Quantity: ${productInfo['Quantity'] ?? 'No Quantity'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Shop: ${productDetails['shopName'] ?? 'No Shop'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Description: ${productDetails['description'] ?? 'No Description'}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       // Add to Cart and Buy Now Buttons
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch buttons to full width
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 _addToCart(productDetails);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue, // Button color
//                                 padding: EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: Text(
//                                 'Add to Cart',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16), // Space between buttons
//                             ElevatedButton(
//                               onPressed: () {
//                                 _buyNow(productDetails);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 padding: EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: Text(
//                                 'Buy Now',
//                                 style: TextStyle(fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

/// best 1

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sadhana_cart/Customer/customer_address_form.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:video_player/video_player.dart';
//
// class ParticularProductDetailsScreen extends StatefulWidget {
//   final String productId;
//
//   const ParticularProductDetailsScreen({super.key, required this.productId});
//
//   @override
//   _ParticularProductDetailsScreenState createState() =>
//       _ParticularProductDetailsScreenState();
// }
//
// int _quantity = 1;
//
// class _ParticularProductDetailsScreenState
//     extends State<ParticularProductDetailsScreen> {
//   late Future<Map<String, dynamic>> _productDetails;
//   late List<VideoPlayerController> _videoControllers;
//
//   @override
//   void initState() {
//     super.initState();
//     _productDetails = _fetchProductDetails();
//     _videoControllers = [];
//   }
//
//   @override
//   void dispose() {
//     // Dispose all video controllers to free up resources
//     for (var controller in _videoControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   Future<Map<String, dynamic>> _fetchProductDetails() async {
//     try {
//       // Fetch all sellers
//       QuerySnapshot sellersSnapshot =
//           await FirebaseFirestore.instance.collection('seller').get();
//
//       // Iterate through each seller
//       for (var sellerDoc in sellersSnapshot.docs) {
//         String sellerId = sellerDoc.id;
//
//         // Fetch all categories for the seller
//         var categories = [
//           'Footwear',
//           'Clothing',
//           'Electronics',
//           'Accessories',
//           'Home Appliances',
//           'Books',
//           'Others'
//         ];
//
//         for (var category in categories) {
//           // Fetch the product document from the category subcollection
//           DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
//               .collection('seller')
//               .doc(sellerId)
//               .collection(category)
//               .doc(widget.productId)
//               .get();
//
//           if (productSnapshot.exists) {
//             // Return the product details if found
//             return productSnapshot.data() as Map<String, dynamic>;
//           }
//         }
//       }
//
//       // If no product is found, throw an exception
//       throw Exception('Product not found');
//     } catch (e) {
//       throw Exception('Failed to fetch product details: $e');
//     }
//   }
//
//   void _initializeVideoControllers(List<String> videoUrls) {
//     for (var videoUrl in videoUrls) {
//       // Declare and initialize the controller
//       final VideoPlayerController controller =
//           VideoPlayerController.network(videoUrl);
//
//       // Initialize the controller and add it to the list
//       controller.initialize().then((_) {
//         // Mute the video
//         controller.setVolume(0);
//         // Start playing the video in a loop
//         controller.setLooping(true);
//         controller.play();
//         setState(() {});
//       });
//
//       // Add the controller to the list
//       _videoControllers.add(controller);
//     }
//   }
//
//   Future<void> _addToCart(Map<String, dynamic> productDetails) async {
//     try {
//       // Get the current user from Firebase Auth
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user == null) {
//         // If no user is logged in, navigate to the sign-in screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Use the user's UID as the customerId
//       String customerId = user.uid;
//
//       // Fetch the customer's document
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .get();
//
//       if (!customerSnapshot.exists) {
//         // If the customer document does not exist, navigate to the sign-in screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Check if the customer is logged in
//       String status = customerSnapshot['status'];
//       if (status != 'loggedIn') {
//         // If the customer is not logged in, navigate to the sign-in screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Check if the product already exists in the cart
//       DocumentSnapshot cartDoc = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .doc(widget.productId) // Check if product ID exists as a document
//           .get();
//
//       if (cartDoc.exists) {
//         // If the product already exists in the cart, show a message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Product already in cart')),
//         );
//         return;
//       }
//
//       // Add the product to the cart using productId as the document ID
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .doc(widget.productId) // Set document ID as productId
//           .set({
//         'productId': widget.productId,
//         'name': productDetails['name'],
//         'brandName': productDetails['brandName'],
//         'productDetails': productDetails['productDetails'],
//         'isShowCashOnDelivery': productDetails['isShowCashOnDelivery'],
//         'images': productDetails['images'],
//         'videos': productDetails['videos'],
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       // Show a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product added to cart')),
//       );
//     } catch (e) {
//       // Handle errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to add product to cart: $e')),
//       );
//     }
//   }
//
//   // Future<void> _buyNow(Map<String, dynamic> productDetails) async {
//   //   try {
//   //     User? user = FirebaseAuth.instance.currentUser;
//   //     if (user == null) {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//   //       );
//   //       return;
//   //     }
//   //
//   //     String customerId = user.uid;
//   //
//   //     // Fetch customer document
//   //     DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//   //         .collection('customers')
//   //         .doc(customerId)
//   //         .get();
//   //
//   //     if (!customerSnapshot.exists || customerSnapshot['status'] != 'loggedIn') {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Navigate to Address Form Screen
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => AddressFormScreen(productId: widget.productId,),
//   //       ),
//   //     );
//   //
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => AddressFormScreen(productId: widget.productId),
//   //       ),
//   //     );
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to proceed: $e')),
//   //     );
//   //   }
//   // }
//   Future<void> _buyNow(Map<String, dynamic> productDetails) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       String customerId = user.uid;
//
//       // Fetch customer document
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .get();
//
//       if (!customerSnapshot.exists ||
//           customerSnapshot['status'] != 'loggedIn') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
//         );
//         return;
//       }
//
//       // Navigate to Address Form Screen with selected quantity
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AddressFormScreen(
//             productId: widget.productId,
//             quantity: _quantity, // Use the selected quantity
//             isShowCashOnDelivery: productDetails['isShowCashOnDelivery'],
//             sellerId: productDetails['productSellerId'],
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to proceed: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.productId),
//       // ),
//
//       appBar: AppBar(
//         title: FutureBuilder<Map<String, dynamic>>(
//           future: _productDetails,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Text('Loading...');
//             }
//             if (snapshot.hasError || !snapshot.hasData) {
//               return Text(widget.productId); // Fallback to product ID if error
//             }
//             return Text(snapshot.data!['name'] ?? widget.productId);
//           },
//         ),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _productDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No product details found.'));
//           }
//
//           Map<String, dynamic> productDetails = snapshot.data!;
//           List<String> images =
//               List<String>.from(productDetails['images'] ?? []);
//           List<String> videos =
//               List<String>.from(productDetails['videos'] ?? []);
//           Map<String, dynamic> productInfo =
//               productDetails['productDetails'] ?? {};
//
//           // Initialize video controllers if not already initialized
//           if (_videoControllers.isEmpty && videos.isNotEmpty) {
//             _initializeVideoControllers(videos);
//           }
//
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Carousel Slider for Images and Videos
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 300,
//                     autoPlay: true,
//                     aspectRatio: 16 / 9,
//                     viewportFraction: 1.0,
//                   ),
//                   items: [
//                     ...images.map((imageUrl) {
//                       return Image.network(
//                         imageUrl,
//                         fit: BoxFit.cover,
//                       );
//                     }),
//                     ..._videoControllers.map((controller) {
//                       return controller.value.isInitialized
//                           ? AspectRatio(
//                               aspectRatio: controller.value.aspectRatio,
//                               child: VideoPlayer(controller),
//                             )
//                           : const Center(child: CircularProgressIndicator());
//                     }),
//                   ],
//                 ),
//                 // Product Details
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Display product name
//                       Text(
//                         productDetails['name'] ?? 'No Name',
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Price Information Section
//                       Card(
//                         elevation: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Pricing Information',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Divider(),
//                               Row(
//                                 children: [
//                                   const Text(
//                                     'Offer Price: ',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     '₹${productInfo['Offer Price'] ?? 'Not Available'}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   const Text(
//                                     'Original Price: ',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     '₹${productInfo['Price'] ?? 'Not Available'}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       decoration: TextDecoration.lineThrough,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               if (productInfo['Discount'] != null)
//                                 Row(
//                                   children: [
//                                     const Text(
//                                       'Discount: ',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       '${productInfo['Discount']}%',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.green,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Basic Information Section
//                       Card(
//                         elevation: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Basic Information',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Divider(),
//                               _buildDetailRow(
//                                   'Brand', productDetails['brandName']),
//                               _buildDetailRow(
//                                   'Shop', productDetails['shopName']),
//                               _buildDetailRow(
//                                   'Category', productDetails['category']),
//                               _buildDetailRow(
//                                   'Expected Delivery', productDetails['expectedDelivery']),
//                               _buildDetailRow(
//                                   'Description', productDetails['description']),
//                               // _buildDetailRow('Cash on Delivery',
//                               //     productDetails['isShowCashOnDelivery']),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Product Specifications Section
//                       Card(
//                         elevation: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Product Specifications',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Divider(),
//                               // Dynamically display all fields from productInfo
//                               ...productInfo.entries.map((entry) {
//                                 // Skip fields already shown in pricing section
//                                 if (['Offer Price', 'Price', 'Discount']
//                                     .contains(entry.key)) {
//                                   return const SizedBox.shrink();
//                                 }
//                                 return _buildDetailRow(entry.key, entry.value);
//                               }),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Action Buttons
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             // Quantity selector
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.remove),
//                                   onPressed: () {
//                                     if (_quantity > 1) {
//                                       setState(() {
//                                         _quantity--;
//                                       });
//                                     }
//                                   },
//                                 ),
//                                 Text(
//                                   '$_quantity',
//                                   style: const TextStyle(fontSize: 18),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.add),
//                                   onPressed: () {
//                                     setState(() {
//                                       _quantity++;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             ElevatedButton(
//                               onPressed: () => _addToCart(productDetails),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: const Text(
//                                 'Add to Cart',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             ElevatedButton(
//                               onPressed: () => _buyNow(productDetails),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: const Text(
//                                 'Buy Now',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, dynamic value) {
//     if (value == null || value.toString().isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               '$label:',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value.toString(),
//               style: const TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


/// quantity issue fixed


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sadhana_cart/Customer/customer_address_form.dart';
// import 'package:sadhana_cart/Customer/customer_signin.dart';
// import 'package:sadhana_cart/Web/Customer/customer_signin.dart';
// import 'package:video_player/video_player.dart';
//
// class WebParticularProductDetailsScreen extends StatefulWidget {
//   final String productId;
//
//   const WebParticularProductDetailsScreen({super.key, required this.productId});
//
//   @override
//   _WebParticularProductDetailsScreenState createState() =>
//       _WebParticularProductDetailsScreenState();
// }
//
// class _WebParticularProductDetailsScreenState
//     extends State<WebParticularProductDetailsScreen> {
//   late Future<Map<String, dynamic>> _productDetails;
//   late List<VideoPlayerController> _videoControllers;
//   int _quantity = 1;
//   int _availableQuantity = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _productDetails = _fetchProductDetails();
//     _videoControllers = [];
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _videoControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   Future<Map<String, dynamic>> _fetchProductDetails() async {
//     try {
//       QuerySnapshot sellersSnapshot =
//       await FirebaseFirestore.instance.collection('seller').get();
//
//       for (var sellerDoc in sellersSnapshot.docs) {
//         String sellerId = sellerDoc.id;
//
//         var categories = [
//           'Footwear',
//           'Clothing',
//           'Electronics',
//           'Accessories',
//           'Home Appliances',
//           'Books',
//           'Others'
//         ];
//
//         for (var category in categories) {
//           DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
//               .collection('seller')
//               .doc(sellerId)
//               .collection(category)
//               .doc(widget.productId)
//               .get();
//
//           if (productSnapshot.exists) {
//             return productSnapshot.data() as Map<String, dynamic>;
//           }
//         }
//       }
//       throw Exception('Product not found');
//     } catch (e) {
//       throw Exception('Failed to fetch product details: $e');
//     }
//   }
//
//   void _initializeVideoControllers(List<String> videoUrls) {
//     for (var videoUrl in videoUrls) {
//       final VideoPlayerController controller =
//       VideoPlayerController.network(videoUrl);
//
//       controller.initialize().then((_) {
//         controller.setVolume(0);
//         controller.setLooping(true);
//         controller.play();
//         setState(() {});
//       });
//
//       _videoControllers.add(controller);
//     }
//   }
//
//   Future<void> _addToCart(Map<String, dynamic> productDetails) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user == null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
//         );
//         return;
//       }
//
//       String customerId = user.uid;
//
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .get();
//
//       if (!customerSnapshot.exists) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
//         );
//         return;
//       }
//
//       String status = customerSnapshot['status'];
//       if (status != 'loggedIn') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
//         );
//         return;
//       }
//
//       DocumentSnapshot cartDoc = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .doc(widget.productId)
//           .get();
//
//       if (cartDoc.exists) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Product already in cart')),
//         );
//         return;
//       }
//
//       await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .collection('cart')
//           .doc(widget.productId)
//           .set({
//         'productId': widget.productId,
//         'name': productDetails['name'],
//         'brandName': productDetails['brandName'],
//         'productDetails': productDetails['productDetails'],
//         'isShowCashOnDelivery': productDetails['isShowCashOnDelivery'],
//         'images': productDetails['images'],
//         'videos': productDetails['videos'],
//         'quantity': _quantity, // Add selected quantity
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product added to cart')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to add product to cart: $e')),
//       );
//     }
//   }
//
//   Future<void> _buyNow(Map<String, dynamic> productDetails) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
//         );
//         return;
//       }
//
//       String customerId = user.uid;
//
//       DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
//           .collection('customers')
//           .doc(customerId)
//           .get();
//
//       if (!customerSnapshot.exists ||
//           customerSnapshot['status'] != 'loggedIn') {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
//         );
//         return;
//       }
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AddressFormScreen(
//             productId: widget.productId,
//             quantity: _quantity,
//             isShowCashOnDelivery: productDetails['isShowCashOnDelivery'],
//             sellerId: productDetails['productSellerId'],
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to proceed: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: FutureBuilder<Map<String, dynamic>>(
//           future: _productDetails,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Text('Loading...');
//             }
//             if (snapshot.hasError || !snapshot.hasData) {
//               return Text(widget.productId);
//             }
//             return Text(snapshot.data!['name'] ?? widget.productId);
//           },
//         ),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _productDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No product details found.'));
//           }
//
//           Map<String, dynamic> productDetails = snapshot.data!;
//           List<String> images =
//           List<String>.from(productDetails['images'] ?? []);
//           List<String> videos =
//           List<String>.from(productDetails['videos'] ?? []);
//           Map<String, dynamic> productInfo =
//               productDetails['productDetails'] ?? {};
//
//           // Initialize video controllers if not already initialized
//           if (_videoControllers.isEmpty && videos.isNotEmpty) {
//             _initializeVideoControllers(videos);
//           }
//
//           // Update available quantity
//           _availableQuantity = int.tryParse(
//               (productInfo['Quantity'] ?? '0').toString()) ??
//               0;
//
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 300,
//                     autoPlay: true,
//                     aspectRatio: 16 / 9,
//                     viewportFraction: 1.0,
//                   ),
//                   items: [
//                     ...images.map((imageUrl) {
//                       return Image.network(
//                         imageUrl,
//                         fit: BoxFit.cover,
//                       );
//                     }),
//                     ..._videoControllers.map((controller) {
//                       return controller.value.isInitialized
//                           ? AspectRatio(
//                         aspectRatio: controller.value.aspectRatio,
//                         child: VideoPlayer(controller),
//                       )
//                           : const Center(child: CircularProgressIndicator());
//                     }),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         productDetails['name'] ?? 'No Name',
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Card(
//                         elevation: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Pricing Information',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Divider(),
//                               Row(
//                                 children: [
//                                   const Text(
//                                     'Offer Price: ',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     '₹${productInfo['Offer Price'] ?? 'Not Available'}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   const Text(
//                                     'Original Price: ',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     '₹${productInfo['Price'] ?? 'Not Available'}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       decoration: TextDecoration.lineThrough,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               if (productInfo['Discount'] != null)
//                                 Row(
//                                   children: [
//                                     const Text(
//                                       'Discount: ',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       '${productInfo['Discount']}%',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.green,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Card(
//                         elevation: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Basic Information',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Divider(),
//                               _buildDetailRow(
//                                   'Brand', productDetails['brandName']),
//                               _buildDetailRow(
//                                   'Shop', productDetails['shopName']),
//                               _buildDetailRow(
//                                   'Category', productDetails['category']),
//                               _buildDetailRow(
//                                   'Expected Delivery', productDetails['expectedDelivery']),
//                               _buildDetailRow(
//                                   'Description', productDetails['description']),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Card(
//                         elevation: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Product Specifications',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Divider(),
//                               ...productInfo.entries.map((entry) {
//                                 if (['Offer Price', 'Price', 'Discount']
//                                     .contains(entry.key)) {
//                                   return const SizedBox.shrink();
//                                 }
//                                 return _buildDetailRow(entry.key, entry.value);
//                               }),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.remove),
//                                   onPressed: () {
//                                     if (_quantity > 1) {
//                                       setState(() {
//                                         _quantity--;
//                                       });
//                                     }
//                                   },
//                                 ),
//                                 Text(
//                                   '$_quantity',
//                                   style: const TextStyle(fontSize: 18),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.add),
//                                   onPressed: () {
//                                     if (_quantity < _availableQuantity) {
//                                       setState(() {
//                                         _quantity++;
//                                       });
//                                     } else {
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         const SnackBar(
//                                           content: Text('Maximum available quantity reached'),
//                                           duration: Duration(seconds: 2),
//                                         ),
//                                       );
//                                     }
//                                   },
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 8.0),
//                                   child: Text(
//                                     'Available: $_availableQuantity',
//                                     style: const TextStyle(fontSize: 14, color: Colors.grey),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             ElevatedButton(
//                               onPressed: () => _addToCart(productDetails),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 padding:
//                                 const EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: const Text(
//                                 'Add to Cart',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             ElevatedButton(
//                               onPressed: () => _buyNow(productDetails),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 padding:
//                                 const EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: const Text(
//                                 'Buy Now',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, dynamic value) {
//     if (value == null || value.toString().isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               '$label:',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value.toString(),
//               style: const TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// changing front end according to web



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/Web/Customer/customer_address_form.dart';
// import 'package:sadhana_cart/Customer/customer_address_form.dart';
import 'package:sadhana_cart/Web/Customer/customer_signin.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

class WebParticularProductDetailsScreen extends StatefulWidget {
  final String productId;

  const WebParticularProductDetailsScreen({super.key, required this.productId});

  @override
  _WebParticularProductDetailsScreenState createState() =>
      _WebParticularProductDetailsScreenState();
}

class _WebParticularProductDetailsScreenState
    extends State<WebParticularProductDetailsScreen> {
  late Future<Map<String, dynamic>> _productDetails;
  late List<VideoPlayerController> _videoControllers;
  int _quantity = 1;
  int _availableQuantity = 0;
  int _currentImageIndex = 0;
  bool _isWishlisted = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _productDetails = _fetchProductDetails();
    _videoControllers = [];
    _checkWishlistStatus();
  }

  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _checkWishlistStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot wishlistDoc = await FirebaseFirestore.instance
          .collection('customers')
          .doc(user.uid)
          .collection('wishlist')
          .doc(widget.productId)
          .get();

      if (mounted) {
        setState(() {
          _isWishlisted = wishlistDoc.exists;
        });
      }
    }
  }

  Future<Map<String, dynamic>> _fetchProductDetails() async {
    try {
      QuerySnapshot sellersSnapshot =
      await FirebaseFirestore.instance.collection('seller').get();

      for (var sellerDoc in sellersSnapshot.docs) {
        String sellerId = sellerDoc.id;

        var categories = [
          'Footwear',
          'Clothing',
          'Electronics',
          'Accessories',
          'Home Appliances',
          'Books',
          'Others'
        ];

        for (var category in categories) {
          DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
              .collection('seller')
              .doc(sellerId)
              .collection(category)
              .doc(widget.productId)
              .get();

          if (productSnapshot.exists) {
            return productSnapshot.data() as Map<String, dynamic>;
          }
        }
      }
      throw Exception('Product not found');
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

  void _initializeVideoControllers(List<String> videoUrls) {
    for (var videoUrl in videoUrls) {
      final VideoPlayerController controller =
      VideoPlayerController.network(videoUrl);

      controller.initialize().then((_) {
        controller.setVolume(0);
        controller.setLooping(true);
        controller.play();
        if (mounted) {
          setState(() {});
        }
      });

      _videoControllers.add(controller);
    }
  }

  Future<void> _toggleWishlist() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
        );
        return;
      }

      String customerId = user.uid;

      if (_isWishlisted) {
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(customerId)
            .collection('wishlist')
            .doc(widget.productId)
            .delete();
      } else {
        Map<String, dynamic> productDetails = await _productDetails;

        await FirebaseFirestore.instance
            .collection('customers')
            .doc(customerId)
            .collection('wishlist')
            .doc(widget.productId)
            .set({
          'productId': widget.productId,
          'name': productDetails['name'],
          'brandName': productDetails['brandName'],
          'images': productDetails['images'],
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      if (mounted) {
        setState(() {
          _isWishlisted = !_isWishlisted;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isWishlisted ? 'Added to wishlist' : 'Removed from wishlist'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update wishlist: $e')),
        );
      }
    }
  }

  Future<void> _addToCart(Map<String, dynamic> productDetails) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
        );
        return;
      }

      String customerId = user.uid;

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .get();

      if (!customerSnapshot.exists) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
        );
        return;
      }

      String status = customerSnapshot['status'];
      if (status != 'loggedIn') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
        );
        return;
      }

      DocumentSnapshot cartDoc = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('cart')
          .doc(widget.productId)
          .get();

      if (cartDoc.exists) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Product already in cart'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
        return;
      }

      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('cart')
          .doc(widget.productId)
          .set({
        'productId': widget.productId,
        'name': productDetails['name'],
        'brandName': productDetails['brandName'],
        'productDetails': productDetails['productDetails'],
        'isShowCashOnDelivery': productDetails['isShowCashOnDelivery'],
        'images': productDetails['images'],
        'videos': productDetails['videos'],
        'quantity': _quantity,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text('Product added to cart'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add product to cart: $e'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  Future<void> _buyNow(Map<String, dynamic> productDetails) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
        );
        return;
      }

      String customerId = user.uid;

      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .get();

      if (!customerSnapshot.exists ||
          customerSnapshot['status'] != 'loggedIn') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebCustomerSigninScreen()),
        );
        return;
      }

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              WebAddressFormScreen(
                productId: widget.productId,
                quantity: _quantity,
                isShowCashOnDelivery: productDetails['isShowCashOnDelivery'],
                sellerId: productDetails['productSellerId'],
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to proceed: $e'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  Widget _buildImageGallery(List<String> images, List<String> videos) {
    return Column(
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[100],
          ),
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 500,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
                items: [
                  ...images.map((imageUrl) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ).animate().fadeIn(duration: 500.ms);
                  }),
                  ..._videoControllers.map((controller) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: controller.value.isInitialized
                          ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )
                          : const Center(child: CircularProgressIndicator()),
                    );
                  }),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length + videos.length,
                        (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentImageIndex == index
                            ? Colors.blue
                            : Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    _isWishlisted ? Icons.favorite : Icons.favorite_border,
                    color: _isWishlisted ? Colors.red : Colors.grey[700],
                    size: 30,
                  ),
                  onPressed: _toggleWishlist,
                ).animate().scale(duration: 300.ms),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (images.length + videos.length > 1)
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length + videos.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _currentImageIndex == index
                            ? Colors.blue
                            : Colors.grey[300]!,
                        width: _currentImageIndex == index ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: index < images.length
                          ? Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.videocam, size: 30),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // Widget _buildPriceSection(Map<String, dynamic> productInfo) {
  //   final offerPrice = productInfo['Offer Price'] ?? 0;
  //   final originalPrice = productInfo['Price'] ?? 0;
  //   final discount = productInfo['Discount'] != null
  //       ? '${productInfo['Discount']}% OFF'
  //       : '';
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       if (discount.isNotEmpty)
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //           decoration: BoxDecoration(
  //             color: Colors.red[50],
  //             borderRadius: BorderRadius.circular(4),
  //           ),
  //           child: Text(
  //             discount,
  //             style: TextStyle(
  //               color: Colors.red[800],
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ).animate().slideX(begin: 0.2),
  //       const SizedBox(height: 8),
  //       Row(
  //         children: [
  //           Text(
  //             '₹$offerPrice',
  //             style: const TextStyle(
  //               fontSize: 28,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black87,
  //             ),
  //           ),
  //           const SizedBox(width: 10),
  //           if (originalPrice > offerPrice)
  //             Text(
  //               '₹$originalPrice',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 decoration: TextDecoration.lineThrough,
  //                 color: Colors.grey[600],
  //               ),
  //             ),
  //         ],
  //       ).animate().fadeIn(delay: 100.ms),
  //       const SizedBox(height: 8),
  //       if (originalPrice > offerPrice)
  //         Text(
  //           'You save ₹${originalPrice - offerPrice}',
  //           style: TextStyle(
  //             color: Colors.green[800],
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ).animate().fadeIn(delay: 200.ms),
  //       const SizedBox(height: 16),
  //       const Divider(),
  //     ],
  //   );
  // }

  Widget _buildPriceSection(Map<String, dynamic> productInfo) {
    // Helper function to parse formatted price strings
    num parseFormattedPrice(String priceStr) {
      if (priceStr == null || priceStr.isEmpty) return 0;
      return num.tryParse(priceStr.replaceAll(',', '')) ?? 0;
    }

    final offerPrice = parseFormattedPrice(productInfo['Offer Price']?.toString() ?? '0');
    final originalPrice = parseFormattedPrice(productInfo['Price']?.toString() ?? '0');
    final discount = productInfo['Discount'] != null
        ? '${productInfo['Discount']}% OFF'
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (discount.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              discount,
              style: TextStyle(
                color: Colors.red[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ).animate().slideX(begin: 0.2),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '₹${offerPrice.toStringAsFixed(2).replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},',
              )}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 10),
            if (originalPrice > offerPrice)
              Text(
                '₹${originalPrice.toStringAsFixed(2).replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                )}',
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ).animate().fadeIn(delay: 100.ms),
        const SizedBox(height: 8),
        if (originalPrice > offerPrice)
          Text(
            'You save ₹${(originalPrice - offerPrice).toStringAsFixed(2).replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},',
            )}',
            style: TextStyle(
              color: Colors.green[800],
              fontWeight: FontWeight.w500,
            ),
          ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (_quantity > 1) {
                    setState(() {
                      _quantity--;
                    });
                  }
                },
                splashRadius: 20,
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '$_quantity',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_quantity < _availableQuantity) {
                    setState(() {
                      _quantity++;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                        content: Text('Maximum available quantity reached'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                },
                splashRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Available: $_availableQuantity',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> productDetails) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _buyNow(productDetails),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'BUY NOW',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ).animate().scale(delay: 300.ms),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _addToCart(productDetails),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.deepOrange),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'ADD TO CART',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ).animate().scale(delay: 400.ms),
        ),
      ],
    );
  }

  Widget _buildSpecificationItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _productDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerLoading();
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _productDetails = _fetchProductDetails();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No product details found.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          Map<String, dynamic> productDetails = snapshot.data!;
          List<String> images =
          List<String>.from(productDetails['images'] ?? []);
          List<String> videos =
          List<String>.from(productDetails['videos'] ?? []);
          Map<String, dynamic> productInfo =
              productDetails['productDetails'] ?? {};

          // Initialize video controllers if not already initialized
          if (_videoControllers.isEmpty && videos.isNotEmpty) {
            _initializeVideoControllers(videos);
          }

          // Update available quantity
          _availableQuantity = int.tryParse(
              (productInfo['Quantity'] ?? '0').toString()) ??
              0;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    productDetails['name'] ?? 'Product Details',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  background: images.isNotEmpty
                      ? Image.network(
                    images[0],
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                  )
                      : Container(color: Colors.grey),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name and Brand
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productDetails['name'] ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (productDetails['brandName'] != null)
                            Text(
                              'by ${productDetails['brandName']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ).animate().fadeIn(duration: 300.ms),

                      const SizedBox(height: 24),

                      // Main Content Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image Gallery
                          Expanded(
                            flex: 6,
                            child: _buildImageGallery(images, videos),
                          ),

                          const SizedBox(width: 32),

                          // Product Info
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Price Section
                                _buildPriceSection(productInfo),

                                const SizedBox(height: 24),

                                // Quantity Selector
                                _buildQuantitySelector(),

                                const SizedBox(height: 24),

                                // Action Buttons
                                _buildActionButtons(productDetails),

                                const SizedBox(height: 24),

                                // Delivery Info
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.local_shipping,
                                              color: Colors.deepOrange,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'Delivery',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          productDetails['expectedDelivery'] ??
                                              'Delivery time not specified',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Product Details Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Product Details'),
                          const Divider(),
                          const SizedBox(height: 16),
                          if (productDetails['description'] != null)
                            Text(
                              productDetails['description']!,
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.6,
                              ),
                            ),
                        ],
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 40),

                      // Specifications Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Specifications'),
                          const Divider(),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              _buildSpecificationItem(
                                  'Brand', productDetails['brandName'] ?? '-'),
                              _buildSpecificationItem(
                                  'Shop', productDetails['shopName'] ?? '-'),
                              _buildSpecificationItem(
                                  'Category', productDetails['category'] ?? '-'),
                              ...productInfo.entries.map((entry) {
                                if (['Offer Price', 'Price', 'Discount', 'Quantity']
                                    .contains(entry.key)) {
                                  return const SizedBox.shrink();
                                }
                                return _buildSpecificationItem(
                                    entry.key, entry.value.toString());
                              }),
                            ],
                          ),
                        ],
                      ).animate().fadeIn(delay: 300.ms),

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 30,
                        width: 200,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 20,
                        width: 150,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

