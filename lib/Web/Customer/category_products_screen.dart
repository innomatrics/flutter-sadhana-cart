// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
//
// class CategoryProductsPage extends StatelessWidget {
//   final String category;
//   final List<Map<String, dynamic>> allItems;
//
//   const CategoryProductsPage({super.key,
//     required this.category,
//     required this.allItems,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter items by the selected category
//     List<Map<String, dynamic>> categoryItems = allItems
//         .where((item) => item['category'] == category)
//         .toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$category Products'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // 3 columns
//             crossAxisSpacing: 8, // Horizontal spacing between items
//             mainAxisSpacing: 8, // Vertical spacing between items
//             childAspectRatio: 0.7, // Width to height ratio of each item
//           ),
//           itemCount: categoryItems.length,
//           itemBuilder: (context, index) {
//             var item = categoryItems[index];
//             Map<String, dynamic> productDetails = item['productDetails'] ?? {};
//             String offerPrice = productDetails['Offer Price'] ?? '0';
//             String price = productDetails['Price'] ?? '0';
//             String size = productDetails['Size'] ?? 'No Size';
//             String color = productDetails['Color'] ?? 'No Color';
//
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ParticularProductDetailsScreen(
//                       productId: item['id'],
//                     ),
//                   ),
//                 );
//               },
//               child: Card(
//                 elevation: 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Product Image
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
//                         ),
//                         child: item['images'] != null && item['images'].isNotEmpty
//                             ? Image.network(
//                           item['images'][0],
//                           fit: BoxFit.cover,
//                         )
//                             : const Placeholder(),
//                       ),
//                     ),
//                     // Product Details
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Product Name
//                           Text(
//                             item['name'] ?? 'No Name',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 4),
//                           // Prices
//                           // Row(
//                           //   children: [
//                           //     Text(
//                           //       '₹$offerPrice',
//                           //       style: TextStyle(
//                           //         fontSize: 12,
//                           //         fontWeight: FontWeight.bold,
//                           //         color: Colors.red,
//                           //       ),
//                           //     ),
//                           //     SizedBox(width: 4),
//                           //     Text(
//                           //       '₹$price',
//                           //       style: TextStyle(
//                           //         fontSize: 10,
//                           //         color: Colors.grey,
//                           //         decoration: TextDecoration.lineThrough,
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//
//                           Text(
//                             '₹$offerPrice',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             '₹$price',
//                             style: const TextStyle(
//                               fontSize: 10,
//                               color: Colors.grey,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           // Brand Name
//                           Text(
//                             item['brandName'] ?? 'No Brand',
//                             style: const TextStyle(
//                               fontSize: 10,
//                               color: Colors.grey,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




// Updating ui



import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sadhana_cart/Customer/particular_product_details_screen.dart';
import 'package:sadhana_cart/Web/Customer/particular_product_details_screen.dart';

class WebCategoryProductsPage extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> allItems;

  const WebCategoryProductsPage({
    super.key,
    required this.category,
    required this.allItems,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categoryItems =
    allItems.where((item) => item['category'] == category).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$category Products'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimationLimiter(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 columns
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.70,
            ),
            itemCount: categoryItems.length,
            itemBuilder: (context, index) {
              final item = categoryItems[index];
              final productDetails = item['productDetails'] ?? {};
              final offerPrice = productDetails['Offer Price'] ?? '0';
              final price = productDetails['Price'] ?? '0';
              final hasImage = item['images'] != null && item['images'].isNotEmpty;

              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 4,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebParticularProductDetailsScreen(
                              productId: item['id'],
                            ),
                          ),
                        );
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image with SALE badge
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: hasImage
                                          ? Image.network(
                                        item['images'][0],
                                        fit: BoxFit.cover,
                                      )
                                          : Container(
                                        color: Colors.deepOrange.shade100,
                                        child: const Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (offerPrice != price)
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.deepOrange,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'SALE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              // Details section
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Ratings


                                      // Product Name
                                      Text(
                                        item['name'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),

                                      // Brand
                                      Text(
                                        item['brandName'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      // Price Section
                                      Row(
                                        children: [
                                          Text(
                                            '₹$offerPrice',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepOrange,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          if (offerPrice != price)
                                            Text(
                                              '₹$price',
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
                              ),
                            ],
                          ),
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
    );
  }
}





