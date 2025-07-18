// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/category_products_screen.dart';
// import 'package:sadhana_cart/Customer/customer_category_see_all_screen.dart';
// import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
//
// class CategoriesTab extends StatelessWidget {
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
//                   // Display items in a carousel slider for each category
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
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


// ui not good

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/category_products_screen.dart';
//
// class CategoriesTab extends StatelessWidget {
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
//   CategoriesTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         // Fetch all sellers
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
//           // Fetch items for each seller
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
//                   // Horizontal scrollable category list with circular images
//                   // Grid layout with 3 columns
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GridView.builder(
//                         itemCount: categories.length,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3, // 3 items per row
//                           mainAxisSpacing: 12,
//                           crossAxisSpacing: 12,
//                           childAspectRatio: 0.9, // Adjust height/width ratio
//                         ),
//                         itemBuilder: (context, index) {
//                           String category = categories[index];
//                           String imagePath = categoryImages[category] ??
//                               'assets/images/Sadhana_cart1.png';
//
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CategoryProductsPage(
//                                     category: category,
//                                     allItems: itemSnapshot.data!,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // CircleAvatar(
//                                 //   radius: 30,
//                                 //   backgroundImage: AssetImage(imagePath),
//                                 // ),
//
//                                 Container(
//                                   width: 60,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(imagePath),
//                                       fit: BoxFit
//                                           .cover, // Makes sure image covers the container
//                                     ),
//                                     borderRadius: BorderRadius.circular(
//                                         8), // Rounded corners (optional)
//                                     border:
//                                         Border.all(color: Colors.grey.shade300),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   category,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black,
//                                     fontFamily: 'Roboto',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   // Display items in a carousel slider for each category
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   // Fetch all items for all sellers
//   Future<List<Map<String, dynamic>>> _fetchAllSellerItems(
//       List<QueryDocumentSnapshot> sellers) async {
//     List<Map<String, dynamic>> allItems = [];
//
//     for (var seller in sellers) {
//       String sellerId = seller.id;
//
//       // Manually fetch subcollections (categories) for the seller
//       var categories = [
//         'Clothing',
//         'Electronics',
//         'Footwear',
//         'Accessories',
//         'Home Appliances',
//         'Books',
//         'Vegetables'
//       ]; // Add all your categories here
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



// Avarage


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sadhana_cart/Customer/category_products_screen.dart';
// import 'package:flutter_animate/flutter_animate.dart';
//
// class CategoriesTab extends StatelessWidget {
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
//   CategoriesTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isLargeScreen = MediaQuery.of(context).size.width > 600;
//
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('seller').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.deepOrange,
//               ),
//             );
//           }
//
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Error loading categories',
//                 style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
//               ),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text(
//                 'No sellers available',
//                 style: theme.textTheme.bodyLarge,
//               ),
//             );
//           }
//
//           return FutureBuilder<List<Map<String, dynamic>>>(
//             future: _fetchAllSellerItems(snapshot.data!.docs),
//             builder: (context, itemSnapshot) {
//               if (itemSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.deepOrange,
//                   ),
//                 );
//               }
//
//               if (itemSnapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     'Error loading products',
//                     style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
//                   ),
//                 );
//               }
//
//               if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     'No products available',
//                     style: theme.textTheme.bodyLarge,
//                   ),
//                 );
//               }
//
//               final itemsByCategory = _organizeByCategory(itemSnapshot.data!);
//               final categories = itemsByCategory.keys.toList();
//
//               return CustomScrollView(
//                 slivers: [
//                   SliverAppBar(
//                     expandedHeight: 120,
//                     flexibleSpace: FlexibleSpaceBar(
//                       title: Text(
//                         'Shop by Category',
//                         style: theme.textTheme.headlineSmall?.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       centerTitle: true,
//                       background: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               Colors.deepOrange.shade800,
//                               Colors.deepOrange.shade400,
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     pinned: true,
//                   ),
//                   SliverPadding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: isLargeScreen ? 40 : 16,
//                       vertical: 24,
//                     ),
//                     sliver: SliverGrid(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: isLargeScreen ? 4 : 2,
//                         mainAxisSpacing: 20,
//                         crossAxisSpacing: 20,
//                         childAspectRatio: 0.85,
//                       ),
//                       delegate: SliverChildBuilderDelegate(
//                             (context, index) {
//                           final category = categories[index];
//                           final imagePath = categoryImages[category] ??
//                               'assets/images/Sadhana_cart1.png';
//
//                           return _CategoryCard(
//                             category: category,
//                             imagePath: imagePath,
//                             itemCount: itemsByCategory[category]?.length ?? 0,
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CategoryProductsPage(
//                                     category: category,
//                                     allItems: itemSnapshot.data!,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ).animate().fadeIn(
//                             delay: (100 * index).ms,
//                             duration: 500.ms,
//                           ).slideY(
//                             begin: 0.2,
//                             curve: Curves.easeOut,
//                           );
//                         },
//                         childCount: categories.length,
//                       ),
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
//   Map<String, List<Map<String, dynamic>>> _organizeByCategory(
//       List<Map<String, dynamic>> items) {
//     final itemsByCategory = <String, List<Map<String, dynamic>>>{};
//     for (var item in items) {
//       final category = item['category'];
//       if (!itemsByCategory.containsKey(category)) {
//         itemsByCategory[category] = [];
//       }
//       itemsByCategory[category]!.add(item);
//     }
//     return itemsByCategory;
//   }
//
//   Future<List<Map<String, dynamic>>> _fetchAllSellerItems(
//       List<QueryDocumentSnapshot> sellers) async {
//     final allItems = <Map<String, dynamic>>[];
//     final categories = [
//       'Clothing',
//       'Electronics',
//       'Footwear',
//       'Accessories',
//       'Home Appliances',
//       'Books',
//       'Vegetables'
//     ];
//
//     for (var seller in sellers) {
//       final sellerId = seller.id;
//       for (var category in categories) {
//         final snapshot = await FirebaseFirestore.instance
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
//       }
//     }
//     return allItems;
//   }
// }
//
// class _CategoryCard extends StatelessWidget {
//   final String category;
//   final String imagePath;
//   final int itemCount;
//   final VoidCallback onTap;
//
//   const _CategoryCard({
//     required this.category,
//     required this.imagePath,
//     required this.itemCount,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Category Image
//             Expanded(
//               flex: 3,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(12),
//                 ),
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     color: Colors.grey.shade200,
//                     child: const Center(
//                       child: Icon(
//                         Icons.image_not_supported,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             // Category Info
//             Expanded(
//               flex: 1,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       category,
//                       style: theme.textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '$itemCount products',
//                       style: theme.textTheme.bodySmall?.copyWith(
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// best


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/Customer/category_products_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sadhana_cart/Web/Customer/category_products_screen.dart';

class WebCategoriesTab extends StatefulWidget {
  const WebCategoriesTab({super.key});

  @override
  State<WebCategoriesTab> createState() => _WebCategoriesTabState();
}

class _WebCategoriesTabState extends State<WebCategoriesTab> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Map<String, String> _categoryImages = {
    'Clothing': 'assets/images/clothings_category_customer_hometab.jpeg',
    'Electronics': 'assets/images/Electronics_category_customer_hometab.jpeg',
    'Footwear': 'assets/images/footwear_category_customer_hometab.jpeg',
    'Accessories': 'assets/images/Accessories_category.jpg',
    'Home Appliances': 'assets/images/home_appliences_category.jpg',
    'Books': 'assets/images/books_category.jpeg',
    'Others': 'assets/images/vegetables_category.jpeg',
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 800;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Parallax App Bar
          SliverAppBar(
            expandedHeight: size.height * 0.25,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Explore Categories',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/clothings_category_customer_hometab.jpeg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.deepOrange.withOpacity(0.7),
                          Colors.deepOrange.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('seller').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Error loading categories',
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
                    ),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No sellers available',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                );
              }

              return FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchAllSellerItems(snapshot.data!.docs),
                builder: (context, itemSnapshot) {
                  if (itemSnapshot.connectionState == ConnectionState.waiting) {
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ),
                      ),
                    );
                  }

                  if (itemSnapshot.hasError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Error loading products',
                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
                        ),
                      ),
                    );
                  }

                  if (!itemSnapshot.hasData || itemSnapshot.data!.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'No products available',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }

                  final itemsByCategory = _organizeByCategory(itemSnapshot.data!);
                  final categories = itemsByCategory.keys.toList();

                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isLargeScreen ? 40 : 16,
                      vertical: 24,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isLargeScreen ? 3 : 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.9,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final category = categories[index];
                          final imagePath = _categoryImages[category] ??
                              'assets/images/Sadhana_cart1.png';

                          return _AnimatedCategoryCard(
                            category: category,
                            imagePath: imagePath,
                            itemCount: itemsByCategory[category]?.length ?? 0,
                            animationController: _animationController,
                            index: index,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      FadeTransition(
                                        opacity: animation,
                                        child: WebCategoryProductsPage(
                                          category: category,
                                          allItems: itemSnapshot.data!,
                                        ),
                                      ),
                                ),
                              );
                            },
                          );
                        },
                        childCount: categories.length,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _organizeByCategory(
      List<Map<String, dynamic>> items) {
    final itemsByCategory = <String, List<Map<String, dynamic>>>{};
    for (var item in items) {
      final category = item['category'];
      if (!itemsByCategory.containsKey(category)) {
        itemsByCategory[category] = [];
      }
      itemsByCategory[category]!.add(item);
    }
    return itemsByCategory;
  }

  Future<List<Map<String, dynamic>>> _fetchAllSellerItems(
      List<QueryDocumentSnapshot> sellers) async {
    final allItems = <Map<String, dynamic>>[];
    final categories = [
      'Clothing',
      'Electronics',
      'Footwear',
      'Accessories',
      'Home Appliances',
      'Books',
      'Vegetables'
    ];

    for (var seller in sellers) {
      final sellerId = seller.id;
      for (var category in categories) {
        final snapshot = await FirebaseFirestore.instance
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
      }
    }
    return allItems;
  }
}

class _AnimatedCategoryCard extends StatefulWidget {
  final String category;
  final String imagePath;
  final int itemCount;
  final AnimationController animationController;
  final int index;
  final VoidCallback onTap;

  const _AnimatedCategoryCard({
    required this.category,
    required this.imagePath,
    required this.itemCount,
    required this.animationController,
    required this.index,
    required this.onTap,
  });

  @override
  State<_AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<_AnimatedCategoryCard> {
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    const intervalStart = 0.1;
    const intervalEnd = 0.5;
    final delay = intervalStart + (widget.index * 0.05);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          delay,
          delay + intervalEnd,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          delay,
          delay + intervalEnd,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _isHovering ? 1.03 : _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Card(
            elevation: _isHovering ? 8 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Category Image with Gradient Overlay
                Positioned.fill(
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),

                // Gradient Overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),

                // Category Info
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.category,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Iconsax.shop,
                              size: 16,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.itemCount} products',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Hover Effect
                if (_isHovering)
                  Positioned.fill(
                    child: Container(
                      color: Colors.deepOrange.withOpacity(0.2),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 40,
                          color: Colors.white,
                        ),
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