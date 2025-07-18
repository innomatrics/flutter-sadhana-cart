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

// Fixing the issue to scroll from top to bottom IT IS GOOD

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/app_localization.dart';
// import 'package:sadhana_cart/Customer/branded_products_list.dart';
// import 'package:sadhana_cart/Customer/see_all_brands_screen.dart';
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
//   HomeTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context);
//
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No sellers found.'));
//           }
//
//           return FutureBuilder<List<Map<String, dynamic>>>(
//             future: _fetchAllSellerItems(snapshot.data!.docs),
//             builder: (context, itemSnapshot) {
//               if (itemSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (itemSnapshot.hasError) {
//                 return Center(child: Text('Error: ${itemSnapshot.error}'));
//               }
//
//               if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
//                 return const Center(child: Text('No items found.'));
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
//               // Get unique brand names
//               Set<String> brandNamesSet = regularItems
//                   .where((item) =>
//                       item['brandName'] != null && item['brandName'].isNotEmpty)
//                   .map((item) => item['brandName'] as String)
//                   .toSet();
//               List<String> brandNames = brandNamesSet.toList();
//
//               // Define a list of unique colors for brands
//               final List<Color> brandColors = [
//                 Colors.blue[300]!,
//                 Colors.red[300]!,
//                 Colors.green[300]!,
//                 Colors.purple[300]!,
//                 Colors.orange[300]!,
//                 Colors.teal[300]!,
//                 Colors.pink[300]!,
//                 Colors.cyan[300]!,
//                 Colors.amber[300]!,
//                 Colors.lime[300]!,
//                 // Add more colors if you expect more brands
//               ];
//
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // Horizontal Categories List
//                     SizedBox(
//                       height: 100,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         physics:
//                             const ClampingScrollPhysics(), // Enable scrolling with smooth behavior
//                         shrinkWrap: true,
//                         itemCount: categories.length,
//                         itemBuilder: (context, index) {
//                           String category = categories[index];
//                           String imagePath = categoryImages[category] ??
//                               'assets/images/default.png';
//
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CategoryProductsPage(
//                                     category: category,
//                                     allItems: regularItems,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 30,
//                                     backgroundImage: AssetImage(imagePath),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     category,
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//
//                     // // Offers Carousel
//                     // if (offers.isNotEmpty)
//                     //   Padding(
//                     //     padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                     //     child: CarouselSlider(
//                     //       options: CarouselOptions(
//                     //         height: 150,
//                     //         autoPlay: true,
//                     //         enlargeCenterPage: true,
//                     //         viewportFraction: 0.9,
//                     //         autoPlayInterval: Duration(seconds: 3),
//                     //       ),
//                     //       items: offers.map((offer) {
//                     //         return Container(
//                     //           margin: EdgeInsets.symmetric(horizontal: 4.0),
//                     //           decoration: BoxDecoration(
//                     //             borderRadius: BorderRadius.circular(12.0),
//                     //             image: DecorationImage(
//                     //               image: NetworkImage(offer['bannerUrl']),
//                     //               fit: BoxFit.cover,
//                     //             ),
//                     //           ),
//                     //         );
//                     //       }).toList(),
//                     //     ),
//                     //   ),
//
//                     // offers
//
//                     // if (offers.isNotEmpty)
//                     //   Padding(
//                     //     padding: const EdgeInsets.symmetric(
//                     //         vertical: 12.0, horizontal: 8.0),
//                     //     child: _buildOffersCarousel(context, offers),
//                     //   ),
//
//                     // StreamBuilder<QuerySnapshot>(
//                     //   stream: FirebaseFirestore.instance
//                     //       .collection('admin')
//                     //       .doc('admin_document')
//                     //       .collection('banners')
//                     //       .where('isActive', isEqualTo: true)
//                     //       .snapshots(), // Removed orderBy to avoid index requirement
//                     //   builder: (context, bannerSnapshot) {
//                     //     if (bannerSnapshot.connectionState == ConnectionState.waiting) {
//                     //       return const SizedBox(
//                     //           height: 180,
//                     //           child: Center(child: CircularProgressIndicator()));
//                     //     }
//                     //
//                     //     if (bannerSnapshot.hasError) {
//                     //       return SizedBox(
//                     //           height: 180,
//                     //           child: Center(
//                     //               child: Text('Error loading banners: ${bannerSnapshot.error}')));
//                     //     }
//                     //
//                     //     if (!bannerSnapshot.hasData || bannerSnapshot.data!.docs.isEmpty) {
//                     //       return const SizedBox();
//                     //     }
//                     //
//                     //     // Sort locally if needed
//                     //     final banners = bannerSnapshot.data!.docs;
//                     //     banners.sort((a, b) {
//                     //       final aDate = a['createdAt'] as Timestamp? ?? Timestamp.now();
//                     //       final bDate = b['createdAt'] as Timestamp? ?? Timestamp.now();
//                     //       return bDate.compareTo(aDate);
//                     //     });
//                     //
//                     //     return Padding(
//                     //       padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
//                     //       child: _buildBannersCarousel(context, banners),
//                     //     );
//                     //   },
//                     // ),  working
//
//
//                     // In your HomeTab widget's build method, replace the banner section with:
//                     StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('admin')
//                           .doc('admin_document')
//                           .collection('banners')
//                           .where('isActive', isEqualTo: true)
//                           .snapshots(),
//                       builder: (context, bannerSnapshot) {
//                         if (bannerSnapshot.connectionState == ConnectionState.waiting) {
//                           return const SizedBox(
//                               height: 180,
//                               child: Center(child: CircularProgressIndicator()));
//                         }
//
//                         if (bannerSnapshot.hasError) {
//                           return SizedBox(
//                               height: 180,
//                               child: Center(
//                                   child: Text('Error loading banners: ${bannerSnapshot.error}')));
//                         }
//
//                         if (!bannerSnapshot.hasData || bannerSnapshot.data!.docs.isEmpty) {
//                           return const SizedBox();
//                         }
//
//                         return Column(
//                           children: [
//                             const Divider(
//                               thickness: 1,
//                               height: 20,
//                               color: Colors.black12,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
//                               child: _buildBannersCarousel(context, bannerSnapshot.data!.docs),
//                             ),
//                             const Divider(
//                               thickness: 1,
//                               height: 20,
//                               color: Colors.black12,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//
//
//                     // Horizontal Brand Names List
//                     if (brandNames.isNotEmpty)
//                       Container(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Header Row for "Brands" and "See All"
//                             Padding(
//                               padding: const EdgeInsets.all(8),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     'Brands',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => AllBrandsPage(
//                                             brandNames: brandNames,
//                                             allItems: regularItems,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: const Text(
//                                       'See All',
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.indigo,
//                                         decoration: TextDecoration.underline,
//                                         decorationColor: Colors.indigo,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Brand Names List
//                             SizedBox(
//                               height: 100,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 physics:
//                                     const ClampingScrollPhysics(), // Enable scrolling with smooth behavior
//                                 shrinkWrap: true,
//                                 itemCount: brandNames.length,
//                                 itemBuilder: (context, index) {
//                                   String brandName = brandNames[index];
//                                   // Select color based on index, cycling through brandColors
//                                   Color brandColor =
//                                       brandColors[index % brandColors.length];
//
//                                   return GestureDetector(
//                                     onTap: () {
//                                       // Navigate to a brand-specific products page
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               BrandProductsPage(
//                                             brandName: brandName,
//                                             allItems: regularItems,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 30,
//                                             backgroundColor:
//                                                 brandColor, // Use unique brand color
//                                             child: Text(
//                                               brandName[0].toUpperCase(),
//                                               style: const TextStyle(
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors
//                                                     .white, // White for better contrast
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(height: 8),
//                                           Text(
//                                             brandName,
//                                             style: const TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     // Products Grid
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: categories.length,
//                       itemBuilder: (context, index) {
//                         String category = categories[index];
//                         List<Map<String, dynamic>> items =
//                             itemsByCategory[category]!;
//
//                         // Sort items by timestamp (newest first)
//                         items.sort((a, b) {
//                           Timestamp? timestampA = a['timestamp'] as Timestamp?;
//                           Timestamp? timestampB = b['timestamp'] as Timestamp?;
//                           return timestampB
//                                   ?.compareTo(timestampA ?? Timestamp.now()) ??
//                               0;
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
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const Spacer(),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               CategorySeeAllScreen(
//                                             category: category,
//                                             items: items,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: const Text(
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
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: items.length > 4 ? 4 : items.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10,
//                                 mainAxisSpacing: 10,
//                                 childAspectRatio: 0.68,
//                               ),
//                               itemBuilder: (context, index) {
//                                 final item = items[index];
//                                 final productDetails =
//                                     item['productDetails'] ?? {};
//
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             ParticularProductDetailsScreen(
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
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // Product Image
//                                         ClipRRect(
//                                           borderRadius:
//                                               const BorderRadius.vertical(
//                                                   top: Radius.circular(12)),
//                                           child: SizedBox(
//                                             height: 135,
//                                             width: double.infinity,
//                                             child: item['images'] != null &&
//                                                     item['images'].isNotEmpty
//                                                 ? Image.network(
//                                                     item['images'][0],
//                                                     fit: BoxFit.cover,
//                                                   )
//                                                 : Container(
//                                                     color: Colors.grey[200],
//                                                     child: const Center(
//                                                         child: Icon(Icons
//                                                             .image_not_supported)),
//                                                   ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(6.0),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 item['name'] ?? 'No Name',
//                                                 style: const TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 14,
//                                                 ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               const SizedBox(height: 2),
//                                               Text(
//                                                 item['brandName'] ?? 'No Brand',
//                                                 style: const TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.grey),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               const SizedBox(height: 4),
//                                               Row(
//                                                 children: [
//                                                   if (productDetails[
//                                                           'Offer Price'] !=
//                                                       null)
//                                                     Text(
//                                                       '₹${productDetails['Offer Price']}',
//                                                       style: const TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 14,
//                                                         color: Colors.blue,
//                                                       ),
//                                                     ),
//                                                   const SizedBox(width: 4),
//                                                   if (productDetails['Price'] !=
//                                                           null &&
//                                                       productDetails['Price'] !=
//                                                           productDetails[
//                                                               'Offer Price'])
//                                                     Text(
//                                                       '₹${productDetails['Price']}',
//                                                       style: const TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.grey,
//                                                         decoration:
//                                                             TextDecoration
//                                                                 .lineThrough,
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
//                   ],
//                 ),
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
//         'Clothing',
//         'Electronics',
//         'Footwear',
//         'Accessories',
//         'Home Appliances',
//         'Books',
//         'Vegetables'
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
//               ...doc.data(),
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
//             ...offerDoc.data(),
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
//
// // Widget _buildOffersCarousel(
// //     BuildContext context, List<Map<String, dynamic>> offers) {
// //   return Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       CarouselSlider.builder(
// //         itemCount: offers.length,
// //         options: CarouselOptions(
// //           height: 180,
// //           autoPlay: true,
// //           enlargeCenterPage: true,
// //           viewportFraction: 0.95, // Increased for wider images
// //           autoPlayInterval: const Duration(seconds: 4),
// //           autoPlayAnimationDuration: const Duration(milliseconds: 800),
// //           enlargeStrategy: CenterPageEnlargeStrategy.scale,
// //           aspectRatio: 16 / 9, // Consistent aspect ratio
// //         ),
// //         itemBuilder: (context, index, realIndex) {
// //           final offer = offers[index];
// //           return _buildCarouselItem(context, offer, index);
// //         },
// //       ),
// //     ],
// //   );
// // }
// //
// // Widget _buildCarouselItem(
// //     BuildContext context, Map<String, dynamic> offer, int index) {
// //   return GestureDetector(
// //     onTap: () {
// //       // Navigate to product details or offer-specific page
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => ParticularProductDetailsScreen(
// //             productId: offer['id'],
// //           ),
// //         ),
// //       );
// //     },
// //     child: AnimatedContainer(
// //       duration: const Duration(milliseconds: 300),
// //       margin: const EdgeInsets.symmetric(
// //           horizontal: 4.0, vertical: 10.0), // Reduced horizontal margin
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(16.0),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1),
// //             blurRadius: 10,
// //             spreadRadius: 2,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(16.0),
// //         child: Stack(
// //           fit: StackFit.expand,
// //           children: [
// //             // Background Image
// //             Container(
// //               width: double.infinity, // Ensure full width
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(16.0),
// //                 image: DecorationImage(
// //                   image: NetworkImage(
// //                     offer['bannerUrl'] ?? 'https://via.placeholder.com/300',
// //                   ),
// //                   fit: BoxFit.cover, // Fill the container
// //                   alignment: Alignment.center,
// //                 ),
// //               ),
// //               child: offer['bannerUrl'] == null
// //                   ? Container(
// //                       color: Colors.grey[200],
// //                       child: const Icon(
// //                         Icons.broken_image,
// //                         size: 50,
// //                         color: Colors.grey,
// //                       ),
// //                     )
// //                   : null,
// //             ),
// //             // Gradient Overlay
// //             Container(
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(16.0),
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                   colors: [
// //                     Colors.black.withOpacity(0.1),
// //                     Colors.black.withOpacity(0.5),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ),
// //   );
//
// Widget _buildBannersCarousel(
//     BuildContext context, List<DocumentSnapshot> banners) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       CarouselSlider.builder(
//         itemCount: banners.length,
//         options: CarouselOptions(
//           height: 180,
//           autoPlay: true,
//           enlargeCenterPage: true,
//           viewportFraction: 0.95,
//           autoPlayInterval: const Duration(seconds: 4),
//           autoPlayAnimationDuration: const Duration(milliseconds: 800),
//           enlargeStrategy: CenterPageEnlargeStrategy.scale,
//           aspectRatio: 16 / 9,
//         ),
//         itemBuilder: (context, index, realIndex) {
//           final banner = banners[index];
//           return _buildBannerItem(context, banner, index);
//         },
//       ),
//     ],
//   );
// }
//
// Widget _buildBannerItem(
//     BuildContext context, DocumentSnapshot banner, int index) {
//   final imageUrl = banner['imageUrl'] as String?;
//   final percentage = banner['percentage'] as int?;
//   final category = banner['category'] as String?; // Assuming banners have a category field
//
//
//   return GestureDetector(
//     onTap: () {
//       if (category != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BannerProductsPage(
//               category: category,
//               discountPercentage: percentage ?? 0,
//             ),
//           ),
//         );
//       }
//     },
//     child: AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             spreadRadius: 2,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16.0),
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             // Background Image
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16.0),
//                 image: imageUrl != null
//                     ? DecorationImage(
//                   image: NetworkImage(imageUrl),
//                   fit: BoxFit.cover,
//                   alignment: Alignment.center,
//                 )
//                     : null,
//               ),
//               child: imageUrl == null
//                   ? Container(
//                 color: Colors.grey[200],
//                 child: const Icon(
//                   Icons.broken_image,
//                   size: 50,
//                   color: Colors.grey,
//                 ),
//               )
//                   : null,
//             ),
//             // Gradient Overlay
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16.0),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.1),
//                     Colors.black.withOpacity(0.5),
//                   ],
//                 ),
//               ),
//             ),
//             // Percentage Badge
//             if (percentage != null)
//               Positioned(
//                 top: 16,
//                 right: 16,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.redAccent,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     '$percentage% OFF',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
//
// class BannerProductsPage extends StatelessWidget {
//   final String category;
//   final int discountPercentage;
//
//   const BannerProductsPage({
//     required this.category,
//     required this.discountPercentage,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$category - $discountPercentage% OFF'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No sellers found.'));
//           }
//
//           return FutureBuilder<List<Map<String, dynamic>>>(
//             future: _fetchDiscountedProducts(
//               snapshot.data!.docs,
//               category,
//               discountPercentage,
//             ),
//             builder: (context, itemSnapshot) {
//               if (itemSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (itemSnapshot.hasError) {
//                 return Center(child: Text('Error: ${itemSnapshot.error}'));
//               }
//
//               if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text('No discounted products found in $category'),
//                 );
//               }
//
//               return GridView.builder(
//                 padding: const EdgeInsets.all(8),
//                 itemCount: itemSnapshot.data!.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 0.68,
//                 ),
//                 itemBuilder: (context, index) {
//                   final item = itemSnapshot.data![index];
//                   final productDetails = item['productDetails'] ?? {};
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ParticularProductDetailsScreen(
//                             productId: item['id'],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Product Image
//                           ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                                 top: Radius.circular(12)),
//                             child: SizedBox(
//                               height: 135,
//                               width: double.infinity,
//                               child: item['images'] != null &&
//                                   item['images'].isNotEmpty
//                                   ? Image.network(
//                                 item['images'][0],
//                                 fit: BoxFit.cover,
//                               )
//                                   : Container(
//                                 color: Colors.grey[200],
//                                 child: const Center(
//                                     child: Icon(Icons.image_not_supported)),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item['name'] ?? 'No Name',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   item['brandName'] ?? 'No Brand',
//                                   style: const TextStyle(
//                                       fontSize: 12, color: Colors.grey),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     if (productDetails['Offer Price'] != null)
//                                       Text(
//                                         '₹${productDetails['Offer Price']}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                           color: Colors.blue,
//                                         ),
//                                       ),
//                                     const SizedBox(width: 4),
//                                     if (productDetails['Price'] != null &&
//                                         productDetails['Price'] !=
//                                             productDetails['Offer Price'])
//                                       Text(
//                                         '₹${productDetails['Price']}',
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey,
//                                           decoration:
//                                           TextDecoration.lineThrough,
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                                 // Display discount percentage
//                                 if (productDetails['Price'] != null &&
//                                     productDetails['Offer Price'] != null)
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 4),
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 6, vertical: 2),
//                                     decoration: BoxDecoration(
//                                       color: Colors.redAccent,
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                     child: Text(
//                                       '${_calculateDiscountPercentage(
//                                         double.parse(
//                                             productDetails['Price'].toString()),
//                                         double.parse(productDetails['Offer Price']
//                                             .toString()),
//                                       )}% OFF',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 10,
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> _fetchDiscountedProducts(
//       List<QueryDocumentSnapshot> sellers,
//       String category,
//       int discountPercentage,
//       ) async {
//     List<Map<String, dynamic>> discountedItems = [];
//
//     for (var seller in sellers) {
//       String sellerId = seller.id;
//
//       try {
//         var snapshot = await FirebaseFirestore.instance
//             .collection('seller')
//             .doc(sellerId)
//             .collection(category)
//             .get();
//
//         for (var doc in snapshot.docs) {
//           final data = doc.data();
//           if (data['productDetails'] != null) {
//             final productDetails = data['productDetails'] as Map<String, dynamic>;
//             if (productDetails['Price'] != null &&
//                 productDetails['Offer Price'] != null) {
//               final price = double.parse(productDetails['Price'].toString());
//               final offerPrice =
//               double.parse(productDetails['Offer Price'].toString());
//               final calculatedDiscount = _calculateDiscountPercentage(price, offerPrice);
//
//               // Only include products with discount >= banner's discount percentage
//               if (calculatedDiscount >= discountPercentage) {
//                 discountedItems.add({
//                   ...data,
//                   'sellerId': sellerId,
//                   'category': category,
//                   'id': doc.id,
//                 });
//               }
//             }
//           }
//         }
//       } catch (e) {
//         print('Error fetching $category for seller $sellerId: $e');
//       }
//     }
//
//     return discountedItems;
//   }
//
//   int _calculateDiscountPercentage(double originalPrice, double offerPrice) {
//     if (originalPrice <= 0) return 0;
//     return ((originalPrice - offerPrice) / originalPrice * 100).round();
//   }
// }




// -------------------------------------------------------------------------------------------------------------------------------
//web
// --------------------------------------------------------------------------------------------------------------------------------


// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/app_localization.dart';
// import 'package:sadhana_cart/Customer/branded_products_list.dart';
// import 'package:sadhana_cart/Customer/see_all_brands_screen.dart';
// import 'package:sadhana_cart/Web/Customer/see_all_brands_screen.dart';
//
// // Import your other screens here
// import 'animated_footer.dart';
// import 'category_products_screen.dart';
// import 'category_tabb.dart';
// import 'customer_bottom_navigationber_layout.dart';
// import 'customer_cart_screen.dart';
// import 'customer_category_see_all_screen.dart';
// import 'customer_profile_screen.dart';
// import 'particular_product_details_screen.dart';
//
// class WebHomeTab extends StatelessWidget {
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
//   WebHomeTab({super.key});
//
//   get category => null;
//
//   get items => null;
//
//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isLargeScreen = screenWidth > 800;
//
//     return Scaffold(
//
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
//         builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//     return const Center(child: CircularProgressIndicator());
//     }
//
//     if (snapshot.hasError) {
//     return Center(child: Text('Error: ${snapshot.error}'));
//     }
//
//     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//     return const Center(child: Text('No sellers found.'));
//     }
//
//     return FutureBuilder<List<Map<String, dynamic>>>(
//     future: _fetchAllSellerItems(snapshot.data!.docs),
//     builder: (context, itemSnapshot) {
//     if (itemSnapshot.connectionState == ConnectionState.waiting) {
//     return const Center(child: CircularProgressIndicator());
//     }
//
//     if (itemSnapshot.hasError) {
//     return Center(child: Text('Error: ${itemSnapshot.error}'));
//     }
//
//     if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
//     return const Center(child: Text('No items found.'));
//     }
//
//     // Separate offers from regular items
//     List<Map<String, dynamic>> offers = itemSnapshot.data!
//         .where((item) => item['bannerUrl'] != null)
//         .toList();
//
//     // Get regular items (non-offers)
//     List<Map<String, dynamic>> regularItems = itemSnapshot.data!
//         .where((item) => item['bannerUrl'] == null)
//         .toList();
//
//     // Organize regular items by category
//     Map<String, List<Map<String, dynamic>>> itemsByCategory = {};
//     for (var item in regularItems) {
//     String category = item['category'];
//     if (!itemsByCategory.containsKey(category)) {
//     itemsByCategory[category] = [];
//     }
//     itemsByCategory[category]!.add(item);
//     }
//
//     List<String> categories = itemsByCategory.keys.toList();
//
//     // Get unique brand names
//     Set<String> brandNamesSet = regularItems
//         .where((item) =>
//     item['brandName'] != null && item['brandName'].isNotEmpty)
//         .map((item) => item['brandName'] as String)
//         .toSet();
//     List<String> brandNames = brandNamesSet.toList();
//
//     // Define a list of unique colors for brands
//     final List<Color> brandColors = [
//     Colors.blue[300]!,
//     Colors.red[300]!,
//     Colors.green[300]!,
//     Colors.purple[300]!,
//     Colors.orange[300]!,
//     Colors.teal[300]!,
//     Colors.pink[300]!,
//     Colors.cyan[300]!,
//     Colors.amber[300]!,
//     Colors.lime[300]!,
//     ];
//
//     return SingleChildScrollView(
//     child: Column(
//     children: [
//     // Search Bar (Web-style at the top)
//
//     // if (isLargeScreen) buildWebStyleAppBar(context),
//
//     // Horizontal Categories List - Web optimized
//     //   Container(
//     //     padding: const EdgeInsets.symmetric(vertical: 12),
//     //     color: Colors.white,
//     //     child: SizedBox(
//     //       height: 200,
//     //       child: ListView.builder(
//     //         scrollDirection: Axis.horizontal,
//     //         physics: const ClampingScrollPhysics(),
//     //         shrinkWrap: true,
//     //         itemCount: categories.length,
//     //         itemBuilder: (context, index) {
//     //           String category = categories[index];
//     //           String imagePath = categoryImages[category] ??
//     //               'assets/images/default.png';
//     //
//     //           return GestureDetector(
//     //             onTap: () {
//     //               Navigator.push(
//     //                 context,
//     //                 MaterialPageRoute(
//     //                   builder: (context) => CategoryProductsPage(
//     //                     category: category,
//     //                     allItems: regularItems,
//     //                   ),
//     //                 ),
//     //               );
//     //             },
//     //             child: Container(
//     //               width: 100,
//     //               margin: const EdgeInsets.symmetric(horizontal: 8),
//     //               child: Column(
//     //                 mainAxisAlignment: MainAxisAlignment.center,
//     //                 children: [
//     //                   Container(
//     //                     width: 64,
//     //                     height: 64,
//     //                     decoration: BoxDecoration(
//     //                       shape: BoxShape.circle,
//     //                       color: Colors.white,
//     //                       boxShadow: [
//     //                         BoxShadow(
//     //                             color: Colors.grey.withOpacity(0.3),
//     //                             blurRadius: 5,
//     //                             spreadRadius: 1)
//     //                       ],
//     //                     ),
//     //                     child: ClipOval(
//     //                       child: Image.asset(
//     //                         imagePath,
//     //                         fit: BoxFit.cover,
//     //                       ),
//     //                     ),
//     //                   ),
//     //                   const SizedBox(height: 8),
//     //                   Text(
//     //                     category,
//     //                     style: const TextStyle(
//     //                       fontSize: 14,
//     //                       fontWeight: FontWeight.bold,
//     //                       color: Colors.black87,
//     //                     ),
//     //                     textAlign: TextAlign.center,
//     //                     maxLines: 2,
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //           );
//     //         },
//     //       ),
//     //     ),
//     //   ),
//
//       Container(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         color: Colors.white,
//         child: SizedBox(
//           height: 150,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             physics: const ClampingScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: categories.length,
//             itemBuilder: (context, index) {
//               String category = categories[index];
//               String imagePath = categoryImages[category] ?? 'assets/images/default.png';
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => WebCategoryProductsPage(
//                         category: category,
//                         allItems: regularItems,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 100,
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // 🔼 Increased image size here
//                       Container(
//                         width: 100, // Increased from 64
//                         height: 100, // Increased from 64
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.3),
//                               blurRadius: 5,
//                               spreadRadius: 1,
//                             )
//                           ],
//                         ),
//                         child: ClipOval(
//                           child: Image.asset(
//                             imagePath,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10), // Optional: adjust spacing
//                       // 🔼 Increased text font size here
//                       Text(
//                         category,
//                         style: const TextStyle(
//                           fontSize: 16, // Increased from 14
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//
//
//
//       // Banner Carousel - Web optimized
//       StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('admin')
//             .doc('admin_document')
//             .collection('banners')
//             .where('isActive', isEqualTo: true)
//             .snapshots(),
//         builder: (context, bannerSnapshot) {
//           if (bannerSnapshot.connectionState == ConnectionState.waiting) {
//             return const SizedBox(
//               height: 200,
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//
//           if (bannerSnapshot.hasError) {
//             return SizedBox(
//               height: 200,
//               child: Center(
//                 child: Text('Error loading banners: ${bannerSnapshot.error}'),
//               ),
//             );
//           }
//
//           if (!bannerSnapshot.hasData || bannerSnapshot.data!.docs.isEmpty) {
//             return const SizedBox();
//           }
//
//           return _buildBannersCarousel(context, bannerSnapshot.data!.docs, isLargeScreen);
//         },
//       ),
//
//
//     // Deals of the Day Section - Web style
//     _buildDealsOfTheDay(context, regularItems, isLargeScreen),
//
//     // Horizontal Brand Names List - Web optimized
//     if (brandNames.isNotEmpty)
//     Container(
//     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//     color: Colors.white,
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     // Header Row for "Brands" and "See All"
//     Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//     const Text(
//     'Top Brands',
//     style: TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.bold,
//     color: Colors.black,
//     ),
//     ),
//     GestureDetector(
//     onTap: () {
//     Navigator.push(
//     context,
//     MaterialPageRoute(
//     builder: (context) => WebAllBrandsPage(
//     brandNames: brandNames,
//     allItems: regularItems,
//     ),
//     ),
//     );
//     },
//     child: Text(
//     'See All',
//     style: TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w600,
//     color: Colors.deepOrange,
//     ),
//     ),
//     ),
//     ],
//     ),
//     ),
//     const SizedBox(height: 12),
//     // Brand Names Grid - Responsive
//     // GridView.builder(
//     // shrinkWrap: true,
//     // physics: const NeverScrollableScrollPhysics(),
//     // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     // crossAxisCount: isLargeScreen ? 6 : 3,
//     // crossAxisSpacing: 8,
//     // mainAxisSpacing: 8,
//     // childAspectRatio: 1,
//     // ),
//     // itemCount: brandNames.length > (isLargeScreen ? 12 : 6)
//     // ? (isLargeScreen ? 12 : 6)
//     //     : brandNames.length,
//     // itemBuilder: (context, index) {
//     // String brandName = brandNames[index];
//     // Color brandColor = brandColors[index % brandColors.length];
//     //
//     // return GestureDetector(
//     // onTap: () {
//     // Navigator.push(
//     // context,
//     // MaterialPageRoute(
//     // builder: (context) => BrandProductsPage(
//     // brandName: brandName,
//     // allItems: regularItems,
//     // ),
//     // ),
//     // );
//     // },
//     // child: Container(
//     // decoration: BoxDecoration(
//     // color: Colors.white,
//     // borderRadius: BorderRadius.circular(8),
//     // boxShadow: [
//     // BoxShadow(
//     // color: Colors.grey.withOpacity(0.2),
//     // blurRadius: 4,
//     // spreadRadius: 1,
//     // ),
//     // ],
//     // ),
//     // child: Column(
//     // mainAxisAlignment: MainAxisAlignment.center,
//     // children: [
//     // CircleAvatar(
//     // radius: isLargeScreen ? 30 : 24,
//     // backgroundColor: brandColor,
//     // child: Text(
//     // brandName[0].toUpperCase(),
//     // style: TextStyle(
//     // fontSize: isLargeScreen ? 20 : 16,
//     // fontWeight: FontWeight.bold,
//     // color: Colors.white,
//     // ),
//     // ),
//     // ),
//     // const SizedBox(height: 8),
//     // Text(
//     // brandName,
//     // style: TextStyle(
//     // fontSize: isLargeScreen ? 14 : 12,
//     // fontWeight: FontWeight.w500,
//     // color: Colors.black87,
//     // ),
//     // textAlign: TextAlign.center,
//     // maxLines: 2,
//     // ),
//     // ],
//     // ),
//     // ),
//     // );
//     // },
//     // ),
//
//
//
//       CarouselSlider(
//         options: CarouselOptions(
//           height: isLargeScreen ? 180 : 150, // Increased height
//           enableInfiniteScroll: false,
//           viewportFraction: isLargeScreen ? 0.18 : 0.28, // Wider cards
//           enlargeCenterPage: false,
//           padEnds: false,
//         ),
//         items: List.generate(
//           brandNames.length > (isLargeScreen ? 12 : 6)
//               ? (isLargeScreen ? 12 : 6)
//               : brandNames.length,
//               (index) {
//             String brandName = brandNames[index];
//             Color brandColor = brandColors[index % brandColors.length];
//
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BrandProductsPage(
//                       brandName: brandName,
//                       allItems: regularItems,
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 // Removed horizontal margin for tight spacing
//                 padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       blurRadius: 5,
//                       spreadRadius: 1,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: isLargeScreen ? 36 : 30, // Bigger brand circle
//                       backgroundColor: brandColor,
//                       child: Text(
//                         brandName[0].toUpperCase(),
//                         style: TextStyle(
//                           fontSize: isLargeScreen ? 22 : 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       width: isLargeScreen ? 90 : 70,
//                       child: Text(
//                         brandName,
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: isLargeScreen ? 15 : 13,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//
//
//     ],
//     ),
//     ),
//
//     // Products Grid - Web optimized
//     // Container(
//     //   padding: const EdgeInsets.symmetric(vertical: 16),
//     //   color: Colors.grey[50],
//     //   child: Column(
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: categories.map((category) {
//     //       List<Map<String, dynamic>> items = itemsByCategory[category]!;
//     //       items.sort((a, b) {
//     //         Timestamp? timestampA = a['timestamp'] as Timestamp?;
//     //         Timestamp? timestampB = b['timestamp'] as Timestamp?;
//     //         return timestampB?.compareTo(timestampA ?? Timestamp.now()) ?? 0;
//     //       });
//     //
//     //       return Column(
//     //         crossAxisAlignment: CrossAxisAlignment.start,
//     //         children: [
//     //           Container(
//     //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     //             color: Colors.white,
//     //             child: Row(
//     //               children: [
//     //                 Text(
//     //                   category,
//     //                   style: const TextStyle(
//     //                     fontSize: 20,
//     //                     fontWeight: FontWeight.bold,
//     //                   ),
//     //                 ),
//     //                 const Spacer(),
//     //                 GestureDetector(
//     //                   onTap: () {
//     //                     Navigator.push(
//     //                       context,
//     //                       MaterialPageRoute(
//     //                         builder: (context) => CategorySeeAllScreen(
//     //                           category: category,
//     //                           items: items,
//     //                         ),
//     //                       ),
//     //                     );
//     //                   },
//     //                   child: Text(
//     //                     "View All",
//     //                     style: TextStyle(
//     //                       fontSize: 16,
//     //                       fontWeight: FontWeight.w600,
//     //                       color: Theme.of(context).primaryColor,
//     //                     ),
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //           ),
//     //           const SizedBox(height: 8),
//     //           GridView.builder(
//     //             padding: const EdgeInsets.symmetric(horizontal: 16),
//     //             shrinkWrap: true,
//     //             physics: const NeverScrollableScrollPhysics(),
//     //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     //               crossAxisCount: isLargeScreen ? 4 : 2,
//     //               crossAxisSpacing: 16,
//     //               mainAxisSpacing: 16,
//     //               childAspectRatio: 0.75,
//     //             ),
//     //             itemCount: items.length > (isLargeScreen ? 8 : 4)
//     //                 ? (isLargeScreen ? 8 : 4)
//     //                 : items.length,
//     //             itemBuilder: (context, index) {
//     //               final item = items[index];
//     //               final productDetails = item['productDetails'] ?? {};
//     //
//     //               return _buildProductCard(context, item, productDetails);
//     //             },
//     //           ),
//     //           const SizedBox(height: 16),
//     //         ],
//     //       );
//     //     }).toList(),
//     //   ),
//     // ),
//
//     // products
//
//     // Replace your current GridView.builder with this:
//       ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           String category = categories[index];
//           List<Map<String, dynamic>> items = itemsByCategory[category]!;
//
//           // Sort items by timestamp (newest first)
//           items.sort((a, b) {
//             Timestamp? timestampA = a['timestamp'] as Timestamp?;
//             Timestamp? timestampB = b['timestamp'] as Timestamp?;
//             return timestampB?.compareTo(timestampA ?? Timestamp.now()) ?? 0;
//           });
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Category Header
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//                 child: Row(
//                   children: [
//                     Text(
//                       category,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => WebCategorySeeAllScreen(
//                               category: category,
//                               items: items,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Text(
//                             "View All",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.deepOrange,
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 14,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Grid of Products (image in container, text below)
//               GridView.count(
//                 crossAxisCount: 4,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.55,
//                 children: List.generate(
//                   items.length > 4 ? 4 : items.length,
//                       (index) {
//                     final item = items[index];
//                     final productDetails = item['productDetails'] ?? {};
//                     double price = double.tryParse(productDetails['Price']?.toString() ?? '0') ?? 0;
//                     double offerPrice = double.tryParse(productDetails['Offer Price']?.toString() ?? '0') ?? 0;
//                     int discount = price > 0 ? ((price - offerPrice) / price * 100).round() : 0;
//
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => WebParticularProductDetailsScreen(
//                               productId: item['id'],
//                             ),
//                           ),
//                         );
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Container with just image
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.transparent,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   spreadRadius: 1,
//                                   blurRadius: 3,
//                                   offset: const Offset(0, 1),
//                                 ),
//                               ],
//                             ),
//                             child: Stack(
//                               children: [
//                                 AspectRatio(
//                                   aspectRatio: 1,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: item['images'] != null && item['images'].isNotEmpty
//                                         ? Image.network(
//                                       item['images'][0],
//                                       fit: BoxFit.cover,
//                                     )
//                                         : Container(
//                                       color: Colors.grey[100],
//                                       child: const Center(
//                                         child: Icon(Icons.image_not_supported, color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 if (discount > 0)
//                                   Positioned(
//                                     top: 6,
//                                     left: 6,
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: Colors.redAccent,
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                       child: Text(
//                                         '$discount% OFF',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//
//                           const SizedBox(height: 8),
//
//                           // Text Below Container
//                           Text(
//                             item['name'] ?? 'No Name',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 18,
//                               color: Colors.black87,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             item['brandName'] ?? 'No Brand',
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey[600],
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             children: [
//                               Text(
//                                 '₹${productDetails['Offer Price'] ?? '0'}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                   color: Colors.deepOrange,
//                                 ),
//                               ),
//                               const SizedBox(width: 6),
//                               if (productDetails['Price'] != null &&
//                                   productDetails['Price'] != productDetails['Offer Price'])
//                                 Text(
//                                   '₹${productDetails['Price']}',
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.grey,
//                                     decoration: TextDecoration.lineThrough,
//                                   ),
//                                 ),
//
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//             ],
//           );
//
//         },
//       ),
//        const WebFooterSection(),
//
//
//     ]
//     )
//     );
//     },
//     );
//     }
//       )
//
//     );
//   }
//
//
//   // Widget buildWebStyleAppBar(BuildContext context) {
//   //   return Container(
//   //     color: Colors.white,
//   //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//   //     child: Row(
//   //       crossAxisAlignment: CrossAxisAlignment.center,
//   //       children: [
//   //         // Left: Logo stacked above App Name
//   //         Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             Image.asset(
//   //               'assets/images/Sadhana_cart1.png',
//   //               height: 55,
//   //               width: 55,
//   //               fit: BoxFit.contain,
//   //             ),
//   //             const SizedBox(height: 2),
//   //             const Text(
//   //               'SadhanaCart',
//   //               style: TextStyle(
//   //                 color: Colors.deepOrange,
//   //                 fontSize: 23,
//   //                 fontWeight: FontWeight.bold,
//   //                 letterSpacing: 1.2,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //
//   //         const Spacer(),
//   //
//   //         // Center: Navigation Links
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: [
//   //             _buildNavText('Home', context, onTap: null, isActive: true),
//   //             _buildNavText('Categories', context, onTap: () {
//   //               Navigator.push(context, MaterialPageRoute(builder: (_) => CategoriesTab()));
//   //             }),
//   //             _buildNavText('Orders', context, onTap: () {
//   //               Navigator.push(context, MaterialPageRoute(builder: (_) => const ExploreTab()));
//   //             }),
//   //             _buildNavText('Profile', context, onTap: () {
//   //               Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileTab()));
//   //             }),
//   //           ],
//   //         ),
//   //
//   //         const Spacer(),
//   //
//   //         // Right: Icons (Search & Cart)
//   //         Row(
//   //           children: [
//   //             IconButton(
//   //               icon: const Icon(Icons.search, color: Colors.grey, size: 35),
//   //               onPressed: () {
//   //                 Navigator.push(
//   //                   context,
//   //                   MaterialPageRoute(builder: (_) => const SearchScreen(searchQuery: '')),
//   //                 );
//   //               },
//   //             ),
//   //             const SizedBox(width: 15),
//   //             IconButton(
//   //               icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 35),
//   //               onPressed: () {
//   //                 Navigator.push(
//   //                   context,
//   //                   MaterialPageRoute(builder: (_) => const CartTab()),
//   //                 );
//   //               },
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   // Widget buildWebStyleAppBar(BuildContext context, Function(int) onTabSelected, int currentIndex) {
//   //   return Container(
//   //     color: Colors.white,
//   //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//   //     child: Row(
//   //       crossAxisAlignment: CrossAxisAlignment.center,
//   //       children: [
//   //         // Logo stacked above text
//   //         Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             Image.asset(
//   //               'assets/images/Sadhana_cart1.png',
//   //               height: 55,
//   //               width: 55,
//   //               fit: BoxFit.contain,
//   //             ),
//   //             const SizedBox(height: 2),
//   //             const Text(
//   //               'SadhanaCart',
//   //               style: TextStyle(
//   //                 color: Colors.deepOrange,
//   //                 fontSize: 23,
//   //                 fontWeight: FontWeight.bold,
//   //                 letterSpacing: 1.2,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //
//   //         const Spacer(),
//   //
//   //         // Center Nav
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: [
//   //             _buildNavText('Home', 0, currentIndex, onTabSelected),
//   //             _buildNavText('Categories', 1, currentIndex, onTabSelected),
//   //             _buildNavText('Orders', 2, currentIndex, onTabSelected),
//   //             _buildNavText('Profile', 3, currentIndex, onTabSelected),
//   //           ],
//   //         ),
//   //
//   //         const Spacer(),
//   //
//   //         // Icons (Search & Cart)
//   //         Row(
//   //           children: [
//   //             IconButton(
//   //               icon: const Icon(Icons.search, color: Colors.grey, size: 35),
//   //               onPressed: () {
//   //                 onTabSelected(5); // Optional: index for search screen
//   //               },
//   //             ),
//   //             const SizedBox(width: 15),
//   //             IconButton(
//   //               icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 35),
//   //               onPressed: () {
//   //                 onTabSelected(4); // Navigate to cart
//   //               },
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   //
//   //
//   // Widget _buildNavText(String title, int index, int currentIndex, Function(int) onTap) {
//   //   final bool isActive = index == currentIndex;
//   //
//   //   return GestureDetector(
//   //     onTap: () => onTap(index),
//   //     child: Padding(
//   //       padding: const EdgeInsets.symmetric(horizontal: 14),
//   //       child: Text(
//   //         title,
//   //         style: TextStyle(
//   //           fontSize: 18,
//   //           fontWeight: FontWeight.w600,
//   //           color: isActive ? Colors.deepOrange : Colors.grey[800],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//
//
//
//
//   // chat gpt final good output
//
//
//   // Widget _buildWebProductCard(
//   //     BuildContext context, Map<String, dynamic> product, Map<String, dynamic> details) {
//   //   final String name = product['name'] ?? 'Unnamed Product';
//   //   final List<dynamic> images = product['images'] ?? [];
//   //   final String offerPrice = details['Offer Price']?.toString() ?? '';
//   //   final String originalPrice = details['Original Price']?.toString() ?? '';
//   //
//   //   return TweenAnimationBuilder<double>(
//   //     duration: const Duration(milliseconds: 300),
//   //     tween: Tween<double>(begin: 0.95, end: 1),
//   //     curve: Curves.easeOut,
//   //     builder: (context, scale, child) {
//   //       return Transform.scale(
//   //         scale: scale,
//   //         child: Column(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             // Product Image Card
//   //             Stack(
//   //               children: [
//   //                 Card(
//   //                   elevation: 4,
//   //                   shape: RoundedRectangleBorder(
//   //                     borderRadius: BorderRadius.circular(12),
//   //                   ),
//   //                   clipBehavior: Clip.antiAlias,
//   //                   child: ClipRRect(
//   //                     borderRadius: BorderRadius.circular(12),
//   //                     child: images.isNotEmpty
//   //                         ? Image.network(
//   //                       images[0],
//   //                       height: 180,
//   //                       width: double.infinity,
//   //                       fit: BoxFit.cover,
//   //                     )
//   //                         : Container(
//   //                       height: 180,
//   //                       width: double.infinity,
//   //                       color: Colors.grey[300],
//   //                       child: const Icon(Icons.image_not_supported),
//   //                     ),
//   //                   ),
//   //                 ),
//   //
//   //                 // SALE Badge
//   //                 if (originalPrice != offerPrice && originalPrice.isNotEmpty)
//   //                   Positioned(
//   //                     top: 8,
//   //                     left: 8,
//   //                     child: Container(
//   //                       padding:
//   //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//   //                       decoration: BoxDecoration(
//   //                         color: Colors.pinkAccent,
//   //                         borderRadius: BorderRadius.circular(20),
//   //                       ),
//   //                       child: const Text(
//   //                         'SALE',
//   //                         style: TextStyle(
//   //                           color: Colors.white,
//   //                           fontSize: 10,
//   //                           fontWeight: FontWeight.bold,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //               ],
//   //             ),
//   //
//   //             const SizedBox(height: 8),
//   //
//   //             // Product Name
//   //             Text(
//   //               name,
//   //               textAlign: TextAlign.start,
//   //               maxLines: 2,
//   //               overflow: TextOverflow.ellipsis,
//   //               style: const TextStyle(
//   //                 fontWeight: FontWeight.w600,
//   //                 fontSize: 14.5,
//   //                 color: Colors.black87,
//   //               ),
//   //             ),
//   //             const SizedBox(height: 4),
//   //
//   //             // Price Row
//   //             Row(
//   //               children: [
//   //                 Text(
//   //                   '₹$offerPrice',
//   //                   style: const TextStyle(
//   //                     fontWeight: FontWeight.bold,
//   //                     fontSize: 14.5,
//   //                     color: Colors.black,
//   //                   ),
//   //                 ),
//   //                 const SizedBox(width: 6),
//   //                 if (originalPrice.isNotEmpty && offerPrice != originalPrice)
//   //                   Text(
//   //                     '₹$originalPrice',
//   //                     style: const TextStyle(
//   //                       fontSize: 13,
//   //                       color: Colors.grey,
//   //                       decoration: TextDecoration.lineThrough,
//   //                     ),
//   //                   ),
//   //               ],
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//
//
//
//
//
//
//   Widget _buildDealsOfTheDay(BuildContext context, List<Map<String, dynamic>> items, bool isLargeScreen) {
//     // Filter items with discounts
//     List<Map<String, dynamic>> discountedItems = items.where((item) {
//       final productDetails = item['productDetails'] ?? {};
//       return productDetails['Price'] != null &&
//           productDetails['Offer Price'] != null &&
//           productDetails['Price'] != productDetails['Offer Price'];
//     }).toList();
//
//     // Sort by discount percentage (highest first)
//     discountedItems.sort((a, b) {
//       final aDetails = a['productDetails'] ?? {};
//       final bDetails = b['productDetails'] ?? {};
//       double aPrice = double.tryParse(aDetails['Price']?.toString() ?? '0') ?? 0;
//       double aOffer = double.tryParse(aDetails['Offer Price']?.toString() ?? '0') ?? 0;
//       double bPrice = double.tryParse(bDetails['Price']?.toString() ?? '0') ?? 0;
//       double bOffer = double.tryParse(bDetails['Offer Price']?.toString() ?? '0') ?? 0;
//
//       double aDiscount = aPrice > 0 ? ((aPrice - aOffer) / aPrice * 100) : 0;
//       double bDiscount = bPrice > 0 ? ((bPrice - bOffer) / bPrice * 100) : 0;
//
//       return bDiscount.compareTo(aDiscount);
//     });
//
//     if (discountedItems.isEmpty) {
//       return const SizedBox();
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               'Deals of the Day',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           SizedBox(
//             height: isLargeScreen ? 280 : 240,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: discountedItems.length > 10 ? 10 : discountedItems.length,
//               itemBuilder: (context, index) {
//                 final item = discountedItems[index];
//                 final productDetails = item['productDetails'] ?? {};
//                 double price = double.tryParse(productDetails['Price']?.toString() ?? '0') ?? 0;
//                 double offerPrice = double.tryParse(productDetails['Offer Price']?.toString() ?? '0') ?? 0;
//                 int discount = price > 0 ? ((price - offerPrice) / price * 100).round() : 0;
//
//                 return Container(
//                   width: isLargeScreen ? 180 : 160,
//                   margin: const EdgeInsets.only(right: 16),
//                   child: _buildProductCard(context, item, productDetails, showDiscount: true),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductCard(BuildContext context, Map<String, dynamic> item,
//       Map<String, dynamic> productDetails, {bool showDiscount = false}) {
//     double price = double.tryParse(productDetails['Price']?.toString() ?? '0') ?? 0;
//     double offerPrice = double.tryParse(productDetails['Offer Price']?.toString() ?? '0') ?? 0;
//     int discount = price > 0 ? ((price - offerPrice) / price * 100).round() : 0;
//
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebParticularProductDetailsScreen(
//               productId: item['id'],
//             ),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image with Discount Badge
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(8)),
//                   child: Container(
//                     height: 140,
//                     width: double.infinity,
//                     color: Colors.grey[100],
//                     child: item['images'] != null && item['images'].isNotEmpty
//                         ? Image.network(
//                       item['images'][0],
//                       fit: BoxFit.contain,
//                     )
//                         : const Center(
//                       child: Icon(Icons.image_not_supported, size: 40),
//                     ),
//                   ),
//                 ),
//                 if (showDiscount && discount > 0)
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 6, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.red[600],
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         '$discount% OFF',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item['name'] ?? 'No Name',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     item['brandName'] ?? 'No Brand',
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600]),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Text(
//                         '₹${productDetails['Offer Price'] ?? '0'}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       if (productDetails['Price'] != null &&
//                           productDetails['Price'] !=
//                               productDetails['Offer Price'])
//                         Text(
//                           '₹${productDetails['Price']}',
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   if (!showDiscount && discount > 0)
//                     Text(
//                       '$discount% off',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.green[700],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
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
//         'Clothing',
//         'Electronics',
//         'Footwear',
//         'Accessories',
//         'Home Appliances',
//         'Books',
//         'Vegetables'
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
//               ...doc.data(),
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
//             ...offerDoc.data(),
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
//
//
// }
//
// Widget _buildBannersCarousel(
//     BuildContext context, List<DocumentSnapshot> banners, bool isLargeScreen) {
//   final screenWidth = MediaQuery.of(context).size.width;
//
//   return CarouselSlider.builder(
//     itemCount: banners.length,
//     options: CarouselOptions(
//       height: 440,               // Full banner height
//       autoPlay: true,
//       enlargeCenterPage: false, // Disable zoom effect
//       viewportFraction: 1.0,    // 🔥 Show only one banner at a time
//       autoPlayInterval: const Duration(seconds: 4),
//       autoPlayAnimationDuration: const Duration(milliseconds: 800),
//       padEnds: false,
//     ),
//     itemBuilder: (context, index, realIndex) {
//       final banner = banners[index];
//       return _buildBannerItem(context, banner, index, screenWidth);
//     },
//   );
// }
//
// Widget _buildBannerItem(
//     BuildContext context, DocumentSnapshot banner, int index, double screenWidth) {
//   final imageUrl = banner['imageUrl'] as String?;
//   final percentage = banner['percentage'] as int?;
//   final category = banner['category'] as String?;
//
//   return GestureDetector(
//     onTap: () {
//       if (category != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WebBannerProductsPage(
//               category: category,
//               discountPercentage: percentage ?? 0,
//             ),
//           ),
//         );
//       }
//     },
//     child: SizedBox(
//       width: screenWidth,
//       height: 540, // Match Carousel height
//       child: imageUrl != null
//           ? Image.network(
//         imageUrl,
//         fit: BoxFit.fill, // 📷 Display clean full image (not zoomed)
//         width: double.infinity,
//         height: double.infinity,
//       )
//           : Container(
//
//         color: Colors.grey[200],
//         child: const Center(
//           child: Icon(
//             Icons.broken_image,
//             size: 50,
//             color: Colors.grey,
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// class WebBannerProductsPage extends StatelessWidget {
//   final String category;
//   final int discountPercentage;
//
//   const WebBannerProductsPage({
//     required this.category,
//     required this.discountPercentage,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final isLargeScreen = MediaQuery.of(context).size.width > 800;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$category - $discountPercentage% OFF'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No sellers found.'));
//           }
//
//           return FutureBuilder<List<Map<String, dynamic>>>(
//             future: _fetchDiscountedProducts(
//               snapshot.data!.docs,
//               category,
//               discountPercentage,
//             ),
//             builder: (context, itemSnapshot) {
//               if (itemSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (itemSnapshot.hasError) {
//                 return Center(child: Text('Error: ${itemSnapshot.error}'));
//               }
//
//               if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text('No discounted products found in $category'),
//                 );
//               }
//
//               return GridView.builder(
//                 padding: const EdgeInsets.all(16),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: isLargeScreen ? 4 : 2,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemCount: itemSnapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final item = itemSnapshot.data![index];
//                   final productDetails = item['productDetails'] ?? {};
//                   double price = double.tryParse(productDetails['Price']?.toString() ?? '0') ?? 0;
//                   double offerPrice = double.tryParse(productDetails['Offer Price']?.toString() ?? '0') ?? 0;
//                   int discount = price > 0 ? ((price - offerPrice) / price * 100).round() : 0;
//
//                   return Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Product Image with Discount Badge
//                         Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(8)),
//                               child: Container(
//                                 height: 160,
//                                 width: double.infinity,
//                                 color: Colors.grey[100],
//                                 child: item['images'] != null && item['images'].isNotEmpty
//                                     ? Image.network(
//                                   item['images'][0],
//                                   fit: BoxFit.contain,
//                                 )
//                                     : const Center(
//                                   child: Icon(Icons.image_not_supported, size: 40),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 8,
//                               left: 8,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.red[600],
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: Text(
//                                   '$discount% OFF',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item['name'] ?? 'No Name',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 16,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 item['brandName'] ?? 'No Brand',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.grey[600]),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Text(
//                                     '₹${productDetails['Offer Price'] ?? '0'}',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   if (productDetails['Price'] != null &&
//                                       productDetails['Price'] !=
//                                           productDetails['Offer Price'])
//                                     Text(
//                                       '₹${productDetails['Price']}',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                         decoration: TextDecoration.lineThrough,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Theme.of(context).primaryColor,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => WebParticularProductDetailsScreen(
//                                           productId: item['id'],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: const Text(
//                                     'View Details',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> _fetchDiscountedProducts(
//       List<QueryDocumentSnapshot> sellers,
//       String category,
//       int discountPercentage,
//       ) async {
//     List<Map<String, dynamic>> discountedItems = [];
//
//     for (var seller in sellers) {
//       String sellerId = seller.id;
//
//       try {
//         var snapshot = await FirebaseFirestore.instance
//             .collection('seller')
//             .doc(sellerId)
//             .collection(category)
//             .get();
//
//         for (var doc in snapshot.docs) {
//           final data = doc.data();
//           if (data['productDetails'] != null) {
//             final productDetails = data['productDetails'] as Map<String, dynamic>;
//             if (productDetails['Price'] != null &&
//                 productDetails['Offer Price'] != null) {
//               final price = double.parse(productDetails['Price'].toString());
//               final offerPrice =
//               double.parse(productDetails['Offer Price'].toString());
//               final calculatedDiscount = _calculateDiscountPercentage(price, offerPrice);
//
//               if (calculatedDiscount >= discountPercentage) {
//                 discountedItems.add({
//                   ...data,
//                   'sellerId': sellerId,
//                   'category': category,
//                   'id': doc.id,
//                 });
//               }
//             }
//           }
//         }
//       } catch (e) {
//         print('Error fetching $category for seller $sellerId: $e');
//       }
//     }
//
//     return discountedItems;
//   }
//
//
//
//   int _calculateDiscountPercentage(double originalPrice, double offerPrice) {
//     if (originalPrice <= 0) return 0;
//     return ((originalPrice - offerPrice) / originalPrice * 100).round();
//   }
// }



// adding listener



import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/app_localization.dart';
import 'package:sadhana_cart/Customer/branded_products_list.dart';
import 'package:sadhana_cart/Customer/see_all_brands_screen.dart';
import 'package:sadhana_cart/Web/Customer/see_all_brands_screen.dart';
import 'package:async/async.dart';
// Import your other screens here
import 'animated_footer.dart';
import 'category_products_screen.dart';
import 'category_tabb.dart';
import 'customer_bottom_navigationber_layout.dart';
import 'customer_cart_screen.dart';
import 'customer_category_see_all_screen.dart';
import 'customer_profile_screen.dart';
import 'particular_product_details_screen.dart';

class WebHomeTab extends StatelessWidget {
  final Map<String, String> categoryImages = {
    'Clothing': 'assets/images/clothings_category_customer_hometab.jpeg',
    'Electronics': 'assets/images/Electronics_category_customer_hometab.jpeg',
    'Footwear': 'assets/images/footwear_category_customer_hometab.jpeg',
    'Accessories': 'assets/images/Accessories_category.jpg',
    'Home Appliances': 'assets/images/home_appliences_category.jpg',
    'Books': 'assets/images/books_category.jpeg',
    'Others': 'assets/images/vegetables_category.jpeg',
  };

  WebHomeTab({super.key});

  get category => null;

  get items => null;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 800;

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('seller').snapshots(),
            builder: (context, sellersSnapshot) {
              if (sellersSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (sellersSnapshot.hasError) {
                return Center(child: Text('Error: ${sellersSnapshot.error}'));
              }

              if (!sellersSnapshot.hasData || sellersSnapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No sellers found.'));
              }


              return StreamBuilder<List<Map<String, dynamic>>>(
                stream: _getProductsStream(sellersSnapshot.data!.docs),
                builder: (context, productsSnapshot) {
                  if (productsSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (productsSnapshot.hasError) {
                    return Center(child: Text('Error: ${productsSnapshot.error}'));
                  }

                  if (!productsSnapshot.hasData || productsSnapshot.data!.isEmpty) {
                    return const Center(child: Text('No available products found.'));
                  }

                  List<Map<String, dynamic>> allItems = productsSnapshot.data!;

                  // Separate offers from regular items
                  List<Map<String, dynamic>> offers = allItems
                      .where((item) => item['bannerUrl'] != null)
                      .toList();

                  // Get regular items (non-offers)
                  List<Map<String, dynamic>> regularItems = allItems
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
                      .where((item) => item['brandName'] != null && item['brandName'].isNotEmpty)
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
                  ];

                  return SingleChildScrollView(
                      child: Column(
                          children: [
                            // Search Bar (Web-style at the top)

                            // if (isLargeScreen) buildWebStyleAppBar(context),

                            // Horizontal Categories List - Web optimized
                            //   Container(
                            //     padding: const EdgeInsets.symmetric(vertical: 12),
                            //     color: Colors.white,
                            //     child: SizedBox(
                            //       height: 200,
                            //       child: ListView.builder(
                            //         scrollDirection: Axis.horizontal,
                            //         physics: const ClampingScrollPhysics(),
                            //         shrinkWrap: true,
                            //         itemCount: categories.length,
                            //         itemBuilder: (context, index) {
                            //           String category = categories[index];
                            //           String imagePath = categoryImages[category] ??
                            //               'assets/images/default.png';
                            //
                            //           return GestureDetector(
                            //             onTap: () {
                            //               Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => CategoryProductsPage(
                            //                     category: category,
                            //                     allItems: regularItems,
                            //                   ),
                            //                 ),
                            //               );
                            //             },
                            //             child: Container(
                            //               width: 100,
                            //               margin: const EdgeInsets.symmetric(horizontal: 8),
                            //               child: Column(
                            //                 mainAxisAlignment: MainAxisAlignment.center,
                            //                 children: [
                            //                   Container(
                            //                     width: 64,
                            //                     height: 64,
                            //                     decoration: BoxDecoration(
                            //                       shape: BoxShape.circle,
                            //                       color: Colors.white,
                            //                       boxShadow: [
                            //                         BoxShadow(
                            //                             color: Colors.grey.withOpacity(0.3),
                            //                             blurRadius: 5,
                            //                             spreadRadius: 1)
                            //                       ],
                            //                     ),
                            //                     child: ClipOval(
                            //                       child: Image.asset(
                            //                         imagePath,
                            //                         fit: BoxFit.cover,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   const SizedBox(height: 8),
                            //                   Text(
                            //                     category,
                            //                     style: const TextStyle(
                            //                       fontSize: 14,
                            //                       fontWeight: FontWeight.bold,
                            //                       color: Colors.black87,
                            //                     ),
                            //                     textAlign: TextAlign.center,
                            //                     maxLines: 2,
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           );
                            //         },
                            //       ),
                            //     ),
                            //   ),

                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              color: Colors.white,
                              child: SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    String category = categories[index];
                                    String imagePath = categoryImages[category] ?? 'assets/images/default.png';

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebCategoryProductsPage(
                                              category: category,
                                              allItems: regularItems,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 100,
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // 🔼 Increased image size here
                                            Container(
                                              width: 100, // Increased from 64
                                              height: 100, // Increased from 64
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    blurRadius: 5,
                                                    spreadRadius: 1,
                                                  )
                                                ],
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  imagePath,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10), // Optional: adjust spacing
                                            // 🔼 Increased text font size here
                                            Text(
                                              category,
                                              style: const TextStyle(
                                                fontSize: 16, // Increased from 14
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),



                            // Banner Carousel - Web optimized
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('admin')
                                  .doc('admin_document')
                                  .collection('banners')
                                  .where('isActive', isEqualTo: true)
                                  .snapshots(),
                              builder: (context, bannerSnapshot) {
                                if (bannerSnapshot.connectionState == ConnectionState.waiting) {
                                  return const SizedBox(
                                    height: 200,
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }

                                if (bannerSnapshot.hasError) {
                                  return SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Text('Error loading banners: ${bannerSnapshot.error}'),
                                    ),
                                  );
                                }

                                if (!bannerSnapshot.hasData || bannerSnapshot.data!.docs.isEmpty) {
                                  return const SizedBox();
                                }

                                return _buildBannersCarousel(context, bannerSnapshot.data!.docs, isLargeScreen);
                              },
                            ),


                            // Deals of the Day Section - Web style
                            _buildDealsOfTheDay(context, regularItems, isLargeScreen),

                            // Horizontal Brand Names List - Web optimized
                            if (brandNames.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header Row for "Brands" and "See All"
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Top Brands',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => WebAllBrandsPage(
                                                    brandNames: brandNames,
                                                    allItems: regularItems,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'See All',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Brand Names Grid - Responsive
                                    // GridView.builder(
                                    // shrinkWrap: true,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    // crossAxisCount: isLargeScreen ? 6 : 3,
                                    // crossAxisSpacing: 8,
                                    // mainAxisSpacing: 8,
                                    // childAspectRatio: 1,
                                    // ),
                                    // itemCount: brandNames.length > (isLargeScreen ? 12 : 6)
                                    // ? (isLargeScreen ? 12 : 6)
                                    //     : brandNames.length,
                                    // itemBuilder: (context, index) {
                                    // String brandName = brandNames[index];
                                    // Color brandColor = brandColors[index % brandColors.length];
                                    //
                                    // return GestureDetector(
                                    // onTap: () {
                                    // Navigator.push(
                                    // context,
                                    // MaterialPageRoute(
                                    // builder: (context) => BrandProductsPage(
                                    // brandName: brandName,
                                    // allItems: regularItems,
                                    // ),
                                    // ),
                                    // );
                                    // },
                                    // child: Container(
                                    // decoration: BoxDecoration(
                                    // color: Colors.white,
                                    // borderRadius: BorderRadius.circular(8),
                                    // boxShadow: [
                                    // BoxShadow(
                                    // color: Colors.grey.withOpacity(0.2),
                                    // blurRadius: 4,
                                    // spreadRadius: 1,
                                    // ),
                                    // ],
                                    // ),
                                    // child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    // children: [
                                    // CircleAvatar(
                                    // radius: isLargeScreen ? 30 : 24,
                                    // backgroundColor: brandColor,
                                    // child: Text(
                                    // brandName[0].toUpperCase(),
                                    // style: TextStyle(
                                    // fontSize: isLargeScreen ? 20 : 16,
                                    // fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                    // ),
                                    // ),
                                    // ),
                                    // const SizedBox(height: 8),
                                    // Text(
                                    // brandName,
                                    // style: TextStyle(
                                    // fontSize: isLargeScreen ? 14 : 12,
                                    // fontWeight: FontWeight.w500,
                                    // color: Colors.black87,
                                    // ),
                                    // textAlign: TextAlign.center,
                                    // maxLines: 2,
                                    // ),
                                    // ],
                                    // ),
                                    // ),
                                    // );
                                    // },
                                    // ),



                                    CarouselSlider(
                                      options: CarouselOptions(
                                        height: isLargeScreen ? 180 : 150, // Increased height
                                        enableInfiniteScroll: false,
                                        viewportFraction: isLargeScreen ? 0.18 : 0.28, // Wider cards
                                        enlargeCenterPage: false,
                                        padEnds: false,
                                      ),
                                      items: List.generate(
                                        brandNames.length > (isLargeScreen ? 12 : 6)
                                            ? (isLargeScreen ? 12 : 6)
                                            : brandNames.length,
                                            (index) {
                                          String brandName = brandNames[index];
                                          Color brandColor = brandColors[index % brandColors.length];

                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => BrandProductsPage(
                                                    brandName: brandName,
                                                    allItems: regularItems,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              // Removed horizontal margin for tight spacing
                                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    blurRadius: 5,
                                                    spreadRadius: 1,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    radius: isLargeScreen ? 36 : 30, // Bigger brand circle
                                                    backgroundColor: brandColor,
                                                    child: Text(
                                                      brandName[0].toUpperCase(),
                                                      style: TextStyle(
                                                        fontSize: isLargeScreen ? 22 : 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  SizedBox(
                                                    width: isLargeScreen ? 90 : 70,
                                                    child: Text(
                                                      brandName,
                                                      textAlign: TextAlign.center,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: isLargeScreen ? 15 : 13,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black87,
                                                      ),
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

                            // Products Grid - Web optimized
                            // Container(
                            //   padding: const EdgeInsets.symmetric(vertical: 16),
                            //   color: Colors.grey[50],
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: categories.map((category) {
                            //       List<Map<String, dynamic>> items = itemsByCategory[category]!;
                            //       items.sort((a, b) {
                            //         Timestamp? timestampA = a['timestamp'] as Timestamp?;
                            //         Timestamp? timestampB = b['timestamp'] as Timestamp?;
                            //         return timestampB?.compareTo(timestampA ?? Timestamp.now()) ?? 0;
                            //       });
                            //
                            //       return Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Container(
                            //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            //             color: Colors.white,
                            //             child: Row(
                            //               children: [
                            //                 Text(
                            //                   category,
                            //                   style: const TextStyle(
                            //                     fontSize: 20,
                            //                     fontWeight: FontWeight.bold,
                            //                   ),
                            //                 ),
                            //                 const Spacer(),
                            //                 GestureDetector(
                            //                   onTap: () {
                            //                     Navigator.push(
                            //                       context,
                            //                       MaterialPageRoute(
                            //                         builder: (context) => CategorySeeAllScreen(
                            //                           category: category,
                            //                           items: items,
                            //                         ),
                            //                       ),
                            //                     );
                            //                   },
                            //                   child: Text(
                            //                     "View All",
                            //                     style: TextStyle(
                            //                       fontSize: 16,
                            //                       fontWeight: FontWeight.w600,
                            //                       color: Theme.of(context).primaryColor,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           const SizedBox(height: 8),
                            //           GridView.builder(
                            //             padding: const EdgeInsets.symmetric(horizontal: 16),
                            //             shrinkWrap: true,
                            //             physics: const NeverScrollableScrollPhysics(),
                            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //               crossAxisCount: isLargeScreen ? 4 : 2,
                            //               crossAxisSpacing: 16,
                            //               mainAxisSpacing: 16,
                            //               childAspectRatio: 0.75,
                            //             ),
                            //             itemCount: items.length > (isLargeScreen ? 8 : 4)
                            //                 ? (isLargeScreen ? 8 : 4)
                            //                 : items.length,
                            //             itemBuilder: (context, index) {
                            //               final item = items[index];
                            //               final productDetails = item['productDetails'] ?? {};
                            //
                            //               return _buildProductCard(context, item, productDetails);
                            //             },
                            //           ),
                            //           const SizedBox(height: 16),
                            //         ],
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),

                            // products

                            // Replace your current GridView.builder with this:
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                String category = categories[index];
                                List<Map<String, dynamic>> items = itemsByCategory[category]!;

                                // Sort items by timestamp (newest first)
                                items.sort((a, b) {
                                  Timestamp? timestampA = a['timestamp'] as Timestamp?;
                                  Timestamp? timestampB = b['timestamp'] as Timestamp?;
                                  return timestampB?.compareTo(timestampA ?? Timestamp.now()) ?? 0;
                                });

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Category Header
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            category,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => WebCategorySeeAllScreen(
                                                    category: category,
                                                    items: items,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "View All",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.deepOrange,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 14,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Grid of Products (image in container, text below)
                                    GridView.count(
                                      crossAxisCount: 4,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.55,
                                      children: List.generate(
                                        items.length > 4 ? 4 : items.length,
                                            (index) {
                                          final item = items[index];
                                          final productDetails = item['productDetails'] ?? {};
                                          double price = double.tryParse(productDetails['Price']?.toString() ?? '0') ?? 0;
                                          double offerPrice = double.tryParse(productDetails['Offer Price']?.toString() ?? '0') ?? 0;
                                          int discount = price > 0 ? ((price - offerPrice) / price * 100).round() : 0;

                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => WebParticularProductDetailsScreen(
                                                    productId: item['id'],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Container with just image
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius.circular(12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.1),
                                                        spreadRadius: 1,
                                                        blurRadius: 3,
                                                        offset: const Offset(0, 1),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      AspectRatio(
                                                        aspectRatio: 1,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(12),
                                                          child: item['images'] != null && item['images'].isNotEmpty
                                                              ? Image.network(
                                                            item['images'][0],
                                                            fit: BoxFit.cover,
                                                          )
                                                              : Container(
                                                            color: Colors.grey[100],
                                                            child: const Center(
                                                              child: Icon(Icons.image_not_supported, color: Colors.grey),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (discount > 0)
                                                        Positioned(
                                                          top: 6,
                                                          left: 6,
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                            decoration: BoxDecoration(
                                                              color: Colors.redAccent,
                                                              borderRadius: BorderRadius.circular(4),
                                                            ),
                                                            child: Text(
                                                              '$discount% OFF',
                                                              style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 10,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),

                                                const SizedBox(height: 8),

                                                // Text Below Container
                                                Text(
                                                  item['name'] ?? 'No Name',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.black87,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  item['brandName'] ?? 'No Brand',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[600],
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '₹${productDetails['Offer Price'] ?? '0'}',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.deepOrange,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    if (productDetails['Price'] != null &&
                                                        productDetails['Price'] != productDetails['Offer Price'])
                                                      Text(
                                                        '₹${productDetails['Price']}',
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey,
                                                          decoration: TextDecoration.lineThrough,
                                                        ),
                                                      ),

                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                  ],
                                );

                              },
                            ),
                            const WebFooterSection(),


                          ]
                      )
                  );
                },
              );
            }
        )

    );
  }

  Stream<List<Map<String, dynamic>>> _getProductsStream(List<QueryDocumentSnapshot> sellers) {
    // Combine all streams from different sellers and categories
    final allStreams = <Stream<List<Map<String, dynamic>>>>[];

    for (final seller in sellers) {
      final sellerId = seller.id;
      final categories = [
        'Clothing',
        'Electronics',
        'Footwear',
        'Accessories',
        'Home Appliances',
        'Books',
        'Vegetables'
      ];

      // Create streams for each category
      for (final category in categories) {
        final stream = FirebaseFirestore.instance
            .collection('seller')
            .doc(sellerId)
            .collection(category)
            .snapshots()
            .asyncMap((snapshot) {
          return snapshot.docs.map((doc) {
            return {
              ...doc.data(),
              'sellerId': sellerId,
              'category': category,
              'id': doc.id,
            };
          }).where((item) {
            // Filter out items with zero quantity
            final productDetails = item['productDetails'] ?? {};
            final quantity = int.tryParse(productDetails['Quantity']?.toString() ?? '1') ?? 1;
            return quantity > 0;
          }).toList();
        });
        allStreams.add(stream);
      }

      // Add offers stream
      final offersStream = FirebaseFirestore.instance
          .collection('seller')
          .doc(sellerId)
          .collection('offers')
          .snapshots()
          .asyncMap((snapshot) {
        return snapshot.docs.map((doc) {
          return {
            ...doc.data(),
            'sellerId': sellerId,
            'id': doc.id,
          };
        }).where((item) {
          // Filter out offers with zero quantity
          final productDetails = item['productDetails'] ?? {};
          final quantity = int.tryParse(productDetails['Quantity']?.toString() ?? '1') ?? 1;
          return quantity > 0;
        }).toList();
      });
      allStreams.add(offersStream);
    }

    // Combine all streams
    return StreamZip(allStreams).map((listOfLists) {
      return listOfLists.expand((list) => list).toList();
    });
  }





  // Widget buildWebStyleAppBar(BuildContext context) {
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         // Left: Logo stacked above App Name
  //         Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Image.asset(
  //               'assets/images/Sadhana_cart1.png',
  //               height: 55,
  //               width: 55,
  //               fit: BoxFit.contain,
  //             ),
  //             const SizedBox(height: 2),
  //             const Text(
  //               'SadhanaCart',
  //               style: TextStyle(
  //                 color: Colors.deepOrange,
  //                 fontSize: 23,
  //                 fontWeight: FontWeight.bold,
  //                 letterSpacing: 1.2,
  //               ),
  //             ),
  //           ],
  //         ),
  //
  //         const Spacer(),
  //
  //         // Center: Navigation Links
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             _buildNavText('Home', context, onTap: null, isActive: true),
  //             _buildNavText('Categories', context, onTap: () {
  //               Navigator.push(context, MaterialPageRoute(builder: (_) => CategoriesTab()));
  //             }),
  //             _buildNavText('Orders', context, onTap: () {
  //               Navigator.push(context, MaterialPageRoute(builder: (_) => const ExploreTab()));
  //             }),
  //             _buildNavText('Profile', context, onTap: () {
  //               Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileTab()));
  //             }),
  //           ],
  //         ),
  //
  //         const Spacer(),
  //
  //         // Right: Icons (Search & Cart)
  //         Row(
  //           children: [
  //             IconButton(
  //               icon: const Icon(Icons.search, color: Colors.grey, size: 35),
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (_) => const SearchScreen(searchQuery: '')),
  //                 );
  //               },
  //             ),
  //             const SizedBox(width: 15),
  //             IconButton(
  //               icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 35),
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (_) => const CartTab()),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildWebStyleAppBar(BuildContext context, Function(int) onTabSelected, int currentIndex) {
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         // Logo stacked above text
  //         Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Image.asset(
  //               'assets/images/Sadhana_cart1.png',
  //               height: 55,
  //               width: 55,
  //               fit: BoxFit.contain,
  //             ),
  //             const SizedBox(height: 2),
  //             const Text(
  //               'SadhanaCart',
  //               style: TextStyle(
  //                 color: Colors.deepOrange,
  //                 fontSize: 23,
  //                 fontWeight: FontWeight.bold,
  //                 letterSpacing: 1.2,
  //               ),
  //             ),
  //           ],
  //         ),
  //
  //         const Spacer(),
  //
  //         // Center Nav
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             _buildNavText('Home', 0, currentIndex, onTabSelected),
  //             _buildNavText('Categories', 1, currentIndex, onTabSelected),
  //             _buildNavText('Orders', 2, currentIndex, onTabSelected),
  //             _buildNavText('Profile', 3, currentIndex, onTabSelected),
  //           ],
  //         ),
  //
  //         const Spacer(),
  //
  //         // Icons (Search & Cart)
  //         Row(
  //           children: [
  //             IconButton(
  //               icon: const Icon(Icons.search, color: Colors.grey, size: 35),
  //               onPressed: () {
  //                 onTabSelected(5); // Optional: index for search screen
  //               },
  //             ),
  //             const SizedBox(width: 15),
  //             IconButton(
  //               icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 35),
  //               onPressed: () {
  //                 onTabSelected(4); // Navigate to cart
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  //
  // Widget _buildNavText(String title, int index, int currentIndex, Function(int) onTap) {
  //   final bool isActive = index == currentIndex;
  //
  //   return GestureDetector(
  //     onTap: () => onTap(index),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 14),
  //       child: Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.w600,
  //           color: isActive ? Colors.deepOrange : Colors.grey[800],
  //         ),
  //       ),
  //     ),
  //   );
  // }





  // chat gpt final good output


  // Widget _buildWebProductCard(
  //     BuildContext context, Map<String, dynamic> product, Map<String, dynamic> details) {
  //   final String name = product['name'] ?? 'Unnamed Product';
  //   final List<dynamic> images = product['images'] ?? [];
  //   final String offerPrice = details['Offer Price']?.toString() ?? '';
  //   final String originalPrice = details['Original Price']?.toString() ?? '';
  //
  //   return TweenAnimationBuilder<double>(
  //     duration: const Duration(milliseconds: 300),
  //     tween: Tween<double>(begin: 0.95, end: 1),
  //     curve: Curves.easeOut,
  //     builder: (context, scale, child) {
  //       return Transform.scale(
  //         scale: scale,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             // Product Image Card
  //             Stack(
  //               children: [
  //                 Card(
  //                   elevation: 4,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                   clipBehavior: Clip.antiAlias,
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(12),
  //                     child: images.isNotEmpty
  //                         ? Image.network(
  //                       images[0],
  //                       height: 180,
  //                       width: double.infinity,
  //                       fit: BoxFit.cover,
  //                     )
  //                         : Container(
  //                       height: 180,
  //                       width: double.infinity,
  //                       color: Colors.grey[300],
  //                       child: const Icon(Icons.image_not_supported),
  //                     ),
  //                   ),
  //                 ),
  //
  //                 // SALE Badge
  //                 if (originalPrice != offerPrice && originalPrice.isNotEmpty)
  //                   Positioned(
  //                     top: 8,
  //                     left: 8,
  //                     child: Container(
  //                       padding:
  //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  //                       decoration: BoxDecoration(
  //                         color: Colors.pinkAccent,
  //                         borderRadius: BorderRadius.circular(20),
  //                       ),
  //                       child: const Text(
  //                         'SALE',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 10,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //             ),
  //
  //             const SizedBox(height: 8),
  //
  //             // Product Name
  //             Text(
  //               name,
  //               textAlign: TextAlign.start,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 14.5,
  //                 color: Colors.black87,
  //               ),
  //             ),
  //             const SizedBox(height: 4),
  //
  //             // Price Row
  //             Row(
  //               children: [
  //                 Text(
  //                   '₹$offerPrice',
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 14.5,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 const SizedBox(width: 6),
  //                 if (originalPrice.isNotEmpty && offerPrice != originalPrice)
  //                   Text(
  //                     '₹$originalPrice',
  //                     style: const TextStyle(
  //                       fontSize: 13,
  //                       color: Colors.grey,
  //                       decoration: TextDecoration.lineThrough,
  //                     ),
  //                   ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }








  Widget _buildDealsOfTheDay(BuildContext context, List<Map<String, dynamic>> items, bool isLargeScreen) {
    // Filter items with discounts
    List<Map<String, dynamic>> discountedItems = items.where((item) {
      final productDetails = item['productDetails'] ?? {};
      return productDetails['Price'] != null &&
          productDetails['Offer Price'] != null &&
          productDetails['Price'] != productDetails['Offer Price'];
    }).toList();

    // Sort by discount percentage (highest first)
    discountedItems.sort((a, b) {
      final aDetails = a['productDetails'] ?? {};
      final bDetails = b['productDetails'] ?? {};
      double aPrice = double.tryParse(aDetails['Price']?.toString() ?? '0') ?? 0;
      double aOffer = double.tryParse(aDetails['Offer Price']?.toString() ?? '0') ?? 0;
      double bPrice = double.tryParse(bDetails['Price']?.toString() ?? '0') ?? 0;
      double bOffer = double.tryParse(bDetails['Offer Price']?.toString() ?? '0') ?? 0;

      double aDiscount = aPrice > 0 ? ((aPrice - aOffer) / aPrice * 100) : 0;
      double bDiscount = bPrice > 0 ? ((bPrice - bOffer) / bPrice * 100) : 0;

      return bDiscount.compareTo(aDiscount);
    });

    if (discountedItems.isEmpty) {
      return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Deals of the Day',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: isLargeScreen ? 280 : 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: discountedItems.length > 10 ? 10 : discountedItems.length,
              itemBuilder: (context, index) {
                final item = discountedItems[index];
                final productDetails = item['productDetails'] ?? {};
                double price = double.tryParse(productDetails['Price']?.toString() ?? '0') ?? 0;
                double offerPrice = double.tryParse(productDetails['Offer Price']?.toString() ?? '0') ?? 0;
                int discount = price > 0 ? ((price - offerPrice) / price * 100).round() : 0;

                return Container(
                  width: isLargeScreen ? 180 : 160,
                  margin: const EdgeInsets.only(right: 16),
                  child: _buildProductCard(context, item, productDetails, showDiscount: true),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> item,
      Map<String, dynamic> productDetails, {bool showDiscount = false}) {
    double price = double.tryParse(productDetails['Price']?.toString() ?? '0') ?? 0;
    double offerPrice = double.tryParse(productDetails['Offer Price']?.toString() ?? '0') ?? 0;
    int discount = price > 0 ? ((price - offerPrice) / price * 100).round() : 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebParticularProductDetailsScreen(
              productId: item['id'],
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Discount Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8)),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: item['images'] != null && item['images'].isNotEmpty
                        ? Image.network(
                      item['images'][0],
                      fit: BoxFit.contain,
                    )
                        : const Center(
                      child: Icon(Icons.image_not_supported, size: 40),
                    ),
                  ),
                ),
                if (showDiscount && discount > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '$discount% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] ?? 'No Name',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['brandName'] ?? 'No Brand',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${productDetails['Offer Price'] ?? '0'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (productDetails['Price'] != null &&
                          productDetails['Price'] !=
                              productDetails['Offer Price'])
                        Text(
                          '₹${productDetails['Price']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (!showDiscount && discount > 0)
                    Text(
                      '$discount% off',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<List<Map<String, dynamic>>> _fetchAllSellerItems(
  //     List<QueryDocumentSnapshot> sellers) async {
  //   List<Map<String, dynamic>> allItems = [];
  //
  //   for (var seller in sellers) {
  //     String sellerId = seller.id;
  //
  //     // Fetch regular products
  //     var categories = [
  //       'Clothing',
  //       'Electronics',
  //       'Footwear',
  //       'Accessories',
  //       'Home Appliances',
  //       'Books',
  //       'Vegetables'
  //     ];
  //
  //     for (var category in categories) {
  //       try {
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
  //             'id': doc.id,
  //           });
  //         }
  //       } catch (e) {
  //         print('Error fetching $category for seller $sellerId: $e');
  //       }
  //     }
  //
  //     // Fetch offers
  //     try {
  //       var offersSnapshot = await FirebaseFirestore.instance
  //           .collection('seller')
  //           .doc(sellerId)
  //           .collection('offers')
  //           .orderBy('uploadedAt', descending: true)
  //           .get();
  //
  //       for (var offerDoc in offersSnapshot.docs) {
  //         allItems.add({
  //           ...offerDoc.data(),
  //           'sellerId': sellerId,
  //           'id': offerDoc.id,
  //         });
  //       }
  //     } catch (e) {
  //       print('Error fetching offers for seller $sellerId: $e');
  //     }
  //   }
  //
  //   return allItems;
  // }


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
            var data = doc.data();
            // Check if product has quantity and it's greater than 0
            if ((data['productDetails']?['Quantity'] == null) ||
                (int.tryParse(data['productDetails']?['Quantity']?.toString() ?? '0') ?? 0) > 0) {
              allItems.add({
                ...data,
                'sellerId': sellerId,
                'category': category,
                'id': doc.id,
              });
            }
          }
        } catch (e) {
          print('Error fetching $category for seller $sellerId: $e');
        }
      }

      // Fetch offers - also check quantity for offers
      try {
        var offersSnapshot = await FirebaseFirestore.instance
            .collection('seller')
            .doc(sellerId)
            .collection('offers')
            .orderBy('uploadedAt', descending: true)
            .get();

        for (var offerDoc in offersSnapshot.docs) {
          var data = offerDoc.data();
          // Check if product has quantity and it's greater than 0
          if ((data['productDetails']?['Quantity'] == null) ||
              (int.tryParse(data['productDetails']?['Quantity']?.toString() ?? '0') ?? 0) > 0) {
            allItems.add({
              ...data,
              'sellerId': sellerId,
              'id': offerDoc.id,
            });
          }
        }
      } catch (e) {
        print('Error fetching offers for seller $sellerId: $e');
      }
    }

    return allItems;
  }


  Stream<List<Map<String, dynamic>>> _getFilteredProductsStream() {
    return FirebaseFirestore.instance.collection('seller').snapshots().asyncMap((sellersSnapshot) {
      return _fetchAllSellerItems(sellersSnapshot.docs).then((allItems) {
        // Filter out items with zero quantity
        return allItems.where((item) {
          final productDetails = item['productDetails'] ?? {};
          final quantityStr = productDetails['Quantity']?.toString() ?? '1';
          final quantity = int.tryParse(quantityStr) ?? 1;
          return quantity > 0;
        }).toList();
      });
    });
  }

}

Widget _buildBannersCarousel(
    BuildContext context, List<DocumentSnapshot> banners, bool isLargeScreen) {
  final screenWidth = MediaQuery.of(context).size.width;

  return CarouselSlider.builder(
    itemCount: banners.length,
    options: CarouselOptions(
      height: 440,               // Full banner height
      autoPlay: true,
      enlargeCenterPage: false, // Disable zoom effect
      viewportFraction: 1.0,    // 🔥 Show only one banner at a time
      autoPlayInterval: const Duration(seconds: 4),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      padEnds: false,
    ),
    itemBuilder: (context, index, realIndex) {
      final banner = banners[index];
      return _buildBannerItem(context, banner, index, screenWidth);
    },
  );
}

Widget _buildBannerItem(
    BuildContext context, DocumentSnapshot banner, int index, double screenWidth) {
  final imageUrl = banner['imageUrl'] as String?;
  final percentage = banner['percentage'] as int?;
  final category = banner['category'] as String?;

  return GestureDetector(
    onTap: () {
      if (category != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebBannerProductsPage(
              category: category,
              discountPercentage: percentage ?? 0,
            ),
          ),
        );
      }
    },
    child: SizedBox(
      width: screenWidth,
      height: 540, // Match Carousel height
      child: imageUrl != null
          ? Image.network(
        imageUrl,
        fit: BoxFit.fill, // 📷 Display clean full image (not zoomed)
        width: double.infinity,
        height: double.infinity,
      )
          : Container(

        color: Colors.grey[200],
        child: const Center(
          child: Icon(
            Icons.broken_image,
            size: 50,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}

class WebBannerProductsPage extends StatelessWidget {
  final String category;
  final int discountPercentage;

  const WebBannerProductsPage({
    required this.category,
    required this.discountPercentage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text('$category - $discountPercentage% OFF'),
      ),
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
            future: _fetchDiscountedProducts(
              snapshot.data!.docs,
              category,
              discountPercentage,
            ),
            builder: (context, itemSnapshot) {
              if (itemSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (itemSnapshot.hasError) {
                return Center(child: Text('Error: ${itemSnapshot.error}'));
              }

              if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
                return Center(
                  child: Text('No discounted products found in $category'),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isLargeScreen ? 4 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: itemSnapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = itemSnapshot.data![index];
                  final productDetails = item['productDetails'] ?? {};
                  double price = double.tryParse(productDetails['Price']?.toString() ?? '0') ?? 0;
                  double offerPrice = double.tryParse(productDetails['Offer Price']?.toString() ?? '0') ?? 0;
                  int discount = price > 0 ? ((price - offerPrice) / price * 100).round() : 0;

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image with Discount Badge
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8)),
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                color: Colors.grey[100],
                                child: item['images'] != null && item['images'].isNotEmpty
                                    ? Image.network(
                                  item['images'][0],
                                  fit: BoxFit.contain,
                                )
                                    : const Center(
                                  child: Icon(Icons.image_not_supported, size: 40),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '$discount% OFF',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] ?? 'No Name',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['brandName'] ?? 'No Brand',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    '₹${productDetails['Offer Price'] ?? '0'}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (productDetails['Price'] != null &&
                                      productDetails['Price'] !=
                                          productDetails['Offer Price'])
                                    Text(
                                      '₹${productDetails['Price']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebParticularProductDetailsScreen(
                                          productId: item['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'View Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),

    );
  }

  // Future<List<Map<String, dynamic>>> _fetchDiscountedProducts(
  //     List<QueryDocumentSnapshot> sellers,
  //     String category,
  //     int discountPercentage,
  //     ) async {
  //   List<Map<String, dynamic>> discountedItems = [];
  //
  //   for (var seller in sellers) {
  //     String sellerId = seller.id;
  //
  //     try {
  //       var snapshot = await FirebaseFirestore.instance
  //           .collection('seller')
  //           .doc(sellerId)
  //           .collection(category)
  //           .get();
  //
  //       for (var doc in snapshot.docs) {
  //         final data = doc.data();
  //         if (data['productDetails'] != null) {
  //           final productDetails = data['productDetails'] as Map<String, dynamic>;
  //           if (productDetails['Price'] != null &&
  //               productDetails['Offer Price'] != null) {
  //             final price = double.parse(productDetails['Price'].toString());
  //             final offerPrice =
  //             double.parse(productDetails['Offer Price'].toString());
  //             final calculatedDiscount = _calculateDiscountPercentage(price, offerPrice);
  //
  //             if (calculatedDiscount >= discountPercentage) {
  //               discountedItems.add({
  //                 ...data,
  //                 'sellerId': sellerId,
  //                 'category': category,
  //                 'id': doc.id,
  //               });
  //             }
  //           }
  //         }
  //       }
  //     } catch (e) {
  //       print('Error fetching $category for seller $sellerId: $e');
  //     }
  //   }
  //
  //   return discountedItems;
  // }


  Future<List<Map<String, dynamic>>> _fetchDiscountedProducts(
      List<QueryDocumentSnapshot> sellers,
      String category,
      int discountPercentage,
      ) async {
    List<Map<String, dynamic>> discountedItems = [];

    for (var seller in sellers) {
      String sellerId = seller.id;

      try {
        var snapshot = await FirebaseFirestore.instance
            .collection('seller')
            .doc(sellerId)
            .collection(category)
            .get();

        for (var doc in snapshot.docs) {
          final data = doc.data();
          if (data['productDetails'] != null) {
            final productDetails = data['productDetails'] as Map<String, dynamic>;
            // Check quantity first
            final quantity = int.tryParse(productDetails['Quantity']?.toString() ?? '0') ?? 0;
            if (quantity <= 0) continue;

            if (productDetails['Price'] != null &&
                productDetails['Offer Price'] != null) {
              final price = double.parse(productDetails['Price'].toString());
              final offerPrice =
              double.parse(productDetails['Offer Price'].toString());
              final calculatedDiscount = _calculateDiscountPercentage(price, offerPrice);

              if (calculatedDiscount >= discountPercentage) {
                discountedItems.add({
                  ...data,
                  'sellerId': sellerId,
                  'category': category,
                  'id': doc.id,
                });
              }
            }
          }
        }
      } catch (e) {
        print('Error fetching $category for seller $sellerId: $e');
      }
    }

    return discountedItems;
  }



  int _calculateDiscountPercentage(double originalPrice, double offerPrice) {
    if (originalPrice <= 0) return 0;
    return ((originalPrice - offerPrice) / originalPrice * 100).round();
  }


}








