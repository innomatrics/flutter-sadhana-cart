// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Customer/category_tabb.dart';
// import 'package:sadhana_cart/Customer/customer_cart_screen.dart';
// import 'package:sadhana_cart/Customer/customer_profile_screen.dart';
// import 'package:sadhana_cart/Customer/customer_search_screen.dart';
// import 'package:sadhana_cart/Customer/home_tab_screen.dart';
// import 'package:sadhana_cart/Customer/orders_list_screen.dart';
// import 'package:video_player/video_player.dart';
//
// import 'customer_signin.dart';
//
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   int _currentIndex = 0;
// //
// //   final List<Widget> _screens = [
// //     HomeTab(),
// //     CategoriesTab(),
// //     const ExploreTab(),
// //     const CartTab(),
// //     const ProfileTab(),
// //   ];
// //
// //   final List<String> _titles = [
// //     'Home',
// //     'Categories',
// //     'Orders',
// //     'Cart',
// //     'Profile',
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser;
// //
// //     return Scaffold(
// //       // appBar: AppBar(
// //       //   title: Text(_titles[_currentIndex], style: TextStyle(color: Colors.white)),
// //       //   backgroundColor: Colors.blue,
// //       //   elevation: 0,
// //       //   centerTitle: true,
// //       // ),
// //
// //       // appBar: AppBar(
// //       //   backgroundColor: Colors.blue,
// //       //   elevation: 0,
// //       //   centerTitle: true,
// //       //   title: _currentIndex == 0
// //       //       ? Padding(
// //       //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
// //       //     child: AnimatedContainer(
// //       //       duration: Duration(milliseconds: 300),
// //       //       height: 45,
// //       //       decoration: BoxDecoration(
// //       //         color: Colors.white,
// //       //         borderRadius: BorderRadius.circular(30),
// //       //         boxShadow: [
// //       //           BoxShadow(
// //       //             color: Colors.black26,
// //       //             blurRadius: 4,
// //       //             offset: Offset(0, 2),
// //       //           )
// //       //         ],
// //       //       ),
// //       //       child: TextField(
// //       //         style: TextStyle(fontSize: 16),
// //       //         decoration: InputDecoration(
// //       //           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //       //           hintText: 'Search for products...',
// //       //           hintStyle: TextStyle(color: Colors.grey),
// //       //           border: InputBorder.none,
// //       //           prefixIcon: Icon(Icons.search, color: Colors.grey),
// //       //         ),
// //       //         onChanged: (query) {
// //       //           // You can hook this to search filtering
// //       //           print('Search: $query');
// //       //         },
// //       //       ),
// //       //     ),
// //       //   )
// //       //       : Text(
// //       //     _titles[_currentIndex],
// //       //     style: TextStyle(color: Colors.white),
// //       //   ),
// //       // ),
// //
// //       // appBar: AppBar(
// //       //   backgroundColor: Colors.blue,
// //       //   elevation: 0,
// //       //   centerTitle: true,
// //       //   title: _currentIndex == 0
// //       //       ? Padding(
// //       //           padding:
// //       //               const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
// //       //           child: GestureDetector(
// //       //             onTap: () {
// //       //               Navigator.push(
// //       //                 context,
// //       //                 MaterialPageRoute(
// //       //                     builder: (context) => const SearchScreen()),
// //       //               );
// //       //             },
// //       //             child: AnimatedContainer(
// //       //               duration: const Duration(milliseconds: 300),
// //       //               height: 45,
// //       //               decoration: BoxDecoration(
// //       //                 color: Colors.white,
// //       //                 borderRadius: BorderRadius.circular(30),
// //       //                 boxShadow: const [
// //       //                   BoxShadow(
// //       //                     color: Colors.black26,
// //       //                     blurRadius: 4,
// //       //                     offset: Offset(0, 2),
// //       //                   )
// //       //                 ],
// //       //               ),
// //       //               child: const IgnorePointer(
// //       //                 child: TextField(
// //       //                   style: TextStyle(fontSize: 16),
// //       //                   decoration: InputDecoration(
// //       //                     contentPadding: EdgeInsets.symmetric(
// //       //                         horizontal: 20, vertical: 12),
// //       //                     hintText: 'Search for products...',
// //       //                     hintStyle: TextStyle(color: Colors.grey),
// //       //                     border: InputBorder.none,
// //       //                     prefixIcon: Icon(Icons.search, color: Colors.grey),
// //       //                   ),
// //       //                 ),
// //       //               ),
// //       //             ),
// //       //           ),
// //       //         )
// //       //       : Text(
// //       //           _titles[_currentIndex],
// //       //           style: const TextStyle(color: Colors.white),
// //       //         ),
// //       // ),
// //
// //       body: AnimatedSwitcher(
// //         duration: const Duration(milliseconds: 300),
// //         child: _screens[_currentIndex],
// //       ),
// //       bottomNavigationBar: StreamBuilder<QuerySnapshot>(
// //         stream: user != null
// //             ? FirebaseFirestore.instance
// //                 .collection('customers')
// //                 .doc(user.uid)
// //                 .collection('cart')
// //                 .snapshots()
// //             : null,
// //         builder: (context, snapshot) {
// //           int cartItemCount = 0;
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             cartItemCount = 0; // Show 0 while loading
// //           } else if (snapshot.hasData && snapshot.data != null) {
// //             cartItemCount = snapshot
// //                 .data!.docs.length; // Get the number of items in the cart
// //           }
// //
// //           return BottomNavigationBar(
// //             currentIndex: _currentIndex,
// //             onTap: (index) {
// //               setState(() {
// //                 _currentIndex = index;
// //               });
// //             },
// //             selectedItemColor: Colors.blueAccent,
// //             unselectedItemColor: Colors.grey,
// //             type: BottomNavigationBarType.fixed,
// //             items: [
// //               const BottomNavigationBarItem(
// //                   icon: Icon(Icons.home), label: 'Home'),
// //               const BottomNavigationBarItem(
// //                   icon: Icon(Icons.category), label: 'Categories'),
// //               const BottomNavigationBarItem(
// //                   icon: Icon(Icons.explore), label: 'Orders'),
// //               BottomNavigationBarItem(
// //                 icon: Stack(
// //                   children: [
// //                     const Icon(Icons.shopping_cart),
// //                     if (cartItemCount > 0)
// //                       Positioned(
// //                         right: 0,
// //                         child: Container(
// //                           padding: const EdgeInsets.all(2),
// //                           decoration: BoxDecoration(
// //                             color: Colors.red,
// //                             borderRadius: BorderRadius.circular(6),
// //                           ),
// //                           constraints: const BoxConstraints(
// //                             minWidth: 12,
// //                             minHeight: 12,
// //                           ),
// //                           child: Text(
// //                             '$cartItemCount',
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 8,
// //                             ),
// //                             textAlign: TextAlign.center,
// //                           ),
// //                         ),
// //                       ),
// //                   ],
// //                 ),
// //                 label: 'Cart',
// //               ),
// //               const BottomNavigationBarItem(
// //                   icon: Icon(Icons.account_circle), label: 'Profile'),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     HomeTab(),
//     CategoriesTab(),
//     const ExploreTab(),
//     const CartTab(),
//     const ProfileTab(),
//   ];
//
//   final List<String> _titles = [
//     'Home',
//     'Categories',
//     'Orders',
//     'Cart',
//     'Profile',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final isWideScreen = MediaQuery.of(context).size.width > 800;
//
//     return Scaffold(
//
//
//       backgroundColor: Colors.grey[100],
//
//       // AppBar for Web/Desktop
//       appBar: isWideScreen
//           ? PreferredSize(
//         preferredSize: const Size.fromHeight(150),
//         child: buildWebStyleAppBar(context, (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         }, _currentIndex),
//       )
//           : null,
//
//
//
//       // Main Content
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         child: _screens[_currentIndex],
//       ),
//
//       // BottomNavigationBar for Mobile Only
//       bottomNavigationBar: !isWideScreen
//           ? StreamBuilder<QuerySnapshot>(
//         stream: user != null
//             ? FirebaseFirestore.instance
//             .collection('customers')
//             .doc(user.uid)
//             .collection('cart')
//             .snapshots()
//             : null,
//         builder: (context, snapshot) {
//           int cartItemCount = 0;
//           if (snapshot.hasData && snapshot.data != null) {
//             cartItemCount = snapshot.data!.docs.length;
//           }
//
//           return BottomNavigationBar(
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             selectedItemColor: Colors.blueAccent,
//             unselectedItemColor: Colors.grey,
//             type: BottomNavigationBarType.fixed,
//             items: [
//               const BottomNavigationBarItem(
//                   icon: Icon(Icons.home), label: 'Home'),
//               const BottomNavigationBarItem(
//                   icon: Icon(Icons.category), label: 'Categories'),
//               const BottomNavigationBarItem(
//                   icon: Icon(Icons.explore), label: 'Orders'),
//               BottomNavigationBarItem(
//                 icon: Stack(
//                   children: [
//                     const Icon(Icons.shopping_cart),
//                     if (cartItemCount > 0)
//                       Positioned(
//                         right: 0,
//                         child: Container(
//                           padding: const EdgeInsets.all(2),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           constraints: const BoxConstraints(
//                             minWidth: 12,
//                             minHeight: 12,
//                           ),
//                           child: Text(
//                             '$cartItemCount',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 8,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//
//                         ),
//                       ),
//                   ],
//                 ),
//                 label: 'Cart',
//               ),
//               const BottomNavigationBarItem(
//                   icon: Icon(Icons.account_circle), label: 'Profile'),
//             ],
//           );
//         },
//
//       )
//           : null,
//
//     );
//
//   }
//   // Widget buildWebStyleAppBar(BuildContext context, Function(int) onTabSelected, int currentIndex) {
//   //   return Container(
//   //     color: Colors.white,
//   //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6), // Reduced vertical padding
//   //     child: Row(
//   //       crossAxisAlignment: CrossAxisAlignment.center,
//   //       children: [
//   //         // Logo stacked above text
//   //         Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             Image.asset(
//   //               'assets/images/Sadhana_cart1.png',
//   //               height: 45, // Reduced from 50
//   //               width: 45,
//   //               fit: BoxFit.contain,
//   //             ),
//   //             const SizedBox(height: 2),
//   //             const Text(
//   //               'SadhanaCart',
//   //               style: TextStyle(
//   //                 color: Colors.deepOrange,
//   //                 fontSize: 20,
//   //                 fontWeight: FontWeight.bold,
//   //                 letterSpacing: 1.2,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //
//   //         const Spacer(),
//   //
//   //         // Center Nav
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: [
//   //             _buildNavText('Home', 0, currentIndex, onTabSelected),
//   //             _buildNavText('Categories', 1, currentIndex, onTabSelected),
//   //             _buildNavText('Orders', 2, currentIndex, onTabSelected),
//   //             _buildNavText('Profile', 4, currentIndex, onTabSelected),
//   //           ],
//   //         ),
//   //
//   //         const Spacer(),
//   //
//   //         // Icons (Search & Cart)
//   //         Row(
//   //           children: [
//   //             IconButton(
//   //               icon: const Icon(Icons.search, color: Colors.grey, size: 30),
//   //               onPressed: () {
//   //                 onTabSelected(5); // Optional: index for search
//   //               },
//   //             ),
//   //             const SizedBox(width: 12),
//   //             IconButton(
//   //               icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 30),
//   //               onPressed: () {
//   //                 onTabSelected(3);
//   //               },
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget buildWebStyleAppBar(BuildContext context, Function(int) onTabSelected, int currentIndex) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Logo stacked above text
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 'assets/images/Sadhana_cart1.png',
//                 height: 45,
//                 width: 45,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 2),
//               const Text(
//                 'SadhanaCart',
//                 style: TextStyle(
//                   color: Colors.deepOrange,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//             ],
//           ),
//
//           const Spacer(),
//
//           // Center Nav
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildNavText('Home', 0, currentIndex, onTabSelected),
//               _buildNavText('Categories', 1, currentIndex, onTabSelected),
//               _buildNavText('Orders', 2, currentIndex, onTabSelected),
//               // _buildNavText('Profile', 4, currentIndex, onTabSelected),
//             ],
//           ),
//
//           const Spacer(),
//
//           // Icons (Search, Cart & Profile)
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.search, color: Colors.grey, size: 30),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     PageRouteBuilder(
//                       pageBuilder: (context, animation, secondaryAnimation) => const SearchScreen(),
//                       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                         return FadeTransition(
//                           opacity: animation,
//                           child: child,
//                         );
//                       },
//                       transitionDuration: const Duration(milliseconds: 300),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(width: 12),
//               IconButton(
//                 icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 30),
//                 onPressed: () {
//                   onTabSelected(3);
//                 },
//               ),
//               const SizedBox(width: 12),
//               // Profile Section with Hover Effect
//               MouseRegion(
//                 cursor: SystemMouseCursors.click,
//                 child: GestureDetector(
//                   onTap: () async {
//                     if (user == null) {
//                       // Navigate to login screen if not logged in
//                       await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const CustomerSigninScreen(),
//                         ),
//                       );
//                       // Refresh the state after returning from login
//                       if (mounted) setState(() {});
//                     }
//                     // else {
//                     //   // Already logged in - go to profile
//                     //   onTabSelected(4);
//                     // }
//                   },
//                   child: StreamBuilder<DocumentSnapshot>(
//                     stream: user != null
//                         ? FirebaseFirestore.instance
//                         .collection('customers')
//                         .doc(user.uid)
//                         .snapshots()
//                         : null,
//                     builder: (context, snapshot) {
//                       final userName = snapshot.hasData
//                           ? snapshot.data!['name'] as String? ?? 'Profile'
//                           : 'Login';
//
//                       return Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.transparent,
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.account_circle, size: 30),
//                             const SizedBox(width: 8),
//                             TweenAnimationBuilder<Color?>(
//                               duration: const Duration(milliseconds: 200),
//                               tween: ColorTween(
//                                 begin: Colors.grey[800],
//                                 end: Colors.deepOrange,
//                               ),
//                               builder: (context, color, child) {
//                                 return MouseRegion(
//                                   onEnter: (_) => setState(() {}),
//                                   onExit: (_) => setState(() {}),
//                                   child: Text(
//                                     user == null ? 'Login' : userName.split(' ')[0],
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: color,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildNavText(String title, int index, int currentIndex, Function(int) onTap) {
//     final bool isActive = index == currentIndex;
//
//     return GestureDetector(
//       onTap: () => onTap(index),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14),
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: isActive ? Colors.deepOrange : Colors.grey[800],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // Category Items Page
// class CategoryItemsPage extends StatelessWidget {
//   final String categoryId;
//
//   const CategoryItemsPage(
//       {super.key, required this.categoryId, required String category});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Category Items'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('seller')
//             .doc(
//                 'sellerId') // Replace with actual seller ID or fetch dynamically
//             .collection(categoryId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//                 child: Text('No items found in this category.'));
//           }
//
//           var items = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               var item = items[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 child: ListTile(
//                   leading: item['images'] != null && item['images'].isNotEmpty
//                       ? Image.network(
//                           item['images'][0]) // Display the first image
//                       : const Icon(Icons.image),
//                   title: Text(item['name']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Price: \$${item['price']}'),
//                       Text('Offer Price: \$${item['offerPrice']}'),
//                       if (item['videos'] != null && item['videos'].isNotEmpty)
//                         VideoThumbnail(videoUrl: item['videos'][0]),
//                     ],
//                   ),
//                   trailing: const Icon(Icons.arrow_forward),
//                   onTap: () {
//                     // Navigate to item details page if needed
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// // Widget to display video thumbnails
// class VideoThumbnail extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoThumbnail({super.key, required this.videoUrl});
//
//   @override
//   _VideoThumbnailState createState() => _VideoThumbnailState();
// }
//
// class _VideoThumbnailState extends State<VideoThumbnail> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlay() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _togglePlay,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 100,
//             color: Colors.grey[300],
//             child: _controller.value.isInitialized
//                 ? AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   )
//                 : const Center(child: CircularProgressIndicator()),
//           ),
//           Icon(
//             _isPlaying ? Icons.pause : Icons.play_arrow,
//             size: 50,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ExploreTab extends StatelessWidget {
//   const ExploreTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       return const Center(child: Text('Please log in to view orders.'));
//     }
//
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           OrdersList(userId: user.uid),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//



//



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/category_tabb.dart';
import 'package:sadhana_cart/Customer/customer_cart_screen.dart';
import 'package:sadhana_cart/Customer/customer_profile_screen.dart';
import 'package:sadhana_cart/Customer/customer_search_screen.dart';
import 'package:sadhana_cart/Customer/home_tab_screen.dart';
import 'package:sadhana_cart/Customer/orders_list_screen.dart';
import 'package:sadhana_cart/Web/Customer/category_tabb.dart';
import 'package:sadhana_cart/Web/Customer/customer_cart_screen.dart';
import 'package:sadhana_cart/Web/Customer/customer_profile_screen.dart';
import 'package:sadhana_cart/Web/Customer/home_tab_screen.dart';
import 'package:sadhana_cart/Web/Seller/Seller_Sign_In.dart';
import 'package:video_player/video_player.dart';

import '../../Seller/Seller_Sign_In.dart';
import 'customer_signin.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     HomeTab(),
//     CategoriesTab(),
//     const ExploreTab(),
//     const CartTab(),
//     const ProfileTab(),
//   ];
//
//   final List<String> _titles = [
//     'Home',
//     'Categories',
//     'Orders',
//     'Cart',
//     'Profile',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(_titles[_currentIndex], style: TextStyle(color: Colors.white)),
//       //   backgroundColor: Colors.blue,
//       //   elevation: 0,
//       //   centerTitle: true,
//       // ),
//
//       // appBar: AppBar(
//       //   backgroundColor: Colors.blue,
//       //   elevation: 0,
//       //   centerTitle: true,
//       //   title: _currentIndex == 0
//       //       ? Padding(
//       //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
//       //     child: AnimatedContainer(
//       //       duration: Duration(milliseconds: 300),
//       //       height: 45,
//       //       decoration: BoxDecoration(
//       //         color: Colors.white,
//       //         borderRadius: BorderRadius.circular(30),
//       //         boxShadow: [
//       //           BoxShadow(
//       //             color: Colors.black26,
//       //             blurRadius: 4,
//       //             offset: Offset(0, 2),
//       //           )
//       //         ],
//       //       ),
//       //       child: TextField(
//       //         style: TextStyle(fontSize: 16),
//       //         decoration: InputDecoration(
//       //           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       //           hintText: 'Search for products...',
//       //           hintStyle: TextStyle(color: Colors.grey),
//       //           border: InputBorder.none,
//       //           prefixIcon: Icon(Icons.search, color: Colors.grey),
//       //         ),
//       //         onChanged: (query) {
//       //           // You can hook this to search filtering
//       //           print('Search: $query');
//       //         },
//       //       ),
//       //     ),
//       //   )
//       //       : Text(
//       //     _titles[_currentIndex],
//       //     style: TextStyle(color: Colors.white),
//       //   ),
//       // ),
//
//       // appBar: AppBar(
//       //   backgroundColor: Colors.blue,
//       //   elevation: 0,
//       //   centerTitle: true,
//       //   title: _currentIndex == 0
//       //       ? Padding(
//       //           padding:
//       //               const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
//       //           child: GestureDetector(
//       //             onTap: () {
//       //               Navigator.push(
//       //                 context,
//       //                 MaterialPageRoute(
//       //                     builder: (context) => const SearchScreen()),
//       //               );
//       //             },
//       //             child: AnimatedContainer(
//       //               duration: const Duration(milliseconds: 300),
//       //               height: 45,
//       //               decoration: BoxDecoration(
//       //                 color: Colors.white,
//       //                 borderRadius: BorderRadius.circular(30),
//       //                 boxShadow: const [
//       //                   BoxShadow(
//       //                     color: Colors.black26,
//       //                     blurRadius: 4,
//       //                     offset: Offset(0, 2),
//       //                   )
//       //                 ],
//       //               ),
//       //               child: const IgnorePointer(
//       //                 child: TextField(
//       //                   style: TextStyle(fontSize: 16),
//       //                   decoration: InputDecoration(
//       //                     contentPadding: EdgeInsets.symmetric(
//       //                         horizontal: 20, vertical: 12),
//       //                     hintText: 'Search for products...',
//       //                     hintStyle: TextStyle(color: Colors.grey),
//       //                     border: InputBorder.none,
//       //                     prefixIcon: Icon(Icons.search, color: Colors.grey),
//       //                   ),
//       //                 ),
//       //               ),
//       //             ),
//       //           ),
//       //         )
//       //       : Text(
//       //           _titles[_currentIndex],
//       //           style: const TextStyle(color: Colors.white),
//       //         ),
//       // ),
//
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         child: _screens[_currentIndex],
//       ),
//       bottomNavigationBar: StreamBuilder<QuerySnapshot>(
//         stream: user != null
//             ? FirebaseFirestore.instance
//                 .collection('customers')
//                 .doc(user.uid)
//                 .collection('cart')
//                 .snapshots()
//             : null,
//         builder: (context, snapshot) {
//           int cartItemCount = 0;
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             cartItemCount = 0; // Show 0 while loading
//           } else if (snapshot.hasData && snapshot.data != null) {
//             cartItemCount = snapshot
//                 .data!.docs.length; // Get the number of items in the cart
//           }
//
//           return BottomNavigationBar(
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             selectedItemColor: Colors.blueAccent,
//             unselectedItemColor: Colors.grey,
//             type: BottomNavigationBarType.fixed,
//             items: [
//               const BottomNavigationBarItem(
//                   icon: Icon(Icons.home), label: 'Home'),
//               const BottomNavigationBarItem(
//                   icon: Icon(Icons.category), label: 'Categories'),
//               const BottomNavigationBarItem(
//                   icon: Icon(Icons.explore), label: 'Orders'),
//               BottomNavigationBarItem(
//                 icon: Stack(
//                   children: [
//                     const Icon(Icons.shopping_cart),
//                     if (cartItemCount > 0)
//                       Positioned(
//                         right: 0,
//                         child: Container(
//                           padding: const EdgeInsets.all(2),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           constraints: const BoxConstraints(
//                             minWidth: 12,
//                             minHeight: 12,
//                           ),
//                           child: Text(
//                             '$cartItemCount',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 8,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 label: 'Cart',
//               ),
//               const BottomNavigationBarItem(
//                   icon: Icon(Icons.account_circle), label: 'Profile'),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }



class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  _WebHomeScreenState createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    WebHomeTab(),
    WebCategoriesTab(),
    const WebExploreTab(),
    const WebCartTab(),
    const WebProfileTab(),
  ];

  final List<String> _titles = [
    'Home',
    'Categories',
    'Orders',
    'Cart',
    'Profile',
  ];


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isWideScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(


      backgroundColor: Colors.grey[100],

      // AppBar for Web/Desktop
      appBar: isWideScreen
          ? PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: buildWebStyleAppBar(context, (index) {
          setState(() {
            _currentIndex = index;
          });
        }, _currentIndex),
      )
          : null,



      // Main Content
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),

      // BottomNavigationBar for Mobile Only
      bottomNavigationBar: !isWideScreen
          ? StreamBuilder<QuerySnapshot>(
        stream: user != null
            ? FirebaseFirestore.instance
            .collection('customers')
            .doc(user.uid)
            .collection('cart')
            .snapshots()
            : null,
        builder: (context, snapshot) {
          int cartItemCount = 0;
          if (snapshot.hasData && snapshot.data != null) {
            cartItemCount = snapshot.data!.docs.length;
          }

          return BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: 'Orders'),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (cartItemCount > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '$cartItemCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),

                        ),
                      ),
                  ],
                ),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile'),
            ],
          );
        },

      )
          : null,

    );

  }
  // Widget buildWebStyleAppBar(BuildContext context, Function(int) onTabSelected, int currentIndex) {
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6), // Reduced vertical padding
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         // Logo stacked above text
  //         Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Image.asset(
  //               'assets/images/Sadhana_cart1.png',
  //               height: 45, // Reduced from 50
  //               width: 45,
  //               fit: BoxFit.contain,
  //             ),
  //             const SizedBox(height: 2),
  //             const Text(
  //               'SadhanaCart',
  //               style: TextStyle(
  //                 color: Colors.deepOrange,
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 letterSpacing: 1.2,
  //               ),
  //             ),
  //           ],
  //         ),
  //
  //         const Spacer(),
  //
  //         // Center Nav
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             _buildNavText('Home', 0, currentIndex, onTabSelected),
  //             _buildNavText('Categories', 1, currentIndex, onTabSelected),
  //             _buildNavText('Orders', 2, currentIndex, onTabSelected),
  //             _buildNavText('Profile', 4, currentIndex, onTabSelected),
  //           ],
  //         ),
  //
  //         const Spacer(),
  //
  //         // Icons (Search & Cart)
  //         Row(
  //           children: [
  //             IconButton(
  //               icon: const Icon(Icons.search, color: Colors.grey, size: 30),
  //               onPressed: () {
  //                 onTabSelected(5); // Optional: index for search
  //               },
  //             ),
  //             const SizedBox(width: 12),
  //             IconButton(
  //               icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 30),
  //               onPressed: () {
  //                 onTabSelected(3);
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildWebStyleAppBar(BuildContext context, Function(int) onTabSelected, int currentIndex) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo stacked above text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/Sadhana_cart1.png',
                height: 45,
                width: 45,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 2),
              const Text(
                'SadhanaCart',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Center Nav
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavText('Home', 0, currentIndex, onTabSelected),
              _buildNavText('Categories', 1, currentIndex, onTabSelected),
              _buildNavText('Orders', 2, currentIndex, onTabSelected),
              // _buildNavText('Profile', 4, currentIndex, onTabSelected),
            ],
          ),

          const Spacer(),

          // Icons (Search, Cart & Profile)
          // Row(
          //   children: [
          //     IconButton(
          //       icon: const Icon(Icons.search, color: Colors.grey, size: 30),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           PageRouteBuilder(
          //             pageBuilder: (context, animation, secondaryAnimation) => const SearchScreen(),
          //             transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //               return FadeTransition(
          //                 opacity: animation,
          //                 child: child,
          //               );
          //             },
          //             transitionDuration: const Duration(milliseconds: 300),
          //           ),
          //         );
          //       },
          //     ),
          //     const SizedBox(width: 12),
          //     IconButton(
          //       icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 30),
          //       onPressed: () {
          //         onTabSelected(3);
          //       },
          //     ),
          //     const SizedBox(width: 12),
          //     // Profile Section with Hover Effect
          //     MouseRegion(
          //       cursor: SystemMouseCursors.click,
          //       child: GestureDetector(
          //         onTap: () async {
          //           if (user == null) {
          //             // Navigate to login screen if not logged in
          //             await Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => const CustomerSigninScreen(),
          //               ),
          //             );
          //             // Refresh the state after returning from login
          //             if (mounted) setState(() {});
          //           }
          //           // else {
          //           //   // Already logged in - go to profile
          //           //   onTabSelected(4);
          //           // }
          //         },
          //         child: StreamBuilder<DocumentSnapshot>(
          //           stream: user != null
          //               ? FirebaseFirestore.instance
          //               .collection('customers')
          //               .doc(user.uid)
          //               .snapshots()
          //               : null,
          //           builder: (context, snapshot) {
          //             final userName = snapshot.hasData
          //                 ? snapshot.data!['name'] as String? ?? 'Profile'
          //                 : 'Login';
          //
          //             return Container(
          //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(20),
          //                 color: Colors.transparent,
          //               ),
          //               child: Row(
          //                 children: [
          //                   const Icon(Icons.account_circle, size: 30),
          //                   const SizedBox(width: 8),
          //                   TweenAnimationBuilder<Color?>(
          //                     duration: const Duration(milliseconds: 200),
          //                     tween: ColorTween(
          //                       begin: Colors.grey[800],
          //                       end: Colors.deepOrange,
          //                     ),
          //                     builder: (context, color, child) {
          //                       return MouseRegion(
          //                         onEnter: (_) => setState(() {}),
          //                         onExit: (_) => setState(() {}),
          //                         child: Text(
          //                           user == null ? 'Login' : userName.split(' ')[0],
          //                           style: TextStyle(
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.w600,
          //                             color: color,
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 ],
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          // Inside buildWebStyleAppBar, modify the Row containing the icons:
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.grey, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const SearchScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 30),
                onPressed: () {
                  onTabSelected(3);
                },
              ),

              // const SizedBox(width: 12),
              // /// 🔥 Become a Seller Button
              // MouseRegion(
              //   cursor: SystemMouseCursors.click,
              //   child: AnimatedContainer(
              //     duration: const Duration(milliseconds: 300),
              //     decoration: BoxDecoration(
              //       gradient: const LinearGradient(
              //         colors: [Colors.deepOrange, Colors.orangeAccent],
              //       ),
              //       borderRadius: BorderRadius.circular(20),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.deepOrange.withOpacity(0.3),
              //           blurRadius: 10,
              //           offset: const Offset(0, 4),
              //         ),
              //       ],
              //     ),
              //     child: ElevatedButton.icon(
              //       onPressed: () {
              //         // Navigate to seller registration screen
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const WebSellerSignInScreen(),
              //           ),
              //         );
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.transparent,
              //         shadowColor: Colors.transparent,
              //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20),
              //         ),
              //       ),
              //       icon: const Icon(Icons.store, color: Colors.white),
              //       label: const Text(
              //         'Become a Seller',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(width: 12),
              _buildLogoutButton(),
              const SizedBox(width: 12),
              // Profile Section with Hover Effect
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    if (user == null) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WebCustomerSigninScreen(),
                        ),
                      );
                      if (mounted) setState(() {});
                    }
                  },
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: user != null
                        ? FirebaseFirestore.instance
                        .collection('customers')
                        .doc(user.uid)
                        .snapshots()
                        : null,
                    builder: (context, snapshot) {
                      final userName = snapshot.hasData
                          ? snapshot.data!['name'] as String? ?? 'Profile'
                          : 'Login';

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [

                            const Icon(Icons.account_circle, size: 30),
                            const SizedBox(width: 8),
                            TweenAnimationBuilder<Color?>(
                              duration: const Duration(milliseconds: 200),
                              tween: ColorTween(
                                begin: Colors.grey[800],
                                end: Colors.deepOrange,
                              ),
                              builder: (context, color, child) {
                                return MouseRegion(
                                  onEnter: (_) => setState(() {}),
                                  onExit: (_) => setState(() {}),
                                  child: Text(
                                    user == null ? 'Login' : userName.split(' ')[0],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: color,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    final user = FirebaseAuth.instance.currentUser;

    return user != null
        ? MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showLogoutDialog(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              const Icon(Icons.logout, color: Colors.grey, size: 24),

              const SizedBox(width: 8),

              TweenAnimationBuilder<Color?>(
                duration: const Duration(milliseconds: 200),
                tween: ColorTween(
                  begin: Colors.grey[800],
                  end: Colors.deepOrange,
                ),
                builder: (context, color, child) {
                  return MouseRegion(
                    onEnter: (_) => setState(() {}),
                    onExit: (_) => setState(() {}),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    )
        : const SizedBox.shrink();
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // User can tap outside to close
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            'Confirm Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text(
                'No',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text(
                'Yes, Logout',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _performLogout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _performLogout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Update Firestore status first
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(user.uid)
            .update({
          'status': 'offline',
          'lastSeen': DateTime.now(),
        });

        // Then sign out
        await FirebaseAuth.instance.signOut();

        // Update UI state
        if (mounted) {
          setState(() {});
        }

        // Optional: Show a snackbar confirmation
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You have been logged out successfully'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            )
            );
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logout failed: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    }


  Widget _buildNavText(String title, int index, int currentIndex, Function(int) onTap) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.deepOrange : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}


// Category Items Page
class CategoryItemsPage extends StatelessWidget {
  final String categoryId;

  const CategoryItemsPage(
      {super.key, required this.categoryId, required String category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Items'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('seller')
            .doc(
            'sellerId') // Replace with actual seller ID or fetch dynamically
            .collection(categoryId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('No items found in this category.'));
          }

          var items = snapshot.data!.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: item['images'] != null && item['images'].isNotEmpty
                      ? Image.network(
                      item['images'][0]) // Display the first image
                      : const Icon(Icons.image),
                  title: Text(item['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${item['price']}'),
                      Text('Offer Price: \$${item['offerPrice']}'),
                      if (item['videos'] != null && item['videos'].isNotEmpty)
                        VideoThumbnail(videoUrl: item['videos'][0]),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to item details page if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Widget to display video thumbnails
class VideoThumbnail extends StatefulWidget {
  final String videoUrl;

  const VideoThumbnail({super.key, required this.videoUrl});

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.grey[300],
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : const Center(child: CircularProgressIndicator()),
          ),
          Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            size: 50,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class WebExploreTab extends StatelessWidget {
  const WebExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Please log in to view orders.'));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          OrdersList(userId: user.uid),
        ],
      ),
    );
  }
}







