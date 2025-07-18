import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF0D47A1), Colors.black], // blue[900] and black
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Footer Headline
            const Text(
              'Empowering Innovation, Shaping Futures.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 30),

            // Footer Content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Quick Links
                _footerSection(
                  title: 'Quick Links',
                  items: ['Home', 'Courses', 'About Us', 'Contact'],
                ),

                // Social Media
                _footerSectionWithIcons(
                  title: 'Follow Us',
                  icons: [
                    FontAwesomeIcons.facebookF,
                    FontAwesomeIcons.twitter,
                    FontAwesomeIcons.instagram,
                    FontAwesomeIcons.linkedinIn,
                  ],
                ),

                // Contact Info
                _footerSection(
                  title: 'Contact',
                  items: [
                    'Neutill Services Private Limited',
                    '+91 91132 92575',
                    '34/49, 3rd cross, MuthurayaswamiLayout, Sunkadakatte, Banglore-560091',
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Copyright
            const Text(
              '© 2025 EduVision Academy. All rights reserved.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Basic footer section builder
  Widget _footerSection({required String title, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              item,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
      ],
    );
  }

  // Social icons section
  Widget _footerSectionWithIcons({
    required String title,
    required List<IconData> icons,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: icons
              .map(
                (icon) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 16),
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}

// Custom wave clipper for footer
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start at the top-left corner
    path.moveTo(0, 40);

    // First curve
    var firstControlPoint = Offset(size.width / 4, 0);
    var firstEndPoint = Offset(size.width / 2, 40);

    // Second curve
    var secondControlPoint = Offset(size.width * 3 / 4, 80);
    var secondEndPoint = Offset(size.width, 40);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // Finish drawing the bottom and sides of the footer
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

