import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/admin/provider/get_seller_application_provider.dart';
import 'package:sadhana_cart/admin/seller_applications/components/view_application.dart';

class AllSellerRequest extends StatefulWidget {
  const AllSellerRequest({super.key});

  @override
  State<AllSellerRequest> createState() => _AllSellerRequestState();
}

class _AllSellerRequestState extends State<AllSellerRequest> {
  @override
  void initState() {
    super.initState();
    Provider.of<GetSellerApplicationProvider>(context, listen: false)
        .fetchAllRequests(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetSellerApplicationProvider>(context);
    final int length = provider.listofApplications.length;
    return Scaffold(
      body: Consumer<GetSellerApplicationProvider>(
        builder: (context, value, child) {
          return ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                final application = value.listofApplications[index];
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 600),
                          child: ViewApplication(sellerData: application))),
                  title: Text(application['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(application['email']),
                      Text(application['phone']),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
