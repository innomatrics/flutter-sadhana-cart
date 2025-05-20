import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/constants/constants.dart';
import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';
import 'package:sadhana_cart/Seller/seller_account_page/component/view_account.dart';
import 'package:sadhana_cart/Seller/seller_bottom_nav_layout.dart';

class SellerAccountPage extends StatefulWidget {
  const SellerAccountPage({super.key});

  @override
  State<SellerAccountPage> createState() => _SellerAccountPageState();
}

class _SellerAccountPageState extends State<SellerAccountPage> {
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void pickImage() async {
    final provider =
        Provider.of<GetSoldProductByCustomer>(context, listen: false);
    final pickedFile = await provider.pickerImagesFromGallery(context: context);
    if (pickedFile.path.isNotEmpty && context.mounted) {
      await provider.uploadSellerImages(context: context, image: pickedFile);
    }
    setState(() {
      refreshData();
    });
  }

  void replaceImage() async {
    final provider =
        Provider.of<GetSoldProductByCustomer>(context, listen: false);
    final pickedFile = await provider.pickerImagesFromGallery(context: context);

    if (pickedFile.path.isNotEmpty && context.mounted) {
      await provider.replaceSellerImages(
          context: context, newImage: pickedFile);
    }
    setState(() {
      refreshData();
    });
  }

  void refreshData() {
    final provider =
        Provider.of<GetSoldProductByCustomer>(context, listen: false);
    provider.fetchCurrentUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetSoldProductByCustomer>(context);
    final sellerData = provider.currentUserDetails;
    final sellerImage = sellerData['sellerImages'][0] ??
        'https://media.istockphoto.com/id/1393750072/vector/flat-white-icon-man-for-web-design-silhouette-flat-illustration-vector-illustration-stock.jpg?s=612x612&w=0&k=20&c=s9hO4SpyvrDIfELozPpiB_WtzQV9KhoMUP9R9gVohoU=';
    final sellerName = sellerData['name'];
    final sellerEmail = sellerData['email'];
    final sellerNumber = sellerData['phone'];
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 1,
        width: size.width * 1,
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.30,
              width: size.width * 1,
              decoration: const BoxDecoration(
                color: appBarColor,
              ),
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.06),
                alignment: Alignment.topCenter,
                child: _customTextFields(
                    text: sellerName, fontSize: 24, color: Colors.white),
              ),
            ),
            Positioned(
              top: size.height * 0.26,
              child: Container(
                height: size.height * 1,
                width: size.width * 1,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50))),
                child: Column(
                  spacing: size.height * 0.02,
                  children: [
                    SizedBox(
                      height: size.height * 0.11,
                    ),
                    _customTextFields(
                        text: sellerEmail,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    _customTextFields(
                        text: sellerNumber,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.70,
                      child: _customElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 500),
                                  child: ViewAccount(
                                    name: sellerData['name'],
                                    phone: sellerData['phone'],
                                    email: sellerData['email'],
                                    businessType: sellerData['businessType'],
                                    gstNumber: sellerData['gstNumber'],
                                    shopName: sellerData['shopName'],
                                    bankAccount: sellerData['bankAccount'],
                                    address: sellerData['address'],
                                    panNumber: sellerData['panNumber'],
                                    gstCertificateUrl:
                                        sellerData['gstCertificateUrl'],
                                    bankProofUrl: sellerData['bankProofUrl'],
                                    panProofUrl: sellerData['panCardUrl'],
                                  ))),
                          text: "View Account"),
                    ),
                  ],
                ),
              ),
            ),
            sellerImage == null
                ? Positioned(
                    left: size.width * 0.25,
                    top: size.height * 0.12,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        height: size.height * 0.25,
                        width: size.width * 0.50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(sellerImage))),
                      ),
                    ))
                : Positioned(
                    left: size.width * 0.25,
                    top: size.height * 0.12,
                    child: GestureDetector(
                      onTap: replaceImage,
                      child: Container(
                        height: size.height * 0.25,
                        width: size.width * 0.50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(sellerImage),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle),
                      ),
                    ))
          ],
        ),
      ),
    );
  }

  Text _customTextFields(
      {required String text,
      double fontSize = 20,
      FontWeight fontWeight = FontWeight.bold,
      Color color = Colors.black}) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }

  Widget _customElevatedButton(
      {required VoidCallback onPressed, required String text}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: const BorderSide(color: appBarColor, width: 1)),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: appBarColor, fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
