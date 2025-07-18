import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/admin/constants/constants.dart';
import 'package:sadhana_cart/admin/dash_board/components/order_list_view.dart';
import 'package:sadhana_cart/admin/provider/product_provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  DateTime start = DateTime(2025);
  DateTime end = DateTime.now();
  int currentIndex = 0;
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getOrders(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.01),
        child: Column(
          spacing: size.height * 0.02,
          children: [
            SizedBox(
              height: size.height * 0.15,
              width: size.width * 1,
              child: _listofOrders(
                size: size,
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
              width: size.width * 1,
              child: _dateAndTime(size: size),
            ),
            SizedBox(
              height: size.height * 0.60,
              width: size.width * 1,
              child: OrderListView(
                currentIndex: currentIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listofOrders({
    required Size size,
  }) {
    return Consumer<ProductProvider>(builder: (context, value, child) {
      List<int> orderLengthByStatus = [
        value.allOrder.length,
        value.recievedOrder,
        value.pendingOrder,
        value.shippedOrder,
        value.canceledOrder,
      ];
      return ListView.builder(
          itemCount: ordertypes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.all(size.width * 0.02),
                height: size.height * 0.15,
                width: size.width * 0.30,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
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
                              Color.fromARGB(255, 67, 190, 247),
                              Color.fromARGB(255, 13, 141, 246),
                            ])
                      : const LinearGradient(
                          colors: [Colors.white, Colors.white]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ordertypes[index],
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${orderLengthByStatus[index]}",
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  Widget _dateAndTime({required Size size}) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: _dateTimeContainer(
                text: "Start Date",
                onTap: () {
                  provider.pickStartDate(context);
                })),
        Expanded(
            child: _dateTimeContainer(
                text: "End Date",
                onTap: () {
                  provider.pickEndDate(context);
                })),
        IconButton(
            tooltip: "Clear Filter",
            style: IconButton.styleFrom(
                backgroundColor: Colors.blue, shape: const CircleBorder()),
            onPressed: () {
              provider.resetFilter();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ))
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
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
