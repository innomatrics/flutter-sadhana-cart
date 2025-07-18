// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';
//
// class SellerOrdersScreen extends StatefulWidget {
//   const SellerOrdersScreen({super.key});
//
//   @override
//   State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
// }
//
// class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<GetSoldProductByCustomer>(context, listen: false)
//         .fetchSoldProductsByCustomer(context: context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<GetSoldProductByCustomer>(context);
//     final orders = provider.allSoldProductByCustomer;
//     return Scaffold(
//         appBar: AppBar(title: const Text("My Orders")),
//         body: orders.isEmpty
//             ? const Center(child: Text("No Products Ordered"))
//             : Consumer<GetSoldProductByCustomer>(
//                 builder: (context, value, child) {
//                   final orders = value.allSoldProductByCustomer;
//                   return ListView.builder(
//                     itemCount: orders.length,
//                     itemBuilder: (context, index) {
//                       final order = orders[index];
//                       return Card(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         elevation: 3,
//                         child: ListTile(
//                           leading: order['images'] != null &&
//                                   order['images'] is List &&
//                                   order['images'].isNotEmpty
//                               ? Image.network(
//                                   order['images'][0],
//                                   width: 80,
//                                   height: 80,
//                                   fit: BoxFit.cover,
//                                 )
//                               : const Icon(Icons.image,
//                                   size: 50, color: Colors.grey),
//                           title: Text(order['name'] ?? 'No Name',
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.bold)),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Brand: ${order['brandName'] ?? 'Unknown'}"),
//                               Text("Category: ${order['category'] ?? 'N/A'}"),
//                               Text("Price: ₹${order['Offer Price'] ?? 'N/A'}"),
//                               Text("Size: ${order['Size'] ?? 'N/A'}"),
//                               Text(
//                                 "Ordered on: ${_formatTimestamp(order['timestamp'])}",
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ));
//   }
// }
//
// String _formatTimestamp(Timestamp? timestamp) {
//   if (timestamp == null) return 'Unknown';
//   final date = timestamp.toDate();
//   return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
// }


