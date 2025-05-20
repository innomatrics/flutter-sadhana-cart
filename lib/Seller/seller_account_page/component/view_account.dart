import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Seller/constants/constants.dart';

class ViewAccount extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String businessType;
  final String address;
  final String shopName;
  final String gstNumber;
  final String bankAccount;
  final String panNumber;
  final String gstCertificateUrl;
  final String bankProofUrl;
  final String panProofUrl;
  const ViewAccount(
      {super.key,
      required this.name,
      required this.phone,
      required this.email,
      required this.businessType,
      required this.shopName,
      required this.address,
      required this.gstNumber,
      required this.bankAccount,
      required this.panNumber,
      required this.gstCertificateUrl,
      required this.bankProofUrl,
      required this.panProofUrl});

  @override
  Widget build(BuildContext context) {
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
              _customNetWorkImages(size: size, imageUrl: panProofUrl),
            ],
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
