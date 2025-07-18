// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class OrdersList extends StatelessWidget {
//   final String userId;
//
//   const OrdersList({required this.userId, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('customers')
//           .doc(userId)
//           .collection('orders')
//           .orderBy('timestamp', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No orders placed yet.'));
//         }
//
//         var orders = snapshot.data!.docs;
//
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: orders.length,
//           itemBuilder: (context, index) {
//             var order = orders[index].data() as Map<String, dynamic>;
//
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               elevation: 3,
//               child: ListTile(
//                 leading: order['images'] != null && order['images'].isNotEmpty
//                     ? Image.network(
//                   order['images'][0],
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                 )
//                     : const Icon(Icons.image, size: 50, color: Colors.grey),
//                 title: Text(order['name'] ?? 'No Name',
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Brand: ${order['brandName'] ?? 'Unknown'}"),
//                     Text("Category: ${order['category'] ?? 'N/A'}"),
//                     Text("Offer Price: ₹${order['Offer Price'] ?? 'N/A'}"),
//                     Text("Size: ${order['Size'] ?? 'N/A'}"),
//                     Text(
//                       "Ordered on: ${_formatTimestamp(order['timestamp'])}",
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//
//                   ],
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: () {
//                   // Optional: navigate to order details screen
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   String _formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return 'Unknown';
//     final date = timestamp.toDate();
//     return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
//   }
// }


// good


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class OrdersList extends StatelessWidget {
//   final String userId;
//
//
//   const OrdersList({required this.userId, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('customers')
//           .doc(userId)
//           .collection('orders')
//           .orderBy('timestamp', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No orders placed yet.'));
//         }
//
//         var orders = snapshot.data!.docs;
//
//
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: orders.length,
//           itemBuilder: (context, index) {
//             var order = orders[index].data() as Map<String, dynamic>;
//             var expectedDelivery = order['expectedDelivery'];
//
//             // Get order status, default to 'Pending' if not specified
//             var orderStatus = order['status'] ?? 'Pending';
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               elevation: 3,
//               child: ListTile(
//                 leading: order['images'] != null && order['images'].isNotEmpty
//                     ? Image.network(
//                   order['images'][0],
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                 )
//                     : const Icon(Icons.image, size: 50, color: Colors.grey),
//                 title: Text(order['name'] ?? 'No Name',
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Brand: ${order['brandName'] ?? 'Unknown'}"),
//                     Text("Category: ${order['category'] ?? 'N/A'}"),
//                     Text("Offer Price: ₹${order['Offer Price'] ?? 'N/A'}"),
//                     if (order['Size'] != null) Text("Size: ${order['Size']}"),
//                     Text("Order Status: $orderStatus",
//                         style: TextStyle(
//                           color: _getStatusColor(orderStatus),
//                           fontWeight: FontWeight.bold,
//                         )),
//                     if (expectedDelivery != null)
//                       Text("Expected Delivery: $expectedDelivery"),
//                     Text(
//                       "Ordered on: ${_formatTimestamp(order['timestamp'])}",
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                     if (order['productDetails']?['shopName'] != null)
//                       Text("Seller: ${order['productDetails']?['shopName']}"),
//                   ],
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: () {
//                   // Optional: navigate to order details screen
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   String _formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return 'Unknown';
//     final date = timestamp.toDate();
//     return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange;
//       case 'shipped':
//         return Colors.blue;
//       case 'delivered':
//         return Colors.green;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }



// ui is not good expected delivery also showing

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class WebOrdersList extends StatelessWidget {
//   final String userId;
//
//   const WebOrdersList({required this.userId, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('customers')
//           .doc(userId)
//           .collection('orders')
//           .orderBy('timestamp', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No orders placed yet.'));
//         }
//
//         var orders = snapshot.data!.docs;
//
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: orders.length,
//           itemBuilder: (context, index) {
//             var order = orders[index].data() as Map<String, dynamic>;
//             var orderData = order['productDetails'] ?? {};
//
//             // Debug: Print all available fields
//             debugPrint('Order fields: ${order.keys.toList()}');
//             if (orderData.isNotEmpty) {
//               debugPrint('ProductDetails fields: ${orderData.keys.toList()}');
//             }
//
//             // Try multiple possible field names for expected delivery
//             var expectedDelivery = order['expectedDelivery'] ??
//                 order['Expected Delivery'] ??
//                 orderData['expectedDelivery'] ??
//                 orderData['Expected Delivery'];
//
//             var orderStatus = order['status'] ?? 'Pending';
//
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               elevation: 3,
//               child: ListTile(
//                 leading: order['images'] != null && order['images'].isNotEmpty
//                     ? Image.network(
//                   order['images'][0],
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                   const Icon(Icons.image, size: 50, color: Colors.grey),
//                 )
//                     : const Icon(Icons.image, size: 50, color: Colors.grey),
//                 title: Text(order['name'] ?? 'No Name',
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Brand: ${order['brandName'] ?? 'Unknown'}"),
//                     Text("Category: ${order['category'] ?? 'N/A'}"),
//                     Text("Price: ₹${order['Offer Price'] ?? order['price'] ?? 'N/A'}"),
//                     if (order['Size'] != null)
//                       Text("Size: ${order['Size']}"),
//                     Text("Status: ${orderStatus.toString().toUpperCase()}",
//                         style: TextStyle(
//                           color: _getStatusColor(orderStatus.toString()),
//                           fontWeight: FontWeight.bold,
//                         )),
//                     if (expectedDelivery != null && expectedDelivery.toString().isNotEmpty)
//                       Text("Expected Delivery: ${_formatDeliveryDate(expectedDelivery)}"),
//                     Text(
//                       "Ordered on: ${_formatTimestamp(order['timestamp'])}",
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                     if (orderData['shopName'] != null)
//                       Text("Seller: ${orderData['shopName']}"),
//                   ],
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: () {
//                   // Navigate to order details if needed
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   String _formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return 'Unknown';
//     final date = timestamp.toDate();
//     return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
//   }
//
//   String _formatDeliveryDate(dynamic deliveryDate) {
//     if (deliveryDate == null) return 'Not specified';
//
//     // Handle if it's a Timestamp
//     if (deliveryDate is Timestamp) {
//       final date = deliveryDate.toDate();
//       return "${date.day}/${date.month}/${date.year}";
//     }
//
//     // Handle if it's already a string
//     return deliveryDate.toString();
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange;
//       case 'shipped':
//         return Colors.blue;
//       case 'delivered':
//         return Colors.green;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }



//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WebOrdersList extends StatelessWidget {
  final String userId;

  const WebOrdersList({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('customers')
          .doc(userId)
          .collection('orders')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No orders placed yet.', style: TextStyle(fontSize: 18)));
        }

        var orders = snapshot.data!.docs;

        return AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index].data() as Map<String, dynamic>;
              var orderData = order['productDetails'] ?? {};
              var expectedDelivery = order['expectedDelivery'] ??
                  order['Expected Delivery'] ??
                  orderData['expectedDelivery'] ??
                  orderData['Expected Delivery'];
              var orderStatus = order['status'] ?? 'Pending';

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  horizontalOffset: 100.0,
                  child: FadeInAnimation(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ],
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: order['images'] != null && order['images'].isNotEmpty
                                  ? Image.network(
                                order['images'][0],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.broken_image,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              )
                                  : const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order['name'] ?? 'No Name',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Wrap(
                                    spacing: 20,
                                    runSpacing: 6,
                                    children: [
                                      _buildDetail("Brand", order['brandName']),
                                      _buildDetail("Category", order['category']),
                                      _buildDetail("Price", "₹${order['Offer Price'] ?? order['price'] ?? 'N/A'}"),
                                      if (order['Size'] != null) _buildDetail("Size", order['Size']),
                                      _buildDetail(
                                        "Status",
                                        orderStatus.toString().toUpperCase(),
                                        color: _getStatusColor(orderStatus.toString()),
                                        isBold: true,
                                      ),
                                      if (expectedDelivery != null && expectedDelivery.toString().isNotEmpty)
                                        _buildDetail("Expected Delivery", _formatDeliveryDate(expectedDelivery)),
                                      _buildDetail("Ordered On", _formatTimestamp(order['timestamp'])),
                                      if (orderData['shopName'] != null)
                                        _buildDetail("Seller", orderData['shopName']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDetail(String title, dynamic value, {Color? color, bool isBold = false}) {
    return Text(
      "$title: $value",
      style: TextStyle(
        fontSize: 14,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color ?? Colors.black87,
      ),
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown';
    final date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  String _formatDeliveryDate(dynamic deliveryDate) {
    if (deliveryDate == null) return 'Not specified';
    if (deliveryDate is Timestamp) {
      final date = deliveryDate.toDate();
      return "${date.day}/${date.month}/${date.year}";
    }
    return deliveryDate.toString();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}





