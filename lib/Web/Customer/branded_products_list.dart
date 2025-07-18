import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
import 'package:sadhana_cart/Web/Customer/particular_product_details_screen.dart';

class WebBrandProductsPage extends StatelessWidget {
  final String brandName;
  final List<Map<String, dynamic>> allItems;

  const WebBrandProductsPage({
    super.key,
    required this.brandName,
    required this.allItems,
  });

  @override
  Widget build(BuildContext context) {
    // Filter items by brand name
    List<Map<String, dynamic>> brandItems = allItems
        .where((item) => item['brandName'] == brandName && item['bannerUrl'] == null)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(brandName),
      ),
      body: brandItems.isEmpty
          ? Center(child: Text('No products found for $brandName'))
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.68,
        ),
        itemCount: brandItems.length,
        itemBuilder: (context, index) {
          final item = brandItems[index];
          final productDetails = item['productDetails'] ?? {};

          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   '/particular_product_details',
              //   arguments: {'productId': item['id']},
              // );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebParticularProductDetailsScreen(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                    child: SizedBox(
                      height: 135,
                      width: double.infinity,
                      child: item['images'] != null && item['images'].isNotEmpty
                          ? Image.network(
                        item['images'][0],
                        fit: BoxFit.cover,
                      )
                          : Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          style:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (productDetails['Offer Price'] != null)
                              Text(
                                '₹${productDetails['Offer Price']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                            const SizedBox(width: 4),
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
                      ],
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