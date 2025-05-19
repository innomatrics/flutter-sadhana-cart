import 'package:flutter/material.dart';
import 'package:sadhana_cart/admin/seller_applications/components/acctepted_seller_requests.dart';
import 'package:sadhana_cart/admin/seller_applications/components/all_seller_request.dart';
import 'package:sadhana_cart/admin/seller_applications/components/pending_seller_request.dart';
import 'package:sadhana_cart/admin/seller_applications/components/rejected_seller_requests.dart';

class ListOfSellerApplication extends StatefulWidget {
  const ListOfSellerApplication({super.key});

  @override
  State<ListOfSellerApplication> createState() =>
      _ListOfSellerApplicationState();
}

class _ListOfSellerApplicationState extends State<ListOfSellerApplication>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Widget> tabs = const [
    Tab(
      child: Text(
        "All",
        style: TextStyle(color: Colors.white),
      ),
    ),
    Tab(
      child: Text(
        "Pending",
        style: TextStyle(color: Colors.white),
      ),
    ),
    Tab(
      child: Text(
        "Accepted",
        style: TextStyle(color: Colors.white),
      ),
    ),
    Tab(
      child: Text(
        "Rejected",
        style: TextStyle(color: Colors.white),
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Seller Applications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          tabs: tabs,
          controller: controller,
          dividerColor: Colors.white,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(controller: controller, children: const [
        AllSellerRequest(),
        PendingSellerRequest(),
        AccteptedSellerRequests(),
        RejectedSellerRequests()
      ]),
    );
  }
}
