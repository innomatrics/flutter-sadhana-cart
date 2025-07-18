import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';
import 'package:sadhana_cart/Seller/select_sell_type.dart';
import 'package:sadhana_cart/Seller/seller_account_screen/seller_account_screen.dart';
import 'package:sadhana_cart/Seller/seller_home.dart';
import 'package:sadhana_cart/Seller/seller_my_products.dart';
import 'package:sadhana_cart/Seller/seller_offer_upload.dart';
import 'package:flutter_animate/flutter_animate.dart';
// chat

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SellerHomeScreen(),
    const SellerChatScreen(),
     UploadItemScreen(),
    const ListOfSellerOrdersDetailPage(),
    const AccountScreen(),
  ];

  final List<String> _appBarTitles = [
    'Home',
    'Chat',
    'Sell Something',
    'Order Details',
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
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       Container(
      //         height: size.height * 0.20,
      //         width: size.width * 1,
      //         color: Colors.purple,
      //       ),
      //       ListTile(
      //           leading: const Icon(
      //             Icons.shopping_bag,
      //           ),
      //           title: const Text("My Orders"),
      //           onTap: () => {
      //                 Navigator.pop(context),
      //                 Navigator.push(
      //                     context,
      //                     PageTransition(
      //                         type: PageTransitionType.fade,
      //                         duration: const Duration(milliseconds: 500),
      //                         child: const ListOfSellerOrdersDetailPage())),
      //               })
      //     ],
      //   ),
      // ),
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

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Chat with others here!',
//         style: TextStyle(
//             fontSize: 18,
//             color: Theme.of(context)
//                 .colorScheme
//                 .onSurface), // Use onSurface for text color
//       ),
//     );
//   }
// }



class SellerChatScreen extends StatefulWidget {
  const SellerChatScreen({super.key});

  @override
  _SellerChatScreenState createState() => _SellerChatScreenState();
}

class _SellerChatScreenState extends State<SellerChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Messages'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('customers').snapshots(),
        builder: (context, customersSnapshot) {
          if (!customersSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final customers = customersSnapshot.data!.docs;

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              final customerId = customer.id;
              final customerData = customer.data() as Map<String, dynamic>;
              final customerName = customerData['name'] ?? 'No Name';
              final customerEmail = customerData['email'] ?? 'No Email';

              return StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('customers')
                    .doc(customerId)
                    .collection('chat')
                    .orderBy('timestamp', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, chatSnapshot) {
                  if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
                    // Skip customers with no messages
                    return const SizedBox.shrink();
                  }

                  final latestMessage = chatSnapshot.data!.docs.first;
                  final messageText = latestMessage['message'] ?? '';
                  final isCustomer = latestMessage['isCustomer'] ?? false;
                  final timestamp = latestMessage['timestamp'] as Timestamp?;

                  // return Card(
                  //   margin: const EdgeInsets.symmetric(
                  //       horizontal: 8.0, vertical: 4.0),
                  //   child: ListTile(
                  //     onTap: () {
                  //       // Navigate to individual chat screen
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (_) => CustomerChatDetailScreen(
                  //             customerId: customerId,
                  //             customerName: customerName,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     leading: CircleAvatar(
                  //       backgroundColor: Colors.blueAccent,
                  //       child: Text(
                  //         customerName[0].toUpperCase(),
                  //         style: const TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //     title: Text(customerName),
                  //     subtitle: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           messageText,
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //         if (timestamp != null)
                  //           Text(
                  //             _formatTimestamp(timestamp),
                  //             style: const TextStyle(
                  //                 fontSize: 12, color: Colors.grey),
                  //           ),
                  //       ],
                  //     ),
                  //     trailing: const Icon(Icons.chevron_right),
                  //   ),
                  // );

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomerChatDetailScreen(
                                customerId: customerId,
                                customerName: customerName,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Hero(
                                tag: 'avatar_$customerId',
                                child: CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  radius: 24,
                                  child: Text(
                                    customerName[0].toUpperCase(),
                                    style: const TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customerName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      messageText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black54),
                                    ),
                                    if (timestamp != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          _formatTimestamp(timestamp),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
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

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class CustomerChatDetailScreen extends StatefulWidget {
  final String customerId;
  final String customerName;

  const CustomerChatDetailScreen({
    super.key,
    required this.customerId,
    required this.customerName,
  });

  @override
  _CustomerChatDetailScreenState createState() =>
      _CustomerChatDetailScreenState();
}

class _CustomerChatDetailScreenState extends State<CustomerChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('customers')
                  .doc(widget.customerId)
                  .collection('chat')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final message = doc['message'] as String;
                    final isCustomer = doc['isCustomer'] as bool;

                    return Align(
                      alignment: isCustomer
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isCustomer
                              ? Colors.blue[100]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(message),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    await _firestore
        .collection('customers')
        .doc(widget.customerId)
        .collection('chat')
        .add({
      'message': _messageController.text,
      'isCustomer': false, // false because seller is sending
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
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

// ui not good

// class AccountScreen extends StatelessWidget {
//   const AccountScreen({super.key});
//
//   // Function to fetch seller data based on the logged-in user
//   Future<Map<String, dynamic>> fetchSellerData() async {
//     // Get the current logged-in user
//     User? user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       throw Exception('No user is currently logged in.');
//     }
//
//     // Fetch the seller document using the user's UID
//     DocumentSnapshot sellerSnapshot = await FirebaseFirestore.instance
//         .collection('seller')
//         .doc(user.uid) // Use the user's UID as the document ID
//         .get();
//
//     if (sellerSnapshot.exists) {
//       return sellerSnapshot.data() as Map<String, dynamic>;
//     } else {
//       throw Exception('Seller document does not exist for the logged-in user.');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Seller Account'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.local_offer_outlined), // Offers icon
//             tooltip: 'Upload Offer Banner',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const OffersUploadingScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchSellerData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No seller data found.'));
//           } else {
//             // Display the seller data
//             Map<String, dynamic> sellerData = snapshot.data!;
//             return ListView(
//               padding: const EdgeInsets.all(16.0),
//               children: sellerData.entries.map((entry) {
//                 if (entry.key.toLowerCase().contains('image') ||
//                     entry.key.toLowerCase().contains('url')) {
//                   // Display image if the key contains 'image' or 'url'
//                   return ListTile(
//                     title: Text(entry.key),
//                     subtitle: entry.value.toString().startsWith('http')
//                         ? Image.network(
//                             entry.value.toString(),
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           )
//                         : Text(entry.value.toString()),
//                   );
//                 } else {
//                   // Display other fields as text
//                   return ListTile(
//                     title: Text(entry.key),
//                     subtitle: Text(entry.value.toString()),
//                   );
//                 }
//               }).toList(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }







//
// class AccountScreen extends StatelessWidget {
//   const AccountScreen({super.key});
//
//   // Keep the existing backend function unchanged
//   Future<Map<String, dynamic>> fetchSellerData() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) throw Exception('No user is currently logged in.');
//
//     DocumentSnapshot sellerSnapshot = await FirebaseFirestore.instance
//         .collection('seller')
//         .doc(user.uid)
//         .get();
//
//     if (sellerSnapshot.exists) {
//       return sellerSnapshot.data() as Map<String, dynamic>;
//     } else {
//       throw Exception('Seller document does not exist for the logged-in user.');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Seller Account').animate().fadeIn(
//             duration: 300.ms),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.local_offer_outlined),
//             tooltip: 'Upload Offer Banner',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const OffersUploadingScreen(),
//                 ),
//               );
//             },
//           ).animate().slideX(duration: 300.ms),
//         ],
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchSellerData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator().animate(
//                 effects: [
//                   ScaleEffect(duration: Duration(milliseconds: 500)),
//                   ShimmerEffect(duration: Duration(milliseconds: 1000)),
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error_outline, size: 50, color: Colors.red)
//                       .animate()
//                       .shake(),
//                   SizedBox(height: 16),
//                   Text(
//                     'Error: ${snapshot.error}',
//                     textAlign: TextAlign.center,
//                     style: Theme
//                         .of(context)
//                         .textTheme
//                         .bodyLarge,
//                   ),
//                 ],
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.person_outline, size: 50)
//                       .animate()
//                       .fadeIn(),
//                   SizedBox(height: 16),
//                   Text(
//                     'No seller data found',
//                     style: Theme
//                         .of(context)
//                         .textTheme
//                         .headlineSmall,
//                   ).animate().slideY(duration: 300.ms),
//                 ],
//               ),
//             );
//           } else {
//             final sellerData = snapshot.data!;
//             return SingleChildScrollView(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   // Profile Header Card with animations
//                   Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 50,
//                             backgroundImage: sellerData.containsKey(
//                                 'profileImage')
//                                 ? NetworkImage(sellerData['profileImage'])
//                                 : null,
//                             child: !sellerData.containsKey('profileImage')
//                                 ? Icon(Icons.person, size: 50)
//                                 : null,
//                           ).animate().scale(duration: 500.ms),
//                           SizedBox(height: 16),
//                           Text(
//                             sellerData['shopName'] ?? 'My Shop',
//                             style: Theme
//                                 .of(context)
//                                 .textTheme
//                                 .headlineSmall,
//                           ).animate().fadeIn(delay: 200.ms),
//                           SizedBox(height: 8),
//                           Text(
//                             sellerData['email'] ?? '',
//                             style: Theme
//                                 .of(context)
//                                 .textTheme
//                                 .bodyMedium,
//                           ).animate().fadeIn(delay: 300.ms),
//                         ],
//                       ),
//                     ),
//                   ).animate().slideY(duration: 400.ms),
//
//                   SizedBox(height: 24),
//
//                   // Details Section with animated list
//                   Text(
//                     'Account Details',
//                     style: Theme
//                         .of(context)
//                         .textTheme
//                         .titleLarge,
//                   ).animate().fadeIn(delay: 400.ms),
//                   SizedBox(height: 16),
//
//                   ...sellerData.entries.map((entry) {
//                     final index = sellerData.entries.toList().indexOf(entry);
//                     return _buildDetailCard(
//                       context,
//                       key: entry.key,
//                       value: entry.value,
//                     ).animate(
//                       delay: (100 * index).ms,
//                     ).slideX(
//                       begin: 0.5,
//                       curve: Curves.easeOut,
//                     );
//                   }).toList(),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildDetailCard(BuildContext context,
//       {required String key, required dynamic value}) {
//     final theme = Theme.of(context);
//     final formattedKey = key.replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'),
//             (match) => ' ${match.group(0)}').toUpperCase();
//
//     return Card(
//       margin: EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               formattedKey,
//               style: theme.textTheme.labelLarge?.copyWith(
//                 color: theme.colorScheme.primary,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             if (value.toString().startsWith('http'))
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   value.toString(),
//                   width: double.infinity,
//                   height: 150,
//                   fit: BoxFit.cover,
//                 ),
//               )
//             else
//               Text(
//                 value.toString(),
//                 style: theme.textTheme.bodyMedium,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }