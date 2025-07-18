// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/Seller/contants/constants.dart';
//
// class ViewAccount extends StatelessWidget {
//   final Map<String, dynamic> sellerData;
//   const ViewAccount({super.key, required this.sellerData});
//
//   @override
//   Widget build(BuildContext context) {
//     final name = sellerData['name'];
//     final phone = sellerData['phone'];
//     final email = sellerData['email'];
//     final businessType = sellerData['businessType'];
//     final shopName = sellerData['shopName'];
//     final bankAccount = sellerData['bankAccount'];
//     final address = sellerData['address'];
//     final panNumber = sellerData['panNumber'];
//     final gstNumber = sellerData['gstNumber'];
//     final gstCertificateUrl = sellerData['gstCertificateUrl'];
//     final panCardUrl = sellerData['panCardUrl'];
//     final bankProofUrl = sellerData['bankProofUrl'];
//
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: appBarColor,
//         centerTitle: true,
//         title: const Text(
//           "View Account",
//           style: TextStyle(
//               color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         child: Container(
//           width: size.width * 1,
//           padding: EdgeInsets.all(size.width * 0.04),
//           child: Hero(
//             tag: 'profile',
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               spacing: size.height * 0.03,
//               children: [
//                 _richText(heading: "Name: ", content: name),
//                 _richText(heading: "Phone: ", content: phone),
//                 _richText(heading: "Email: ", content: email),
//                 _richText(heading: "Business Type: ", content: businessType),
//                 _richText(heading: "Shop Name: ", content: shopName),
//                 _richText(heading: "Bank Account: ", content: bankAccount),
//                 _richText(heading: "Address: ", content: address),
//                 _richText(heading: "Pan Number: ", content: panNumber),
//                 _richText(heading: "GST Number: ", content: gstNumber),
//                 const Text(
//                   'GST Certificate:',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 _customNetWorkImages(size: size, imageUrl: gstCertificateUrl),
//                 const Text(
//                   'Bank Proof:',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 _customNetWorkImages(size: size, imageUrl: bankProofUrl),
//                 const Text(
//                   'Pan Proof:',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 _customNetWorkImages(size: size, imageUrl: panCardUrl),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _richText({required String heading, required String content}) {
//     return RichText(
//         text: TextSpan(children: [
//           TextSpan(
//               text: heading,
//               style: const TextStyle(
//                   color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)),
//           TextSpan(
//               text: content,
//               style: const TextStyle(
//                   color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
//         ]));
//   }
//
//   Widget _customNetWorkImages({required Size size, required String imageUrl}) {
//     return Container(
//       height: size.height * 0.30,
//       width: size.width * 1,
//       decoration: BoxDecoration(
//           image: DecorationImage(
//               image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover)),
//     );
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/Seller/contants/constants.dart';

class ViewAccount extends StatelessWidget {
  final Map<String, dynamic> sellerData;
  const ViewAccount({super.key, required this.sellerData});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: appBarColor,
        centerTitle: true,
        title: const Text(
          "Seller Account Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Indicator
              _StatusIndicator(status: sellerData['status'] ?? 'Pending'),
              SizedBox(height: 20),

              // Personal Details Section
              _SectionHeader(title: 'Personal Details'),
              _DetailItem(label: "Name:", value: sellerData['name'] ?? 'Not provided'),
              _DetailItem(label: "Email:", value: sellerData['email'] ?? 'Not provided'),
              _DetailItem(label: "Phone:", value: sellerData['phone'] ?? 'Not provided'),
              _DetailItem(label: "Shop Name:", value: sellerData['shopName'] ?? 'Not provided'),
              _DetailItem(label: "Business Type:", value: sellerData['businessType'] ?? 'Not provided'),

              // Financial Details Section
              _SectionHeader(title: 'Financial Details'),
              _DetailItem(label: "PAN Number:", value: sellerData['panNumber'] ?? 'Not provided'),
              _DetailItem(label: "GST Number:", value: sellerData['gstNumber'] ?? 'Not provided'),
              _DetailItem(label: "Bank Account:", value: sellerData['bankAccount'] ?? 'Not provided'),

              // Address Section
              _SectionHeader(title: 'Address Details'),
              _DetailItem(label: "Address:", value: sellerData['address'] ?? 'Not provided'),

              // Document Verification Section
              _SectionHeader(title: 'Document Verification'),
              if (sellerData['gstCertificateUrl']?.isNotEmpty ?? false) ...[
                _DocumentViewer(
                  size: size,
                  imageUrl: sellerData['gstCertificateUrl']!,
                  label: 'GST Certificate',
                ),
              ],
              if (sellerData['panCardUrl']?.isNotEmpty ?? false) ...[
                _DocumentViewer(
                  size: size,
                  imageUrl: sellerData['panCardUrl']!,
                  label: 'PAN Card',
                ),
              ],
              if (sellerData['bankProofUrl']?.isNotEmpty ?? false) ...[
                _DocumentViewer(
                  size: size,
                  imageUrl: sellerData['bankProofUrl']!,
                  label: 'Bank Proof',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: appBarColor,
        ),
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final String status;

  const _StatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
    }

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: statusColor, width: 2),
        ),
        child: Text(
          'STATUS: ${status.toUpperCase()}',
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentViewer extends StatelessWidget {
  final Size size;
  final String imageUrl;
  final String label;

  const _DocumentViewer({
    required this.size,
    required this.imageUrl,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Container(
                      height: size.height * 0.7,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(imageUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            height: size.height * 0.25,
            width: size.width,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
