import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  final String userId;

  const OrdersList({required this.userId, super.key});

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
          return const Center(child: Text('No orders placed yet.'));
        }

        var orders = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index].data() as Map<String, dynamic>;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: ListTile(
                leading: order['images'] != null && order['images'].isNotEmpty
                    ? Image.network(
                  order['images'][0],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.image, size: 50, color: Colors.grey),
                title: Text(order['name'] ?? 'No Name',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Brand: ${order['brandName'] ?? 'Unknown'}"),
                    Text("Category: ${order['category'] ?? 'N/A'}"),
                    Text("Price: ₹${order['Offer Price'] ?? 'N/A'}"),
                    Text("Size: ${order['Size'] ?? 'N/A'}"),
                    Text(
                      "Ordered on: ${_formatTimestamp(order['timestamp'])}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Optional: navigate to order details screen
                },
              ),
            );
          },
        );
      },
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown';
    final date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
}
