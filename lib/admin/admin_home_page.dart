import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sadhana_cart/admin/dash_board/admin_dashboard.dart';
import 'package:sadhana_cart/admin/products/list_of_products.dart';
import 'package:sadhana_cart/admin/seller_applications/list_of_seller_application.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Seller Details',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      drawer: const AdminDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('seller')
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No pending sellers.'));
          }

          final sellers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: sellers.length,
            itemBuilder: (context, index) {
              final seller = sellers[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(seller['shopName']),
                subtitle: Text(
                    '${seller['name']} | ${seller['email']} | ${seller['phone']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewAllSellerDetailsScreen(
                        sellerId: sellers[index].id,
                        sellerData: seller,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Separate widget for the drawer to keep code organized
class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text('Admin Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            title: const Text('Dashboard'),
            leading: const Icon(Icons.dashboard),
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 600),
                    child: const AdminDashboard())),
          ),

          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Products"),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListOfProducts()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Applications"),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ListOfSellerApplication()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('Upload FAQs'),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 500),
                  child: const ListOfSellerApplication());
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (_) => AdminHomeScreen()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.history),
          //   title: const Text('Order History'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (_) => OrderHistoryScreen()),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.logout),
          //   title: const Text('Logout'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     _showLogoutConfirmation(context);
          //   },
          // ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Implement your logout logic here
              // Example: Navigator.pushReplacement to login screen
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// Placeholder screens for each drawer option
class UploadFaqsScreen extends StatelessWidget {
  const UploadFaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload FAQs')),
      body: const Center(child: Text('FAQ Upload Screen Content')),
    );
  }
}

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Settings')),
      body: const Center(child: Text('Settings Screen Content')),
    );
  }
}

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: const Center(child: Text('Order History Screen Content')),
    );
  }
}

class ViewAllSellerDetailsScreen extends StatelessWidget {
  final String sellerId;
  final Map<String, dynamic> sellerData;

  const ViewAllSellerDetailsScreen(
      {super.key, required this.sellerId, required this.sellerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shop Name: ${sellerData['shopName']}'),
            Text('Name: ${sellerData['name']}'),
            Text('Email: ${sellerData['email']}'),
            Text('Phone: ${sellerData['phone']}'),
            Text('Address: ${sellerData['address']}'),
            Text('GST Number: ${sellerData['gstNumber']}'),
            Text('PAN Number: ${sellerData['panNumber']}'),
            Text('Bank Account: ${sellerData['bankAccount']}'),
            Text('Business Type: ${sellerData['businessType']}'),
            const SizedBox(height: 20),
            _buildImageSection(
                context, 'Bank Proof', sellerData['bankProofUrl']),
            _buildImageSection(
                context, 'GST Certificate', sellerData['gstCertificateUrl']),
            _buildImageSection(context, 'PAN Card', sellerData['panCardUrl']),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _updateSellerStatus(context, 'approved'),
                  child: const Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: () => _updateSellerStatus(context, 'rejected'),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(
      BuildContext context, String title, String? imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        imageUrl != null && imageUrl.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenImageView(imageUrl: imageUrl, title: title),
                    ),
                  );
                },
                child: Image.network(imageUrl,
                    height: 150, width: double.infinity, fit: BoxFit.cover),
              )
            : Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported,
                    size: 50, color: Colors.grey),
              ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _updateSellerStatus(BuildContext context, String status) async {
    await FirebaseFirestore.instance
        .collection('seller')
        .doc(sellerId)
        .update({'status': status});

    if (context.mounted) Navigator.pop(context); // Go back to Admin Home Screen
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FullScreenImageView(
      {super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 5.0,
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
