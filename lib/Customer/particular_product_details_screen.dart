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

//testing

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/Customer/customer_address_form.dart';
import 'package:sadhana_cart/Customer/customer_signin.dart';
import 'package:video_player/video_player.dart';

class ParticularProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ParticularProductDetailsScreen({super.key, required this.productId});

  @override
  _ParticularProductDetailsScreenState createState() =>
      _ParticularProductDetailsScreenState();
}

int _quantity = 1;

class _ParticularProductDetailsScreenState
    extends State<ParticularProductDetailsScreen> {
  late Future<Map<String, dynamic>> _productDetails;
  late List<VideoPlayerController> _videoControllers;

  @override
  void initState() {
    super.initState();
    _productDetails = _fetchProductDetails();
    _videoControllers = [];
  }

  @override
  void dispose() {
    // Dispose all video controllers to free up resources
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<Map<String, dynamic>> _fetchProductDetails() async {
    try {
      // Fetch all sellers
      QuerySnapshot sellersSnapshot =
          await FirebaseFirestore.instance.collection('seller').get();

      // Iterate through each seller
      for (var sellerDoc in sellersSnapshot.docs) {
        String sellerId = sellerDoc.id;

        // Fetch all categories for the seller
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
          // Fetch the product document from the category subcollection
          DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
              .collection('seller')
              .doc(sellerId)
              .collection(category)
              .doc(widget.productId)
              .get();

          if (productSnapshot.exists) {
            // Return the product details if found
            return productSnapshot.data() as Map<String, dynamic>;
          }
        }
      }

      // If no product is found, throw an exception
      throw Exception('Product not found');
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

  void _initializeVideoControllers(List<String> videoUrls) {
    for (var videoUrl in videoUrls) {
      // Declare and initialize the controller
      final VideoPlayerController controller =
          VideoPlayerController.network(videoUrl);

      // Initialize the controller and add it to the list
      controller.initialize().then((_) {
        // Mute the video
        controller.setVolume(0);
        // Start playing the video in a loop
        controller.setLooping(true);
        controller.play();
        setState(() {});
      });

      // Add the controller to the list
      _videoControllers.add(controller);
    }
  }

  Future<void> _addToCart(Map<String, dynamic> productDetails) async {
    try {
      // Get the current user from Firebase Auth
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // If no user is logged in, navigate to the sign-in screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
        );
        return;
      }

      // Use the user's UID as the customerId
      String customerId = user.uid;

      // Fetch the customer's document
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .get();

      if (!customerSnapshot.exists) {
        // If the customer document does not exist, navigate to the sign-in screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
        );
        return;
      }

      // Check if the customer is logged in
      String status = customerSnapshot['status'];
      if (status != 'loggedIn') {
        // If the customer is not logged in, navigate to the sign-in screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
        );
        return;
      }

      // Check if the product already exists in the cart
      DocumentSnapshot cartDoc = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('cart')
          .doc(widget.productId) // Check if product ID exists as a document
          .get();

      if (cartDoc.exists) {
        // If the product already exists in the cart, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product already in cart')),
        );
        return;
      }

      // Add the product to the cart using productId as the document ID
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .collection('cart')
          .doc(widget.productId) // Set document ID as productId
          .set({
        'productId': widget.productId,
        'name': productDetails['name'],
        'brandName': productDetails['brandName'],
        'productDetails': productDetails['productDetails'],
        'isShowCashOnDelivery': productDetails['isShowCashOnDelivery'],
        'images': productDetails['images'],
        'videos': productDetails['videos'],
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added to cart')),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product to cart: $e')),
      );
    }
  }

  // Future<void> _buyNow(Map<String, dynamic> productDetails) async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
  //       );
  //       return;
  //     }
  //
  //     String customerId = user.uid;
  //
  //     // Fetch customer document
  //     DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
  //         .collection('customers')
  //         .doc(customerId)
  //         .get();
  //
  //     if (!customerSnapshot.exists || customerSnapshot['status'] != 'loggedIn') {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => CustomerSigninScreen()),
  //       );
  //       return;
  //     }
  //
  //     // Navigate to Address Form Screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AddressFormScreen(productId: widget.productId,),
  //       ),
  //     );
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AddressFormScreen(productId: widget.productId),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to proceed: $e')),
  //     );
  //   }
  // }
  Future<void> _buyNow(Map<String, dynamic> productDetails) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
        );
        return;
      }

      String customerId = user.uid;

      // Fetch customer document
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .get();

      if (!customerSnapshot.exists ||
          customerSnapshot['status'] != 'loggedIn') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomerSigninScreen()),
        );
        return;
      }

      // Navigate to Address Form Screen with selected quantity
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressFormScreen(
            productId: widget.productId,
            quantity: _quantity, // Use the selected quantity
            isShowCashOnDelivery: productDetails['isShowCashOnDelivery'],
            sellerId: productDetails['productSellerId'],
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to proceed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productId),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _productDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No product details found.'));
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

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carousel Slider for Images and Videos
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                  ),
                  items: [
                    ...images.map((imageUrl) {
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      );
                    }),
                    ..._videoControllers.map((controller) {
                      return controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: VideoPlayer(controller),
                            )
                          : const Center(child: CircularProgressIndicator());
                    }),
                  ],
                ),
                // Product Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display product name
                      Text(
                        productDetails['name'] ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Price Information Section
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pricing Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  const Text(
                                    'Offer Price: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '₹${productInfo['Offer Price'] ?? 'Not Available'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    'Original Price: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '₹${productInfo['Price'] ?? 'Not Available'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (productInfo['Discount'] != null)
                                Row(
                                  children: [
                                    const Text(
                                      'Discount: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${productInfo['Discount']}%',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Basic Information Section
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Basic Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(),
                              _buildDetailRow(
                                  'Brand', productDetails['brandName']),
                              _buildDetailRow(
                                  'Shop', productDetails['shopName']),
                              _buildDetailRow(
                                  'Category', productDetails['category']),
                              _buildDetailRow(
                                  'Description', productDetails['description']),
                              // _buildDetailRow('Cash on Delivery',
                              //     productDetails['isShowCashOnDelivery']),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Product Specifications Section
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Product Specifications',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(),
                              // Dynamically display all fields from productInfo
                              ...productInfo.entries.map((entry) {
                                // Skip fields already shown in pricing section
                                if (['Offer Price', 'Price', 'Discount']
                                    .contains(entry.key)) {
                                  return const SizedBox.shrink();
                                }
                                return _buildDetailRow(entry.key, entry.value);
                              }),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Action Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Quantity selector
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                ),
                                Text(
                                  '$_quantity',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      _quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _addToCart(productDetails),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _buyNow(productDetails),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Buy Now',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
