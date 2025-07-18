



// Android

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Map<String, dynamic>? sellerData;
  bool isLoading = true;
  bool uploading = false;

  late AnimationController _controller;


  @override
  void initState() {
    super.initState();
    refreshData();
    _loadSellerData();
  }

  Future<void> _loadSellerData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No logged-in user.');

      final doc = await FirebaseFirestore.instance
          .collection('seller')
          .doc(user.uid)
          .get();

      if (!doc.exists) throw Exception('Seller not found.');

      setState(() {
        sellerData = doc.data()!;
        isLoading = false;
      });

      _controller.forward();
    } catch (e) {
      debugPrint('Error loading seller data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // void pickImage() async {
  //   final provider = Provider.of<GetSoldProductByCustomer>(context, listen: false);
  //   final pickedFile = await provider.pickerImagesFromGallery(context: context);
  //   if (pickedFile.path.isNotEmpty && mounted) {
  //     await provider.uploadSellerImages(context: context, image: pickedFile,);
  //     refreshData();
  //   }
  // }

  // void replaceImage() async {
  //   final provider = Provider.of<GetSoldProductByCustomer>(context, listen: false);
  //   final pickedFile = await provider.pickerImagesFromGallery(context: context);
  //
  //   if (pickedFile.path.isNotEmpty && mounted) {
  //     await provider.replaceSellerImages(context: context, newImage: pickedFile);
  //     refreshData();
  //   }
  // }

  void refreshData() {
    final provider = Provider.of<GetSoldProductByCustomer>(context, listen: false);
    provider.fetchCurrentUserData(context: context);
  }

  Future<void> _uploadNewProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        setState(() {
          uploading = true;
        });

        final fileBytes = result.files.single.bytes!;
        final fileName = "profile_${user.uid}.jpg";

        final storageRef =
        FirebaseStorage.instance.ref().child("seller_profile/$fileName");
        await storageRef.putData(fileBytes);

        final downloadUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('seller')
            .doc(user.uid)
            .update({'profileImage': downloadUrl});

        await _loadSellerData();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile image updated successfully")),
        );
      }
    } catch (e) {
      debugPrint('Image upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    } finally {
      setState(() {
        uploading = false;
      });
    }
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
                    onTap: _uploadNewProfileImage,
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
  Widget _buildProfileCard() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange[100],
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(2, 4),
              )
            ],
          ),
          child: uploading
              ? const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange))
              : IconButton(
            onPressed: _uploadNewProfileImage,
            iconSize: 80,
            icon: const Icon(Icons.account_circle,
                color: Colors.deepOrange),
            tooltip: 'Click to change profile image',
          ),
        ),
        Positioned(
          bottom: 8,
          right: MediaQuery.of(context).size.width * 0.37,
          child: GestureDetector(
            onTap: _uploadNewProfileImage,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.edit, color: Colors.deepOrange, size: 20),
            ),
          ),
        ),
      ],
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




//web








