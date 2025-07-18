import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
import 'package:sadhana_cart/Web/Customer/particular_product_details_screen.dart';

class WebCategorySeeAllScreen extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> items;

  const WebCategorySeeAllScreen({
    super.key,
    required this.category,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All $category Products'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.65, // Adjusted ratio
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = items[index];
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
                  builder: (context) =>   WebParticularProductDetailsScreen(
                    productId: item['id'],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3, // Takes 3 parts of available space
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: item['images'] != null && item['images'].isNotEmpty
                            ? Image.network(
                          item['images'][0],
                          fit: BoxFit.cover,
                        )
                            : const Placeholder(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2, // Takes 2 parts of available space
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            item['name'] ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                '₹$offerPrice',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '₹$price',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            item['brandName'] ?? 'No Brand Name',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}