// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:sadhana_cart/Customer/category_products_screen.dart';
// // import 'package:sadhana_cart/Customer/customer_bottom_navigationber_layout.dart';
// //
// // class HomeTab extends StatelessWidget {
// //   // Map category names to asset image paths
// //   final Map<String, String> categoryImages = {
// //     'Clothing': 'assets/images/clothings_category_customer_hometab.jpeg',
// //     'Electronics': 'assets/images/Electronics_category_customer_hometab.jpeg',
// //     'Footwear': 'assets/images/footwear_category_customer_hometab.jpeg',
// //     'Accessories': 'assets/images/accessories.png',
// //     'Home Appliances': 'assets/images/home_appliances.png',
// //     'Books': 'assets/images/books.png',
// //     'Others': 'assets/images/others.png',
// //   };
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: StreamBuilder<QuerySnapshot>(
// //         // Fetch all sellers
// //         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           }
// //
// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //             return Center(child: Text('No sellers found.'));
// //           }
// //
// //           // Fetch items for each seller
// //           return FutureBuilder<List<Map<String, dynamic>>>(
// //             future: _fetchAllSellerItems(snapshot.data!.docs),
// //             builder: (context, itemSnapshot) {
// //               if (itemSnapshot.connectionState == ConnectionState.waiting) {
// //                 return Center(child: CircularProgressIndicator());
// //               }
// //
// //               if (itemSnapshot.hasError) {
// //                 return Center(child: Text('Error: ${itemSnapshot.error}'));
// //               }
// //
// //               if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
// //                 return Center(child: Text('No items found.'));
// //               }
// //
// //               // Extract unique categories
// //               Set<String> uniqueCategories = {};
// //               for (var item in itemSnapshot.data!) {
// //                 uniqueCategories.add(item['category']);
// //               }
// //               List<String> categories = uniqueCategories.toList();
// //
// //               // Display only the category list
// //               return Column(
// //                 children: [
// //                   // Horizontal scrollable category list with circular images
// //                   Container(
// //                     height: 100, // Adjust height as needed
// //                     child: ListView.builder(
// //                       scrollDirection: Axis.horizontal,
// //                       itemCount: categories.length,
// //                       itemBuilder: (context, index) {
// //                         String category = categories[index];
// //                         String imagePath = categoryImages[category] ?? 'assets/images/default.png'; // Fallback image
// //
// //                         return GestureDetector(
// //                           onTap: () {
// //                             // Navigate to the category-specific products page
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => CategoryProductsPage(
// //                                   category: category,
// //                                   allItems: itemSnapshot.data!,
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                           child: Padding(
// //                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 // Circular image
// //                                 CircleAvatar(
// //                                   radius: 30, // Adjust size as needed
// //                                   backgroundImage: AssetImage(imagePath),
// //                                 ),
// //                                 SizedBox(height: 8), // Spacing between image and text
// //                                 // Category name with custom text style
// //                                 Text(
// //                                   category,
// //                                   style: TextStyle(
// //                                     fontSize: 12, // Adjust font size
// //                                     color: Colors.black, // Text color
// //                                     fontFamily: 'Roboto', // Custom font family
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   // Fetch all items for all sellers
// //   Future<List<Map<String, dynamic>>> _fetchAllSellerItems(List<QueryDocumentSnapshot> sellers) async {
// //     List<Map<String, dynamic>> allItems = [];
// //
// //     for (var seller in sellers) {
// //       String sellerId = seller.id;
// //
// //       // Manually fetch subcollections (categories) for the seller
// //       var categories = ['Clothing', 'Electronics', 'Footwear', 'Accessories', 'Home Appliances', 'Books', 'Others']; // Add all your categories here
// //
// //       for (var category in categories) {
// //         var snapshot = await FirebaseFirestore.instance
// //             .collection('seller')
// //             .doc(sellerId)
// //             .collection(category)
// //             .get();
// //
// //         for (var doc in snapshot.docs) {
// //           allItems.add({
// //             ...doc.data(),
// //             'sellerId': sellerId,
// //             'category': category,
// //           });
// //         }
// //       }
// //     }
// //
// //     return allItems;
// //   }
// // }
//
//
//
//
//
// // new
//
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:carousel_slider/carousel_slider.dart';
// // import 'package:sadhana_cart/Customer/category_products_screen.dart';
// // import 'package:sadhana_cart/Customer/customer_bottom_navigationber_layout.dart';
// //
// // class HomeTab extends StatelessWidget {
// //   // Map category names to asset image paths
// //   final Map<String, String> categoryImages = {
// //     'Clothing': 'assets/images/clothings_category_customer_hometab.jpeg',
// //     'Electronics': 'assets/images/Electronics_category_customer_hometab.jpeg',
// //     'Footwear': 'assets/images/footwear_category_customer_hometab.jpeg',
// //     'Accessories': 'assets/images/accessories.png',
// //     'Home Appliances': 'assets/images/home_appliances.png',
// //     'Books': 'assets/images/books.png',
// //     'Others': 'assets/images/others.png',
// //   };
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: StreamBuilder<QuerySnapshot>(
// //         // Fetch all sellers
// //         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           }
// //
// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //             return Center(child: Text('No sellers found.'));
// //           }
// //
// //           // Fetch items for each seller
// //           return FutureBuilder<List<Map<String, dynamic>>>(
// //             future: _fetchAllSellerItems(snapshot.data!.docs),
// //             builder: (context, itemSnapshot) {
// //               if (itemSnapshot.connectionState == ConnectionState.waiting) {
// //                 return Center(child: CircularProgressIndicator());
// //               }
// //
// //               if (itemSnapshot.hasError) {
// //                 return Center(child: Text('Error: ${itemSnapshot.error}'));
// //               }
// //
// //               if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
// //                 return Center(child: Text('No items found.'));
// //               }
// //
// //               // Organize items by category
// //               Map<String, List<Map<String, dynamic>>> itemsByCategory = {};
// //               for (var item in itemSnapshot.data!) {
// //                 String category = item['category'];
// //                 if (!itemsByCategory.containsKey(category)) {
// //                   itemsByCategory[category] = [];
// //                 }
// //                 itemsByCategory[category]!.add(item);
// //               }
// //
// //               // Extract unique categories
// //               List<String> categories = itemsByCategory.keys.toList();
// //
// //               return Column(
// //                 children: [
// //                   // Horizontal scrollable category list with circular images
// //                   Container(
// //                     height: 100, // Adjust height as needed
// //                     child: ListView.builder(
// //                       scrollDirection: Axis.horizontal,
// //                       itemCount: categories.length,
// //                       itemBuilder: (context, index) {
// //                         String category = categories[index];
// //                         String imagePath = categoryImages[category] ?? 'assets/images/default.png'; // Fallback image
// //
// //                         return GestureDetector(
// //                           onTap: () {
// //                             // Navigate to the category-specific products page
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => CategoryProductsPage(
// //                                   category: category,
// //                                   allItems: itemSnapshot.data!,
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                           child: Padding(
// //                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 // Circular image
// //                                 CircleAvatar(
// //                                   radius: 30, // Adjust size as needed
// //                                   backgroundImage: AssetImage(imagePath),
// //                                 ),
// //                                 SizedBox(height: 8), // Spacing between image and text
// //                                 // Category name with custom text style
// //                                 Text(
// //                                   category,
// //                                   style: TextStyle(
// //                                     fontSize: 12, // Adjust font size
// //                                     color: Colors.black, // Text color
// //                                     fontFamily: 'Roboto', // Custom font family
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   // Display items in a carousel slider for each category
// //                   Expanded(
// //                     child: ListView.builder(
// //                       itemCount: categories.length,
// //                       itemBuilder: (context, index) {
// //                         String category = categories[index];
// //                         List<Map<String, dynamic>> items = itemsByCategory[category]!;
// //
// //                         return Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: Row(
// //                                 children: [
// //                                   Text(
// //                                     category,
// //                                     style: TextStyle(
// //                                       fontSize: 18,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                   Spacer(), // Pushes "See All" to the right
// //                                   Stack(
// //                                     clipBehavior: Clip.none, // Ensures proper alignment
// //                                     children: [
// //                                       Text(
// //                                         "See All",
// //                                         style: TextStyle(
// //                                           fontSize: 15,
// //                                           fontWeight: FontWeight.bold,
// //                                           color: Colors.indigo, // Text color
// //                                         ),
// //                                       ),
// //                                       Positioned(
// //                                         bottom: -1, // Adjust to remove space between text and underline
// //                                         left: 0,
// //                                         child: Container(
// //                                           height: 2, // Underline thickness
// //                                           width: 50, // Adjust width as needed
// //                                           color: Colors.indigo, // Underline color
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: 180, // Fixed height for the carousel
// //                               child: CarouselSlider(
// //                                 options: CarouselOptions(
// //                                   height: 180, // Match the height of the SizedBox
// //                                   autoPlay: false,
// //                                   aspectRatio: 16 / 9,
// //                                   viewportFraction: 0.32, // Adjust this value to add a little space between items
// //                                   enlargeCenterPage: false, // Disable highlighting of the middle item
// //                                   padEnds: false, // Reduce space at the ends
// //                                 ),
// //                                 items: items.map((item) {
// //                                   // Extract product details from the map
// //                                   Map<String, dynamic> productDetails = item['productDetails'] ?? {};
// //                                   String offerPrice = productDetails['Offer Price'] ?? '0';
// //                                   String price = productDetails['Price'] ?? '0';
// //                                   String size = productDetails['Size'] ?? 'No Size';
// //                                   String color = productDetails['Color'] ?? 'No Color';
// //
// //                                   return Container(
// //                                     margin: EdgeInsets.symmetric(horizontal: 4), // Add a little space between items
// //                                     child: SizedBox(
// //                                       width: 110, // Fixed width for each item
// //                                       child: Card(
// //                                         elevation: 2.0,
// //                                         child: Column(
// //                                           crossAxisAlignment: CrossAxisAlignment.start,
// //                                           children: [
// //                                             // Display the first image from the imageUrls list
// //                                             ClipRRect(
// //                                               borderRadius: BorderRadius.only(
// //                                                 topLeft: Radius.circular(12), // Adjust as needed
// //                                                 topRight: Radius.circular(12),
// //                                               ),
// //                                               child: Container(
// //                                                 height: 80, // Fixed height for the image
// //                                                 width: double.infinity,
// //                                                 child: item['images'] != null && item['images'].isNotEmpty
// //                                                     ? Image.network(
// //                                                   item['images'][0], // Use the first image
// //                                                   fit: BoxFit.cover,
// //                                                 )
// //                                                     : Placeholder(), // Fallback if no image is available
// //                                               ),
// //                                             ),
// //                                             Padding(
// //                                               padding: const EdgeInsets.all(4.0),
// //                                               child: Column(
// //                                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                                 children: [
// //                                                   // Display the product name
// //                                                   Text(
// //                                                     item['name'] ?? 'No Name',
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                       fontWeight: FontWeight.bold,
// //                                                     ),
// //                                                     maxLines: 1,
// //                                                     overflow: TextOverflow.ellipsis,
// //                                                   ),
// //                                                   SizedBox(height: 2),
// //                                                   // Display the offer price and original price
// //                                                   Row(
// //                                                     children: [
// //                                                       Text(
// //                                                         '₹$offerPrice',
// //                                                         style: TextStyle(
// //                                                           fontSize: 10,
// //                                                           fontWeight: FontWeight.bold,
// //                                                           color: Colors.red,
// //                                                         ),
// //                                                       ),
// //                                                       SizedBox(width: 4),
// //                                                       Text(
// //                                                         '₹$price',
// //                                                         style: TextStyle(
// //                                                           fontSize: 10,
// //                                                           color: Colors.grey,
// //                                                           decoration: TextDecoration.lineThrough,
// //                                                         ),
// //                                                       ),
// //                                                     ],
// //                                                   ),
// //                                                   SizedBox(height: 2),
// //                                                   // Display the brand name
// //                                                   Text(
// //                                                     item['brandName'] ?? 'No Brand Name',
// //                                                     style: TextStyle(
// //                                                       fontSize: 10,
// //                                                       color: Colors.grey,
// //                                                     ),
// //                                                     maxLines: 1,
// //                                                     overflow: TextOverflow.ellipsis,
// //                                                   ),
// //                                                   SizedBox(height: 2),
// //                                                   // Display the size
// //                                                   Text(
// //                                                     'Size: $size',
// //                                                     style: TextStyle(
// //                                                       fontSize: 10,
// //                                                       color: Colors.grey,
// //                                                     ),
// //                                                     maxLines: 1,
// //                                                     overflow: TextOverflow.ellipsis,
// //                                                   ),
// //                                                   SizedBox(height: 2),
// //                                                   // Display the color
// //                                                   Text(
// //                                                     'Color: $color',
// //                                                     style: TextStyle(
// //                                                       fontSize: 10,
// //                                                       color: Colors.grey,
// //                                                     ),
// //                                                     maxLines: 1,
// //                                                     overflow: TextOverflow.ellipsis,
// //                                                   ),
// //                                                 ],
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   );
// //                                 }).toList(),
// //                               ),
// //                             ),
// //                           ],
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   // Fetch all items for all sellers
// //   Future<List<Map<String, dynamic>>> _fetchAllSellerItems(List<QueryDocumentSnapshot> sellers) async {
// //     List<Map<String, dynamic>> allItems = [];
// //
// //     for (var seller in sellers) {
// //       String sellerId = seller.id;
// //
// //       // Manually fetch subcollections (categories) for the seller
// //       var categories = ['Clothing', 'Electronics', 'Footwear', 'Accessories', 'Home Appliances', 'Books', 'Others']; // Add all your categories here
// //
// //       for (var category in categories) {
// //         var snapshot = await FirebaseFirestore.instance
// //             .collection('seller')
// //             .doc(sellerId)
// //             .collection(category)
// //             .get();
// //
// //         for (var doc in snapshot.docs) {
// //           allItems.add({
// //             ...doc.data(),
// //             'sellerId': sellerId,
// //             'category': category,
// //           });
// //         }
// //       }
// //     }
// //
// //     return allItems;
// //   }
// // }
//
//
//     // 04/16/2025
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sadhana_cart/Customer/category_products_screen.dart';
// import 'package:sadhana_cart/Customer/customer_category_see_all_screen.dart';
// import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
//
// class HomeTab extends StatelessWidget {
//   // Map category names to asset image paths
//   final Map<String, String> categoryImages = {
//     'Clothing': 'assets/images/clothings_category_customer_hometab.jpeg',
//     'Electronics': 'assets/images/Electronics_category_customer_hometab.jpeg',
//     'Footwear': 'assets/images/footwear_category_customer_hometab.jpeg',
//     'Accessories': 'assets/images/Accessories_category.jpg',
//     'Home Appliances': 'assets/images/home_appliences_category.jpg',
//     'Books': 'assets/images/books_category.jpeg',
//     'Others': 'assets/images/vegetables_category.jpeg',
//   };
//
//   String? _sellerId;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         // Fetch all sellers
//         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No sellers found.'));
//           }
//
//           // Fetch items for each seller
//           return FutureBuilder<List<Map<String, dynamic>>>(
//             future: _fetchAllSellerItems(snapshot.data!.docs),
//             builder: (context, itemSnapshot) {
//               if (itemSnapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }
//
//               if (itemSnapshot.hasError) {
//                 return Center(child: Text('Error: ${itemSnapshot.error}'));
//               }
//
//               if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
//                 return Center(child: Text('No items found.'));
//               }
//
//               // Organize items by category
//               Map<String, List<Map<String, dynamic>>> itemsByCategory = {};
//               for (var item in itemSnapshot.data!) {
//                 String category = item['category'];
//                 if (!itemsByCategory.containsKey(category)) {
//                   itemsByCategory[category] = [];
//                 }
//                 itemsByCategory[category]!.add(item);
//               }
//
//               // Extract unique categories
//               List<String> categories = itemsByCategory.keys.toList();
//
//               return Column(
//                 children: [
//
//
//                   // Horizontal scrollable category list with circular images
//                   Container(
//                     height: 100, // Adjust height as needed
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: categories.length,
//                       itemBuilder: (context, index) {
//                         String category = categories[index];
//                         String imagePath = categoryImages[category] ?? 'assets/images/default.png'; // Fallback image
//
//                         return GestureDetector(
//                           onTap: () {
//                             // Navigate to the category-specific products page
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CategoryProductsPage(
//                                   category: category,
//                                   allItems: itemSnapshot.data!,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Circular image
//                                 CircleAvatar(
//                                   radius: 30, // Adjust size as needed
//                                   backgroundImage: AssetImage(imagePath),
//                                 ),
//                                 SizedBox(height: 8), // Spacing between image and text
//                                 // Category name with custom text style
//                                 Text(
//                                   category,
//                                   style: TextStyle(
//                                     fontSize: 12, // Adjust font size
//                                     color: Colors.black, // Text color
//                                     fontFamily: 'Roboto', // Custom font family
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//
//                   // 🔥 Carousel Slider (Fetching from seller-specific 'offers')
//                   StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collectionGroup('offers')
//                         .orderBy('uploadedAt', descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return SizedBox(
//                           height: 180,
//                           child: Center(child: CircularProgressIndicator()),
//                         );
//                       }
//
//                       if (snapshot.hasError) {
//                         return SizedBox(
//                           height: 180,
//                           child: Center(child: Text('Failed to load banners')),
//                         );
//                       }
//
//                       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                         return SizedBox(
//                           height: 180,
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.image_not_supported, size: 40),
//                                 Text('No banners uploaded yet'),
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//
//                       final banners = snapshot.data!.docs;
//
//                       return CarouselSlider(
//                         options: CarouselOptions(
//                           height: 180,
//                           autoPlay: true,
//                           aspectRatio: 16 / 9,
//                           autoPlayInterval: Duration(seconds: 3),
//                           viewportFraction: 0.9,
//                           enlargeCenterPage: true,
//                         ),
//                         items: banners.map((doc) {
//                           final bannerUrl = doc['bannerUrl'] as String;
//                           return Container(
//                             margin: EdgeInsets.symmetric(horizontal: 8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 4,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.network(
//                                 bannerUrl,
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (context, child, progress) {
//                                   return progress == null
//                                       ? child
//                                       : Center(child: CircularProgressIndicator());
//                                 },
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     color: Colors.grey[200],
//                                     child: Center(
//                                       child: Icon(Icons.broken_image, size: 40),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     },
//                   ),
//
//                   // Display items in a carousel slider for each category
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: categories.length,
//                       itemBuilder: (context, index) {
//                         String category = categories[index];
//                         List<Map<String, dynamic>> items = itemsByCategory[category]!;
//
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     category,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Spacer(), // Pushes "See All" to the right
//                                   // In your HomeTab widget, update the "See All" section to:
//                                   Stack(
//                                     clipBehavior: Clip.none,
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) => CategorySeeAllScreen(
//                                                 category: category,
//                                                 items: items,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         child: Text(
//                                           "See All",
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.indigo,
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         bottom: -1,
//                                         left: 0,
//                                         child: Container(
//                                           height: 2,
//                                           width: 50,
//                                           color: Colors.indigo,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // GridView.builder(
//                             //   padding: const EdgeInsets.all(8),
//                             //   shrinkWrap: true,
//                             //   physics: NeverScrollableScrollPhysics(),
//                             //   itemCount: items.length,
//                             //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             //     crossAxisCount: 2,
//                             //     crossAxisSpacing: 10,
//                             //     mainAxisSpacing: 10,
//                             //     childAspectRatio: 0.68, // Controls height vs width of the cards
//                             //   ),
//                             //   itemBuilder: (context, index) {
//                             //     final item = items[index];
//                             //     final productDetails = item['productDetails'] ?? {};
//                             //
//                             //     return GestureDetector(
//                             //       onTap: () {
//                             //         Navigator.push(
//                             //           context,
//                             //           MaterialPageRoute(
//                             //             builder: (context) => ParticularProductDetailsScreen(productId: item['id']),
//                             //           ),
//                             //         );
//                             //       },
//                             //       child: Card(
//                             //         elevation: 4,
//                             //         shape: RoundedRectangleBorder(
//                             //           borderRadius: BorderRadius.circular(12),
//                             //         ),
//                             //         child: Column(
//                             //           crossAxisAlignment: CrossAxisAlignment.start,
//                             //           children: [
//                             //             // Product Image
//                             //             ClipRRect(
//                             //               borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                             //               child: Container(
//                             //                 height: 135,
//                             //                 width: double.infinity,
//                             //                 child: item['images'] != null && item['images'].isNotEmpty
//                             //                     ? Image.network(
//                             //                   item['images'][0],
//                             //                   fit: BoxFit.cover,
//                             //                 )
//                             //                     : Container(
//                             //                   color: Colors.grey[200],
//                             //                   child: Center(child: Icon(Icons.image_not_supported, size: 30)),
//                             //                 ),
//                             //               ),
//                             //             ),
//                             //             Padding(
//                             //               padding: const EdgeInsets.all(6.0),
//                             //               child: Column(
//                             //                 crossAxisAlignment: CrossAxisAlignment.start,
//                             //                 children: [
//                             //                   Text(
//                             //                     item['name'] ?? 'No Name',
//                             //                     style: TextStyle(
//                             //                       fontWeight: FontWeight.bold,
//                             //                       fontSize: 14,
//                             //                     ),
//                             //                     maxLines: 2, // <-- Allow up to 2 lines
//                             //                     overflow: TextOverflow.ellipsis, // Truncate with ellipsis if still too long
//                             //                   ),
//                             //                   SizedBox(height: 2),
//                             //                   Text(
//                             //                     item['brandName'] ?? 'No Brand',
//                             //                     style: TextStyle(fontSize: 12, color: Colors.grey),
//                             //                     maxLines: 1,
//                             //                     overflow: TextOverflow.ellipsis,
//                             //                   ),
//                             //                   SizedBox(height: 4),
//                             //                   Row(
//                             //                     children: [
//                             //                       if (productDetails['Offer Price'] != null)
//                             //                         Text(
//                             //                           '₹${productDetails['Offer Price']}',
//                             //                           style: TextStyle(
//                             //                             fontWeight: FontWeight.bold,
//                             //                             fontSize: 14,
//                             //                             color: Colors.blue,
//                             //                           ),
//                             //                         ),
//                             //                       SizedBox(width: 4),
//                             //                       if (productDetails['Price'] != null &&
//                             //                           productDetails['Price'] != productDetails['Offer Price'])
//                             //                         Text(
//                             //                           '₹${productDetails['Price']}',
//                             //                           style: TextStyle(
//                             //                             fontSize: 12,
//                             //                             color: Colors.grey,
//                             //                             decoration: TextDecoration.lineThrough,
//                             //                           ),
//                             //                         ),
//                             //                     ],
//                             //                   ),
//                             //                   // Optional Size
//                             //                   // if (productDetails['Size'] != null)
//                             //                   //   Text("Size: ${productDetails['Size']}", style: TextStyle(fontSize: 12, color: Colors.grey)),
//                             //                 ],
//                             //               ),
//                             //             ),
//                             //           ],
//                             //         ),
//                             //       ),
//                             //     );
//                             //   },
//                             // )
//
//                             GridView.builder(
//                               padding: const EdgeInsets.all(8),
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: items.length,
//                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10,
//                                 mainAxisSpacing: 10,
//                                 childAspectRatio: 0.68, // Controls height vs width of the cards
//                               ),
//                               itemBuilder: (context, index) {
//                                 // Sort items by timestamp in descending order
//                                 items.sort((a, b) {
//                                   final timestampA = a['timestamp'] ?? 0; // assuming timestamp is a field in each item
//                                   final timestampB = b['timestamp'] ?? 0;
//                                   return timestampB.compareTo(timestampA); // Descending order
//                                 });
//
//                                 final item = items[index];
//                                 final productDetails = item['productDetails'] ?? {};
//
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ParticularProductDetailsScreen(productId: item['id']),
//                                       ),
//                                     );
//                                   },
//                                   child: Card(
//                                     elevation: 4,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         // Product Image
//                                         ClipRRect(
//                                           borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                                           child: Container(
//                                             height: 135,
//                                             width: double.infinity,
//                                             child: item['images'] != null && item['images'].isNotEmpty
//                                                 ? Image.network(
//                                               item['images'][0],
//                                               fit: BoxFit.cover,
//                                             )
//                                                 : Container(
//                                               color: Colors.grey[200],
//                                               child: Center(child: Icon(Icons.image_not_supported, size: 30)),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(6.0),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 item['name'] ?? 'No Name',
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 14,
//                                                 ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               SizedBox(height: 2),
//                                               Text(
//                                                 item['brandName'] ?? 'No Brand',
//                                                 style: TextStyle(fontSize: 12, color: Colors.grey),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               SizedBox(height: 4),
//                                               Row(
//                                                 children: [
//                                                   if (productDetails['Offer Price'] != null)
//                                                     Text(
//                                                       '₹${productDetails['Offer Price']}',
//                                                       style: TextStyle(
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 14,
//                                                         color: Colors.blue,
//                                                       ),
//                                                     ),
//                                                   SizedBox(width: 4),
//                                                   if (productDetails['Price'] != null &&
//                                                       productDetails['Price'] != productDetails['Offer Price'])
//                                                     Text(
//                                                       '₹${productDetails['Price']}',
//                                                       style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.grey,
//                                                         decoration: TextDecoration.lineThrough,
//                                                       ),
//                                                     ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//
//
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//
//             },
//           );
//         },
//       ),
//     );
//   }
//
//
//
//   // Fetch all items for all sellers
//   Future<List<Map<String, dynamic>>> _fetchAllSellerItems(List<QueryDocumentSnapshot> sellers) async {
//     List<Map<String, dynamic>> allItems = [];
//
//     for (var seller in sellers) {
//       String sellerId = seller.id;
//
//       // Manually fetch subcollections (categories) for the seller
//       var categories = ['Clothing', 'Electronics', 'Footwear', 'Accessories', 'Home Appliances', 'Books', 'Vegetables']; // Add all your categories here
//
//       for (var category in categories) {
//         var snapshot = await FirebaseFirestore.instance
//             .collection('seller')
//             .doc(sellerId)
//             .collection(category)
//             .get();
//
//         for (var doc in snapshot.docs) {
//           allItems.add({
//             ...doc.data(),
//             'sellerId': sellerId,
//             'category': category,
//             'id': doc.id, // Ensure the item ID is included
//           });
//         }
//       }
//     }
//
//     return allItems;
//   }
// }
//
// Future<List<Map<String, dynamic>>> _fetchAllSellerItems(List<QueryDocumentSnapshot> sellers) async {
//   List<Map<String, dynamic>> allItems = [];
//
//   for (var seller in sellers) {
//     String sellerId = seller.id;
//
//     // Fetch main categories
//     var categories = ['Clothing', 'Electronics', 'Footwear', 'Accessories', 'Home Appliances', 'Books', 'Vegetables'];
//     for (var category in categories) {
//       var snapshot = await FirebaseFirestore.instance
//           .collection('seller')
//           .doc(sellerId)
//           .collection(category)
//           .get();
//
//       for (var doc in snapshot.docs) {
//         allItems.add({
//           ...doc.data(),
//           'sellerId': sellerId,
//           'category': category,
//           'id': doc.id,
//         });
//       }
//     }
//
//     // ✅ Fetch offers collection for each seller
//     var offersSnapshot = await FirebaseFirestore.instance
//         .collection('seller')
//         .doc(sellerId)
//         .collection('offers')
//         .get();
//
//     for (var offerDoc in offersSnapshot.docs) {
//       allItems.add({
//         ...offerDoc.data(),
//         'sellerId': sellerId,
//         'category': 'Offers', // mark as offer
//         'id': offerDoc.id,
//       });
//     }
//   }
//
//   return allItems;
// }

// updated code with offers but not scroling goodly with grid view part

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// // Import your other screens here
// import 'category_products_screen.dart';
// import 'customer_category_see_all_screen.dart';
// import 'particular_product_details_screen.dart';
//
// class HomeTab extends StatelessWidget {
//   final Map<String, String> categoryImages = {
//     'Clothing': 'assets/images/clothings_category_customer_hometab.jpeg',
//     'Electronics': 'assets/images/Electronics_category_customer_hometab.jpeg',
//     'Footwear': 'assets/images/footwear_category_customer_hometab.jpeg',
//     'Accessories': 'assets/images/Accessories_category.jpg',
//     'Home Appliances': 'assets/images/home_appliences_category.jpg',
//     'Books': 'assets/images/books_category.jpeg',
//     'Others': 'assets/images/vegetables_category.jpeg',
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No sellers found.'));
//           }
//
//           return FutureBuilder<List<Map<String, dynamic>>>(
//             future: _fetchAllSellerItems(snapshot.data!.docs),
//             builder: (context, itemSnapshot) {
//               if (itemSnapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }
//
//               if (itemSnapshot.hasError) {
//                 return Center(child: Text('Error: ${itemSnapshot.error}'));
//               }
//
//               if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
//                 return Center(child: Text('No items found.'));
//               }
//
//               // Separate offers from regular items
//               List<Map<String, dynamic>> offers = itemSnapshot.data!
//                   .where((item) => item['bannerUrl'] != null)
//                   .toList();
//
//               // Get regular items (non-offers)
//               List<Map<String, dynamic>> regularItems = itemSnapshot.data!
//                   .where((item) => item['bannerUrl'] == null)
//                   .toList();
//
//               // Organize regular items by category
//               Map<String, List<Map<String, dynamic>>> itemsByCategory = {};
//               for (var item in regularItems) {
//                 String category = item['category'];
//                 if (!itemsByCategory.containsKey(category)) {
//                   itemsByCategory[category] = [];
//                 }
//                 itemsByCategory[category]!.add(item);
//               }
//
//               List<String> categories = itemsByCategory.keys.toList();
//
//               return Column(
//                 children: [
//                   // Offers Carousel
//                   if (offers.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                       child: CarouselSlider(
//                         options: CarouselOptions(
//                           height: 150,
//                           autoPlay: true,
//                           enlargeCenterPage: true,
//                           viewportFraction: 0.9,
//                           autoPlayInterval: Duration(seconds: 3),
//                         ),
//                         items: offers.map((offer) {
//                           return Container(
//                             margin: EdgeInsets.symmetric(horizontal: 4.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12.0),
//                               image: DecorationImage(
//                                 image: NetworkImage(offer['bannerUrl']),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//
//                   // Horizontal Categories List
//                   Container(
//                     height: 100,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: categories.length,
//                       itemBuilder: (context, index) {
//                         String category = categories[index];
//                         String imagePath = categoryImages[category] ??
//                             'assets/images/default.png';
//
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CategoryProductsPage(
//                                   category: category,
//                                   allItems: regularItems,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 30,
//                                   backgroundImage: AssetImage(imagePath),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   category,
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//
//                   // Products Grid
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: categories.length,
//                       itemBuilder: (context, index) {
//                         String category = categories[index];
//                         List<Map<String, dynamic>> items =
//                         itemsByCategory[category]!;
//
//                         // Sort items by timestamp (newest first)
//                         items.sort((a, b) {
//                           Timestamp? timestampA = a['timestamp'] as Timestamp?;
//                           Timestamp? timestampB = b['timestamp'] as Timestamp?;
//                           return timestampB?.compareTo(timestampA ?? Timestamp.now()) ?? 0;
//                         });
//
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     category,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Spacer(),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => CategorySeeAllScreen(
//                                             category: category,
//                                             items: items,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Text(
//                                       "See All",
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.indigo,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             GridView.builder(
//                               padding: const EdgeInsets.all(8),
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: items.length > 4 ? 4 : items.length,
//                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10,
//                                 mainAxisSpacing: 10,
//                                 childAspectRatio: 0.68,
//                               ),
//                               itemBuilder: (context, index) {
//                                 final item = items[index];
//                                 final productDetails = item['productDetails'] ?? {};
//
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ParticularProductDetailsScreen(
//                                           productId: item['id'],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Card(
//                                     elevation: 4,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         // Product Image
//                                         ClipRRect(
//                                           borderRadius: BorderRadius.vertical(
//                                               top: Radius.circular(12)),
//                                           child: Container(
//                                             height: 135,
//                                             width: double.infinity,
//                                             child: item['images'] != null &&
//                                                 item['images'].isNotEmpty
//                                                 ? Image.network(
//                                               item['images'][0],
//                                               fit: BoxFit.cover,
//                                             )
//                                                 : Container(
//                                               color: Colors.grey[200],
//                                               child: Center(
//                                                   child: Icon(Icons.image_not_supported)),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(6.0),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 item['name'] ?? 'No Name',
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 14,
//                                                 ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               SizedBox(height: 2),
//                                               Text(
//                                                 item['brandName'] ?? 'No Brand',
//                                                 style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.grey),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               SizedBox(height: 4),
//                                               Row(
//                                                 children: [
//                                                   if (productDetails['Offer Price'] != null)
//                                                     Text(
//                                                       '₹${productDetails['Offer Price']}',
//                                                       style: TextStyle(
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 14,
//                                                         color: Colors.blue,
//                                                       ),
//                                                     ),
//                                                   SizedBox(width: 4),
//                                                   if (productDetails['Price'] != null &&
//                                                       productDetails['Price'] !=
//                                                           productDetails['Offer Price'])
//                                                     Text(
//                                                       '₹${productDetails['Price']}',
//                                                       style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.grey,
//                                                         decoration: TextDecoration.lineThrough,
//                                                       ),
//                                                     ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> _fetchAllSellerItems(
//       List<QueryDocumentSnapshot> sellers) async {
//     List<Map<String, dynamic>> allItems = [];
//
//     for (var seller in sellers) {
//       String sellerId = seller.id;
//
//       // Fetch regular products
//       var categories = [
//         'Clothing', 'Electronics', 'Footwear', 'Accessories',
//         'Home Appliances', 'Books', 'Vegetables'
//       ];
//
//       for (var category in categories) {
//         try {
//           var snapshot = await FirebaseFirestore.instance
//               .collection('seller')
//               .doc(sellerId)
//               .collection(category)
//               .get();
//
//           for (var doc in snapshot.docs) {
//             allItems.add({
//               ...doc.data() as Map<String, dynamic>,
//               'sellerId': sellerId,
//               'category': category,
//               'id': doc.id,
//             });
//           }
//         } catch (e) {
//           print('Error fetching $category for seller $sellerId: $e');
//         }
//       }
//
//       // Fetch offers
//       try {
//         var offersSnapshot = await FirebaseFirestore.instance
//             .collection('seller')
//             .doc(sellerId)
//             .collection('offers')
//             .orderBy('uploadedAt', descending: true)
//             .get();
//
//         for (var offerDoc in offersSnapshot.docs) {
//           allItems.add({
//             ...offerDoc.data() as Map<String, dynamic>,
//             'sellerId': sellerId,
//             'id': offerDoc.id,
//           });
//         }
//       } catch (e) {
//         print('Error fetching offers for seller $sellerId: $e');
//       }
//     }
//
//     return allItems;
//   }
// }

// Fixing the issue to scroll from top to bottom

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/app_localization.dart';
import 'package:sadhana_cart/Customer/branded_products_list.dart';
import 'package:sadhana_cart/Customer/see_all_brands_screen.dart';

// Import your other screens here
import 'category_products_screen.dart';
import 'customer_category_see_all_screen.dart';
import 'particular_product_details_screen.dart';

class HomeTab extends StatelessWidget {
  final Map<String, String> categoryImages = {
    'Clothing': 'assets/images/clothings_category_customer_hometab.jpeg',
    'Electronics': 'assets/images/Electronics_category_customer_hometab.jpeg',
    'Footwear': 'assets/images/footwear_category_customer_hometab.jpeg',
    'Accessories': 'assets/images/Accessories_category.jpg',
    'Home Appliances': 'assets/images/home_appliences_category.jpg',
    'Books': 'assets/images/books_category.jpeg',
    'Others': 'assets/images/vegetables_category.jpeg',
  };

  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('seller').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No sellers found.'));
          }

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchAllSellerItems(snapshot.data!.docs),
            builder: (context, itemSnapshot) {
              if (itemSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (itemSnapshot.hasError) {
                return Center(child: Text('Error: ${itemSnapshot.error}'));
              }

              if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
                return const Center(child: Text('No items found.'));
              }

              // Separate offers from regular items
              List<Map<String, dynamic>> offers = itemSnapshot.data!
                  .where((item) => item['bannerUrl'] != null)
                  .toList();

              // Get regular items (non-offers)
              List<Map<String, dynamic>> regularItems = itemSnapshot.data!
                  .where((item) => item['bannerUrl'] == null)
                  .toList();

              // Organize regular items by category
              Map<String, List<Map<String, dynamic>>> itemsByCategory = {};
              for (var item in regularItems) {
                String category = item['category'];
                if (!itemsByCategory.containsKey(category)) {
                  itemsByCategory[category] = [];
                }
                itemsByCategory[category]!.add(item);
              }

              List<String> categories = itemsByCategory.keys.toList();

              // Get unique brand names
              Set<String> brandNamesSet = regularItems
                  .where((item) =>
                      item['brandName'] != null && item['brandName'].isNotEmpty)
                  .map((item) => item['brandName'] as String)
                  .toSet();
              List<String> brandNames = brandNamesSet.toList();

              // Define a list of unique colors for brands
              final List<Color> brandColors = [
                Colors.blue[300]!,
                Colors.red[300]!,
                Colors.green[300]!,
                Colors.purple[300]!,
                Colors.orange[300]!,
                Colors.teal[300]!,
                Colors.pink[300]!,
                Colors.cyan[300]!,
                Colors.amber[300]!,
                Colors.lime[300]!,
                // Add more colors if you expect more brands
              ];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Horizontal Categories List
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics:
                            const ClampingScrollPhysics(), // Enable scrolling with smooth behavior
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          String category = categories[index];
                          String imagePath = categoryImages[category] ??
                              'assets/images/default.png';

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryProductsPage(
                                    category: category,
                                    allItems: regularItems,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(imagePath),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    category,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // // Offers Carousel
                    // if (offers.isNotEmpty)
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    //     child: CarouselSlider(
                    //       options: CarouselOptions(
                    //         height: 150,
                    //         autoPlay: true,
                    //         enlargeCenterPage: true,
                    //         viewportFraction: 0.9,
                    //         autoPlayInterval: Duration(seconds: 3),
                    //       ),
                    //       items: offers.map((offer) {
                    //         return Container(
                    //           margin: EdgeInsets.symmetric(horizontal: 4.0),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(12.0),
                    //             image: DecorationImage(
                    //               image: NetworkImage(offer['bannerUrl']),
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         );
                    //       }).toList(),
                    //     ),
                    //   ),

                    // offers

                    if (offers.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        child: _buildOffersCarousel(context, offers),
                      ),

                    // Horizontal Brand Names List
                    if (brandNames.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row for "Brands" and "See All"
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Brands',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AllBrandsPage(
                                            brandNames: brandNames,
                                            allItems: regularItems,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'See All',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.indigo,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Brand Names List
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics:
                                    const ClampingScrollPhysics(), // Enable scrolling with smooth behavior
                                shrinkWrap: true,
                                itemCount: brandNames.length,
                                itemBuilder: (context, index) {
                                  String brandName = brandNames[index];
                                  // Select color based on index, cycling through brandColors
                                  Color brandColor =
                                      brandColors[index % brandColors.length];

                                  return GestureDetector(
                                    onTap: () {
                                      // Navigate to a brand-specific products page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BrandProductsPage(
                                            brandName: brandName,
                                            allItems: regularItems,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                brandColor, // Use unique brand color
                                            child: Text(
                                              brandName[0].toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .white, // White for better contrast
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            brandName,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Products Grid
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        String category = categories[index];
                        List<Map<String, dynamic>> items =
                            itemsByCategory[category]!;

                        // Sort items by timestamp (newest first)
                        items.sort((a, b) {
                          Timestamp? timestampA = a['timestamp'] as Timestamp?;
                          Timestamp? timestampB = b['timestamp'] as Timestamp?;
                          return timestampB
                                  ?.compareTo(timestampA ?? Timestamp.now()) ??
                              0;
                        });

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CategorySeeAllScreen(
                                            category: category,
                                            items: items,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "See All",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.all(8),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length > 4 ? 4 : items.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.68,
                              ),
                              itemBuilder: (context, index) {
                                final item = items[index];
                                final productDetails =
                                    item['productDetails'] ?? {};

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ParticularProductDetailsScreen(
                                          productId: item['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Product Image
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(12)),
                                          child: SizedBox(
                                            height: 135,
                                            width: double.infinity,
                                            child: item['images'] != null &&
                                                    item['images'].isNotEmpty
                                                ? Image.network(
                                                    item['images'][0],
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(
                                                    color: Colors.grey[200],
                                                    child: const Center(
                                                        child: Icon(Icons
                                                            .image_not_supported)),
                                                  ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['name'] ?? 'No Name',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                item['brandName'] ?? 'No Brand',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  if (productDetails[
                                                          'Offer Price'] !=
                                                      null)
                                                    Text(
                                                      '₹${productDetails['Offer Price']}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  const SizedBox(width: 4),
                                                  if (productDetails['Price'] !=
                                                          null &&
                                                      productDetails['Price'] !=
                                                          productDetails[
                                                              'Offer Price'])
                                                    Text(
                                                      '₹${productDetails['Price']}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchAllSellerItems(
      List<QueryDocumentSnapshot> sellers) async {
    List<Map<String, dynamic>> allItems = [];

    for (var seller in sellers) {
      String sellerId = seller.id;

      // Fetch regular products
      var categories = [
        'Clothing',
        'Electronics',
        'Footwear',
        'Accessories',
        'Home Appliances',
        'Books',
        'Vegetables'
      ];

      for (var category in categories) {
        try {
          var snapshot = await FirebaseFirestore.instance
              .collection('seller')
              .doc(sellerId)
              .collection(category)
              .get();

          for (var doc in snapshot.docs) {
            allItems.add({
              ...doc.data(),
              'sellerId': sellerId,
              'category': category,
              'id': doc.id,
            });
          }
        } catch (e) {
          print('Error fetching $category for seller $sellerId: $e');
        }
      }

      // Fetch offers
      try {
        var offersSnapshot = await FirebaseFirestore.instance
            .collection('seller')
            .doc(sellerId)
            .collection('offers')
            .orderBy('uploadedAt', descending: true)
            .get();

        for (var offerDoc in offersSnapshot.docs) {
          allItems.add({
            ...offerDoc.data(),
            'sellerId': sellerId,
            'id': offerDoc.id,
          });
        }
      } catch (e) {
        print('Error fetching offers for seller $sellerId: $e');
      }
    }

    return allItems;
  }
}

Widget _buildOffersCarousel(
    BuildContext context, List<Map<String, dynamic>> offers) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider.builder(
        itemCount: offers.length,
        options: CarouselOptions(
          height: 180,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.95, // Increased for wider images
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          aspectRatio: 16 / 9, // Consistent aspect ratio
        ),
        itemBuilder: (context, index, realIndex) {
          final offer = offers[index];
          return _buildCarouselItem(context, offer, index);
        },
      ),
    ],
  );
}

Widget _buildCarouselItem(
    BuildContext context, Map<String, dynamic> offer, int index) {
  return GestureDetector(
    onTap: () {
      // Navigate to product details or offer-specific page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParticularProductDetailsScreen(
            productId: offer['id'],
          ),
        ),
      );
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(
          horizontal: 4.0, vertical: 10.0), // Reduced horizontal margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Container(
              width: double.infinity, // Ensure full width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: NetworkImage(
                    offer['bannerUrl'] ?? 'https://via.placeholder.com/300',
                  ),
                  fit: BoxFit.cover, // Fill the container
                  alignment: Alignment.center,
                ),
              ),
              child: offer['bannerUrl'] == null
                  ? Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