// android



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sadhana_cart/Seller/provider/seller_product_provider.dart';
// import 'package:sadhana_cart/Seller/seller_orders/componenets/seller_own_order.dart';
//
// class ListOfSellerOrdersDetailPage extends StatefulWidget {
//   const ListOfSellerOrdersDetailPage({super.key});
//
//   @override
//   State<ListOfSellerOrdersDetailPage> createState() =>
//       _ListOfSellerOrdersDetailPageState();
// }
//
// class _ListOfSellerOrdersDetailPageState
//     extends State<ListOfSellerOrdersDetailPage> {
//   int currentIndex = 0;
//
//   final List<String> statusList = [
//     'All',
//     'Pending',
//     'Recieved',
//     'Shipped',
//     'Canceled',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<SellerProductProvider>(context, listen: false);
//     provider.fetchSellerOrders(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       // appBar: AppBar(
//       //   iconTheme: const IconThemeData(color: Colors.white),
//       //   backgroundColor: Colors.purple,
//       //   title: const Text(
//       //     'My Orders',
//       //     style: TextStyle(color: Colors.white),
//       //   ),
//       // ),
//       body: Container(
//         padding: EdgeInsets.all(size.width * 0.01),
//         child: Column(
//           children: [
//             SizedBox(
//               height: size.height * 0.15,
//               width: size.width,
//               child: _listofOrders(size: size),
//             ),
//             SizedBox(
//               height: size.height * 0.08,
//               width: size.width,
//               child: _dateAndTime(size: size),
//             ),
//             Expanded(
//               child: SellerOwnOrder(
//                 currentIndex: currentIndex,
//               ), // No need to pass index now
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _listofOrders({required Size size}) {
//     return Consumer<SellerProductProvider>(
//       builder: (context, value, child) {
//         List<int> orderLengthByStatus = [
//           value.allOrders.length,
//           value.pendingCount,
//           value.receivedCount,
//           value.shippedCount,
//           value.canceledCount,
//         ];
//
//         return ListView.builder(
//           itemCount: statusList.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             final isSelected = currentIndex == index;
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   currentIndex = index;
//                 });
//                 Provider.of<SellerProductProvider>(context, listen: false)
//                     .filterOrdersByStatus(statusList[index]);
//               },
//               child: Container(
//                 margin: EdgeInsets.all(size.width * 0.02),
//                 height: size.height * 0.15,
//                 width: size.width * 0.30,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   gradient: isSelected
//                       ? const LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color.fromARGB(255, 244, 54, 225),
//                       Color.fromARGB(255, 211, 13, 246),
//                     ],
//                   )
//                       : const LinearGradient(
//                       colors: [Colors.white, Colors.white]),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       statusList[index],
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "${orderLengthByStatus[index]}",
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _dateAndTime({required Size size}) {
//     final provider = Provider.of<SellerProductProvider>(context, listen: false);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Expanded(
//           child: _dateTimeContainer(
//             text: "Start Date",
//             onTap: () {
//               provider.pickStartDate(context);
//             },
//           ),
//         ),
//         Expanded(
//           child: _dateTimeContainer(
//             text: "End Date",
//             onTap: () {
//               provider.pickEndDate(context);
//             },
//           ),
//         ),
//         IconButton(
//           tooltip: "Clear Filter",
//           style: IconButton.styleFrom(
//             backgroundColor: Colors.purple,
//             shape: const CircleBorder(),
//           ),
//           onPressed: () {
//             provider.resetFilters();
//           },
//           icon: const Icon(
//             Icons.close,
//             color: Colors.white,
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget _dateTimeContainer(
//       {required String text, required VoidCallback onTap}) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.purple,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }




// web


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/provider/seller_product_provider.dart';
import 'package:sadhana_cart/Seller/seller_orders/componenets/seller_own_order.dart';

class WebListOfSellerOrdersDetailPage extends StatefulWidget {
  const WebListOfSellerOrdersDetailPage({super.key});

  @override
  State<WebListOfSellerOrdersDetailPage> createState() =>
      _WebListOfSellerOrdersDetailPageState();
}

class _WebListOfSellerOrdersDetailPageState extends State<WebListOfSellerOrdersDetailPage> {
  int currentIndex = 0;

  final List<String> statusList = [
    'All',
    'Pending',
    'Recieved',
    'Shipped',
    'Canceled',
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SellerProductProvider>(context, listen: false);
    provider.fetchSellerOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Column(
          children: [
            _orderStatusGrid(size),
            const SizedBox(height: 20),
            _dateFilterRow(),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: SellerOwnOrder(
                  key: ValueKey(currentIndex),
                  currentIndex: currentIndex,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderStatusGrid(Size size) {
    return Consumer<SellerProductProvider>(
      builder: (context, value, _) {
        List<int> orderCountList = [
          value.allOrders.length,
          value.pendingCount,
          value.receivedCount,
          value.shippedCount,
          value.canceledCount,
        ];

        return LayoutBuilder(builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;

          return GridView.builder(
            shrinkWrap: true,
            itemCount: statusList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWide ? 5 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final isSelected = currentIndex == index;
              return InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                  Provider.of<SellerProductProvider>(context, listen: false)
                      .filterOrdersByStatus(statusList[index]);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.deepOrange : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.deepOrange.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        color: isSelected ? Colors.white : Colors.deepOrange,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        statusList[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${orderCountList[index]} Orders',
                        style: TextStyle(
                          color: isSelected ? Colors.white70 : Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }

  Widget _dateFilterRow() {
    final provider = Provider.of<SellerProductProvider>(context, listen: false);
    return Row(
      children: [
        _filterButton("Start Date", () => provider.pickStartDate(context)),
        const SizedBox(width: 16),
        _filterButton("End Date", () => provider.pickEndDate(context)),
        const SizedBox(width: 16),
        IconButton(
          tooltip: "Clear Filters",
          onPressed: () => provider.resetFilters(),
          style: IconButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            shape: const CircleBorder(),
          ),
          icon: const Icon(Icons.close, color: Colors.white),
        )
      ],
    );
  }

  Widget _filterButton(String text, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.date_range, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}







// updating ui




