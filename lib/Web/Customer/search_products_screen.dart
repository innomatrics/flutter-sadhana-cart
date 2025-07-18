// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key, required String searchQuery});
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _searchResults = [];
//   bool _isSearching = false;
//
//   Future<void> _searchProducts(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//         _isSearching = false;
//       });
//       return;
//     }
//
//     setState(() {
//       _isSearching = true;
//     });
//
//     try {
//       final searchQuery = query.toLowerCase();
//       final sellers = await FirebaseFirestore.instance.collection('seller').get();
//
//       List<Map<String, dynamic>> results = [];
//
//       for (var seller in sellers.docs) {
//         final categories = [
//           'Clothing',
//           'Electronics',
//           'Footwear',
//           'Accessories',
//           'Home Appliances',
//           'Books',
//           'Vegetables'
//         ];
//
//         for (var category in categories) {
//           final snapshot = await FirebaseFirestore.instance
//               .collection('seller')
//               .doc(seller.id)
//               .collection(category)
//               .get();
//
//           for (var doc in snapshot.docs) {
//             final product = doc.data();
//             final productName = product['name']?.toString().toLowerCase() ?? '';
//             final brandName = product['brandName']?.toString().toLowerCase() ?? '';
//
//             if (productName.contains(searchQuery) || brandName.contains(searchQuery)) {
//               results.add({
//                 ...product,
//                 'sellerId': seller.id,
//                 'category': category,
//                 'id': doc.id,
//               });
//             }
//           }
//         }
//       }
//
//       setState(() {
//         _searchResults = results;
//         _isSearching = false;
//       });
//     } catch (e) {
//       print('Search error: $e');
//       setState(() {
//         _isSearching = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Container(
//           height: 45,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: _searchController,
//             autofocus: true,
//             style: const TextStyle(fontSize: 16),
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               hintText: 'Search for products...',
//               hintStyle: const TextStyle(color: Colors.grey),
//               border: InputBorder.none,
//               prefixIcon: const Icon(Icons.search, color: Colors.grey),
//               suffixIcon: _searchController.text.isNotEmpty
//                   ? IconButton(
//                 icon: const Icon(Icons.clear, color: Colors.grey),
//                 onPressed: () {
//                   _searchController.clear();
//                   _searchProducts('');
//                 },
//               )
//                   : null,
//             ),
//             onChanged: (query) {
//               _searchProducts(query);
//             },
//           ),
//         ),
//       ),
//       body: _isSearching
//           ? const Center(child: CircularProgressIndicator())
//           : _searchResults.isEmpty
//           ? Center(
//         child: Text(
//           _searchController.text.isEmpty
//               ? 'Search for products'
//               : 'No products found',
//           style: const TextStyle(fontSize: 16),
//         ),
//       )
//           : ListView.builder(
//         itemCount: _searchResults.length,
//         itemBuilder: (context, index) {
//           final product = _searchResults[index];
//           final productDetails = product['productDetails'] ?? {};
//
//           return ListTile(
//             leading: product['images'] != null &&
//                 product['images'] is List &&
//                 product['images'].isNotEmpty
//                 ? Image.network(
//               product['images'][0],
//               width: 50,
//               height: 50,
//               fit: BoxFit.cover,
//             )
//                 : const Icon(Icons.image_not_supported),
//             title: Text(product['name'] ?? 'No Name'),
//             subtitle: Text(product['brandName'] ?? 'No Brand'),
//             trailing: productDetails['Offer Price'] != null
//                 ? Text(
//               '₹${productDetails['Offer Price']}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             )
//                 : null,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ParticularProductDetailsScreen(
//                     productId: product['id'],
//                     // You can also pass other values like sellerId, category if needed
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
import 'package:sadhana_cart/Web/Customer/particular_product_details_screen.dart';

class WebSearchScreen extends StatefulWidget {
  const WebSearchScreen({super.key, required String searchQuery});

  @override
  _WebSearchScreenState createState() => _WebSearchScreenState();
}

class _WebSearchScreenState extends State<WebSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  Future<void> _searchProducts(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final searchQuery = query.toLowerCase();
      final sellers = await FirebaseFirestore.instance.collection('seller').get();

      List<Map<String, dynamic>> results = [];

      for (var seller in sellers.docs) {
        final categories = [
          'Clothing',
          'Electronics',
          'Footwear',
          'Accessories',
          'Home Appliances',
          'Books',
          'Vegetables'
        ];

        for (var category in categories) {
          final snapshot = await FirebaseFirestore.instance
              .collection('seller')
              .doc(seller.id)
              .collection(category)
              .get();

          for (var doc in snapshot.docs) {
            final product = doc.data();
            final productName = product['name']?.toString().toLowerCase() ?? '';
            final brandName = product['brandName']?.toString().toLowerCase() ?? '';

            if (productName.contains(searchQuery) || brandName.contains(searchQuery)) {
              results.add({
                ...product,
                'sellerId': seller.id,
                'category': category,
                'id': doc.id,
              });
            }
          }
        }
      }

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      print('Search error: $e');
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              hintText: 'Search for products...',
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _searchController.clear();
                  _searchProducts('');
                },
              )
                  : null,
            ),
            onChanged: (query) {
              _searchProducts(query);
            },
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isSearching
            ? const Center(child: CircularProgressIndicator())
            : _searchResults.isEmpty
            ? Center(
          key: const ValueKey('empty'),
          child: Text(
            _searchController.text.isEmpty
                ? 'Search for products'
                : 'No products found',
            style: const TextStyle(fontSize: 16),
          ),
        )
            : ListView.builder(
          key: const ValueKey('results'),
          padding: const EdgeInsets.all(16),
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final product = _searchResults[index];
            final productDetails = product['productDetails'] ?? {};

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebParticularProductDetailsScreen(
                      productId: product['id'],
                    ),
                  ),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: product['images'] != null &&
                          product['images'] is List &&
                          product['images'].isNotEmpty
                          ? Image.network(
                        product['images'][0],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Product Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product['brandName'] ?? 'No Brand',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Category: ${product['category'] ?? 'Unknown'}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (productDetails['Offer Price'] != null)
                          Text(
                            '₹${productDetails['Offer Price']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        if (productDetails['Original Price'] != null &&
                            productDetails['Original Price'] !=
                                productDetails['Offer Price'])
                          Text(
                            '₹${productDetails['Original Price']}',
                            style: const TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}










