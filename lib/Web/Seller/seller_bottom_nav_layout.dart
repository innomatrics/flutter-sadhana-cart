// import 'package:animations/animations.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';
// import 'package:sadhana_cart/Seller/select_sell_type.dart';
// import 'package:sadhana_cart/Seller/seller_account_screen/seller_account_screen.dart';
// import 'package:sadhana_cart/Seller/seller_home.dart';
// import 'package:sadhana_cart/Seller/seller_my_products.dart';
// import 'package:sadhana_cart/Seller/seller_offer_upload.dart';
//
// // chat
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class WebBottomNavBarScreen extends StatefulWidget {
//   const WebBottomNavBarScreen({super.key});
//
//   @override
//   _WebBottomNavBarScreenState createState() => _WebBottomNavBarScreenState();
// }
//
// class _WebBottomNavBarScreenState extends State<WebBottomNavBarScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const SellerHomeScreen(),
//     const SellerChatScreen(),
//      UploadItemScreen(),
//     const ListOfSellerOrdersDetailPage(),
//     const AccountScreen(),
//   ];
//
//   final List<String> _appBarTitles = [
//     'Home',
//     'Chat',
//     'Sell Something',
//     'Order Details',
//     'Account',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     // Get the theme data
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           _appBarTitles[_currentIndex],
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: colorScheme.onPrimary, // Use onPrimary for text color
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: colorScheme.primary, // Use primary color for AppBar
//       ),
//       // drawer: Drawer(
//       //   child: Column(
//       //     children: [
//       //       Container(
//       //         height: size.height * 0.20,
//       //         width: size.width * 1,
//       //         color: Colors.purple,
//       //       ),
//       //       ListTile(
//       //           leading: const Icon(
//       //             Icons.shopping_bag,
//       //           ),
//       //           title: const Text("My Orders"),
//       //           onTap: () => {
//       //                 Navigator.pop(context),
//       //                 Navigator.push(
//       //                     context,
//       //                     PageTransition(
//       //                         type: PageTransitionType.fade,
//       //                         duration: const Duration(milliseconds: 500),
//       //                         child: const ListOfSellerOrdersDetailPage())),
//       //               })
//       //     ],
//       //   ),
//       // ),
//       body: PageTransitionSwitcher(
//         duration: const Duration(milliseconds: 500),
//         transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
//           return FadeThroughTransition(
//             animation: primaryAnimation,
//             secondaryAnimation: secondaryAnimation,
//             child: child,
//           );
//         },
//         child: _screens[_currentIndex],
//       ),
//       bottomNavigationBar: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           BottomNavigationBar(
//             currentIndex: _currentIndex,
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor:
//                 colorScheme.secondary, // Use secondary color for selected item
//             unselectedItemColor: Colors.grey, // Grey for unselected items
//             onTap: (index) {
//               if (index == 2) {
//                 return; // Skip handling for the 'Sell' button here
//               }
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.chat),
//                 label: 'Chat',
//               ),
//               BottomNavigationBarItem(
//                 icon: SizedBox.shrink(), // Empty space for Sell button
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.list),
//                 label: 'My Products',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Account',
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 10, // Adjust the height of the button
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _currentIndex = 2;
//                 });
//               },
//               child: Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color:
//                       colorScheme.secondary, // Use secondary color for the FAB
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       spreadRadius: 1,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.add,
//                   color:
//                       colorScheme.onSecondary, // Use onSecondary for icon color
//                   size: 35,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// web
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';
// import 'package:sadhana_cart/Seller/select_sell_type.dart';
import 'package:sadhana_cart/Seller/seller_account_screen/seller_account_screen.dart';
import 'package:sadhana_cart/Seller/seller_home.dart';
import 'package:sadhana_cart/Seller/seller_my_products.dart';
import 'package:sadhana_cart/Seller/seller_offer_upload.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// chat

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:sadhana_cart/Web/Seller/select_sell_type.dart';
import 'package:sadhana_cart/Web/Seller/seller_account_screen/seller_account_screen.dart';
import 'package:sadhana_cart/Web/Seller/seller_home.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Web/Seller/seller_my_products.dart'
    hide ListOfSellerOrdersDetailPage;

class WebBottomNavBarScreen extends StatefulWidget {
  const WebBottomNavBarScreen({super.key});

  @override
  _WebBottomNavBarScreenState createState() => _WebBottomNavBarScreenState();
}

