import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/provider/seller_product_provider.dart';

class SellerOwnOrder extends StatelessWidget {
  final int currentIndex;

  const SellerOwnOrder({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Consumer<SellerProductProvider>(
        builder: (context, value, child) {
          final order = value.filteredOrders;

          // Status-based filtering from filtered list
          final recievedOrders =
              order.where((e) => e['status'] == "pending").toList();
          final pendingOrders =
              order.where((e) => e['status'] == "recieved").toList();
          final shippedOrders =
              order.where((e) => e['status'] == "shipped").toList();
          final canceledOrders =
              order.where((e) => e['status'] == "canceled").toList();

          final orderToDisplay = currentIndex == 1
              ? recievedOrders
              : currentIndex == 2
                  ? pendingOrders
                  : currentIndex == 3
                      ? shippedOrders
                      : currentIndex == 4
                          ? canceledOrders
                          : order;

          return orderToDisplay.isEmpty
              ? const Center(child: Text("No orders found"))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: orderToDisplay.length,
                  itemBuilder: (context, index) {
                    final orders = orderToDisplay[index];
                    final formatDate =
                        value.formatTimestamp(orders['timestamp']);
                    final paymentMethods =
                        orders['paymentMethod'] == "Cash on Delivery"
                            ? "COD"
                            : "Online";

                    return Container(
                      margin: EdgeInsets.all(size.width * 0.02),
                      child: Container(
                        padding: EdgeInsets.all(size.width * 0.04),
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          spacing: size.height * 0.01,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _customRichText(
                                  text: "Order ID: ",
                                  text2: "${orders['orderId']}",
                                ),
                                Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.20,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${orders['status']}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade400,
                              thickness: 0.4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _customTextWithIcon(
                                  icon: Icons.person,
                                  text: "${orders['name']}",
                                ),
                                _customTextWithIcon(
                                  icon: Icons.contact_page,
                                  text: "${orders['phone']}",
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _customTextWithIcon(
                                  icon: Icons.currency_rupee,
                                  text: "${orders['Price']}",
                                ),
                                _customTextWithIcon(
                                  icon: Icons.payment,
                                  text: paymentMethods,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.date_range),
                                _customRichText(
                                  text: "Date: ",
                                  text2: formatDate,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget _customTextWithIcon({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _customRichText({required String text, required String text2}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        children: [
          TextSpan(
            text: text2,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
