import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/webapp_screen_footer.dart';

class StudyWebappHome extends StatefulWidget {
  const StudyWebappHome({super.key});

  @override
  State<StudyWebappHome> createState() => _StudyWebappHomeState();
}

class _StudyWebappHomeState extends State<StudyWebappHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Vision Section
            Container(
              width: double.infinity,
              color: Colors.blue[50],
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Section Title with Divider
                  Column(
                    children: [
                      Text(
                        'Our Vision',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue[800],
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 170,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Responsive Text Area
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: const Text(
                        'We envision a future shaped by a thriving culture of research and development—where the next generation of the workforce is empowered through cutting-edge technologies. '
                            'By fostering partnerships across colleges, universities, MNCs, and startups, we are committed to upskilling human capital through guided learning paths and immersive, hands-on training. '
                            'Our mission is to cultivate a workforce proficient in Artificial Intelligence, Machine Learning, Generative AI, Augmented Reality, Virtual Reality, IoT, and beyond. '
                            'We aim to transform individuals into innovation architects, equipped with the experience and expertise to build applications that power industries into the AI era.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.8,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Mission Section
            // Mission Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue[800],
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 170,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Fetch and display the latest mission image
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('adm')
                        .doc('main')
                        .collection('missions')
                        .orderBy('timestamp', descending: true)
                        .limit(1)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('No mission image available');
                      }

                      final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                      final missionImageUrl = data['imageUrl'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            missionImageUrl,
                            width: double.infinity,
                            height: 400,
                            fit: BoxFit.contain,
                            // fit: BoxFit.fitWidth,
                            // alignment: Alignment.topCenter,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 400,
                              color: Colors.grey[300],
                              child: const Center(child: Text('Image failed to load')),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Banners from Firestore
            const SizedBox(height: 30),
            Text(
              'Explore Our Courses',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.blue[800],
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 320,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildBannerGrid(),
            ),
          ],
        ),
      ),
    );
  }

  /// Firestore Banner Grid
  // Widget _buildBannerGrid() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance
  //         .collection('adm')
  //         .doc('main')
  //         .collection('banners')
  //         .orderBy('timestamp', descending: true)
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Padding(
  //           padding: EdgeInsets.all(40),
  //           child: Center(child: CircularProgressIndicator()),
  //         );
  //       }
  //
  //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //         return const Padding(
  //           padding: EdgeInsets.all(40),
  //           child: Center(child: Text('No banners uploaded yet.')),
  //         );
  //       }
  //
  //       final banners = snapshot.data!.docs;
  //
  //       return GridView.builder(
  //         padding: const EdgeInsets.only(top: 10),
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: banners.length,
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2,
  //           mainAxisSpacing: 20,
  //           crossAxisSpacing: 20,
  //           childAspectRatio: 1.8,
  //         ),
  //         itemBuilder: (context, index) {
  //           final data = banners[index].data() as Map<String, dynamic>;
  //           final imageUrl = data['imageUrl'];
  //           final title = data['title'];
  //
  //           return _buildBannerCardFromUrl(imageUrl, title);
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _buildBannerGrid() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('adm')
          .doc('main')
          .collection('banners')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: Text('No banners uploaded yet.')),
          );
        }

        final allBanners = snapshot.data!.docs;

        // Desired order
        final desiredOrder = [
          'Tech Manthana',
          'Upscaling',
          'Resourcing Counseltancy',
          'ALFA',
        ];

        // Filter and sort based on title match
        final sortedBanners = <QueryDocumentSnapshot>[];

        for (final title in desiredOrder) {
          final match = allBanners.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['title'] == title;
          }).toList();

          if (match.isNotEmpty) {
            sortedBanners.add(match.first);
          }
        }


        return GridView.builder(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedBanners.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.8,
          ),
          itemBuilder: (context, index) {
            final data = sortedBanners[index].data() as Map<String, dynamic>;
            final imageUrl = data['imageUrl'];
            final title = data['title'];
            return _buildBannerCardFromUrl(imageUrl, title);
          },
        );
      },
    );
  }


  Widget _buildBannerCardFromUrl(String imageUrl, String title) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover, // Use BoxFit.fill or BoxFit.cover as needed
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image, size: 50)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

}