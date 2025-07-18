import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sadhana_cart/admin/cancelation_related_faqs_upload_screen.dart';
import 'package:sadhana_cart/admin/delivery_related_faqs_uplod_screen.dart';
import 'package:sadhana_cart/admin/grocery_related_faqs_upload_screen.dart';
import 'package:sadhana_cart/admin/login_related_faqs_upload_screen.dart';
import 'package:sadhana_cart/admin/payment_related_faqs_upload_screen.dart';
import 'package:sadhana_cart/admin/pickup_related_faqs_upload_screen.dart';
import 'package:sadhana_cart/admin/refund_related_faqs_screen.dart';
import 'package:sadhana_cart/admin/return_related_faqs_upload_screen.dart';
import 'package:sadhana_cart/admin/two_wheelers_related_faqs_upload_screen.dart';

// Individual Service Page
class ServiceDetailPage extends StatelessWidget {
  final String serviceName;
  final Color serviceColor;
  final IconData serviceIcon;

  const ServiceDetailPage({
    super.key,
    required this.serviceName,
    required this.serviceColor,
    required this.serviceIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
        backgroundColor: serviceColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, serviceColor.withOpacity(0.1)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: serviceName,
                child: Icon(
                  serviceIcon,
                  size: 100,
                  color: serviceColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$serviceName Service',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'This is the $serviceName service page. Add your specific service details and functionality here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServicesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {
      'name': 'Delivery',
      'icon': Icons.delivery_dining,
      'color': Colors.blue,
      'page': const DeliveryRelatedFaqsUplodScreen(),
    },
    {
      'name': 'Login',
      'icon': Icons.login,
      'color': Colors.green,
      'page': const LoginRelatedFaqsUploadScreen(),
    },
    {
      'name': 'Refund',
      'icon': Icons.money_off,
      'color': Colors.red,
      'page': const RefundRelatedFaqsUploadScreen(),
    },
    {
      'name': 'Payment',
      'icon': Icons.payment,
      'color': Colors.purple,
      'page': const PaymentRelatedFaqsUploadScreen(),
    },
    {
      'name': 'Return',
      'icon': Icons.assignment_return,
      'color': Colors.orange,
      'page': const ReturnRelatedFaqsUploadScreen(),
    },
    {
      'name': 'Pickup',
      'icon': Icons.local_shipping,
      'color': Colors.teal,
      'page': const PickupRelatedFaqsUploadScreen(),
    },
    {
      'name': 'Cancellation',
      'icon': Icons.cancel,
      'color': Colors.pink,
      'page': const CancelationRelatedFaqsUploadScreen(),
    },
    {
      'name': 'Grocery',
      'icon': Icons.shopping_cart,
      'color': Colors.amber,
      'page': const GroceryRelatedFaqsUploadScreen(),
    },
    {
      'name': 'Two Wheelers',
      'icon': Icons.two_wheeler,
      'color': Colors.indigo,
      'page': const TwoWheelersRelatedFaqsUploadScreen(),
    },
  ];

  ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Services',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black26,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade700, Colors.blue.shade400],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 3,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: ServiceCard(
                              service: services[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatefulWidget {
  final Map<String, dynamic> service;

  const ServiceCard({super.key, required this.service});

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.service['page']),
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  widget.service['color'].withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.service['name'],
                  child: Icon(
                    widget.service['icon'],
                    size: 48,
                    color: widget.service['color'],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.service['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
