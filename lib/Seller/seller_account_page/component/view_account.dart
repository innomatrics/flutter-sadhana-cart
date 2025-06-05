import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Seller/constants/constants.dart';

class ViewAccount extends StatelessWidget {
  final Map<String, dynamic> sellerData;
  const ViewAccount({super.key, required this.sellerData});

  @override
  Widget build(BuildContext context) {
    final name = sellerData['name'];
    final phone = sellerData['phone'];
    final email = sellerData['email'];
    final businessType = sellerData['businessType'];
    final shopName = sellerData['shopName'];
    final bankAccount = sellerData['bankAccount'];
    final address = sellerData['address'];
    final panNumber = sellerData['panNumber'];
    final gstNumber = sellerData['gstNumber'];
    final gstCertificateUrl = sellerData['gstCertificateUrl'];
    final panCardUrl = sellerData['panCardUrl'];
    final bankProofUrl = sellerData['bankProofUrl'];

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: appBarColor,
        centerTitle: true,
        title: const Text(
          "View Account",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: size.width * 1,
          padding: EdgeInsets.all(size.width * 0.04),
          child: Hero(
            tag: 'profile',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: size.height * 0.03,
              children: [
                _richText(heading: "Name: ", content: name),
                _richText(heading: "Phone: ", content: phone),
                _richText(heading: "Email: ", content: email),
                _richText(heading: "Business Type: ", content: businessType),
                _richText(heading: "Shop Name: ", content: shopName),
                _richText(heading: "Bank Account: ", content: bankAccount),
                _richText(heading: "Address: ", content: address),
                _richText(heading: "Pan Number: ", content: panNumber),
                _richText(heading: "GST Number: ", content: gstNumber),
                const Text(
                  'GST Certificate:',
                  style: TextStyle(fontSize: 20),
                ),
                _customNetWorkImages(size: size, imageUrl: gstCertificateUrl),
                const Text(
                  'Bank Proof:',
                  style: TextStyle(fontSize: 20),
                ),
                _customNetWorkImages(size: size, imageUrl: bankProofUrl),
                const Text(
                  'Pan Proof:',
                  style: TextStyle(fontSize: 20),
                ),
                _customNetWorkImages(size: size, imageUrl: panCardUrl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _richText({required String heading, required String content}) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: heading,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)),
      TextSpan(
          text: content,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
    ]));
  }

  Widget _customNetWorkImages({required Size size, required String imageUrl}) {
    return Container(
      height: size.height * 0.30,
      width: size.width * 1,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover)),
    );
  }
}
