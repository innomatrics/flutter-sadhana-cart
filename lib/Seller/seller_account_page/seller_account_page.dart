import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/constants/constants.dart';
import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';

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
    if (pickedFile.path.isNotEmpty && mounted) {
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

    if (pickedFile.path.isNotEmpty && mounted) {
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
    final List<String> allImages = [
      sellerData['gstCertificateUrl'],
      sellerData['bankProofUrl'],
      sellerData['panCardUrl'],
    ];
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height * 1,
        width: size.width * 1,
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.32,
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
              top: size.height * 0.22,
              child: Container(
                height: size.height * 0.78,
                width: size.width * 1,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50))),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.11),
                      Container(
                        color: Colors.pink,
                        padding: EdgeInsets.only(left: size.height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: _customTextFields(
                                text: sellerEmail,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _images(size: size, url: allImages[0]),
                                _images(size: size, url: allImages[1]),
                                _images(size: size, url: allImages[2]),
                              ],
                            ),
                            const Text(
                              "Personal Details",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Center(
                              child: _customTextFormFieldDesign(
                                size: size,
                                icon: Icons.person,
                                text: sellerName,
                              ),
                            ),
                            Center(
                              child: _customTextFormFieldDesign(
                                size: size,
                                icon: Icons.shopping_bag,
                                text: sellerData['shopName'],
                              ),
                            ),
                            Center(
                              child: _customTextFormFieldDesign(
                                size: size,
                                icon: Icons.person,
                                text: sellerName,
                              ),
                            ),
                            const Text(
                              "Address Details",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Center(
                              child: _customTextFormFieldDesign(
                                size: size,
                                icon: Icons.person,
                                text: sellerName,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                        height: size.height * 0.20,
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
                        height: size.height * 0.20,
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

  Widget _customTextFormFieldDesign(
      {required Size size, required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.only(left: size.width * 0.02),
      height: size.height * 0.06,
      width: size.width * 0.80,
      decoration: BoxDecoration(
        color: textFieldColor,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(12),
          right: Radius.circular(12),
        ),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 28,
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget _images({required Size size, required String url}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            content: Container(
              height: size.height * 0.5,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(url), fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.20,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(url), fit: BoxFit.cover)),
      ),
    );
  }
}
