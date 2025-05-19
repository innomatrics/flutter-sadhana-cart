import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/admin/provider/product_provider.dart';

class AdminViewSellerProducts extends StatelessWidget {
  final Map<String, dynamic> sellerProducts;
  const AdminViewSellerProducts({super.key, required this.sellerProducts});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          sellerProducts['name'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider for Images and Videos
            CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                ),
                items: (sellerProducts['images'] as List<dynamic>)
                    .map((images) => Container(
                          height: size.height * 0.30,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(images),
                                fit: BoxFit.fitHeight),
                          ),
                        ))
                    .toList()),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display product name
                  Text(
                    "${sellerProducts['name']}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price Information Section
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pricing Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text(
                                'Offer Price: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '₹${sellerProducts['Offer Price'] ?? 'Not Available'}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                'Original Price: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '₹${sellerProducts['Price'] ?? 'Not Available'}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (sellerProducts['Discount'] != null)
                            Row(
                              children: [
                                const Text(
                                  'Discount: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${sellerProducts['Discount']}%',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Basic Information Section
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Basic Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          _buildDetailRow('Brand', sellerProducts['brandName']),
                          _buildDetailRow('Shop', sellerProducts['shopName']),
                          _buildDetailRow(
                              'Category', sellerProducts['category']),
                          _buildDetailRow(
                              'Description', sellerProducts['description']),
                          // _buildDetailRow('Cash on Delivery',
                          //     productDetails['isShowCashOnDelivery']),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product Specifications Section
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Specifications',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          // Dynamically display all fields from productInfo
                          ...sellerProducts.entries.map((entry) {
                            // Skip fields already shown in pricing section
                            if ([
                              'Offer Price',
                              'Price',
                              'Discount',
                              'productId',
                              'images',
                              'videos',
                              'timestamp',
                              'isShowCashOnDelivery'
                            ].contains(entry.key)) {
                              return const SizedBox.shrink();
                            }
                            return _buildDetailRow(entry.key, entry.value);
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    final provider =
                        Provider.of<ProductProvider>(context, listen: false);

                    final bool isSuccess =
                        await provider.adminDeleteSellerProduct(
                            context: context,
                            productId: sellerProducts['productId']);
                    log(isSuccess.toString());
                    log('${sellerProducts['productId']}');
                    if (isSuccess && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product deleted successfully'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Delete Product",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailRow(String label, dynamic value) {
  if (value == null || value.toString().isEmpty) {
    return const SizedBox.shrink();
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
