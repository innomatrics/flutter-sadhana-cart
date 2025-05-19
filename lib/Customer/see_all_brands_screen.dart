// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/branded_products_list.dart';
//
// class AllBrandsPage extends StatelessWidget {
//   final List<String> brandNames;
//   final List<Map<String, dynamic>> allItems;
//
//   const AllBrandsPage({
//     Key? key,
//     required this.brandNames,
//     required this.allItems,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Brands'),
//       ),
//       body: brandNames.isEmpty
//           ? Center(child: Text('No brands available'))
//           : GridView.builder(
//         padding: const EdgeInsets.all(16.0),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3, // 3 brands per row
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 1.0, // Square items
//         ),
//         itemCount: brandNames.length,
//         itemBuilder: (context, index) {
//           String brandName = brandNames[index];
//
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BrandProductsPage(
//                     brandName: brandName,
//                     allItems: allItems,
//                   ),
//                 ),
//               );
//             },
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.grey[200],
//                     child: Text(
//                       brandName[0].toUpperCase(),
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     brandName,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     textAlign: TextAlign.center,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/branded_products_list.dart';

class AllBrandsPage extends StatelessWidget {
  final List<String> brandNames;
  final List<Map<String, dynamic>> allItems;

  // Define the same list of unique colors as in HomeTab
  final List<Color> brandColors = [
    Colors.blue[300]!,
    Colors.red[300]!,
    Colors.green[300]!,
    Colors.purple[300]!,
    Colors.orange[300]!,
    Colors.teal[300]!,
    Colors.pink[300]!,
    Colors.cyan[300]!,
    Colors.amber[300]!,
    Colors.lime[300]!,
    // Add more colors if you expect more brands
  ];

   AllBrandsPage({
    super.key,
    required this.brandNames,
    required this.allItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Brands'),
      ),
      body: brandNames.isEmpty
          ? const Center(child: Text('No brands available'))
          : GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 brands per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.0, // Square items
        ),
        itemCount: brandNames.length,
        itemBuilder: (context, index) {
          String brandName = brandNames[index];
          // Select color based on index, cycling through brandColors
          Color brandColor = brandColors[index % brandColors.length];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BrandProductsPage(
                    brandName: brandName,
                    allItems: allItems,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: brandColor, // Use unique brand color
                    child: Text(
                      brandName[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White for better contrast
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    brandName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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