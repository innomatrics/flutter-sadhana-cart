import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
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
      body: _isSearching
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
          ? Center(
        child: Text(
          _searchController.text.isEmpty
              ? 'Search for products'
              : 'No products found',
          style: const TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final product = _searchResults[index];
          final productDetails = product['productDetails'] ?? {};

          return ListTile(
            leading: product['images'] != null &&
                product['images'] is List &&
                product['images'].isNotEmpty
                ? Image.network(
              product['images'][0],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.image_not_supported),
            title: Text(product['name'] ?? 'No Name'),
            subtitle: Text(product['brandName'] ?? 'No Brand'),
            trailing: productDetails['Offer Price'] != null
                ? Text(
              '₹${productDetails['Offer Price']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            )
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParticularProductDetailsScreen(
                    productId: product['id'],
                    // You can also pass other values like sellerId, category if needed
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
