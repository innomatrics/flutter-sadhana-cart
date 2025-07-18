import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/provider/seller_product_provider.dart';
import 'package:sadhana_cart/Seller/seller_orders/componenets/view_order_details_page.dart';

class SellerOwnOrder extends StatelessWidget {
  final int currentIndex;

  const SellerOwnOrder({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Consumer<SellerProductProvider>(
        builder: (context, value, child) {
          final orders = value.filteredOrders;

          final filteredOrders = {
                1: orders.where((e) => e['status'] == "Pending").toList(),
                2: orders.where((e) => e['status'] == "Received").toList(),
                3: orders.where((e) => e['status'] == "Shipped").toList(),
                4: orders.where((e) => e['status'] == "Canceled").toList(),
              }[currentIndex] ??
              orders;

          return filteredOrders.isEmpty
              ? const Center(child: Text("No orders found"))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredOrders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    final formatDate =
                        value.formatTimestamp(order['timestamp']);
                    final status =
                        (order['status'] ?? '').toString().toLowerCase();
                    final statusColor = _getStatusColor(status);
                    final payment = order['paymentMethod'] == "Cash on Delivery"
                        ? "COD"
                        : "Online";

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewOrderDetailsPage(order: order)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Order ID & Status Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _labelValue(
                                      "Order ID",
                                      order['orderId'] ?? 'N/A',
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  _statusBadge(status, statusColor),
                                ],
                              ),

                              const SizedBox(height: 12),
                              const Divider(),

                              /// Product Name (Single Row)
                              _infoRowSingle(
                                Icons.shopping_bag,
                                order['name'] ?? 'N/A',
                              ),

                              /// Price and Payment
                              _infoRow(
                                Icons.currency_rupee,
                                "${order['Price'] ?? '0'}",
                                Icons.payment,
                                payment,
                              ),

                              /// Date Row
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.date_range,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        "Date: $formatDate",
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  /// Two columns in one row
  Widget _infoRow(
    IconData icon1,
    String value1,
    IconData icon2,
    String value2,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _iconText(icon1, value1)),
          const SizedBox(width: 12),
          Expanded(child: _iconText(icon2, value2)),
        ],
      ),
    );
  }

  /// Single info row
  Widget _infoRowSingle(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: _iconText(icon, value),
    );
  }

  /// Icon with text & overflow handling
  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Order ID label + value
  Widget _labelValue(String label, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        children: [
          TextSpan(text: "$label: "),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// Status badge
  Widget _statusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  /// Status-based color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'received':
        return Colors.blue;
      case 'shipped':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
