import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/admin/provider/get_seller_application_provider.dart';
import 'package:sadhana_cart/admin/seller_applications/components/view_application.dart';

class PendingSellerRequest extends StatefulWidget {
  const PendingSellerRequest({super.key});

  @override
  State<PendingSellerRequest> createState() => _PendingSellerRequestState();
}

class _PendingSellerRequestState extends State<PendingSellerRequest> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetSellerApplicationProvider>(context);
    final length = provider.filterPending.length;
    return Scaffold(
      body: Consumer<GetSellerApplicationProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final application = value.filterPending[index];
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
            },
          );
        },
      ),
    );
  }
}
