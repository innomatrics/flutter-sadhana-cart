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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/category_products_screen.dart';

class CategoriesTab extends StatelessWidget {
  // Map category names to asset image paths
  final Map<String, String> categoryImages = {
    'Clothing': 'assets/images/clothings_category_customer_hometab.jpeg',
    'Electronics': 'assets/images/Electronics_category_customer_hometab.jpeg',
    'Footwear': 'assets/images/footwear_category_customer_hometab.jpeg',
    'Accessories': 'assets/images/Accessories_category.jpg',
    'Home Appliances': 'assets/images/home_appliences_category.jpg',
    'Books': 'assets/images/books_category.jpeg',
    'Others': 'assets/images/vegetables_category.jpeg',
  };

  CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        // Fetch all sellers
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

          // Fetch items for each seller
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

              // Organize items by category
              Map<String, List<Map<String, dynamic>>> itemsByCategory = {};
              for (var item in itemSnapshot.data!) {
                String category = item['category'];
                if (!itemsByCategory.containsKey(category)) {
                  itemsByCategory[category] = [];
                }
                itemsByCategory[category]!.add(item);
              }

              // Extract unique categories
              List<String> categories = itemsByCategory.keys.toList();

              return Column(
                children: [
                  // Horizontal scrollable category list with circular images
                  // Grid layout with 3 columns
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 items per row
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.9, // Adjust height/width ratio
                        ),
                        itemBuilder: (context, index) {
                          String category = categories[index];
                          String imagePath = categoryImages[category] ??
                              'assets/images/Sadhana_cart1.png';

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryProductsPage(
                                    category: category,
                                    allItems: itemSnapshot.data!,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // CircleAvatar(
                                //   radius: 30,
                                //   backgroundImage: AssetImage(imagePath),
                                // ),

                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(imagePath),
                                      fit: BoxFit
                                          .cover, // Makes sure image covers the container
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        8), // Rounded corners (optional)
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                ),

                                const SizedBox(height: 8),
                                Text(
                                  category,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Display items in a carousel slider for each category
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Fetch all items for all sellers
  Future<List<Map<String, dynamic>>> _fetchAllSellerItems(
      List<QueryDocumentSnapshot> sellers) async {
    List<Map<String, dynamic>> allItems = [];

    for (var seller in sellers) {
      String sellerId = seller.id;

      // Manually fetch subcollections (categories) for the seller
      var categories = [
        'Clothing',
        'Electronics',
        'Footwear',
        'Accessories',
        'Home Appliances',
        'Books',
        'Vegetables'
      ]; // Add all your categories here

      for (var category in categories) {
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
            'id': doc.id, // Ensure the item ID is included
          });
        }
      }
    }

    return allItems;
  }
}
