import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetSoldProductByCustomer>(context, listen: false)
        .fetchSoldProductsByCustomer(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetSoldProductByCustomer>(context);
    final orders = provider.allSoldProductByCustomer;
    return Scaffold(
        appBar: AppBar(title: const Text("My Orders")),
        body: orders.isEmpty
            ? const Center(child: Text("No Products Ordered"))
            : Consumer<GetSoldProductByCustomer>(
                builder: (context, value, child) {
                  final orders = value.allSoldProductByCustomer;
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        child: ListTile(
                          leading: order['images'] != null &&
                                  order['images'] is List &&
                                  order['images'].isNotEmpty
                              ? Image.network(
                                  order['images'][0],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image,
                                  size: 50, color: Colors.grey),
                          title: Text(order['name'] ?? 'No Name',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
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
                        ),
                      );
                    },
                  );
                },
              ));
  }
}

String _formatTimestamp(Timestamp? timestamp) {
  if (timestamp == null) return 'Unknown';
  final date = timestamp.toDate();
  return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
}
