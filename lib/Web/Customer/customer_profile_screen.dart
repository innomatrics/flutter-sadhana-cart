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
import 'package:sadhana_cart/Customer/customer_chat_screen.dart';
import 'package:sadhana_cart/Customer/faqs_screen.dart';
import 'package:sadhana_cart/Customer/my_orders_screen.dart';
import 'package:sadhana_cart/Customer/theme_provider.dart';
import 'package:flutter/services.dart';
import 'package:sadhana_cart/Web/Customer/customer_chat_screen.dart';
import 'package:sadhana_cart/Web/Customer/faqs_screen.dart';
import 'package:sadhana_cart/Web/Customer/my_orders_screen.dart';
import 'customer_signin.dart';

class WebProfileTab extends StatelessWidget {
  const WebProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // if (user == null) {
    //   return const Scaffold(
    //     body: Center(child: Text('No user logged in')),
    //   );
    // }

    if (user == null) {
      // Delay navigation to avoid navigation during build phase
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WebCustomerSigninScreen()),
        );
      });

      // Return a temporary widget while redirection happens
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WebMyOrdersScreen())),
                ),
                _buildSettingTile(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  title: 'FAQs',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WebFAQsScreen())),

                ),
                _buildSettingTile(
                  context,
                  icon: Icons.chat,
                  title: 'Chat with Us',
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const WebChatScreen())),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle('Information'),
                _buildSettingTile(
                  context,
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy & Policy',
                  onTap: () => _navigate(context, const WebPrivacyPolicyScreen()),
                ),
                _buildSettingTile(
                  context,
                  icon: Icons.assignment_outlined,
                  title: 'Terms & Conditions',
                  onTap: () => _navigate(context, const WebTermsAndConditionsScreen()),
                ),
                _buildSettingTile(
                  context,
                  icon: Icons.info_outline,
                  title: 'About Us',
                  onTap: () => _navigate(context, const WebAboutUsScreen()),
                ),
                _buildSettingTile(
                  context,
                  icon: Icons.local_shipping_outlined,
                  title: 'Shipping Policy',
                  onTap: () => _navigate(context, const WebShippingPolicyScreen()),
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





class WebPrivacyPolicyScreen extends StatefulWidget {
  const WebPrivacyPolicyScreen({super.key});

  @override
  State<WebPrivacyPolicyScreen> createState() => _WebPrivacyPolicyScreenState();
}

class _WebPrivacyPolicyScreenState extends State<WebPrivacyPolicyScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset < 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 300.0 : 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Privacy & Policies',
                  style: TextStyle(color: Colors.white)),
              background: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.deepOrange[400]!,
                      Colors.deepOrange[800]!,
                      Colors.amber[900]!,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
                child: Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.privacy_tip_outlined,
                            size: isDesktop ? 80 : 60, color: Colors.white),
                        const SizedBox(height: 20),
                        Text(
                          'Your Privacy Matters',
                          style: TextStyle(
                            fontSize: isDesktop ? 32 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 100 : 20,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnimatedSection(
                    delay: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Our Privacy Policy',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your privacy is critically important to us. This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you visit our e-commerce multi-vendor platform.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildPolicySection(
                    title: '1. Information We Collect',
                    items: [
                      'Personal Information (e.g., name, email, phone number)',
                      'Address and Payment details',
                      'Vendor and product data',
                      'Usage and device data',
                    ],
                    delay: 100,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '2. How We Use Your Information',
                    items: [
                      'To process orders and payments',
                      'To connect vendors with customers',
                      'For customer support and service improvements',
                      'To send promotional emails and app notifications',
                    ],
                    delay: 200,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '3. Data Sharing & Disclosure',
                    items: [
                      'We do not sell your personal data',
                      'We may share information with vendors or delivery partners to fulfill your orders',
                      'Data may be shared with third-party services for analytics and payment processing',
                    ],
                    delay: 300,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '4. Cookies & Tracking',
                    items: [
                      'We use cookies to personalize your experience',
                      'Cookies help us understand user behavior and improve functionality',
                    ],
                    delay: 400,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '5. Your Rights',
                    items: [
                      'You can access, update, or delete your data anytime',
                      'You can opt-out of marketing communications',
                      'You can deactivate your account or vendor profile upon request',
                    ],
                    delay: 500,
                  ),
                  const SizedBox(height: 30),
                  _buildAnimatedSection(
                    delay: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '6. Policy Updates',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'We may update this Privacy Policy from time to time. Changes will be posted in the app with updated effective dates.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildAnimatedSection(
                    delay: 700,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.deepOrange,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.support_agent,
                              size: 40, color: Colors.deepOrange),
                          const SizedBox(height: 16),
                          Text(
                            'Need Help? Contact Our Support Team',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'If you have any questions about our Privacy Policy, please contact our support team.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to contact page
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Contact Support',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Effective Date: April 16, 2025',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicySection({
    required String title,
    required List<String> items,
    required int delay,
  }) {
    return _buildAnimatedSection(
      delay: delay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map(
                  (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6, right: 8),
                      child: Icon(Icons.circle,
                          size: 8, color: Colors.grey),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection({
    required Widget child,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}


class WebTermsAndConditionsScreen extends StatefulWidget {
  const WebTermsAndConditionsScreen({super.key});

  @override
  State<WebTermsAndConditionsScreen> createState() => _WebTermsAndConditionsScreenState();
}

class _WebTermsAndConditionsScreenState extends State<WebTermsAndConditionsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset < 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 300.0 : 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Terms & Conditions',
                  style: TextStyle(color: Colors.white)),
              background: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepOrange[400]!,
                      Colors.amber[900]!,
                    ],
                  ),
                ),
                child: Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment_outlined,
                            size: isDesktop ? 80 : 60, color: Colors.white),
                        const SizedBox(height: 20),
                        Text(
                          'Our Terms & Conditions',
                          style: TextStyle(
                            fontSize: isDesktop ? 32 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 100 : 20,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnimatedSection(
                    delay: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terms & Conditions',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Please read these terms and conditions carefully before using our e-commerce multi-vendor application. By accessing or using the app, you agree to be bound by these terms.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildTermSection(
                    title: '1. User Accounts',
                    items: [
                      'You must register an account to make purchases or sell products',
                      'You are responsible for maintaining the confidentiality of your account',
                      'You must provide accurate and complete information',
                    ],
                    delay: 100,
                  ),
                  const SizedBox(height: 30),
                  _buildTermSection(
                    title: '2. Vendor Responsibilities',
                    items: [
                      'Vendors must ensure their products are legal, genuine, and as described',
                      'Vendors are responsible for order fulfillment, returns, and refunds',
                      'Vendors must comply with all applicable laws and regulations',
                    ],
                    delay: 200,
                  ),
                  const SizedBox(height: 30),
                  _buildTermSection(
                    title: '3. Purchases and Payments',
                    items: [
                      'All purchases made through the app are subject to availability',
                      'We use secure third-party payment gateways for processing',
                      'Prices are subject to change without notice',
                    ],
                    delay: 300,
                  ),
                  const SizedBox(height: 30),
                  _buildTermSection(
                    title: '4. Prohibited Activities',
                    items: [
                      'Posting or selling counterfeit or restricted items',
                      'Attempting to hack or disrupt the platform',
                      'Using automated tools to access data or manipulate listings',
                    ],
                    delay: 400,
                  ),
                  const SizedBox(height: 30),
                  _buildTermSection(
                    title: '5. Intellectual Property',
                    items: [
                      'All content, logos, and trademarks are owned by us or our partners',
                      'Users may not copy or reproduce app content without permission',
                      'Vendors retain ownership of their product listings and images',
                    ],
                    delay: 500,
                  ),
                  const SizedBox(height: 30),
                  _buildTermSection(
                    title: '6. Termination',
                    items: [
                      'We reserve the right to suspend or terminate accounts for violations',
                      'Terminated users may lose access to their data or listings',
                      'Users may appeal termination decisions through our support system',
                    ],
                    delay: 600,
                  ),
                  const SizedBox(height: 30),
                  _buildTermSection(
                    title: '7. Limitation of Liability',
                    items: [
                      'We are not liable for any damages arising from use of the app',
                      'All transactions are between vendors and customers directly',
                      'We provide the platform but do not guarantee product quality or delivery',
                    ],
                    delay: 700,
                  ),
                  const SizedBox(height: 40),
                  _buildAnimatedSection(
                    delay: 800,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.deepOrange.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.gavel,
                              size: 40, color: Colors.deepOrange),
                          const SizedBox(height: 16),
                          Text(
                            'Acceptance of Terms',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'By using our app, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: const Text('I Understand',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              if (isDesktop) const SizedBox(width: 16),
                              if (isDesktop)
                                OutlinedButton(
                                  onPressed: () {
                                    // Navigate to contact page
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    side: BorderSide(
                                        color: Colors.deepOrange),
                                  ),
                                  child: const Text('Contact Support',
                                      style: TextStyle(color: Colors.deepOrange)),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Effective Date: April 16, 2025',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermSection({
    required String title,
    required List<String> items,
    required int delay,
  }) {
    return _buildAnimatedSection(
      delay: delay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map(
                  (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, right: 8),
                      child: Icon(Icons.circle,
                          size: 8, color: Colors.deepOrange),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection({
    required Widget child,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}


class WebAboutUsScreen extends StatefulWidget {
  const WebAboutUsScreen({super.key});

  @override
  State<WebAboutUsScreen> createState() => _WebAboutUsScreenState();
}

class _WebAboutUsScreenState extends State<WebAboutUsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset < 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 350.0 : 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('About Us',
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                  )),
              background: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepOrange[400]!,
                      Colors.amber[900]!,
                    ],
                  ),
                ),
                child: Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.storefront_outlined,
                            size: isDesktop ? 100 : 80, color: Colors.white),
                        const SizedBox(height: 20),
                        Text(
                          'Our Story',
                          style: TextStyle(
                            fontSize: isDesktop ? 42 : 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 10)
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Building connections between buyers and sellers',
                          style: TextStyle(
                            fontSize: isDesktop ? 18 : 16,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 5)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 100 : 20,
                vertical: 40,
              ),
              child: Column(
                children: [
                  _buildAnimatedSection(
                    delay: 0,
                    child: Column(
                      children: [
                        Text(
                          'Welcome to Our Marketplace!',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'We are a multi-vendor e-commerce platform committed to bringing together sellers and buyers in one seamless shopping experience.',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildFeatureCard(
                    icon: Icons.flag_outlined,
                    title: 'Our Mission',
                    content:
                    'To empower small businesses and independent sellers by providing them with the tools and exposure they need to grow online.',
                    delay: 100,
                    isDesktop: isDesktop,
                  ),
                  const SizedBox(height: 30),
                  _buildFeatureCard(
                    icon: Icons.remove_red_eye_outlined,
                    title: 'Our Vision',
                    content:
                    'To become the most trusted and user-friendly online marketplace where customers can discover, shop, and support vendors from across the country.',
                    delay: 200,
                    isDesktop: isDesktop,
                  ),
                  const SizedBox(height: 30),
                  _buildAnimatedSection(
                    delay: 300,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.deepOrange.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What We Offer',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildFeatureItem(
                              'A wide range of products from various trusted vendors'),
                          _buildFeatureItem(
                              'Easy order placement and secure payments'),
                          _buildFeatureItem(
                              'Real-time order tracking and customer support'),
                          _buildFeatureItem(
                              'Special deals and discounts for loyal customers'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildTeamSection(isDesktop: isDesktop),
                  const SizedBox(height: 40),
                  _buildAnimatedSection(
                    delay: 700,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.deepOrange.withOpacity(0.2),
                            Colors.amber.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.handshake_outlined,
                              size: 50, color: Colors.deepOrange),
                          const SizedBox(height: 16),
                          Text(
                            'Join Our Journey',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Whether you are a customer looking for great products or a seller wanting to grow your business, we welcome you to our family!',
                            style: theme.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to sign up page
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                            ),
                            child: const Text('Get Started',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildAnimatedSection(
                    delay: 800,
                    child: Column(
                      children: [
                        Text(
                          'Thank you for choosing us!',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '© 2025 SadhanaCart. All rights reserved.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color
                                ?.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String content,
    required int delay,
    required bool isDesktop,
  }) {
    return _buildAnimatedSection(
      delay: delay,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.deepOrange),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              size: 20, color: Colors.deepOrange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection({required bool isDesktop}) {
    final teamMembers = [
      {'name': 'John Doe', 'role': 'Founder & CEO', 'image': 'assets/team1.jpg'},
      {'name': 'Jane Smith', 'role': 'Marketing Director', 'image': 'assets/team2.jpg'},
      {'name': 'Mike Johnson', 'role': 'Tech Lead', 'image': 'assets/team3.jpg'},
      if (isDesktop)
        {'name': 'Sarah Williams', 'role': 'Customer Support', 'image': 'assets/team4.jpg'},
    ];

    return _buildAnimatedSection(
      delay: 500,
      child: Column(
        children: [
          Text(
            'Meet Our Team',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'The passionate people behind our platform',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 30),
          isDesktop
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: teamMembers
                .map((member) => _buildTeamMember(member, isDesktop))
                .toList(),
          )
              : Column(
            children: teamMembers
                .map((member) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildTeamMember(member, isDesktop),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(Map<String, String> member, bool isDesktop) {
    return Container(
      width: isDesktop ? 200 : double.infinity,
      margin: isDesktop ? const EdgeInsets.symmetric(horizontal: 12) : null,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.deepOrange, width: 2),
              image: DecorationImage(
                image: AssetImage(member['image']!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            member['name']!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            member['role']!,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection({
    required Widget child,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}



class WebShippingPolicyScreen extends StatefulWidget {
  const WebShippingPolicyScreen({super.key});

  @override
  State<WebShippingPolicyScreen> createState() => _WebShippingPolicyScreenState();
}

class _WebShippingPolicyScreenState extends State<WebShippingPolicyScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset < 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 300.0 : 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Shipping Policy',
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                  )),
              background: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepOrange[400]!,
                      Colors.amber[900]!,
                    ],
                  ),
                ),
                child: Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_shipping_outlined,
                            size: isDesktop ? 80 : 60, color: Colors.white),
                        const SizedBox(height: 20),
                        Text(
                          'Fast & Reliable Delivery',
                          style: TextStyle(
                            fontSize: isDesktop ? 32 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 100 : 20,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnimatedSection(
                    delay: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping Policy',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'At SadhanaCart, we are committed to delivering your orders quickly and efficiently. This Shipping Policy outlines how and when your items will be shipped.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildShippingSection(
                    title: '1. Processing Time',
                    items: [
                      'Orders are typically processed within 1–3 business days',
                      'Vendors may require extra time during high-demand periods',
                    ],
                    icon: Icons.timer_outlined,
                    delay: 100,
                  ),
                  const SizedBox(height: 30),
                  _buildShippingSection(
                    title: '2. Shipping Methods',
                    items: [
                      'We offer standard and express shipping options',
                      'Shipping carriers may vary depending on location and vendor',
                    ],
                    icon: Icons.delivery_dining_outlined,
                    delay: 200,
                  ),
                  const SizedBox(height: 30),
                  _buildShippingSection(
                    title: '3. Estimated Delivery Times',
                    items: [
                      'Standard: 4–7 business days',
                      'Express: 1–3 business days',
                      'Delivery times may vary by vendor and region',
                    ],
                    icon: Icons.calendar_today_outlined,
                    delay: 300,
                  ),
                  const SizedBox(height: 30),
                  _buildShippingSection(
                    title: '4. Shipping Charges',
                    items: [
                      'Shipping charges are calculated at checkout',
                      'Free shipping may be available on select products or orders above ₹500',
                    ],
                    icon: Icons.attach_money_outlined,
                    delay: 400,
                  ),
                  const SizedBox(height: 30),
                  _buildShippingSection(
                    title: '5. International Shipping',
                    items: [
                      'Currently, we only ship within India',
                      'International shipping options will be added in future updates',
                    ],
                    icon: Icons.language_outlined,
                    delay: 500,
                  ),
                  const SizedBox(height: 30),
                  _buildShippingSection(
                    title: '6. Delays and Tracking',
                    items: [
                      'In case of delays due to weather, holidays, or vendor issues, we will keep you informed via email',
                      'A tracking number will be provided once your item ships',
                    ],
                    icon: Icons.track_changes_outlined,
                    delay: 600,
                  ),
                  const SizedBox(height: 30),
                  _buildShippingSection(
                    title: '7. Undeliverable Packages',
                    items: [
                      'If a package is returned due to an incorrect address or failed delivery attempt, we will contact you to resolve the issue',
                    ],
                    icon: Icons.warning_amber_outlined,
                    delay: 700,
                  ),
                  const SizedBox(height: 40),
                  _buildAnimatedSection(
                    delay: 800,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.deepOrange.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.help_outline_outlined,
                              size: 40, color: Colors.deepOrange),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Need Help With Shipping?',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Contact our customer support team for any shipping-related questions or issues.',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to contact page
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text('Contact Support',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Effective Date: April 16, 2025',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingSection({
    required String title,
    required List<String> items,
    required IconData icon,
    required int delay,
  }) {
    return _buildAnimatedSection(
      delay: delay,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.deepOrange),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items
                        .map(
                          (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6, right: 8),
                              child: Icon(Icons.circle,
                                  size: 8, color: Colors.deepOrange),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection({
    required Widget child,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}



class WebReturnPolicyScreen extends StatefulWidget {
  const WebReturnPolicyScreen({super.key});

  @override
  State<WebReturnPolicyScreen> createState() => _WebReturnPolicyScreenState();
}

class _WebReturnPolicyScreenState extends State<WebReturnPolicyScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset < 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 300.0 : 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Return & Refund Policy',
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
                  )),
              background: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepOrange[400]!,
                      Colors.amber[900]!,
                    ],
                  ),
                ),
                child: Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment_return_outlined,
                            size: isDesktop ? 80 : 60, color: Colors.white),
                        const SizedBox(height: 20),
                        Text(
                          'Hassle-Free Returns',
                          style: TextStyle(
                            fontSize: isDesktop ? 32 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 100 : 20,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnimatedSection(
                    delay: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Return & Refund Policy',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'We want you to be completely satisfied with your purchase. If you are not satisfied, our return and refund policy is designed to be simple and fair.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildPolicySection(
                    title: '1. Return Window',
                    items: [
                      'Products can be returned within 7 days of delivery',
                      'Items must be unused and in their original packaging',
                      'Return shipping label must be used if provided',
                    ],
                    icon: Icons.calendar_today_outlined,
                    delay: 100,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '2. Items Not Eligible for Return',
                    items: [
                      'Perishable goods',
                      'Personalized/custom products',
                      'Items marked as "Non-returnable"',
                      'Products without original tags or packaging',
                    ],
                    icon: Icons.block_outlined,
                    delay: 200,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '3. How to Initiate a Return',
                    items: [
                      'Go to "My Orders" in the app',
                      'Select the item and tap "Request Return"',
                      'Follow the instructions and choose pickup/drop-off option',
                      'Print return label if required',
                    ],
                    icon: Icons.reply_outlined,
                    delay: 300,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '4. Refund Process',
                    items: [
                      'Once your return is approved and received, your refund will be processed within 5–7 business days',
                      'Refunds will be issued to the original payment method',
                      'Shipping fees are non-refundable unless the return is due to our error',
                    ],
                    icon: Icons.payment_outlined,
                    delay: 400,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '5. Exchange Policy',
                    items: [
                      'Exchanges are allowed for size or defective issues',
                      'Subject to stock availability',
                      'Customer responsible for return shipping costs',
                      'New item will be shipped after receiving the original',
                    ],
                    icon: Icons.swap_horiz_outlined,
                    delay: 500,
                  ),
                  const SizedBox(height: 30),
                  _buildPolicySection(
                    title: '6. Damaged or Incorrect Items',
                    items: [
                      'If you receive a damaged or incorrect item, please contact our support within 48 hours of delivery',
                      'Provide photo evidence of the issue',
                      'We will arrange for return pickup at no cost to you',
                      'Replacement or full refund will be processed immediately',
                    ],
                    icon: Icons.warning_amber_outlined,
                    delay: 600,
                  ),
                  const SizedBox(height: 40),
                  _buildAnimatedSection(
                    delay: 700,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.deepOrange.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.support_agent_outlined,
                              size: 40, color: Colors.deepOrange),
                          const SizedBox(height: 16),
                          Text(
                            'Need Help With a Return?',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'For any return-related queries, contact our support team at:',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'support@sadhanacart.com',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to contact page
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Contact Support',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Effective Date: April 16, 2025',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicySection({
    required String title,
    required List<String> items,
    required IconData icon,
    required int delay,
  }) {
    return _buildAnimatedSection(
      delay: delay,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.deepOrange),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items
                        .map(
                          (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6, right: 8),
                              child: Icon(Icons.circle,
                                  size: 8, color: Colors.deepOrange),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection({
    required Widget child,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}



