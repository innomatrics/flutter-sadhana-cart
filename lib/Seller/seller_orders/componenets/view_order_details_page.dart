import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/provider/seller_product_provider.dart';

class ViewOrderDetailsPage extends StatefulWidget {
  final Map<String, dynamic> order;

  const ViewOrderDetailsPage({super.key, required this.order});

  @override
  State<ViewOrderDetailsPage> createState() => _ViewOrderDetailsPageState();
}

class _ViewOrderDetailsPageState extends State<ViewOrderDetailsPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String productName = widget.order['name'] ?? 'N/A';
    final String brand = widget.order['brandName'] ?? 'N/A';
    final String category = widget.order['category'] ?? 'N/A';
    final String description = widget.order['description'] ?? 'N/A';
    final int quantity = widget.order['quantity'] ?? 0;
    final String orderId = widget.order['orderId'] ?? 'N/A';
    final String customerId = widget.order['customerId'] ?? 'N/A';
    final String payment =
        widget.order['paymentMethod'] == 'Cash on Delivery' ? 'COD' : 'Online';
    final String status =
        (widget.order['status'] ?? 'N/A').toString().toUpperCase();
    final int total = widget.order['totalAmount'] ?? 0;
    final String offerPrice = widget.order['Offer Price'] ?? 'N/A';
    final String regularPrice = widget.order['Price'] ?? 'N/A';

    final Map<String, dynamic> address = widget.order['addressDetails'] ?? {};
    final String fullName = address['fullName'] ?? 'N/A';
    final String addressLine = address['addressLine1'] ?? '';
    final String city = address['city'] ?? '';
    final String state = address['state'] ?? '';
    final String postal = address['postalCode'] ?? '';

    final timestamp = widget.order['timestamp'];
    final formattedDate = timestamp is DateTime
        ? DateFormat('dd MMM yyyy, hh:mm a').format(timestamp)
        : 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: AbsorbPointer(
          absorbing: isLoading,
          child: Stack(
            children: [
              Column(
                children: [
                  /// Product Info
                  _sectionCard(
                    title: "Product Info",
                    children: [
                      _labelValue("Name", productName),
                      _labelValue("Brand", brand),
                      _labelValue("Category", category),
                      _labelValue("Description", description),
                    ],
                  ),

                  /// Pricing Info
                  _sectionCard(
                    title: "Pricing",
                    children: [
                      _labelValue("Regular Price", "₹$regularPrice"),
                      _labelValue("Offer Price", "₹$offerPrice"),
                      _labelValue("Quantity", "$quantity"),
                      _labelValue("Total Amount", "₹$total"),
                      _labelValue("Payment Method", payment),
                    ],
                  ),

                  /// Order Info
                  _sectionCard(
                    title: "Order Details",
                    children: [
                      _labelValue("Order Status", status),
                      _labelValue("Order Date", formattedDate),
                    ],
                  ),

                  /// Address Info
                  _sectionCard(
                    title: "Shipping Address",
                    children: [
                      _labelValue("Name", fullName),
                      _labelValue(
                          "Address", "$addressLine, $city, $state - $postal"),
                    ],
                  ),
                  context.read<SellerProductProvider>().statusDropDown(
                      isLoading: isLoading,
                      size: size,
                      orderId: orderId,
                      customerId: customerId)
                ],
              ),
              if (isLoading)
                Container(
                  height: size.height * 1,
                  width: size.width * 1,
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  /// Card container for sections
  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  /// Label + value row
  Widget _labelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ",
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey)),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
