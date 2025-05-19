import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/category_tabb.dart';
import 'package:sadhana_cart/Customer/customer_cart_screen.dart';
import 'package:sadhana_cart/Customer/customer_profile_screen.dart';
import 'package:sadhana_cart/Customer/customer_search_screen.dart';
import 'package:sadhana_cart/Customer/home_tab_screen.dart';
import 'package:sadhana_cart/Customer/orders_list_screen.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeTab(),
    CategoriesTab(),
    const ExploreTab(),
    const CartTab(),
    const ProfileTab(),
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

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_titles[_currentIndex], style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.blue,
      //   elevation: 0,
      //   centerTitle: true,
      // ),

      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: _currentIndex == 0
      //       ? Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      //     child: AnimatedContainer(
      //       duration: Duration(milliseconds: 300),
      //       height: 45,
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(30),
      //         boxShadow: [
      //           BoxShadow(
      //             color: Colors.black26,
      //             blurRadius: 4,
      //             offset: Offset(0, 2),
      //           )
      //         ],
      //       ),
      //       child: TextField(
      //         style: TextStyle(fontSize: 16),
      //         decoration: InputDecoration(
      //           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //           hintText: 'Search for products...',
      //           hintStyle: TextStyle(color: Colors.grey),
      //           border: InputBorder.none,
      //           prefixIcon: Icon(Icons.search, color: Colors.grey),
      //         ),
      //         onChanged: (query) {
      //           // You can hook this to search filtering
      //           print('Search: $query');
      //         },
      //       ),
      //     ),
      //   )
      //       : Text(
      //     _titles[_currentIndex],
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: _currentIndex == 0
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: const IgnorePointer(
                      child: TextField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          hintText: 'Search for products...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Text(
                _titles[_currentIndex],
                style: const TextStyle(color: Colors.white),
              ),
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: StreamBuilder<QuerySnapshot>(
        stream: user != null
            ? FirebaseFirestore.instance
                .collection('customers')
                .doc(user.uid)
                .collection('cart')
                .snapshots()
            : null,
        builder: (context, snapshot) {
          int cartItemCount = 0;
          if (snapshot.connectionState == ConnectionState.waiting) {
            cartItemCount = 0; // Show 0 while loading
          } else if (snapshot.hasData && snapshot.data != null) {
            cartItemCount = snapshot
                .data!.docs.length; // Get the number of items in the cart
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

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

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




// class CartTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final cartModel = Provider.of<CartModel>(context);
//
//     return Scaffold(
//       body: Column(
//         children: [
//           // List of products in the cart
//           Expanded(
//             child: cartModel.cartItems.isEmpty
//                 ? Center(
//               child: Text(
//                 'Your cart is empty',
//                 style: TextStyle(fontSize: 18),
//               ),
//             )
//                 : ListView.builder(
//               itemCount: cartModel.cartItems.length,
//               itemBuilder: (context, index) {
//                 final product = cartModel.cartItems[index];
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Product Image and Details
//                       Row(
//                         children: [
//                           // Product Image
//                           if (product['images'] != null && product['images'].isNotEmpty)
//                             Image.network(
//                               product['images'][0],
//                               width: 80,
//                               height: 80,
//                               fit: BoxFit.cover,
//                             ),
//                           SizedBox(width: 16),
//                           // Product Details
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product['name'],
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   '₹${product['offerPrice']}',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       // Buttons for Delete and Place Order
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Delete Button
//                           ElevatedButton(
//                             onPressed: () {
//                               // Remove the product from the cart
//                               cartModel.removeFromCart(index);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red, // Button color
//                               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                             ),
//                             child: Text(
//                               'Delete',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           // Place Order Button
//                           ElevatedButton(
//                             onPressed: () {
//                               // Handle Place Order action for this product
//                               print('Place Order clicked for ${product['name']}');
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue, // Button color
//                               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                             ),
//                             child: Text(
//                               'Place Order',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class ProfileTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Your Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
//   }
// }



// class ProfileTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Your Profile',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20), // Add some spacing
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to the MyOrdersScreen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => MyOrdersScreen(),
//                   ),
//                 );
//               },
//               child: Text('Orders History'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }