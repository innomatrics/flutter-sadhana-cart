// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sadhana_cart/Customer/my_orders_screen.dart';
// import 'package:sadhana_cart/Customer/theme_provider.dart';
//
//
// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       return const Scaffold(
//         body: Center(child: Text('No user logged in')),
//       );
//     }
//
//     return Scaffold(
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance.collection('customers').doc(user.uid).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return const Center(child: Text('No profile data found.'));
//           }
//
//           final data = snapshot.data!.data() as Map<String, dynamic>;
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildProfileHeader(user, data),
//                 const SizedBox(height: 24),
//                 _buildSectionTitle('Account'),
//                 _buildSettingTile(
//                   context,
//                   icon: Icons.shopping_bag_outlined,
//                   title: 'Order History',
//                   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MyOrdersScreen())),
//                 ),
//                 _buildSettingTile(
//                   context,
//                   icon: Icons.logout,
//                   title: 'Logout',
//                   iconColor: Colors.red,
//                   onTap: () async {
//                     await FirebaseAuth.instance.signOut();
//                     Navigator.of(context).pop(); // Go back or navigate to login screen
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 _buildSectionTitle('Information'),
//                 _buildSettingTile(
//                   context,
//                   icon: Icons.privacy_tip_outlined,
//                   title: 'Privacy & Policy',
//                   onTap: () => _navigate(context, PrivacyPolicyScreen()),
//                 ),
//                 _buildSettingTile(
//                   context,
//                   icon: Icons.assignment_outlined,
//                   title: 'Terms & Conditions',
//                   onTap: () => _navigate(context, TermsAndConditionsScreen()),
//                 ),
//                 _buildSettingTile(
//                   context,
//                   icon: Icons.info_outline,
//                   title: 'About Us',
//                   onTap: () => _navigate(context, AboutUsScreen()),
//                 ),
//                 _buildSettingTile(
//                   context,
//                   icon: Icons.local_shipping_outlined,
//                   title: 'Shipping Policy',
//                   onTap: () => _navigate(context, ShippingPolicyScreen()),
//                 ),
//                 const SizedBox(height: 24),
//                 _buildSectionTitle('Theme'),
//                 _buildSettingTile(
//                   context,
//                   icon: Icons.palette_outlined,
//                   title: 'Change Theme',
//                   onTap: () => _showThemeBottomSheet(context),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader(User user, Map<String, dynamic> data) {
//     return Center(
//       child: Column(
//         children: [
//           const CircleAvatar(
//             radius: 45,
//             backgroundColor: Colors.blueAccent,
//             child: Icon(Icons.person, size: 50, color: Colors.white),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             data['name'] ?? 'No Name',
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             user.email ?? '',
//             style: const TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
//       ),
//     );
//   }
//
//   Widget _buildSettingTile(
//       BuildContext context, {
//         required IconData icon,
//         required String title,
//         required VoidCallback onTap,
//         Color iconColor = Colors.blueAccent,
//       }) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 1,
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: ListTile(
//         leading: Icon(icon, color: iconColor),
//         title: Text(title, style: const TextStyle(fontSize: 16)),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: onTap,
//       ),
//     );
//   }
//
//   void _showThemeBottomSheet(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Wrap(
//             children: [
//               const Text('Choose Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 20),
//               ListTile(
//                 leading: const Icon(Icons.light_mode, color: Colors.orange),
//                 title: const Text('Light Theme'),
//                 onTap: () {
//                   themeProvider.setLightMode();
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.dark_mode, color: Colors.blueGrey),
//                 title: const Text('Dark Theme'),
//                 onTap: () {
//                   themeProvider.setDarkMode();
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _navigate(BuildContext context, Widget screen) {
//     Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
//   }
// }

// working fine but adding login button

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Customer/faqs_screen.dart';
import 'package:sadhana_cart/Customer/my_orders_screen.dart';
import 'package:sadhana_cart/Customer/theme_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No user logged in')),
      );
    }

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('customers').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No profile data found.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(user, data),
                const SizedBox(height: 24),
                _buildSectionTitle('Account'),
                _buildSettingTile(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  title: 'Order History',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrdersScreen())),
                ),
                _buildSettingTile(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  title: 'FAQs',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FAQsScreen())),

                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Information'),
                _buildSettingTile(
                  context,
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy & Policy',
                  onTap: () => _navigate(context, const PrivacyPolicyScreen()),
                ),
                _buildSettingTile(
                  context,
                  icon: Icons.assignment_outlined,
                  title: 'Terms & Conditions',
                  onTap: () => _navigate(context, const TermsAndConditionsScreen()),
                ),
                _buildSettingTile(
                  context,
                  icon: Icons.info_outline,
                  title: 'About Us',
                  onTap: () => _navigate(context, const AboutUsScreen()),
                ),
                _buildSettingTile(
                  context,
                  icon: Icons.local_shipping_outlined,
                  title: 'Shipping Policy',
                  onTap: () => _navigate(context, const ShippingPolicyScreen()),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Theme'),
                _buildSettingTile(
                  context,
                  icon: Icons.palette_outlined,
                  title: 'Change Theme',
                  onTap: () => _showThemeBottomSheet(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(User user, Map<String, dynamic> data) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            data['name'] ?? 'No Name',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  Widget _buildSettingTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
        Color iconColor = Colors.blueAccent,
      }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showThemeBottomSheet(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              const Text('Choose Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.light_mode, color: Colors.orange),
                title: const Text('Light Theme'),
                onTap: () {
                  themeProvider.setLightMode();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode, color: Colors.blueGrey),
                title: const Text('Dark Theme'),
                onTap: () {
                  themeProvider.setDarkMode();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}




class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Policies'),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Our Privacy Policy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Your privacy is critically important to us. This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you visit our e-commerce multi-vendor platform.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              Text(
                '1. Information We Collect',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Personal Information (e.g., name, email, phone number)\n'
                    '- Address and Payment details\n'
                    '- Vendor and product data\n'
                    '- Usage and device data\n',
              ),
              SizedBox(height: 10),

              Text(
                '2. How We Use Your Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- To process orders and payments\n'
                    '- To connect vendors with customers\n'
                    '- For customer support and service improvements\n'
                    '- To send promotional emails and app notifications',
              ),
              SizedBox(height: 10),

              Text(
                '3. Data Sharing & Disclosure',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- We do not sell your personal data.\n'
                    '- We may share information with vendors or delivery partners to fulfill your orders.\n'
                    '- Data may be shared with third-party services for analytics and payment processing.',
              ),
              SizedBox(height: 10),

              Text(
                '4. Cookies & Tracking',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- We use cookies to personalize your experience.\n'
                    '- Cookies help us understand user behavior and improve functionality.',
              ),
              SizedBox(height: 10),

              Text(
                '5. Your Rights',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- You can access, update, or delete your data anytime.\n'
                    '- You can opt-out of marketing communications.\n'
                    '- You can deactivate your account or vendor profile upon request.',
              ),
              SizedBox(height: 10),

              Text(
                '6. Policy Updates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'We may update this Privacy Policy from time to time. Changes will be posted in the app with updated effective dates.',
              ),
              SizedBox(height: 20),

              Text(
                'If you have any questions about our Privacy Policy, please contact our support team.',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  'Effective Date: April 16, 2025',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Please read these terms and conditions carefully before using our e-commerce multi-vendor application. By accessing or using the app, you agree to be bound by these terms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              Text(
                '1. User Accounts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- You must register an account to make purchases or sell products.\n'
                    '- You are responsible for maintaining the confidentiality of your account.\n',
              ),
              SizedBox(height: 10),

              Text(
                '2. Vendor Responsibilities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Vendors must ensure their products are legal, genuine, and as described.\n'
                    '- Vendors are responsible for order fulfillment, returns, and refunds.',
              ),
              SizedBox(height: 10),

              Text(
                '3. Purchases and Payments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- All purchases made through the app are subject to availability.\n'
                    '- We use secure third-party payment gateways for processing.\n',
              ),
              SizedBox(height: 10),

              Text(
                '4. Prohibited Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Posting or selling counterfeit or restricted items.\n'
                    '- Attempting to hack or disrupt the platform.\n'
                    '- Using automated tools to access data or manipulate listings.',
              ),
              SizedBox(height: 10),

              Text(
                '5. Intellectual Property',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- All content, logos, and trademarks are owned by us or our partners.\n'
                    '- Users may not copy or reproduce app content without permission.',
              ),
              SizedBox(height: 10),

              Text(
                '6. Termination',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- We reserve the right to suspend or terminate accounts for violations.\n'
                    '- Terminated users may lose access to their data or listings.',
              ),
              SizedBox(height: 10),

              Text(
                '7. Limitation of Liability',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- We are not liable for any damages arising from use of the app.\n'
                    '- All transactions are between vendors and customers directly.',
              ),
              SizedBox(height: 20),

              Text(
                'By using our app, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  'Effective Date: April 16, 2025',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.storefront, size: 100, color: Colors.blue),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to Our Marketplace!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'We are a multi-vendor e-commerce platform committed to bringing together sellers and buyers in one seamless shopping experience.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              Text(
                'Our Mission',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'To empower small businesses and independent sellers by providing them with the tools and exposure they need to grow online.',
              ),
              SizedBox(height: 10),

              Text(
                'Our Vision',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'To become the most trusted and user-friendly online marketplace where customers can discover, shop, and support vendors from across the country.',
              ),
              SizedBox(height: 10),

              Text(
                'What We Offer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- A wide range of products from various trusted vendors\n'
                    '- Easy order placement and secure payments\n'
                    '- Real-time order tracking and customer support\n'
                    '- Special deals and discounts for loyal customers',
              ),
              SizedBox(height: 10),

              Text(
                'Join Our Journey',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                'Whether you are a customer looking for great products or a seller wanting to grow your business, we welcome you to our family!',
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  'Thank you for choosing us!',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  '© 2025 YourAppName. All rights reserved.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ShippingPolicyScreen extends StatelessWidget {
  const ShippingPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Policy'),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.local_shipping, size: 80, color: Colors.blue),
              SizedBox(height: 20),

              Text(
                'Shipping Policy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(
                'At YourAppName, we are committed to delivering your orders quickly and efficiently. This Shipping Policy outlines how and when your items will be shipped.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              Text(
                '1. Processing Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Orders are typically processed within 1–3 business days.\n'
                    '- Vendors may require extra time during high-demand periods.',
              ),
              SizedBox(height: 10),

              Text(
                '2. Shipping Methods',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- We offer standard and express shipping options.\n'
                    '- Shipping carriers may vary depending on location and vendor.',
              ),
              SizedBox(height: 10),

              Text(
                '3. Estimated Delivery Times',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Standard: 4–7 business days\n'
                    '- Express: 1–3 business days\n'
                    '- Delivery times may vary by vendor and region.',
              ),
              SizedBox(height: 10),

              Text(
                '4. Shipping Charges',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Shipping charges are calculated at checkout.\n'
                    '- Free shipping may be available on select products or orders above a certain amount.',
              ),
              SizedBox(height: 10),

              Text(
                '5. International Shipping',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Currently, we only ship within [your country].\n'
                    '- International shipping options will be added in future updates.',
              ),
              SizedBox(height: 10),

              Text(
                '6. Delays and Tracking',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- In case of delays due to weather, holidays, or vendor issues, we will keep you informed via email.\n'
                    '- A tracking number will be provided once your item ships.',
              ),
              SizedBox(height: 10),

              Text(
                '7. Undeliverable Packages',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- If a package is returned due to an incorrect address or failed delivery attempt, we will contact you to resolve the issue.',
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  'Effective Date: April 16, 2025',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ReturnPolicyScreen extends StatelessWidget {
  const ReturnPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return & Refund Policy'),
        backgroundColor: Colors.teal,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.assignment_return, size: 80, color: Colors.teal),
              SizedBox(height: 20),

              Text(
                'Return & Refund Policy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(
                'We want you to be completely satisfied with your purchase. If you are not satisfied, our return and refund policy is designed to be simple and fair.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              Text(
                '1. Return Window',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Products can be returned within 7 days of delivery.\n'
                    '- Items must be unused and in their original packaging.',
              ),
              SizedBox(height: 10),

              Text(
                '2. Items Not Eligible for Return',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Perishable goods\n'
                    '- Personalized/custom products\n'
                    '- Items marked as "Non-returnable"',
              ),
              SizedBox(height: 10),

              Text(
                '3. How to Initiate a Return',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Go to “My Orders” in the app.\n'
                    '- Select the item and tap “Request Return.”\n'
                    '- Follow the instructions and choose pickup/drop-off option.',
              ),
              SizedBox(height: 10),

              Text(
                '4. Refund Process',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Once your return is approved and received, your refund will be processed within 5–7 business days.\n'
                    '- Refunds will be issued to the original payment method.',
              ),
              SizedBox(height: 10),

              Text(
                '5. Exchange Policy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- Exchanges are allowed for size or defective issues.\n'
                    '- Subject to stock availability.',
              ),
              SizedBox(height: 10),

              Text(
                '6. Damaged or Incorrect Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                '- If you receive a damaged or incorrect item, please contact our support within 48 hours of delivery with photo evidence.',
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  'Effective Date: April 16, 2025',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  'For any return-related queries, contact us at support@yourappname.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




