// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class SellerHomeScreen extends StatefulWidget {
//   @override
//   _SellerHomeScreenState createState() => _SellerHomeScreenState();
// }
//
// class _SellerHomeScreenState extends State<SellerHomeScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Maps to store clothing and footwear items grouped by color
//   Map<String, List<Map<String, dynamic>>> _groupedClothingsByColor = {};
//   Map<String, List<Map<String, dynamic>>> _groupedFootwearsByColor = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchClothingItems();
//     _fetchFootwearItems();
//   }
//
//   Future<void> _fetchClothingItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Clothings')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             // Extracting first available size's price and offer price
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'name': doc['name'],
//               'images': colorData['images'], // Images for this color
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedClothingsByColor = groupedByColor;
//         });
//       }
//     } catch (e) {
//       print('Error fetching clothing items: $e');
//     }
//   }
//
//   Future<void> _fetchFootwearItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Footwears')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             // Extracting first available size's price and offer price
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'name': doc['name'],
//               'images': colorData['images'], // Images for this color
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedFootwearsByColor = groupedByColor;
//         });
//       }
//     } catch (e) {
//       print('Error fetching footwear items: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _groupedClothingsByColor.isEmpty && _groupedFootwearsByColor.isEmpty
//           ? Center(child: Text('No items found.'))
//           : SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display Clothing Items
//             if (_groupedClothingsByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Clothings',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Column(
//                 children: _groupedClothingsByColor.entries.map((entry) {
//                   String color = entry.key;
//                   List<Map<String, dynamic>> items = entry.value;
//
//                   return Column(
//                     children: [
//                       // Image Outside the Container
//                       if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                         Container(
//                           height: 150, // Adjust height as needed
//                           width: 120, // Adjust width as needed
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                               image: NetworkImage(items[0]['images'][0]),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       SizedBox(height: 10),
//
//                       // Container for Name & Prices
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             items[0]['name'],
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             'Rs ${items[0]['price']}',
//                             style: TextStyle(fontSize: 14, color: Colors.red),
//                           ),
//                           Text(
//                             'Rs ${items[0]['offerPrice']}',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.green,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ],
//
//             // Display Footwear Items
//             if (_groupedFootwearsByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Footwears',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 250,
//                   autoPlay: false,
//                   enlargeCenterPage: false,
//                   viewportFraction: 0.8,
//                 ),
//                 items: _groupedFootwearsByColor.entries.map((entry) {
//                   String color = entry.key;
//                   List<Map<String, dynamic>> items = entry.value;
//
//                   return Container(
//                     margin: EdgeInsets.symmetric(horizontal: 5.0),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                           Image.network(
//                             items[0]['images'][0],
//                             width: double.infinity,
//                             height: 150,
//                             fit: BoxFit.cover,
//                           ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 items[0]['name'],
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Rs ${items[0]['price']}',
//                                 style: TextStyle(fontSize: 14, color: Colors.red),
//                               ),
//                               Text(
//                                 '${items[0]['offerPrice']}',
//                                 style: TextStyle(fontSize: 14, color: Colors.green),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// Detailed Page for Clothing Item
// class ClothingDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> item;
//
//   ClothingDetailsScreen({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(item['name']),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (item['images'].isNotEmpty)
//               Column(
//                 children: item['images'].map<Widget>((image) {
//                   return Image.network(
//                     image,
//                     width: double.infinity,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   );
//                 }).toList(),
//               ),
//             SizedBox(height: 16),
//             Text(
//               'Name: ${item['name']}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Category: ${item['category']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Shop Name: ${item['shopName']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Brand Name: ${item['brandName']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Description: ${item['description']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Sizes:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ...item['sizes'].map<Widget>((size) {
//               return ListTile(
//                 title: Text('Size: ${size['size']}'),
//                 subtitle: Text(
//                     'Quantity: ${size['quantity']}, Price: Rs${size['price']}'),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Detailed Page for Footwear Item
// class FootwearDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> item;
//
//   FootwearDetailsScreen({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(item['name']),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (item['images'].isNotEmpty)
//               Column(
//                 children: item['images'].map<Widget>((image) {
//                   return Image.network(
//                     image,
//                     width: double.infinity,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   );
//                 }).toList(),
//               ),
//             SizedBox(height: 16),
//             Text(
//               'Name: ${item['name']}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Category: ${item['category']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Shop Name: ${item['shopName']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Brand Name: ${item['brandName']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Description: ${item['description']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Sizes:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ...item['sizes'].map<Widget>((size) {
//               return ListTile(
//                 title: Text('Size: ${size['size']}'),
//                 subtitle: Text(
//                     'Quantity: ${size['quantity']}, Price: \$${size['price']}'),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// main code with good working

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class SellerHomeScreen extends StatefulWidget {
//   @override
//   _SellerHomeScreenState createState() => _SellerHomeScreenState();
// }
//
// class _SellerHomeScreenState extends State<SellerHomeScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Map<String, List<Map<String, dynamic>>> _groupedClothingsByColor = {};
//   Map<String, List<Map<String, dynamic>>> _groupedFootwearsByColor = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchClothingItems();
//     _fetchFootwearItems();
//   }
//
//   Future<void> _fetchClothingItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Clothings')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'Brand Name': doc['Brand Name'],
//               'category': doc['category'],
//               'colors': doc['colors'],
//               'description': doc['description'],
//               'name': doc['name'],
//               'shop Name': doc['shop Name'],
//               'images': colorData['images'],
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedClothingsByColor = groupedByColor;
//         });
//       }
//     } catch (e) {
//       print('Error fetching clothing items: $e');
//     }
//   }
//
//   Future<void> _fetchFootwearItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Footwears')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'Brand Name': doc['Brand Name'],
//               'category': doc['category'],
//               'colors': doc['colors'],
//               'description': doc['description'],
//               'name': doc['name'],
//               'shop Name': doc['shop Name'],
//               'images': colorData['images'],
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedFootwearsByColor = groupedByColor;
//         });
//       }
//     } catch (e) {
//       print('Error fetching footwear items: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _groupedClothingsByColor.isEmpty && _groupedFootwearsByColor.isEmpty
//           ? Center(child: Text('No items found.'))
//           : SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (_groupedClothingsByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Clothings',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Column(
//                 children: _groupedClothingsByColor.entries.map((entry) {
//                   String color = entry.key;
//                   List<Map<String, dynamic>> items = entry.value;
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ItemDetailScreen(itemDetails: items[0]),
//                         ),
//                       );
//                     },
//                     child: Column(
//                       children: [
//                         if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                           Container(
//                             height: 150,
//                             width: 120,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 image: NetworkImage(items[0]['images'][0]),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         SizedBox(height: 10),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               items[0]['name'],
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               'Rs ${items[0]['price']}',
//                               style: TextStyle(fontSize: 14, color: Colors.red),
//                             ),
//                             Text(
//                               'Rs ${items[0]['offerPrice']}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.green,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//
//             if (_groupedFootwearsByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Footwears',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 250,
//                   autoPlay: false,
//                   enlargeCenterPage: false,
//                   viewportFraction: 0.8,
//                 ),
//                 items: _groupedFootwearsByColor.entries.map((entry) {
//                   String color = entry.key;
//                   List<Map<String, dynamic>> items = entry.value;
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ItemDetailScreen(itemDetails: items[0]),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 5.0),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                             Image.network(
//                               items[0]['images'][0],
//                               width: double.infinity,
//                               height: 150,
//                               fit: BoxFit.cover,
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   items[0]['name'],
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   'Rs ${items[0]['price']}',
//                                   style: TextStyle(fontSize: 14, color: Colors.red),
//                                 ),
//                                 Text(
//                                   '${items[0]['offerPrice']}',
//                                   style: TextStyle(fontSize: 14, color: Colors.green),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
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
// class ItemDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> itemDetails;
//
//   ItemDetailScreen({required this.itemDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(itemDetails['name']),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Display Brand Name
//               if (itemDetails['Brand Name'] != null)
//                 Text(
//                   'Brand: ${itemDetails['Brand Name']}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               SizedBox(height: 8),
//
//               // Display Category
//               if (itemDetails['category'] != null)
//                 Text(
//                   'Category: ${itemDetails['category']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 8),
//
//               // Display Shop Name
//               if (itemDetails['shop Name'] != null)
//                 Text(
//                   'Shop: ${itemDetails['shop Name']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Images
//               if (itemDetails['images'] != null && itemDetails['images'].isNotEmpty)
//                 Image.network(
//                   itemDetails['images'][0],
//                   width: double.infinity,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               SizedBox(height: 16),
//
//               // Display Description
//               if (itemDetails['description'] != null)
//                 Text(
//                   'Description: ${itemDetails['description']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Sizes
//               if (itemDetails['colors'] != null &&
//                   itemDetails['colors'].isNotEmpty &&
//                   itemDetails['colors'][0]['sizes'].isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Sizes:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     ...itemDetails['colors'][0]['sizes'].map<Widget>((size) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Size: ${size['size']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             'Price: Rs ${size['price']}',
//                             style: TextStyle(fontSize: 16, color: Colors.red),
//                           ),
//                           Text(
//                             'Offer Price: Rs ${size['offerPrice']}',
//                             style: TextStyle(fontSize: 16, color: Colors.green),
//                           ),
//                           Text(
//                             'Quantity: ${size['quantity']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Divider(),
//                         ],
//                       );
//                     }).toList(),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// with frontend

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:video_player/video_player.dart';
//
// class SellerHomeScreen extends StatefulWidget {
//   @override
//   _SellerHomeScreenState createState() => _SellerHomeScreenState();
// }
//
// class _SellerHomeScreenState extends State<SellerHomeScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Map<String, List<Map<String, dynamic>>> _groupedClothingsByColor = {};
//   Map<String, List<Map<String, dynamic>>> _groupedFootwearsByColor = {};
//   Map<String, List<Map<String, dynamic>>> _groupedMobilesByColor = {};
//
//   bool _isLoading = true; // Loading state
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchClothingItems();
//     _fetchFootwearItems();
//     _fetchMobilesItems();
//   }
//
//   Future<void> _fetchClothingItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Clothing')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'Brand Name': doc['Brand Name'],
//               'category': doc['category'],
//               'colors': doc['colors'],
//               'description': doc['description'],
//               'name': doc['name'],
//               'shop Name': doc['shop Name'],
//               'images': colorData['images'],
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedClothingsByColor = groupedByColor;
//           _isLoading = false; // Stop loading
//         });
//       }
//     } catch (e) {
//       print('Error fetching clothing items: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _fetchFootwearItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Footwear')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'Brand Name': doc['Brand Name'],
//               'category': doc['category'],
//               'colors': doc['colors'],
//               'description': doc['description'],
//               'name': doc['name'],
//               'shop Name': doc['shop Name'],
//               'images': colorData['images'],
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedFootwearsByColor = groupedByColor;
//           _isLoading = false; // Stop loading
//         });
//       }
//     } catch (e) {
//       print('Error fetching footwear items: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//
//   Future<void> _fetchMobilesItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Mobiles')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'Brand Name': doc['Brand Name'],
//               'category': doc['category'],
//               'colors': doc['colors'],
//               'description': doc['description'],
//               'name': doc['name'],
//               'shop Name': doc['shop Name'],
//               'images': colorData['images'],
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedMobilesByColor = groupedByColor;
//           _isLoading = false; // Stop loading
//         });
//       }
//     } catch (e) {
//       print('Error fetching Mobile items: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('My Products'),
//       //   backgroundColor: Colors.blue,
//       //   elevation: 0,
//       // ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator()) // Show loader while fetching
//           : _groupedClothingsByColor.isEmpty && _groupedFootwearsByColor.isEmpty && _groupedMobilesByColor.isEmpty
//           ? Center(child: Text('No items found.'))
//           : SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (_groupedClothingsByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Clothings',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 204,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _groupedClothingsByColor.length,
//                   itemBuilder: (context, index) {
//                     String color = _groupedClothingsByColor.keys.elementAt(index);
//                     List<Map<String, dynamic>> items = _groupedClothingsByColor[color]!;
//
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ItemDetailScreen(itemDetails: items[0]),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: 150,
//                         margin: EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.3),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                                 child: Image.network(
//                                   items[0]['images'][0],
//                                   height: 120,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     items[0]['name'],
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     'Rs ${items[0]['price']}',
//                                     style: TextStyle(fontSize: 14, color: Colors.red),
//                                   ),
//                                   Text(
//                                     'Rs ${items[0]['offerPrice']}',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.green,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//
//
//
//             // if (_groupedFootwearsByColor.isNotEmpty) ...[
//             //   Padding(
//             //     padding: const EdgeInsets.all(16.0),
//             //     child: Text(
//             //       'Footwears',
//             //       style: TextStyle(
//             //         fontSize: 24,
//             //         fontWeight: FontWeight.bold,
//             //         color: Colors.blue,
//             //       ),
//             //     ),
//             //   ),
//             //   CarouselSlider(
//             //     options: CarouselOptions(
//             //       height: 250,
//             //       autoPlay: true,
//             //       enlargeCenterPage: true,
//             //       viewportFraction: 0.8,
//             //     ),
//             //     items: _groupedFootwearsByColor.entries.map((entry) {
//             //       String color = entry.key;
//             //       List<Map<String, dynamic>> items = entry.value;
//             //
//             //       return GestureDetector(
//             //         onTap: () {
//             //           Navigator.push(
//             //             context,
//             //             MaterialPageRoute(
//             //               builder: (context) => ItemDetailScreen(itemDetails: items[0]),
//             //             ),
//             //           );
//             //         },
//             //         child: Container(
//             //           margin: EdgeInsets.symmetric(horizontal: 5.0),
//             //           decoration: BoxDecoration(
//             //             color: Colors.white,
//             //             borderRadius: BorderRadius.circular(10),
//             //             boxShadow: [
//             //               BoxShadow(
//             //                 color: Colors.grey.withOpacity(0.3),
//             //                 spreadRadius: 2,
//             //                 blurRadius: 5,
//             //                 offset: Offset(0, 3),
//             //               ),
//             //             ],
//             //           ),
//             //           child: Column(
//             //             crossAxisAlignment: CrossAxisAlignment.start,
//             //             children: [
//             //               if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//             //                 ClipRRect(
//             //                   borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//             //                   child: Image.network(
//             //                     items[0]['images'][0],
//             //                     width: double.infinity,
//             //                     height: 150,
//             //                     fit: BoxFit.cover,
//             //                   ),
//             //                 ),
//             //               Padding(
//             //                 padding: const EdgeInsets.all(8.0),
//             //                 child: Column(
//             //                   crossAxisAlignment: CrossAxisAlignment.start,
//             //                   children: [
//             //                     Text(
//             //                       items[0]['name'],
//             //                       style: TextStyle(
//             //                         fontSize: 16,
//             //                         fontWeight: FontWeight.bold,
//             //                       ),
//             //                     ),
//             //                     SizedBox(height: 8),
//             //                     Text(
//             //                       'Rs ${items[0]['price']}',
//             //                       style: TextStyle(fontSize: 14, color: Colors.red),
//             //                     ),
//             //                     Text(
//             //                       'Rs ${items[0]['offerPrice']}',
//             //                       style: TextStyle(
//             //                         fontSize: 14,
//             //                         color: Colors.green,
//             //                         decoration: TextDecoration.lineThrough,
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       );
//             //     }).toList(),
//             //   ),
//             // ],
//
//             if (_groupedFootwearsByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Footwear',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 204,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _groupedFootwearsByColor.length,
//                   itemBuilder: (context, index) {
//                     String color = _groupedFootwearsByColor.keys.elementAt(index);
//                     List<Map<String, dynamic>> items = _groupedFootwearsByColor[color]!;
//
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ItemDetailScreen(itemDetails: items[0]),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: 150,
//                         margin: EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.3),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                                 child: Image.network(
//                                   items[0]['images'][0],
//                                   height: 120,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     items[0]['name'],
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     'Rs ${items[0]['price']}',
//                                     style: TextStyle(fontSize: 14, color: Colors.red),
//                                   ),
//                                   Text(
//                                     'Rs ${items[0]['offerPrice']}',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.green,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//
//             if (_groupedMobilesByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Mobiles',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 204,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _groupedMobilesByColor.length,
//                   itemBuilder: (context, index) {
//                     String color = _groupedMobilesByColor.keys.elementAt(index);
//                     List<Map<String, dynamic>> items = _groupedMobilesByColor[color]!;
//
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ItemDetailScreen(itemDetails: items[0]),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: 150,
//                         margin: EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.3),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                                 child: Image.network(
//                                   items[0]['images'][0],
//                                   height: 120,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     items[0]['name'],
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     'Rs ${items[0]['price']}',
//                                     style: TextStyle(fontSize: 14, color: Colors.red),
//                                   ),
//                                   Text(
//                                     'Rs ${items[0]['offerPrice']}',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.green,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ItemDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> itemDetails;
//
//   ItemDetailScreen({required this.itemDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(itemDetails['name']),
//         backgroundColor: Colors.blue,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Display Brand Name
//               if (itemDetails['Brand Name'] != null)
//                 Text(
//                   'Brand: ${itemDetails['Brand Name']}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               SizedBox(height: 8),
//
//               // Display Category
//               if (itemDetails['category'] != null)
//                 Text(
//                   'Category: ${itemDetails['category']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 8),
//
//               // Display Shop Name
//               if (itemDetails['shop Name'] != null)
//                 Text(
//                   'Shop: ${itemDetails['shop Name']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Images
//               if (itemDetails['images'] != null && itemDetails['images'].isNotEmpty)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     itemDetails['images'][0],
//                     width: double.infinity,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Description
//               if (itemDetails['description'] != null)
//                 Text(
//                   'Description: ${itemDetails['description']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Sizes
//               if (itemDetails['colors'] != null &&
//                   itemDetails['colors'].isNotEmpty &&
//                   itemDetails['colors'][0]['sizes'].isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Sizes:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     ...itemDetails['colors'][0]['sizes'].map<Widget>((size) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Size: ${size['size']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             'Price: Rs ${size['price']}',
//                             style: TextStyle(fontSize: 16, color: Colors.red),
//                           ),
//                           Text(
//                             'Offer Price: Rs ${size['offerPrice']}',
//                             style: TextStyle(fontSize: 16, color: Colors.green),
//                           ),
//                           Text(
//                             'Quantity: ${size['quantity']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Divider(),
//                         ],
//                       );
//                     }).toList(),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ItemDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> itemDetails;
//
//   ItemDetailScreen({required this.itemDetails});
//
//   @override
//   _ItemDetailScreenState createState() => _ItemDetailScreenState();
// }
//
// class _ItemDetailScreenState extends State<ItemDetailScreen> {
//   late List<String> mediaList;
//   VideoPlayerController? _videoController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Get images and videos from itemDetails
//     List<String> images = widget.itemDetails['images']?.cast<String>() ?? [];
//     List<String> videos = widget.itemDetails['videos']?.cast<String>() ?? [];
//
//     // Combine images and videos into one list
//     mediaList = [...images, ...videos];
//
//     // Initialize video player if there's a video
//     if (videos.isNotEmpty) {
//       _videoController = VideoPlayerController.network(videos[0])
//         ..initialize().then((_) {
//           setState(() {}); // Update UI after video is initialized
//         });
//     }
//   }
//
//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.itemDetails['name']),
//         backgroundColor: Colors.blue,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Display Brand Name
//               if (widget.itemDetails['Brand Name'] != null)
//                 Text(
//                   'Brand: ${widget.itemDetails['Brand Name']}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               SizedBox(height: 8),
//
//               // Display Category
//               if (widget.itemDetails['category'] != null)
//                 Text(
//                   'Category: ${widget.itemDetails['category']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 8),
//
//               // Display Shop Name
//               if (widget.itemDetails['shop Name'] != null)
//                 Text(
//                   'Shop: ${widget.itemDetails['shop Name']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Images or Videos
//               if (mediaList.length == 1)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: mediaList[0].endsWith('.mp4')
//                       ? _videoController != null && _videoController!.value.isInitialized
//                       ? AspectRatio(
//                     aspectRatio: _videoController!.value.aspectRatio,
//                     child: VideoPlayer(_videoController!),
//                   )
//                       : Center(child: CircularProgressIndicator())
//                       : Image.network(
//                     mediaList[0],
//                     width: double.infinity,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 )
//               else if (mediaList.length > 1)
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 200,
//                     enableInfiniteScroll: true,
//                     autoPlay: true,
//                     enlargeCenterPage: true,
//                   ),
//                   items: mediaList.map((url) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: url.endsWith('.mp4')
//                           ? _videoController != null && _videoController!.value.isInitialized
//                           ? AspectRatio(
//                         aspectRatio: _videoController!.value.aspectRatio,
//                         child: VideoPlayer(_videoController!),
//                       )
//                           : Center(child: CircularProgressIndicator())
//                           : Image.network(
//                         url,
//                         width: double.infinity,
//                         height: 200,
//                         fit: BoxFit.cover,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Description
//               if (widget.itemDetails['description'] != null)
//                 Text(
//                   'Description: ${widget.itemDetails['description']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Sizes
//               if (widget.itemDetails['colors'] != null &&
//                   widget.itemDetails['colors'].isNotEmpty &&
//                   widget.itemDetails['colors'][0]['sizes'].isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Sizes:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     ...widget.itemDetails['colors'][0]['sizes'].map<Widget>((size) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Size: ${size['size']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             'Price: Rs ${size['price']}',
//                             style: TextStyle(fontSize: 16, color: Colors.red),
//                           ),
//                           Text(
//                             'Offer Price: Rs ${size['offerPrice']}',
//                             style: TextStyle(fontSize: 16, color: Colors.green),
//                           ),
//                           Text(
//                             'Quantity: ${size['quantity']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Divider(),
//                         ],
//                       );
//                     }).toList(),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// rakesh view good

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Seller/edit_items_screen.dart';
// import 'package:video_player/video_player.dart';
//
//
// class SellerHomeScreen extends StatelessWidget {
//   // Get the current user
//   User? getCurrentUser() {
//     return FirebaseAuth.instance.currentUser;
//   }
//
//   // Fetch items from multiple collections
//   Future<List<QuerySnapshot>> fetchItems(User user) async {
//     final List<String> collections = ['Clothing', 'Footwear', 'Electronics'];
//     final List<QuerySnapshot> snapshots = [];
//
//     for (var collection in collections) {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('seller')
//           .doc(user.uid)
//           .collection(collection)
//           .get();
//       snapshots.add(snapshot);
//     }
//
//     return snapshots;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final User? user = getCurrentUser();
//     if (user == null) {
//       return Center(
//         child: Text('No user is logged in!', style: TextStyle(fontSize: 18)),
//       );
//     }
//
//     return Scaffold(
//       body: FutureBuilder<List<QuerySnapshot>>(
//         future: fetchItems(user),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error fetching items: ${snapshot.error}'),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text('No items uploaded yet.', style: TextStyle(fontSize: 18)),
//             );
//           }
//
//           // Combine all items from multiple collections
//           final List<DocumentSnapshot> allItems = [];
//           for (var querySnapshot in snapshot.data!) {
//             allItems.addAll(querySnapshot.docs);
//           }
//
//           // Group items by category
//           final Map<String, List<DocumentSnapshot>> itemsByCategory = {};
//           for (var doc in allItems) {
//             final category = doc['category'] as String;
//             if (!itemsByCategory.containsKey(category)) {
//               itemsByCategory[category] = [];
//             }
//             itemsByCategory[category]!.add(doc);
//           }
//
//           return ListView(
//             children: itemsByCategory.entries.map((entry) {
//               final category = entry.key;
//               final items = entry.value;
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       category,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   ...items.map((item) {
//                     final imageUrl = item['images'].isNotEmpty ? item['images'][0] : null;
//
//                     return GestureDetector(
//                       onTap: () {
//                         // Navigate to ItemDetailsScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ItemDetailsScreen(item: item),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: ListTile(
//                           leading: imageUrl != null
//                               ? Image.network(
//                             imageUrl,
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           )
//                               : Icon(Icons.image, size: 50),
//                           title: Text(item['name']),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Price: Rs ${item['price']}'),
//                               if (item['offerPrice'] > 0)
//                                 Text(
//                                   'Offer Price: Rs ${item['offerPrice']}',
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ItemDetailsScreen extends StatefulWidget {
//   final DocumentSnapshot item;
//
//   ItemDetailsScreen({required this.item});
//
//   @override
//   _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
// }
//
// class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
//   late List<VideoPlayerController> _videoControllers;
//   late List<bool> _isVideoPlaying;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoControllers = widget.item['videos'].map<VideoPlayerController>((videoUrl) {
//       final controller = VideoPlayerController.network(videoUrl)
//         ..initialize().then((_) {
//           setState(() {});
//         });
//       return controller;
//     }).toList();
//     _isVideoPlaying = List.filled(_videoControllers.length, false);
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
//   void _toggleVideoPlay(int index) {
//     setState(() {
//       if (_videoControllers[index].value.isPlaying) {
//         _videoControllers[index].pause();
//         _isVideoPlaying[index] = false;
//       } else {
//         _videoControllers[index].play();
//         _isVideoPlaying[index] = true;
//       }
//     });
//   }
//
//   // Function to show delete confirmation dialog
//   void _showDeleteConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Item'),
//           content: Text('Are you sure you want to delete this item?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('No'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 // Delete the item from Firestore
//                 await FirebaseFirestore.instance
//                     .collection('seller')
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .collection(widget.item['category'])
//                     .doc(widget.item.id)
//                     .delete();
//
//                 // Close the dialog and navigate back
//                 Navigator.of(context).pop(); // Close the dialog
//                 Navigator.of(context).pop(); // Navigate back to the previous screen
//               },
//               child: Text('Yes'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.item['name']),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.item['name'],
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Category: ${widget.item['category']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Shop Name: ${widget.item['shopName']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Brand Name: ${widget.item['brandName']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Price: Rs ${widget.item['price']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             if (widget.item['offerPrice'] > 0)
//               Text(
//                 'Offer Price: Rs ${widget.item['offerPrice']}',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             SizedBox(height: 16),
//             Text(
//               'Description: ${widget.item['description']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Product Details: ${widget.item['productDetails']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Images:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Wrap(
//               spacing: 8.0,
//               children: widget.item['images'].map<Widget>((imageUrl) {
//                 return Image.network(
//                   imageUrl,
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//             if (widget.item['videos'].isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Videos:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, // Number of videos per row
//                       crossAxisSpacing: 8.0, // Spacing between videos horizontally
//                       mainAxisSpacing: 8.0, // Spacing between videos vertically
//                       childAspectRatio: 1, // Width and height ratio (1:1 for 100x100)
//                     ),
//                     itemCount: widget.item['videos'].length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () => _toggleVideoPlay(index),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Container(
//                               width: 100,
//                               height: 100,
//                               child: AspectRatio(
//                                 aspectRatio: _videoControllers[index].value.aspectRatio,
//                                 child: VideoPlayer(_videoControllers[index]),
//                               ),
//                             ),
//                             Icon(
//                               _isVideoPlaying[index] ? Icons.pause : Icons.play_arrow,
//                               size: 30,
//                               color: Colors.indigo,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to EditItemScreen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditItemScreen(item: widget.item),
//                       ),
//                     );
//                   },
//                   child: Text('Edit'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _showDeleteConfirmationDialog(context); // Show delete confirmation dialog
//                   },
//                   child: Text('Delete'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red, // Red color for delete button
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

// with updating immediately changes good but bad

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart'; // Import rxdart
// import 'package:sadhana_cart/Seller/edit_items_screen.dart';
// import 'package:video_player/video_player.dart';
//
// class SellerHomeScreen extends StatelessWidget {
//   // Get the current user
//   User? getCurrentUser() {
//     return FirebaseAuth.instance.currentUser;
//   }
//
//   // Create a stream that listens to multiple collections
//   Stream<List<QuerySnapshot>> fetchItemsStream(User user) {
//     final List<String> collections = ['Clothing', 'Footwear', 'Electronics'];
//
//     final List<Stream<QuerySnapshot>> streams = collections.map((collection) {
//       return FirebaseFirestore.instance
//           .collection('seller')
//           .doc(user.uid)
//           .collection(collection)
//           .snapshots();
//     }).toList();
//
//     // Use combineLatest instead of zip so that the UI updates on any change
//     return Rx.combineLatest(streams, (List<QuerySnapshot> snapshots) {
//       return snapshots;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final User? user = getCurrentUser();
//     if (user == null) {
//       return Center(
//         child: Text('No user is logged in!', style: TextStyle(fontSize: 18)),
//       );
//     }
//
//     return Scaffold(
//       body: StreamBuilder<List<QuerySnapshot>>(
//         stream: fetchItemsStream(user),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error fetching items: ${snapshot.error}'),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text('No items uploaded yet.', style: TextStyle(fontSize: 18)),
//             );
//           }
//
//           // Combine all items from multiple collections
//           final List<DocumentSnapshot> allItems = [];
//           for (var querySnapshot in snapshot.data!) {
//             allItems.addAll(querySnapshot.docs);
//           }
//
//           // Group items by category
//           final Map<String, List<DocumentSnapshot>> itemsByCategory = {};
//           for (var doc in allItems) {
//             final category = doc['category'] as String;
//             if (!itemsByCategory.containsKey(category)) {
//               itemsByCategory[category] = [];
//             }
//             itemsByCategory[category]!.add(doc);
//           }
//
//           return ListView(
//             children: itemsByCategory.entries.map((entry) {
//               final category = entry.key;
//               final items = entry.value;
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       category,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   ...items.map((item) {
//                     final imageUrl = item['images'].isNotEmpty ? item['images'][0] : null;
//
//                     return GestureDetector(
//                       onTap: () {
//                         // Navigate to ItemDetailsScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ItemDetailsScreen(item: item),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: ListTile(
//                           leading: imageUrl != null
//                               ? Image.network(
//                             imageUrl,
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           )
//                               : Icon(Icons.image, size: 50),
//                           title: Text(item['name']),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Price: Rs ${item['price']}'),
//                               if (item['offerPrice'] > 0)
//                                 Text(
//                                   'Offer Price: Rs ${item['offerPrice']}',
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ItemDetailsScreen extends StatefulWidget {
//   final DocumentSnapshot item;
//
//   ItemDetailsScreen({required this.item});
//
//   @override
//   _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
// }
//
// class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
//   late List<VideoPlayerController> _videoControllers;
//   late List<bool> _isVideoPlaying;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoControllers = widget.item['videos'].map<VideoPlayerController>((videoUrl) {
//       final controller = VideoPlayerController.network(videoUrl)
//         ..initialize().then((_) {
//           setState(() {});
//         });
//       return controller;
//     }).toList();
//     _isVideoPlaying = List.filled(_videoControllers.length, false);
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
//   void _toggleVideoPlay(int index) {
//     setState(() {
//       if (_videoControllers[index].value.isPlaying) {
//         _videoControllers[index].pause();
//         _isVideoPlaying[index] = false;
//       } else {
//         _videoControllers[index].play();
//         _isVideoPlaying[index] = true;
//       }
//     });
//   }
//
//   void _showDeleteConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Item'),
//           content: Text('Are you sure you want to delete this item?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('No'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 // Delete the item from Firestore
//                 await FirebaseFirestore.instance
//                     .collection('seller')
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .collection(widget.item['category'])
//                     .doc(widget.item.id)
//                     .delete();
//
//                 // Close the dialog and navigate back
//                 Navigator.of(context).pop(); // Close the dialog
//                 Navigator.of(context).pop(); // Navigate back to the previous screen
//               },
//               child: Text('Yes'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.item['name']),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('seller')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection(widget.item['category'])
//             .doc(widget.item.id)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('Item not found.'));
//           }
//
//           final item = snapshot.data!;
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item['name'],
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Category: ${item['category']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Shop Name: ${item['shopName']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Brand Name: ${item['brandName']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Price: Rs ${item['price']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 if (item['offerPrice'] > 0)
//                   Text(
//                     'Offer Price: Rs ${item['offerPrice']}',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Description: ${item['description']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Product Details: ${item['productDetails']}',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Images:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8),
//                 Wrap(
//                   spacing: 8.0,
//                   children: item['images'].map<Widget>((imageUrl) {
//                     return Image.network(
//                       imageUrl,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 16),
//                 if (item['videos'].isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Videos:',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       GridView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           crossAxisSpacing: 8.0,
//                           mainAxisSpacing: 8.0,
//                           childAspectRatio: 1,
//                         ),
//                         itemCount: item['videos'].length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () => _toggleVideoPlay(index),
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   height: 100,
//                                   child: AspectRatio(
//                                     aspectRatio: _videoControllers[index].value.aspectRatio,
//                                     child: VideoPlayer(_videoControllers[index]),
//                                   ),
//                                 ),
//                                 Icon(
//                                   _isVideoPlaying[index] ? Icons.pause : Icons.play_arrow,
//                                   size: 30,
//                                   color: Colors.indigo,
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => EditItemScreen(item: item),
//                           ),
//                         );
//                       },
//                       child: Text('Edit'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         _showDeleteConfirmationDialog(context);
//                       },
//                       child: Text('Delete'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// WORKING FINE BUT UI NOT GOOD



// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:provider/provider.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart'
//     show GetSoldProductByCustomer;
//
// class SellerHomeScreen extends StatelessWidget {
//   const SellerHomeScreen({super.key});
//
//   // Get the current user
//   User? getCurrentUser() {
//     return FirebaseAuth.instance.currentUser;
//   }
//
//   // Create a stream that listens to multiple collections
//   Stream<List<QuerySnapshot>> fetchItemsStream(User user) {
//     final List<String> collections = [
//       'Electronics',
//       'Clothing',
//       'Footwear',
//       'Accessories',
//       'Home Appliances',
//       'Books',
//       'Others',
//     ];
//
//     final List<Stream<QuerySnapshot>> streams = collections.map((collection) {
//       return FirebaseFirestore.instance
//           .collection('seller')
//           .doc(user.uid)
//           .collection(collection)
//           .snapshots();
//     }).toList();
//
//     // Use combineLatest instead of zip so that the UI updates on any change
//     return Rx.combineLatest(streams, (List<QuerySnapshot> snapshots) {
//       return snapshots;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final User? user = getCurrentUser();
//     if (user == null) {
//       return const Center(
//         child: Text('No user is logged in!', style: TextStyle(fontSize: 18)),
//       );
//     }
//
//     return Scaffold(
//       body: StreamBuilder<List<QuerySnapshot>>(
//         stream: fetchItemsStream(user),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error fetching items: ${snapshot.error}'),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text('No items uploaded yet.',
//                   style: TextStyle(fontSize: 18)),
//             );
//           }
//
//           // Combine all items from multiple collections
//           final List<DocumentSnapshot> allItems = [];
//           for (var querySnapshot in snapshot.data!) {
//             allItems.addAll(querySnapshot.docs);
//           }
//
//           // Group items by category
//           final Map<String, List<DocumentSnapshot>> itemsByCategory = {};
//           for (var doc in allItems) {
//             final category = doc['category'] as String;
//             if (!itemsByCategory.containsKey(category)) {
//               itemsByCategory[category] = [];
//             }
//             itemsByCategory[category]!.add(doc);
//           }
//
//           return ListView(
//             children: itemsByCategory.entries.map((entry) {
//               final category = entry.key;
//               final items = entry.value;
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       category,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   ...items.map((item) {
//                     final imageUrl =
//                         item['images'].isNotEmpty ? item['images'][0] : null;
//                     final productDetails =
//                         item['productDetails'] as Map<String, dynamic>?;
//
//                     // Fetch price and offerPrice from productDetails
//                     final price = productDetails?['Price'] ?? 'N/A';
//                     final offerPrice = productDetails?['Offer Price'] ?? 'N/A';
//
//                     return GestureDetector(
//                       onTap: () {
//                         // Navigate to ItemDetailsScreen (if needed)
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => ItemDetailsScreen(item: item),
//                         // );
//                       },
//                       child: Card(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         child: Slidable(
//                           endActionPane: ActionPane(
//                               motion: const StretchMotion(),
//                               children: [
//                                 SlidableAction(
//                                   onPressed: (context) async {
//                                     final provider =
//                                         Provider.of<GetSoldProductByCustomer>(
//                                             context,
//                                             listen: false);
//                                     final bool isSuccess =
//                                         await provider.deleteSellerProductById(
//                                             productId: item.id,
//                                             context: context);
//                                     log(isSuccess.toString());
//                                   },
//                                   backgroundColor: Colors.red,
//                                   icon: Icons.delete,
//                                   label: 'Delete',
//                                 ),
//                               ]),
//                           child: ListTile(
//                             leading: imageUrl != null
//                                 ? Image.network(
//                                     imageUrl,
//                                     width: 50,
//                                     height: 50,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : const Icon(Icons.image, size: 50),
//                             title: Text(item['name']),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Price: Rs $price'),
//                                 if (offerPrice != 'N/A')
//                                   Text(
//                                     'Offer Price: Rs $offerPrice',
//                                     style: const TextStyle(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 if (productDetails != null)
//                                   ...productDetails.entries.map((entry) {
//                                     if (entry.key != 'Price' &&
//                                         entry.key != 'Offer Price') {
//                                       return Text(
//                                           '${entry.key}: ${entry.value}');
//                                     }
//                                     return const SizedBox
//                                         .shrink(); // Skip price and offerPrice
//                                   }),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ],
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }



// sO WORKING ON IMPROVING UI


import 'dart:developer';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:image_picker/image_picker.dart'; // For image selection
import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart'

    show GetSoldProductByCustomer;

// You'll need to create this

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Stream<List<QuerySnapshot>> fetchItemsStream(User user) {
    final List<String> collections = [
      'Electronics',
      'Clothing',
      'Footwear',
      'Accessories',
      'Home Appliances',
      'Books',
      'Others',
    ];

    final List<Stream<QuerySnapshot>> streams = collections.map((collection) {
      return FirebaseFirestore.instance
          .collection('seller')
          .doc(user.uid)
          .collection(collection)
          .snapshots();
    }).toList();

    return Rx.combineLatest(streams, (List<QuerySnapshot> snapshots) {
      return snapshots;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = getCurrentUser();
    if (user == null) {
      return const Center(
        child: Text('No user is logged in!', style: TextStyle(fontSize: 18)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<List<QuerySnapshot>>(
        stream: fetchItemsStream(user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching items: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No items uploaded yet.',
                  style: TextStyle(fontSize: 18)),
            );
          }

          // Combine all items from multiple collections
          final List<DocumentSnapshot> allItems = [];
          for (var querySnapshot in snapshot.data!) {
            allItems.addAll(querySnapshot.docs);
          }

          // Group items by category
          final Map<String, List<DocumentSnapshot>> itemsByCategory = {};
          for (var doc in allItems) {
            final category = doc['category'] as String;
            if (!itemsByCategory.containsKey(category)) {
              itemsByCategory[category] = [];
            }
            itemsByCategory[category]!.add(doc);
          }

          return ListView(
            children: itemsByCategory.entries.map((entry) {
              final category = entry.key;
              final items = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...items.map((item) {
                    final imageUrl =
                    item['images'].isNotEmpty ? item['images'][0] : null;
                    final productDetails =
                    item['productDetails'] as Map<String, dynamic>?;
                    final price = productDetails?['Price'] ?? 'N/A';
                    final offerPrice = productDetails?['Offer Price'] ?? 'N/A';
                    final quantity = productDetails?['Quantity'] ?? 'N/A';

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                final provider = Provider.of<
                                    GetSoldProductByCustomer>(context,
                                    listen: false);
                                final bool isSuccess =
                                await provider.deleteSellerProductById(
                                    productId: item.id, context: context);
                                log(isSuccess.toString());
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SellerItemDetailsScreen(
                                    item: item), // Create this screen
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: imageUrl != null
                                      ? Image.network(
                                    imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.image,
                                        size: 40, color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '₹$price',
                                          style: TextStyle(
                                            fontSize: 16,
                                            decoration: offerPrice != 'N/A'
                                                ? TextDecoration.lineThrough
                                                : null,
                                            color: offerPrice != 'N/A'
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        ),
                                        if (offerPrice != 'N/A')
                                          Text(
                                            '₹$offerPrice',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Qty: $quantity',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

// class SellerItemDetailsScreen extends StatelessWidget {
//   final DocumentSnapshot item;
//
//   const SellerItemDetailsScreen({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     final images = List<String>.from(item['images'] ?? []);
//     final productDetails = item['productDetails'] as Map<String, dynamic>?;
//     final price = productDetails?['Price'] ?? 'N/A';
//     final offerPrice = productDetails?['Offer Price'] ?? 'N/A';
//     final quantity = productDetails?['Quantity'] ?? 'N/A';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(item['name']),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Images Carousel
//             if (images.isNotEmpty)
//               Column(
//                 children: [
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       height: 300,
//                       aspectRatio: 16/9,
//                       viewportFraction: 0.8,
//                       initialPage: 0,
//                       enableInfiniteScroll: true,
//                       reverse: false,
//                       autoPlay: true,
//                       autoPlayInterval: const Duration(seconds: 3),
//                       autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                       enlargeCenterPage: true,
//                       scrollDirection: Axis.horizontal,
//                     ),
//                     items: images.map((imageUrl) {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return Container(
//                             width: MediaQuery.of(context).size.width,
//                             margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.grey[200],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return const Icon(Icons.broken_image, size: 60);
//                                 },
//                                 loadingBuilder: (BuildContext context, Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) return child;
//                                   return Center(
//                                     child: CircularProgressIndicator(
//                                       value: loadingProgress.expectedTotalBytes != null
//                                           ? loadingProgress.cumulativeBytesLoaded /
//                                           loadingProgress.expectedTotalBytes!
//                                           : null,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 12),
//                   // Dots indicator
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: images.asMap().entries.map((entry) {
//                       return Container(
//                         width: 8.0,
//                         height: 8.0,
//                         margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.grey.withOpacity(
//                               Theme.of(context).brightness == Brightness.dark ? 0.9 : 0.4),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               )
//             else
//               Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.grey[200],
//                 ),
//                 child: const Center(
//                   child: Icon(Icons.image, size: 60, color: Colors.grey),
//                 ),
//               ),
//             const SizedBox(height: 24),
//
//             // Product Name
//             Text(
//               item['name'],
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Price Information
//             Row(
//               children: [
//                 Text(
//                   '₹$price',
//                   style: TextStyle(
//                     fontSize: 20,
//                     decoration: offerPrice != 'N/A'
//                         ? TextDecoration.lineThrough
//                         : null,
//                     color: offerPrice != 'N/A' ? Colors.grey : Colors.black,
//                   ),
//                 ),
//                 if (offerPrice != 'N/A') ...[
//                   const SizedBox(width: 10),
//                   Text(
//                     '₹$offerPrice',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Quantity
//             Text(
//               'Available Quantity: $quantity',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             // Category
//             Text(
//               'Category: ${item['category']}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//
//             // Other Details
//             const Text(
//               'Product Details:',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             if (productDetails != null)
//               ...productDetails.entries.map((entry) {
//                 if (entry.key != 'Price' &&
//                     entry.key != 'Offer Price' &&
//                     entry.key != 'Quantity') {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${entry.key}: ',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             entry.value.toString(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               }),
//           ],
//         ),
//       ),
//     );
//   }
// }



class SellerItemDetailsScreen extends StatelessWidget {
  final DocumentSnapshot item;

  const SellerItemDetailsScreen({super.key, required this.item});

  Future<void> _deleteProduct(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final provider = Provider.of<GetSoldProductByCustomer>(context, listen: false);
        final success = await provider.deleteSellerProductById(
          productId: item.id,
          context: context,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product deleted successfully')),
          );
          Navigator.pop(context); // Go back to previous screen
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = List<String>.from(item['images'] ?? []);
    final productDetails = item['productDetails'] as Map<String, dynamic>?;
    final price = productDetails?['Price'] ?? 'N/A';
    final offerPrice = productDetails?['Offer Price'] ?? 'N/A';
    final quantity = productDetails?['Quantity'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Images Carousel
                  if (images.isNotEmpty)
                    Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 300,
                            aspectRatio: 16/9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: images.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[200],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.broken_image, size: 60);
                                      },
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                        // Dots indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: images.asMap().entries.map((entry) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(
                                    Theme.of(context).brightness == Brightness.dark ? 0.9 : 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 60, color: Colors.grey),
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Product Name
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Show original price (always)
                      Text(
                        '₹${productDetails?['Price'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                          decoration: productDetails?['Offer Price'] != null &&
                              productDetails?['Offer Price'] != 'N/A'
                              ? TextDecoration.lineThrough
                              : null,
                          color: productDetails?['Offer Price'] != null &&
                              productDetails?['Offer Price'] != 'N/A'
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),

                      // Show offer price if available
                      if (productDetails?['Offer Price'] != null &&
                          productDetails?['Offer Price'] != 'N/A') ...[
                        const SizedBox(width: 8),
                        Text(
                          '₹${productDetails?['Offer Price']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8), // Category
                  Text(
                    'Available Quantity: ${productDetails?['Quantity'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24), // Category
                  Row(
                    children: [
                      Text(
                        'Category : ',
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${item['category']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Other Details
                  const Text(
                    'Product Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (productDetails != null)
                    ...productDetails.entries.map((entry) {
                      if (entry.key != 'Price' &&
                          entry.key != 'Offer Price' &&
                          entry.key != 'Quantity') {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${entry.key} : ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  entry.value.toString(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                ],
              ),
            ),
          ),
          // Edit and Delete buttons at bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Product'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerEditProductScreen(item: item),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _deleteProduct(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// class SellerEditProductScreen extends StatefulWidget {
//   final DocumentSnapshot item;
//
//   const SellerEditProductScreen({super.key, required this.item});
//
//   @override
//   _SellerEditProductScreenState createState() => _SellerEditProductScreenState();
// }
//
// class _SellerEditProductScreenState extends State<SellerEditProductScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _priceController;
//   late TextEditingController _offerPriceController;
//   late TextEditingController _quantityController;
//   late TextEditingController _categoryController;
//   final Map<String, TextEditingController> _detailControllers = {};
//   List<String> _images = [];
//   List<String> _deletedImages = [];
//   final List<File> _newImages = [];
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     final productDetails = widget.item['productDetails'] as Map<String, dynamic>?;
//
//     _nameController = TextEditingController(text: widget.item['name']);
//     _priceController = TextEditingController(text: productDetails?['Price']?.toString());
//     _offerPriceController = TextEditingController(text: productDetails?['Offer Price']?.toString());
//     _quantityController = TextEditingController(text: productDetails?['Quantity']?.toString());
//     _categoryController = TextEditingController(text: widget.item['category']);
//     _images = List<String>.from(widget.item['images'] ?? []);
//
//     // Initialize controllers for other details
//     if (productDetails != null) {
//       productDetails.forEach((key, value) {
//         if (key != 'Price' && key != 'Offer Price' && key != 'Quantity') {
//           _detailControllers[key] = TextEditingController(text: value.toString());
//         }
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceController.dispose();
//     _offerPriceController.dispose();
//     _quantityController.dispose();
//     _categoryController.dispose();
//     for (var controller in _detailControllers.values) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   Future<void> _pickImages() async {
//     try {
//       final pickedFiles = await _picker.pickMultiImage();
//       if (pickedFiles != null) {
//         setState(() {
//           _newImages.addAll(pickedFiles.map((file) => File(file.path)));
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to pick images: $e')),
//       );
//     }
//   }
//
//   // Future<void> _saveChanges() async {
//   //   try {
//   //     final user = FirebaseAuth.instance.currentUser;
//   //     if (user == null) return;
//   //
//   //     // Prepare the updated data
//   //     final updatedDetails = {
//   //       'name': _nameController.text,
//   //       'category': _categoryController.text,
//   //       'productDetails': {
//   //         'Price': _priceController.text,
//   //         'Offer Price': _offerPriceController.text,
//   //         'Quantity': _quantityController.text,
//   //         ..._detailControllers.map((key, controller) => MapEntry(key, controller.text)),
//   //       },
//   //       // Images will be handled separately (you'll need to upload new ones)
//   //     };
//   //
//   //     // Update the document in Firestore
//   //     await FirebaseFirestore.instance
//   //         .collection('seller')
//   //         .doc(user.uid)
//   //         .collection(widget.item['category'])
//   //         .doc(widget.item.id)
//   //         .update(updatedDetails);
//   //
//   //     // TODO: Handle image uploads and deletions here
//   //     // You'll need to:
//   //     // 1. Upload new images to storage
//   //     // 2. Delete any images marked for deletion
//   //     // 3. Update the images array in Firestore
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Product updated successfully')),
//   //     );
//   //     Navigator.pop(context);
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to update product: $e')),
//   //     );
//   //   }
//   // }
//
//   Future<void> _saveChanges() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;
//
//       final productDocRef = FirebaseFirestore.instance
//           .collection('seller')
//           .doc(user.uid)
//           .collection(widget.item['category'])
//           .doc(widget.item.id);
//
//       final storageRef = FirebaseStorage.instance.ref();
//
//       // 1. Delete removed images from Firebase Storage
//       for (String url in _deletedImages) {
//         try {
//           final ref = FirebaseStorage.instance.refFromURL(url);
//           await ref.delete();
//         } catch (e) {
//           debugPrint('Failed to delete image: $e');
//         }
//       }
//
//       // 2. Upload new images to Firebase Storage
//       List<String> newImageUrls = [];
//       for (File imageFile in _newImages) {
//         final fileName = '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
//         final imageRef = storageRef.child('product_images/${user.uid}/$fileName');
//         await imageRef.putFile(imageFile);
//         final imageUrl = await imageRef.getDownloadURL();
//         newImageUrls.add(imageUrl);
//       }
//
//       // 3. Combine existing + newly uploaded image URLs
//       final updatedImageList = [..._images, ...newImageUrls];
//
//       // 4. Prepare updated data
//       final updatedDetails = {
//         'name': _nameController.text,
//         'category': _categoryController.text,
//         'images': updatedImageList,
//         'productDetails': {
//           'Price': _priceController.text,
//           'Offer Price': _offerPriceController.text,
//           'Quantity': _quantityController.text,
//           ..._detailControllers.map((key, controller) => MapEntry(key, controller.text)),
//         },
//       };
//
//       // 5. Update Firestore document
//       await productDocRef.update(updatedDetails);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product updated successfully')),
//       );
//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update product: $e')),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Product'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _saveChanges,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Images section
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Product Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 // Existing images
//                 if (_images.isNotEmpty)
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: _images.map((imageUrl) {
//                       return Stack(
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               image: DecorationImage(
//                                 image: NetworkImage(imageUrl),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 0,
//                             right: 0,
//                             child: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 setState(() {
//                                   _images.remove(imageUrl);
//                                   _deletedImages.add(imageUrl);
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 // New images
//                 if (_newImages.isNotEmpty)
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: _newImages.map((imageFile) {
//                       return Stack(
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               image: DecorationImage(
//                                 image: FileImage(imageFile),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 0,
//                             right: 0,
//                             child: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 setState(() {
//                                   _newImages.remove(imageFile);
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: _pickImages,
//                   child: const Text('Add More Images'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//
//             // Basic info
//             TextFormField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Product Name'),
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _categoryController,
//               decoration: const InputDecoration(labelText: 'Category'),
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _priceController,
//               decoration: const InputDecoration(labelText: 'Price (₹)'),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _offerPriceController,
//               decoration: const InputDecoration(labelText: 'Offer Price (₹)'),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _quantityController,
//               decoration: const InputDecoration(labelText: 'Quantity'),
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 24),
//
//             // Other details
//             const Text('Product Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             ..._detailControllers.entries.map((entry) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 16.0),
//                 child: TextFormField(
//                   controller: entry.value,
//                   decoration: InputDecoration(labelText: entry.key),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }    products edit screen without UI



class SellerEditProductScreen extends StatefulWidget {
  final DocumentSnapshot item;

  const SellerEditProductScreen({super.key, required this.item});

  @override
  _SellerEditProductScreenState createState() => _SellerEditProductScreenState();
}

class _SellerEditProductScreenState extends State<SellerEditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _offerPriceController;
  late TextEditingController _quantityController;
  late TextEditingController _categoryController;
  final Map<String, TextEditingController> _detailControllers = {};
  late TextEditingController _brandController;
  late TextEditingController _expectedDeliveryController;
  late TextEditingController _descriptionController;

  List<String> _images = [];
  List<String> _deletedImages = [];
  final List<File> _newImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final productDetails = widget.item['productDetails'] as Map<String, dynamic>?;

    _nameController = TextEditingController(text: widget.item['name']);
    _brandController = TextEditingController(text: widget.item['brandName']); // Add this
    _expectedDeliveryController = TextEditingController(text: widget.item['expectedDelivery']); // Add this
    _priceController = TextEditingController(text: productDetails?['Price']?.toString());
    _offerPriceController = TextEditingController(text: productDetails?['Offer Price']?.toString());
    _quantityController = TextEditingController(text: productDetails?['Quantity']?.toString());
    _categoryController = TextEditingController(text: widget.item['category']);
    _descriptionController = TextEditingController(text: productDetails?['description']); // Add this
    _images = List<String>.from(widget.item['images'] ?? []);

    // Initialize controllers for other details
    if (productDetails != null) {
      productDetails.forEach((key, value) {
        if (key != 'Price' && key != 'Offer Price' && key != 'Quantity') {
          _detailControllers[key] = TextEditingController(text: value.toString());
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose(); // Add this
    _expectedDeliveryController.dispose(); // Add this
    _priceController.dispose();
    _offerPriceController.dispose();
    _quantityController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose(); // Add this
    for (var controller in _detailControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null) {
        setState(() {
          _newImages.addAll(pickedFiles.map((file) => File(file.path)));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: $e')),
      );
    }
  }

  // Future<void> _saveChanges() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) return;
  //
  //     // Prepare the updated data
  //     final updatedDetails = {
  //       'name': _nameController.text,
  //       'category': _categoryController.text,
  //       'productDetails': {
  //         'Price': _priceController.text,
  //         'Offer Price': _offerPriceController.text,
  //         'Quantity': _quantityController.text,
  //         ..._detailControllers.map((key, controller) => MapEntry(key, controller.text)),
  //       },
  //       // Images will be handled separately (you'll need to upload new ones)
  //     };
  //
  //     // Update the document in Firestore
  //     await FirebaseFirestore.instance
  //         .collection('seller')
  //         .doc(user.uid)
  //         .collection(widget.item['category'])
  //         .doc(widget.item.id)
  //         .update(updatedDetails);
  //
  //     // TODO: Handle image uploads and deletions here
  //     // You'll need to:
  //     // 1. Upload new images to storage
  //     // 2. Delete any images marked for deletion
  //     // 3. Update the images array in Firestore
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Product updated successfully')),
  //     );
  //     Navigator.pop(context);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to update product: $e')),
  //     );
  //   }
  // }

  Future<void> _saveChanges() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final productDocRef = FirebaseFirestore.instance
          .collection('seller')
          .doc(user.uid)
          .collection(widget.item['category'])
          .doc(widget.item.id);

      final storageRef = FirebaseStorage.instance.ref();

      // 1. Delete removed images from Firebase Storage
      for (String url in _deletedImages) {
        try {
          final ref = FirebaseStorage.instance.refFromURL(url);
          await ref.delete();
        } catch (e) {
          debugPrint('Failed to delete image: $e');
        }
      }

      // 2. Upload new images to Firebase Storage
      List<String> newImageUrls = [];
      for (File imageFile in _newImages) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
        final imageRef = storageRef.child('product_images/${user.uid}/$fileName');
        await imageRef.putFile(imageFile);
        final imageUrl = await imageRef.getDownloadURL();
        newImageUrls.add(imageUrl);
      }

      // 3. Combine existing + newly uploaded image URLs
      final updatedImageList = [..._images, ...newImageUrls];

      // 4. Prepare updated data
      final updatedDetails = {
        'name': _nameController.text,
        'brandName': _brandController.text, // Add this
        'expectedDelivery': _expectedDeliveryController.text, // Add this
        'category': _categoryController.text,
        'images': updatedImageList,
        'productDetails': {
          'Price': _priceController.text,
          'Offer Price': _offerPriceController.text,
          'Quantity': _quantityController.text,
          'description': _descriptionController.text, // Add this
          ..._detailControllers.map((key, controller) => MapEntry(key, controller.text)),
        },
      };

      // 5. Update Firestore document
      await productDocRef.update(updatedDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_rounded),
            tooltip: 'Save Changes',
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Product Images Section
            const Text(
              'Product Images',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    if (_images.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _images.map((imageUrl) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images.remove(imageUrl);
                                      _deletedImages.add(imageUrl);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    if (_newImages.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _newImages.map((imageFile) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  imageFile,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _newImages.remove(imageFile);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _pickImages,
                      icon: const Icon(Icons.add_photo_alternate),
                      label: const Text('Add More Images'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 Basic Info Fields
            const Text(
              'Product Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildTextField(_nameController, 'Product Name', Icons.shopping_bag),
            _buildTextField(_brandController, 'Brand Name', Icons.branding_watermark),
            _buildTextField(_expectedDeliveryController, 'Expected Delivery', Icons.delivery_dining),
            _buildTextField(_descriptionController, 'Description', Icons.description),
            _buildTextField(_categoryController, 'Category', Icons.category),
            _buildTextField(_priceController, 'Price (₹)', Icons.price_check, isNumber: true),
            _buildTextField(_offerPriceController, 'Offer Price (₹)', Icons.discount, isNumber: true),
            _buildTextField(_quantityController, 'Quantity', Icons.confirmation_number, isNumber: true),

            const SizedBox(height: 24),

            /// 🔹 Product Details Section
            const Text(
              'Product Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._detailControllers.entries.map((entry) {
              return _buildTextField(entry.value, entry.key, Icons.info_outline);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    ),
  );
}










// ddkdms


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class SellerHomeScreen extends StatefulWidget {
//   @override
//   _SellerHomeScreenState createState() => _SellerHomeScreenState();
// }
//
// class _SellerHomeScreenState extends State<SellerHomeScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Map<String, List<Map<String, dynamic>>> _groupedClothingsByColor = {};
//   Map<String, List<Map<String, dynamic>>> _groupedFootwearsByColor = {};
//   bool _isLoading = true; // Loading state
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchClothingItems();
//     _fetchFootwearItems();
//   }
//
//   Future<void> _fetchClothingItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Clothings')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'Brand Name': doc['Brand Name'],
//               'category': doc['category'],
//               'colors': doc['colors'],
//               'description': doc['description'],
//               'name': doc['name'],
//               'shop Name': doc['shop Name'],
//               'images': colorData['images'],
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedClothingsByColor = groupedByColor;
//           _isLoading = false; // Stop loading
//         });
//       }
//     } catch (e) {
//       print('Error fetching clothing items: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _fetchFootwearItems() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         QuerySnapshot querySnapshot = await _firestore
//             .collection('seller')
//             .doc(user.uid)
//             .collection('Footwears')
//             .get();
//
//         Map<String, List<Map<String, dynamic>>> groupedByColor = {};
//         querySnapshot.docs.forEach((doc) {
//           var colors = doc['colors'] as List<dynamic>;
//           colors.forEach((colorData) {
//             String color = colorData['color'];
//             if (!groupedByColor.containsKey(color)) {
//               groupedByColor[color] = [];
//             }
//             var sizes = colorData['sizes'] as List<dynamic>;
//             double price = sizes.isNotEmpty ? sizes[0]['price'].toDouble() : 0;
//             double offerPrice = sizes.isNotEmpty ? sizes[0]['offerPrice'].toDouble() : 0;
//
//             groupedByColor[color]!.add({
//               'Brand Name': doc['Brand Name'],
//               'category': doc['category'],
//               'colors': doc['colors'],
//               'description': doc['description'],
//               'name': doc['name'],
//               'shop Name': doc['shop Name'],
//               'images': colorData['images'],
//               'price': price,
//               'offerPrice': offerPrice,
//             });
//           });
//         });
//
//         setState(() {
//           _groupedFootwearsByColor = groupedByColor;
//           _isLoading = false; // Stop loading
//         });
//       }
//     } catch (e) {
//       print('Error fetching footwear items: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('My Products'),
//       //   backgroundColor: Colors.blue,
//       //   elevation: 0,
//       // ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator()) // Show loader while fetching
//           : _groupedClothingsByColor.isEmpty && _groupedFootwearsByColor.isEmpty
//           ? Center(child: Text('No items found.'))
//           : SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (_groupedClothingsByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Clothings',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _groupedClothingsByColor.length,
//                   itemBuilder: (context, index) {
//                     String color = _groupedClothingsByColor.keys.elementAt(index);
//                     List<Map<String, dynamic>> items = _groupedClothingsByColor[color]!;
//
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ItemDetailScreen(itemDetails: items[0]),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: 150,
//                         margin: EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.3),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                                 child: Image.network(
//                                   items[0]['images'][0],
//                                   height: 120,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     items[0]['name'],
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     'Rs ${items[0]['price']}',
//                                     style: TextStyle(fontSize: 14, color: Colors.red),
//                                   ),
//                                   Text(
//                                     'Rs ${items[0]['offerPrice']}',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.green,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//
//             if (_groupedFootwearsByColor.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Footwears',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 250,
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   viewportFraction: 0.8,
//                 ),
//                 items: _groupedFootwearsByColor.entries.map((entry) {
//                   String color = entry.key;
//                   List<Map<String, dynamic>> items = entry.value;
//
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ItemDetailScreen(itemDetails: items[0]),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 5.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (items.isNotEmpty && items[0]['images'].isNotEmpty)
//                             ClipRRect(
//                               borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//                               child: Image.network(
//                                 items[0]['images'][0],
//                                 width: double.infinity,
//                                 height: 150,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   items[0]['name'],
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   'Rs ${items[0]['price']}',
//                                   style: TextStyle(fontSize: 14, color: Colors.red),
//                                 ),
//                                 Text(
//                                   'Rs ${items[0]['offerPrice']}',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.green,
//                                     decoration: TextDecoration.lineThrough,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ItemDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> itemDetails;
//
//   ItemDetailScreen({required this.itemDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(itemDetails['name']),
//         backgroundColor: Colors.blue,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Display Brand Name
//               if (itemDetails['Brand Name'] != null)
//                 Text(
//                   'Brand: ${itemDetails['Brand Name']}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               SizedBox(height: 8),
//
//               // Display Category
//               if (itemDetails['category'] != null)
//                 Text(
//                   'Category: ${itemDetails['category']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 8),
//
//               // Display Shop Name
//               if (itemDetails['shop Name'] != null)
//                 Text(
//                   'Shop: ${itemDetails['shop Name']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Images
//               if (itemDetails['images'] != null && itemDetails['images'].isNotEmpty)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     itemDetails['images'][0],
//                     width: double.infinity,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Description
//               if (itemDetails['description'] != null)
//                 Text(
//                   'Description: ${itemDetails['description']}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 16),
//
//               // Display Sizes
//               if (itemDetails['colors'] != null &&
//                   itemDetails['colors'].isNotEmpty &&
//                   itemDetails['colors'][0]['sizes'].isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Sizes:',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     ...itemDetails['colors'][0]['sizes'].map<Widget>((size) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Size: ${size['size']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             'Price: Rs ${size['price']}',
//                             style: TextStyle(fontSize: 16, color: Colors.red),
//                           ),
//                           Text(
//                             'Offer Price: Rs ${size['offerPrice']}',
//                             style: TextStyle(fontSize: 16, color: Colors.green),
//                           ),
//                           Text(
//                             'Quantity: ${size['quantity']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Divider(),
//                         ],
//                       );
//                     }).toList(),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


