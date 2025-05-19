import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sadhana_cart/Seller/select_sell_type.dart';
import 'package:sadhana_cart/Seller/seller_home.dart';
import 'package:sadhana_cart/Seller/seller_my_products.dart';
import 'package:sadhana_cart/Seller/seller_offer_upload.dart';
import 'package:sadhana_cart/Seller/seller_orders/list_of_seller_orders_detail_page.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SellerHomeScreen(),
    const ChatScreen(),
    const UploadItemScreen(),
    const SellerOrdersScreen(),
    const AccountScreen(),
  ];

  final List<String> _appBarTitles = [
    'Home',
    'Chat',
    'Sell Something',
    'My Ads',
    'Account',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Get the theme data
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _appBarTitles[_currentIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary, // Use onPrimary for text color
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary, // Use primary color for AppBar
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: size.height * 0.20,
              width: size.width * 1,
              color: Colors.purple,
            ),
            ListTile(
                leading: const Icon(
                  Icons.shopping_bag,
                ),
                title: const Text("My Orders"),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 500),
                              child: const ListOfSellerOrdersDetailPage())),
                    })
          ],
        ),
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor:
                colorScheme.secondary, // Use secondary color for selected item
            unselectedItemColor: Colors.grey, // Grey for unselected items
            onTap: (index) {
              if (index == 2) {
                return; // Skip handling for the 'Sell' button here
              }
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Empty space for Sell button
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'My Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
          Positioned(
            bottom: 10, // Adjust the height of the button
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      colorScheme.secondary, // Use secondary color for the FAB
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color:
                      colorScheme.onSecondary, // Use onSecondary for icon color
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Chat with others here!',
        style: TextStyle(
            fontSize: 18,
            color: Theme.of(context)
                .colorScheme
                .onSurface), // Use onSurface for text color
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Manage your account here.', style: TextStyle(fontSize: 18)),
//     );
//   }
// }

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  // Function to fetch seller data based on the logged-in user
  Future<Map<String, dynamic>> fetchSellerData() async {
    // Get the current logged-in user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('No user is currently logged in.');
    }

    // Fetch the seller document using the user's UID
    DocumentSnapshot sellerSnapshot = await FirebaseFirestore.instance
        .collection('seller')
        .doc(user.uid) // Use the user's UID as the document ID
        .get();

    if (sellerSnapshot.exists) {
      return sellerSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception('Seller document does not exist for the logged-in user.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_offer_outlined), // Offers icon
            tooltip: 'Upload Offer Banner',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OffersUploadingScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchSellerData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No seller data found.'));
          } else {
            // Display the seller data
            Map<String, dynamic> sellerData = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: sellerData.entries.map((entry) {
                if (entry.key.toLowerCase().contains('image') ||
                    entry.key.toLowerCase().contains('url')) {
                  // Display image if the key contains 'image' or 'url'
                  return ListTile(
                    title: Text(entry.key),
                    subtitle: entry.value.toString().startsWith('http')
                        ? Image.network(
                            entry.value.toString(),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Text(entry.value.toString()),
                  );
                } else {
                  // Display other fields as text
                  return ListTile(
                    title: Text(entry.key),
                    subtitle: Text(entry.value.toString()),
                  );
                }
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
