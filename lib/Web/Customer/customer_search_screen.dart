// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
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
//         backgroundColor: Colors.deepOrange,
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



// ui is avarage



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sadhana_cart/Web/Customer/particular_product_details_screen.dart';

class WebSearchScreen extends StatefulWidget {
  const WebSearchScreen({super.key});

  @override
  _WebSearchScreenState createState() => _WebSearchScreenState();
}

class _WebSearchScreenState extends State<WebSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
  }

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
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.deepOrange.shade700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.deepOrange),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey),
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

          // Sales header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sales',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.deepOrange.shade700,
                  ),
                ),
                Text(
                  'Show: ${_searchResults.length}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 20, thickness: 1, indent: 16, endIndent: 16),

          // Search results list
          Expanded(
            child: _isSearching
                ? Center(child: CircularProgressIndicator(color: Colors.deepOrange))
                : _searchResults.isEmpty
                ? Center(
              child: Text(
                _searchController.text.isEmpty
                    ? 'Search for products'
                    : 'No products found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final product = _searchResults[index];
                  final productDetails = product['productDetails'] ?? {};
                  final originalPrice = productDetails['Original Price'] ?? '';
                  final offerPrice = productDetails['Offer Price'] ?? '';

                  return // Inside the ListView.builder's itemBuilder:
                    AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Card(
                              elevation: 0,
                              color: Colors.grey.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: product['images'] != null &&
                                    product['images'] is List &&
                                    product['images'].isNotEmpty
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product['images'][0],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey.shade200,
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey.shade400,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                    : Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                title: Text(
                                  product['name'] ?? 'No Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      if (offerPrice.isNotEmpty)
                                        Text(
                                          '₹$offerPrice',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.deepOrange.shade700,
                                          ),
                                        ),
                                      if (originalPrice.isNotEmpty && offerPrice.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '₹$originalPrice',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey.shade500,
                                ),
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
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//






