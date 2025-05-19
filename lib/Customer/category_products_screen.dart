import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';

class CategoryProductsPage extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> allItems;

  const CategoryProductsPage({super.key, 
    required this.category,
    required this.allItems,
  });

  @override
  Widget build(BuildContext context) {
    // Filter items by the selected category
    List<Map<String, dynamic>> categoryItems = allItems
        .where((item) => item['category'] == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns
            crossAxisSpacing: 8, // Horizontal spacing between items
            mainAxisSpacing: 8, // Vertical spacing between items
            childAspectRatio: 0.7, // Width to height ratio of each item
          ),
          itemCount: categoryItems.length,
          itemBuilder: (context, index) {
            var item = categoryItems[index];
            Map<String, dynamic> productDetails = item['productDetails'] ?? {};
            String offerPrice = productDetails['Offer Price'] ?? '0';
            String price = productDetails['Price'] ?? '0';
            String size = productDetails['Size'] ?? 'No Size';
            String color = productDetails['Color'] ?? 'No Color';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParticularProductDetailsScreen(
                      productId: item['id'],
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                        child: item['images'] != null && item['images'].isNotEmpty
                            ? Image.network(
                          item['images'][0],
                          fit: BoxFit.cover,
                        )
                            : const Placeholder(),
                      ),
                    ),
                    // Product Details
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            item['name'] ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Prices
                          // Row(
                          //   children: [
                          //     Text(
                          //       '₹$offerPrice',
                          //       style: TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.red,
                          //       ),
                          //     ),
                          //     SizedBox(width: 4),
                          //     Text(
                          //       '₹$price',
                          //       style: TextStyle(
                          //         fontSize: 10,
                          //         color: Colors.grey,
                          //         decoration: TextDecoration.lineThrough,
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          Text(
                            '₹$offerPrice',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '₹$price',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Brand Name
                          Text(
                            item['brandName'] ?? 'No Brand',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}