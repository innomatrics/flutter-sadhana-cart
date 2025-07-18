// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sadhana_cart/Seller/contants/constants.dart';
// import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';
//
// class AccountScreen extends StatefulWidget {
//   const AccountScreen({super.key});
//
//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }
//
// class _AccountScreenState extends State<AccountScreen> {
//   @override
//   void initState() {
//     super.initState();
//     refreshData();
//   }
//
//   void pickImage() async {
//     final provider =
//     Provider.of<GetSoldProductByCustomer>(context, listen: false);
//     final pickedFile = await provider.pickerImagesFromGallery(context: context);
//     if (pickedFile.path.isNotEmpty && mounted) {
//       await provider.uploadSellerImages(context: context, image: pickedFile);
//     }
//     setState(() {
//       refreshData();
//     });
//   }
//
//   void replaceImage() async {
//     final provider =
//     Provider.of<GetSoldProductByCustomer>(context, listen: false);
//     final pickedFile = await provider.pickerImagesFromGallery(context: context);
//
//     if (pickedFile.path.isNotEmpty && mounted) {
//       await provider.replaceSellerImages(
//           context: context, newImage: pickedFile);
//     }
//     setState(() {
//       refreshData();
//     });
//   }
//
//   void refreshData() {
//     final provider =
//     Provider.of<GetSoldProductByCustomer>(context, listen: false);
//     provider.fetchCurrentUserData(context: context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<GetSoldProductByCustomer>(context);
//     final sellerData = provider.currentUserDetails;
//     final sellerImage = sellerData['sellerImages'][0] ??
//         'https://media.istockphoto.com/id/1393750072/vector/flat-white-icon-man-for-web-design-silhouette-flat-illustration-vector-illustration-stock.jpg?s=612x612&w=0&k=20&c=s9hO4SpyvrDIfELozPpiB_WtzQV9KhoMUP9R9gVohoU=';
//     final sellerName = sellerData['name'];
//     final sellerEmail = sellerData['email'];
//     final List<String> allImages = [
//       sellerData['gstCertificateUrl'],
//       sellerData['bankProofUrl'],
//       sellerData['panCardUrl'],
//     ];
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         height: size.height * 1,
//         width: size.width * 1,
//         decoration: const BoxDecoration(),
//         child: Stack(
//           children: [
//             Container(
//               height: size.height * 0.32,
//               width: size.width * 1,
//               decoration: const BoxDecoration(
//                 color: appBarColor,
//               ),
//               child: Container(
//                 margin: EdgeInsets.only(top: size.height * 0.06),
//                 alignment: Alignment.topCenter,
//                 child: _customTextFields(
//                     text: sellerName, fontSize: 24, color: Colors.white),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.22,
//               child: Container(
//                 height: size.height * 0.78,
//                 width: size.width * 1,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                     BorderRadius.vertical(top: Radius.circular(50))),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: EdgeInsets.symmetric(
//                     vertical: size.height * 0.02,
//                     horizontal: size.width * 0.03,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: size.height * 0.11),
//                       Container(
//                         color: Colors.pink,
//                         padding: EdgeInsets.only(left: size.height * 0.01),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: _customTextFields(
//                                 text: sellerEmail,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 _images(size: size, url: allImages[0]),
//                                 _images(size: size, url: allImages[1]),
//                                 _images(size: size, url: allImages[2]),
//                               ],
//                             ),
//                             const Text(
//                               "Personal Details",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Center(
//                               child: _customTextFormFieldDesign(
//                                 size: size,
//                                 icon: Icons.person,
//                                 text: sellerName,
//                               ),
//                             ),
//                             Center(
//                               child: _customTextFormFieldDesign(
//                                 size: size,
//                                 icon: Icons.shopping_bag,
//                                 text: sellerData['shopName'],
//                               ),
//                             ),
//                             Center(
//                               child: _customTextFormFieldDesign(
//                                 size: size,
//                                 icon: Icons.person,
//                                 text: sellerName,
//                               ),
//                             ),
//                             const Text(
//                               "Address Details",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Center(
//                               child: _customTextFormFieldDesign(
//                                 size: size,
//                                 icon: Icons.person,
//                                 text: sellerName,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             sellerImage == null
//                 ? Positioned(
//                 left: size.width * 0.25,
//                 top: size.height * 0.12,
//                 child: GestureDetector(
//                   onTap: pickImage,
//                   child: Container(
//                     height: size.height * 0.20,
//                     width: size.width * 0.50,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                             image:
//                             CachedNetworkImageProvider(sellerImage))),
//                   ),
//                 ))
//                 : Positioned(
//                 left: size.width * 0.25,
//                 top: size.height * 0.12,
//                 child: GestureDetector(
//                   onTap: replaceImage,
//                   child: Container(
//                     height: size.height * 0.20,
//                     width: size.width * 0.50,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: CachedNetworkImageProvider(sellerImage),
//                             fit: BoxFit.cover),
//                         shape: BoxShape.circle),
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
//
//   Text _customTextFields(
//       {required String text,
//         double fontSize = 20,
//         FontWeight fontWeight = FontWeight.bold,
//         Color color = Colors.black}) {
//     return Text(
//       text,
//       style:
//       TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
//     );
//   }
//
//   Widget _customTextFormFieldDesign(
//       {required Size size, required IconData icon, required String text}) {
//     return Container(
//       padding: EdgeInsets.only(left: size.width * 0.02),
//       height: size.height * 0.06,
//       width: size.width * 0.80,
//       decoration: BoxDecoration(
//         color: textFieldColor,
//         shape: BoxShape.rectangle,
//         borderRadius: const BorderRadius.horizontal(
//           left: Radius.circular(12),
//           right: Radius.circular(12),
//         ),
//       ),
//       child: Center(
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: Colors.black,
//               size: 28,
//             ),
//             SizedBox(
//               width: size.width * 0.02,
//             ),
//             Text(
//               text,
//               style: const TextStyle(fontSize: 18),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _images({required Size size, required String url}) {
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog.adaptive(
//             content: Container(
//               height: size.height * 0.5,
//               width: size.width * 0.5,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: CachedNetworkImageProvider(url), fit: BoxFit.cover),
//               ),
//             ),
//           ),
//         );
//       },
//       child: Container(
//         height: size.height * 0.1,
//         width: size.width * 0.20,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: CachedNetworkImageProvider(url), fit: BoxFit.cover)),
//       ),
//     );
//   }
// }



// Android

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/Seller/contants/constants.dart';
import 'package:sadhana_cart/Seller/provider/get_sold_product_by_customer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void pickImage() async {
    final provider = Provider.of<GetSoldProductByCustomer>(context, listen: false);
    final pickedFile = await provider.pickerImagesFromGallery(context: context);
    if (pickedFile.path.isNotEmpty && mounted) {
      await provider.uploadSellerImages(context: context, image: pickedFile,);
      refreshData();
    }
  }

  void replaceImage() async {
    final provider = Provider.of<GetSoldProductByCustomer>(context, listen: false);
    final pickedFile = await provider.pickerImagesFromGallery(context: context);

    if (pickedFile.path.isNotEmpty && mounted) {
      await provider.replaceSellerImages(context: context, newImage: pickedFile);
      refreshData();
    }
  }

  void refreshData() {
    final provider = Provider.of<GetSoldProductByCustomer>(context, listen: false);
    provider.fetchCurrentUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetSoldProductByCustomer>(context);
    final sellerData = provider.currentUserDetails;
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    // Safe handling of seller images
    final sellerImages = sellerData['sellerImages'] as List? ?? [];
    final sellerImage = sellerImages.isNotEmpty
        ? sellerImages[0]
        : 'https://media.istockphoto.com/id/1393750072/vector/flat-white-icon-man-for-web-design-silhouette-flat-illustration-vector-illustration-stock.jpg?s=612x612&w=0&k=20&c=s9hO4SpyvrDIfELozPpiB_WtzQV9KhoMUP9R9gVohoU=';

    // Safe handling of document URLs
    final List<String> allImages = [
      sellerData['gstCertificateUrl'] ?? '',
      sellerData['bankProofUrl'] ?? '',
      sellerData['panCardUrl'] ?? '',
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.10, // Reduced app bar height
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [appBarColor, appBarColor.withOpacity(0.8)],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Profile image in blue container
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue, // Blue container
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: sellerImages.isEmpty ? pickImage : replaceImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(sellerImage),
                      child: sellerImages.isEmpty
                          ? Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 30,
                      )
                          : null,
                    ),
                  ),
                ),

                // Name and status
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Text(
                        sellerData['name'] ?? 'No Name',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sellerData['email'] ?? 'No Email',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _StatusIndicator(status: sellerData['status'] ?? 'Pending'),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                // Documents Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Documents",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _DocumentImage(size: size, url: allImages[0], label: 'GST'),
                            _DocumentImage(size: size, url: allImages[1], label: 'Bank'),
                            _DocumentImage(size: size, url: allImages[2], label: 'PAN'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Personal Details Section
                _buildSection(
                  context,
                  title: "Personal Details",
                  children: [
                    _DetailField(
                      icon: Icons.phone,
                      text: sellerData['phone'] ?? 'Not provided',
                    ),
                    _DetailField(
                      icon: Icons.person,
                      text: sellerData['name'] ?? 'Not provided',
                    ),
                    _DetailField(
                      icon: Icons.shopping_bag,
                      text: sellerData['shopName'] ?? 'Not provided',
                    ),
                    _DetailField(
                      icon: Icons.business,
                      text: sellerData['businessType'] ?? 'Not provided',
                    ),
                  ],
                ),

                // Financial Details Section
                _buildSection(
                  context,
                  title: "Financial Details",
                  children: [
                    _DetailField(
                      icon: Icons.credit_card,
                      text: sellerData['panNumber'] ?? 'Not provided',
                    ),
                    _DetailField(
                      icon: Icons.receipt,
                      text: sellerData['gstNumber'] ?? 'Not provided',
                    ),
                    _DetailField(
                      icon: Icons.account_balance,
                      text: sellerData['bankAccount'] ?? 'Not provided',
                    ),
                  ],
                ),

                // Address Details Section
                // _buildSection(
                //   context,
                //   title: "Address Details",
                //   children: [
                //     _DetailField(
                //       icon: Icons.location_on,
                //       text: sellerData['address'] ?? 'Not provided',
                //     ),
                //   ],
                // ),
                _buildSection(
                  context,
                  title: "Address Details",
                  children: [
                    _DetailField(
                      icon: Icons.location_on,
                      text: sellerData['address'] ?? 'Not provided',
                      isMultiline: true, // Set this to true for address
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> children}) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ],
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
    IconData statusIcon;

    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 18),
          const SizedBox(width: 8),
          Text(
            'Status: ${status.toUpperCase()}',
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// class _DetailField extends StatelessWidget {
//   final IconData icon;
//   final String text;
//
//   const _DetailField({
//     required this.icon,
//     required this.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: theme.primaryColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: theme.primaryColor, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               text,
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 color: Colors.grey[800],
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _DetailField extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isMultiline; // Add this parameter

  const _DetailField({
    required this.icon,
    required this.text,
    this.isMultiline = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: theme.primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: isMultiline
                ? Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[800],
              ),
            )
                : Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[800],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentImage extends StatelessWidget {
  final Size size;
  final String url;
  final String label;

  const _DocumentImage({
    required this.size,
    required this.url,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (url.isEmpty) {
      return Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Icon(Icons.image, size: 30, color: Colors.grey[400]),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(url),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(url),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: url.isEmpty
                ? Center(
              child: Icon(
                Icons.image,
                color: Colors.grey[400],
                size: 30,
              ),
            )
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ],
    );
  }
}





