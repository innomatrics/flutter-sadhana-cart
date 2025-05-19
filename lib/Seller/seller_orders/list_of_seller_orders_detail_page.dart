import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/provider/seller_product_provider.dart';
import 'package:sadhana_cart/Seller/seller_orders/componenets/seller_own_order.dart';

class ListOfSellerOrdersDetailPage extends StatefulWidget {
  const ListOfSellerOrdersDetailPage({super.key});

  @override
  State<ListOfSellerOrdersDetailPage> createState() =>
      _ListOfSellerOrdersDetailPageState();
}

class _ListOfSellerOrdersDetailPageState
    extends State<ListOfSellerOrdersDetailPage> {
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple,
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.01),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.15,
              width: size.width,
              child: _listofOrders(size: size),
            ),
            SizedBox(
              height: size.height * 0.08,
              width: size.width,
              child: _dateAndTime(size: size),
            ),
            Expanded(
              child: SellerOwnOrder(
                currentIndex: currentIndex,
              ), // No need to pass index now
            ),
          ],
        ),
      ),
    );
  }

  Widget _listofOrders({required Size size}) {
    return Consumer<SellerProductProvider>(
      builder: (context, value, child) {
        List<int> orderLengthByStatus = [
          value.allOrders.length,
          value.pendingCount,
          value.receivedCount,
          value.shippedCount,
          value.canceledCount,
        ];

        return ListView.builder(
          itemCount: statusList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
                Provider.of<SellerProductProvider>(context, listen: false)
                    .filterOrdersByStatus(statusList[index]);
              },
              child: Container(
                margin: EdgeInsets.all(size.width * 0.02),
                height: size.height * 0.15,
                width: size.width * 0.30,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  gradient: isSelected
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 244, 54, 225),
                            Color.fromARGB(255, 211, 13, 246),
                          ],
                        )
                      : const LinearGradient(
                          colors: [Colors.white, Colors.white]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      statusList[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${orderLengthByStatus[index]}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _dateAndTime({required Size size}) {
    final provider = Provider.of<SellerProductProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _dateTimeContainer(
            text: "Start Date",
            onTap: () {
              provider.pickStartDate(context);
            },
          ),
        ),
        Expanded(
          child: _dateTimeContainer(
            text: "End Date",
            onTap: () {
              provider.pickEndDate(context);
            },
          ),
        ),
        IconButton(
          tooltip: "Clear Filter",
          style: IconButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: const CircleBorder(),
          ),
          onPressed: () {
            provider.resetFilters();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _dateTimeContainer(
      {required String text, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