class _WebBottomNavBarScreenState extends State<WebBottomNavBarScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  final List<Widget> _screens = [
    const WebSellerHomeScreen(),
    const WebSellerChatScreen(),
    const WebListOfSellerOrdersDetailPage(),
    const WebAccountScreen(),
  ];

  final List<String> _appBarTitles = ['Home', 'Chat', 'My Products', 'Account'];

  @override
  void initState() {
    super.initState();

    // FAB animation controller
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _fabAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _fabController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Increased app bar height
        child: AppBar(
          automaticallyImplyLeading: false, // Removes back arrow
          title: isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_appBarTitles.length, (index) {
                    final isSelected = _currentIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextButton(
                        onPressed: () => setState(() => _currentIndex = index),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          foregroundColor:
                              isSelected ? Colors.deepOrange : Colors.white,
                        ),
                        child: Text(
                          _appBarTitles[index],
                          style: TextStyle(
                            fontSize: 18, // Increased font size
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }),
                )
              : Center(
                  child: Text(
                    _appBarTitles[_currentIndex],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          elevation: 4,
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => WebUploadItemScreen()),
            // );
          },
          backgroundColor: Colors.deepOrange,
          elevation: 8,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

// Android

// class SellerChatScreen extends StatefulWidget {
//   const SellerChatScreen({super.key});
//
//   @override
//   _SellerChatScreenState createState() => _SellerChatScreenState();
// }
//
// class _SellerChatScreenState extends State<SellerChatScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Customer Messages'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('customers').snapshots(),
//         builder: (context, customersSnapshot) {
//           if (!customersSnapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final customers = customersSnapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: customers.length,
//             itemBuilder: (context, index) {
//               final customer = customers[index];
//               final customerId = customer.id;
//               final customerData = customer.data() as Map<String, dynamic>;
//               final customerName = customerData['name'] ?? 'No Name';
//               final customerEmail = customerData['email'] ?? 'No Email';
//
//               return StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('customers')
//                     .doc(customerId)
//                     .collection('chat')
//                     .orderBy('timestamp', descending: true)
//                     .limit(1)
//                     .snapshots(),
//                 builder: (context, chatSnapshot) {
//                   if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
//                     // Skip customers with no messages
//                     return const SizedBox.shrink();
//                   }
//
//                   final latestMessage = chatSnapshot.data!.docs.first;
//                   final messageText = latestMessage['message'] ?? '';
//                   final isCustomer = latestMessage['isCustomer'] ?? false;
//                   final timestamp = latestMessage['timestamp'] as Timestamp?;
//
//                   // return Card(
//                   //   margin: const EdgeInsets.symmetric(
//                   //       horizontal: 8.0, vertical: 4.0),
//                   //   child: ListTile(
//                   //     onTap: () {
//                   //       // Navigate to individual chat screen
//                   //       Navigator.push(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //           builder: (_) => CustomerChatDetailScreen(
//                   //             customerId: customerId,
//                   //             customerName: customerName,
//                   //           ),
//                   //         ),
//                   //       );
//                   //     },
//                   //     leading: CircleAvatar(
//                   //       backgroundColor: Colors.blueAccent,
//                   //       child: Text(
//                   //         customerName[0].toUpperCase(),
//                   //         style: const TextStyle(color: Colors.white),
//                   //       ),
//                   //     ),
//                   //     title: Text(customerName),
//                   //     subtitle: Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: [
//                   //         Text(
//                   //           messageText,
//                   //           maxLines: 1,
//                   //           overflow: TextOverflow.ellipsis,
//                   //         ),
//                   //         if (timestamp != null)
//                   //           Text(
//                   //             _formatTimestamp(timestamp),
//                   //             style: const TextStyle(
//                   //                 fontSize: 12, color: Colors.grey),
//                   //           ),
//                   //       ],
//                   //     ),
//                   //     trailing: const Icon(Icons.chevron_right),
//                   //   ),
//                   // );
//
//                   return AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                     margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(16),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => CustomerChatDetailScreen(
//                                 customerId: customerId,
//                                 customerName: customerName,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                           child: Row(
//                             children: [
//                               Hero(
//                                 tag: 'avatar_$customerId',
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.blueAccent,
//                                   radius: 24,
//                                   child: Text(
//                                     customerName[0].toUpperCase(),
//                                     style: const TextStyle(color: Colors.white, fontSize: 20),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       customerName,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       messageText,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(color: Colors.black54),
//                                     ),
//                                     if (timestamp != null)
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 2.0),
//                                         child: Text(
//                                           _formatTimestamp(timestamp),
//                                           style: const TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                               const Icon(Icons.chevron_right, color: Colors.grey),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//
//
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   String _formatTimestamp(Timestamp timestamp) {
//     final dateTime = timestamp.toDate();
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);
//
//     if (difference.inDays > 7) {
//       return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
//     } else if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }

//Web

class WebSellerChatScreen extends StatefulWidget {
  const WebSellerChatScreen({super.key});

  @override
  _WebSellerChatScreenState createState() => _WebSellerChatScreenState();
}

class _WebSellerChatScreenState extends State<WebSellerChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.deepOrange,
      //   centerTitle: true,
      //   title: const Text(
      //     'Customer Messages',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 22,
      //       letterSpacing: 0.5,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('customers').snapshots(),
        builder: (context, customersSnapshot) {
          if (!customersSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final customers = customersSnapshot.data!.docs;

          return AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
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
                    if (!chatSnapshot.hasData ||
                        chatSnapshot.data!.docs.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    final latestMessage = chatSnapshot.data!.docs.first;
                    final messageText = latestMessage['message'] ?? '';
                    final timestamp = latestMessage['timestamp'] as Timestamp?;

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Material(
                              color: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.deepOrange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          WebCustomerChatDetailScreen(
                                        customerId: customerId,
                                        customerName: customerName,
                                      ),
                                    ),
                                  );
                                },
                                hoverColor: Colors.deepOrange.withOpacity(0.05),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 18.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Colors.deepOrange,
                                        child: Text(
                                          customerName[0].toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            if (timestamp != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
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
                                      const Icon(Icons.chevron_right,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
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

// android

// class CustomerChatDetailScreen extends StatefulWidget {
//   final String customerId;
//   final String customerName;
//
//   const CustomerChatDetailScreen({
//     super.key,
//     required this.customerId,
//     required this.customerName,
//   });
//
//   @override
//   _CustomerChatDetailScreenState createState() =>
//       _CustomerChatDetailScreenState();
// }
//
// class _CustomerChatDetailScreenState extends State<CustomerChatDetailScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.customerName),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('customers')
//                   .doc(widget.customerId)
//                   .collection('chat')
//                   .orderBy('timestamp', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 return ListView.builder(
//                   padding: const EdgeInsets.all(8.0),
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     final doc = snapshot.data!.docs[index];
//                     final message = doc['message'] as String;
//                     final isCustomer = doc['isCustomer'] as bool;
//
//                     return Align(
//                       alignment: isCustomer
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 4.0),
//                         padding: const EdgeInsets.all(12.0),
//                         decoration: BoxDecoration(
//                           color: isCustomer
//                               ? Colors.blue[100]
//                               : Colors.grey[200],
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         child: Text(message),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         border: Border(top: BorderSide(color: Colors.grey[300]!)),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               decoration: const InputDecoration(
//                 hintText: 'Type your message...',
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Colors.blue),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;
//
//     await _firestore
//         .collection('customers')
//         .doc(widget.customerId)
//         .collection('chat')
//         .add({
//       'message': _messageController.text,
//       'isCustomer': false, // false because seller is sending
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     _messageController.clear();
//   }
//
//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
// }

// web

class WebCustomerChatDetailScreen extends StatefulWidget {
  final String customerId;
  final String customerName;

  const WebCustomerChatDetailScreen({
    super.key,
    required this.customerId,
    required this.customerName,
  });

  @override
  _WebCustomerChatDetailScreenState createState() =>
      _WebCustomerChatDetailScreenState();
}

class _WebCustomerChatDetailScreenState
    extends State<WebCustomerChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        title: Text(
          widget.customerName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
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

                final docs = snapshot.data!.docs;

                return AnimationLimiter(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final message = doc['message'] as String;
                      final isCustomer = doc['isCustomer'] as bool;

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 300),
                        child: SlideAnimation(
                          horizontalOffset: isCustomer ? 50.0 : -50.0,
                          child: FadeInAnimation(
                            child: Align(
                              alignment: isCustomer
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: isCustomer
                                      ? Colors.deepOrange[100]
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(16),
                                    topRight: const Radius.circular(16),
                                    bottomLeft: Radius.circular(
                                        isCustomer ? 16 : 0), // Tail shape
                                    bottomRight: Radius.circular(
                                        isCustomer ? 0 : 16), // Tail shape
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  message,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: Colors.orange[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    await _firestore
        .collection('customers')
        .doc(widget.customerId)
        .collection('chat')
        .add({
      'message': messageText,
      'isCustomer': false,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
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

// class WebAccountScreen extends StatelessWidget {
//   const WebAccountScreen({super.key});
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

// ui is not good for account screen

// class WebAccountScreen extends StatefulWidget {
//   const WebAccountScreen({super.key});
//
//   @override
//   State<WebAccountScreen> createState() => _WebAccountScreenState();
// }
//
// class _WebAccountScreenState extends State<WebAccountScreen> {
//   Map<String, dynamic>? sellerData;
//   bool isLoading = true;
//   bool uploading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSellerData();
//   }
//
//   Future<void> _loadSellerData() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) throw Exception('No logged-in user.');
//
//       final doc = await FirebaseFirestore.instance
//           .collection('seller')
//           .doc(user.uid)
//           .get();
//
//       if (!doc.exists) throw Exception('Seller not found.');
//
//       setState(() {
//         sellerData = doc.data()!;
//         isLoading = false;
//       });
//     } catch (e) {
//       debugPrint('Error loading seller data: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _uploadNewProfileImage() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;
//
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.image,
//         allowMultiple: false,
//         withData: true,
//       );
//
//       if (result != null && result.files.single.bytes != null) {
//         setState(() {
//           uploading = true;
//         });
//
//         final fileBytes = result.files.single.bytes!;
//         final fileName = "profile_${user.uid}.jpg";
//
//         // Upload to Firebase Storage
//         final storageRef =
//         FirebaseStorage.instance.ref().child("seller_profile/$fileName");
//         await storageRef.putData(fileBytes);
//
//         final downloadUrl = await storageRef.getDownloadURL();
//
//         // Update Firestore
//         await FirebaseFirestore.instance
//             .collection('seller')
//             .doc(user.uid)
//             .update({'profileImage': downloadUrl});
//
//         // Reload updated data
//         await _loadSellerData();
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Profile image updated successfully")),
//         );
//       }
//     } catch (e) {
//       debugPrint('Image upload error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to upload image: $e')),
//       );
//     } finally {
//       setState(() {
//         uploading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange[50],
//       appBar: AppBar(
//         title: const Text('Seller Account'),
//         backgroundColor: Colors.deepOrange,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.local_offer_outlined),
//             tooltip: 'Upload Offer Banner',
//             onPressed: () {
//               // TODO: Navigate to offer screen if needed
//             },
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : sellerData == null
//           ? const Center(child: Text('No seller data found.'))
//           : SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: _uploadNewProfileImage,
//                 child: Stack(
//                   alignment: Alignment.topRight,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: sellerData!['profileImage'] != null
//                           ? Image.network(
//                         sellerData!['profileImage'],
//                         width: 150,
//                         height: 150,
//                         fit: BoxFit.cover,
//                       )
//                           : Image.asset(
//                         'assets/images/Sadhana_cart1.png',
//                         width: 150,
//                         height: 150,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     if (uploading)
//                       const Positioned.fill(
//                         child: Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       )
//                     else
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                           ),
//                           child: const Icon(Icons.edit,
//                               color: Colors.deepOrange),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//
//             /// Show all seller data
//             ...sellerData!.entries.map((entry) {
//               if (entry.key == 'profileImage') return const SizedBox();
//               return ListTile(
//                 title: Text(entry.key,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16)),
//                 subtitle: Text(entry.value.toString()),
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// updating ui

class WebAccountScreen extends StatefulWidget {
  const WebAccountScreen({super.key});

  @override
  State<WebAccountScreen> createState() => _WebAccountScreenState();
}

class _WebAccountScreenState extends State<WebAccountScreen> {
  Map<String, dynamic>? sellerData;
  bool isLoading = true;
  bool uploading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, Map<String, String>> fieldGroups = {
    'Personal Information': {
      'name': 'Full Name',
      'email': 'Email Address',
      'phone': 'Phone Number',
      'sellerId': 'Seller ID',
    },
    'Business Details': {
      'shopName': 'Shop Name',
      'businessType': 'Business Type',
      'address': 'Business Address',
      'createdAt': 'Registered On',
    },
    'Tax Information': {
      'gstNumber': 'GST Number',
      'panNumber': 'PAN Number',
    },
    'Banking': {
      'bankAccount': 'Account Number',
      'accountHolderName': 'Account Holder',
    },
    'Documents': {
      'bankProofUrl': 'Bank Proof',
      'panCardUrl': 'PAN Card',
      'gstCertificateUrl': 'GST Certificate',
    },
  };

  @override
  void initState() {
    super.initState();
    _loadSellerData();
  }

  Future<void> _loadSellerData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No logged-in user.');

      final doc = await FirebaseFirestore.instance
          .collection('seller')
          .doc(user.uid)
          .get();

      if (!doc.exists) throw Exception('Seller not found.');

      setState(() {
        sellerData = doc.data()!;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading seller data: $e');
      setState(() {
        isLoading = false;
      });
      _showErrorSnackbar('Failed to load data: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _uploadNewProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        setState(() => uploading = true);

        final fileBytes = result.files.single.bytes!;
        final fileName =
            "profile_${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg";

        final storageRef =
            FirebaseStorage.instance.ref("seller_profiles/$fileName");
        await storageRef.putData(fileBytes);
        final downloadUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('seller')
            .doc(user.uid)
            .update({'profileImage': downloadUrl});

        await _loadSellerData();
        _showSuccessSnackbar('Profile image updated successfully');
      }
    } catch (e) {
      debugPrint('Image upload error: $e');
      _showErrorSnackbar('Failed to upload image: ${e.toString()}');
    } finally {
      if (mounted) setState(() => uploading = false);
    }
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: sellerData?['profileImage'] != null
                      ? Image.network(
                          sellerData!['profileImage'],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                ),
              ),
              Positioned(
                bottom: -4,
                right: -4,
                child: Material(
                  color: Colors.deepOrange,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: _uploadNewProfileImage,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: uploading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sellerData?['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sellerData?['shopName'] ?? 'No Shop Name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          if (sellerData?['status'] != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _getStatusColor(sellerData!['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getStatusColor(sellerData!['status']),
                  width: 1,
                ),
              ),
              child: Text(
                sellerData!['status'].toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(sellerData!['status']),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildInfoCard(String title, Map<String, String> fields) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _getGroupIcon(title),
                    size: 20,
                    color: Colors.deepOrange,
                  ),
                ],
              ),
            ),
            if (title == 'Documents') _buildDocumentRow(),
            ...fields.entries.map((entry) {
              final fieldKey = entry.key;
              final displayName = entry.value;

              if (!sellerData!.containsKey(fieldKey)) return const SizedBox();

              final value = sellerData![fieldKey];

              if (fieldKey == 'createdAt') {
                return _buildInfoField(displayName, _formatTimestamp(value));
              } else if (fieldKey == 'name' || fieldKey == 'shopName') {
                return const SizedBox(); // Skip these as they're in header
              } else if (fieldKey == 'bankProofUrl' ||
                  fieldKey == 'panCardUrl' ||
                  fieldKey == 'gstCertificateUrl') {
                return const SizedBox(); // These are handled in the document row
              }
              return _buildKeyValueField(displayName, value.toString());
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (sellerData?['bankProofUrl'] != null)
            Expanded(
              child: _buildDocumentContainer(
                'Bank Proof',
                sellerData!['bankProofUrl'],
              ),
            ),
          if (sellerData?['panCardUrl'] != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildDocumentContainer(
                  'PAN Card',
                  sellerData!['panCardUrl'],
                ),
              ),
            ),
          if (sellerData?['gstCertificateUrl'] != null)
            Expanded(
              child: _buildDocumentContainer(
                'GST Certificate',
                sellerData!['gstCertificateUrl'],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDocumentContainer(String label, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: imageUrl.isNotEmpty
              ? () => _showFullScreenImage(imageUrl, label)
              : null,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Stack(
              children: [
                if (imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Document not available',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_file,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Upload document',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (imageUrl.isNotEmpty)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.zoom_in,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyValueField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      value.isNotEmpty ? value : 'Not provided',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute}';
  }

  Widget _buildInfoField(String label, String value) {
    return _buildKeyValueField(label, value);
  }

  void _showFullScreenImage(String imageUrl, String title) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: Colors.black.withOpacity(0.5),
              elevation: 0,
              title: Text(title),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4,
                child: Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getGroupIcon(String title) {
    switch (title) {
      case 'Personal Information':
        return Icons.person_outline;
      case 'Business Details':
        return Icons.store_mall_directory_outlined;
      case 'Tax Information':
        return Icons.receipt_long_outlined;
      case 'Banking':
        return Icons.account_balance_outlined;
      case 'Documents':
        return Icons.attach_file_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.deepOrange.shade100,
      body: isLoading
          ? Center(
              child: SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.deepOrange,
                ),
              ),
            )
          : sellerData == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'No seller data found',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _loadSellerData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Try Again',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildProfileHeader(),
                      const SizedBox(height: 24),
                      ...fieldGroups.entries.map((entry) {
                        return _buildInfoCard(entry.key, entry.value);
                      }),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
    );
  }
}
