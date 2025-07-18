// import 'package:flutter/material.dart';
//
// class FooterSection extends StatelessWidget {
//   final ScrollController? scrollController;
//   const FooterSection({super.key, this.scrollController});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ClipPath(
//           clipper: FooterClipper(),
//           child: Container(
//             color: const Color(0xFF1E2A38),
//             padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 44),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     bool isWide = constraints.maxWidth > 800;
//                     return isWide
//                         ? Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: _buildFooterColumns(isWide: true),
//                     )
//                         : Wrap(
//                       spacing: 24,
//                       runSpacing: 24,
//                       children: _buildFooterColumns(isWide: false),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // Floating Scroll to Top Button
//         Positioned(
//           bottom: 20,
//           right: 20,
//           child: GestureDetector(
//             onTap: () {
//               scrollController?.animateTo(
//                 0,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.deepOrange, width: 2),
//               ),
//               child: const Icon(Icons.arrow_upward, color: Colors.deepOrange),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<Widget> _buildFooterColumns({required bool isWide}) {
//     return [
//       // Column 1: Logo + Address + Copyright
//       Flexible(
//         flex: isWide ? 2 : 1,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               children: const [
//                 Image(
//                   image: AssetImage('assets/images/Sadhana_cart1.png'), // 👈 your image path
//                   width: 45,
//                   height: 45,
//                 ),
//                 SizedBox(width: 6),
//                 Text(
//                   "SadhanaCart",
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.deepOrange,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "2nd Floor, Akshay Complex, No. 01,\n16th Main Rd, near Bharat Petroleum\nBTM 2nd Stage,\nBengaluru, Karnataka 560076",
//               style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.6),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "Copyright © 2024-2025, All Right\nReserved Sadhan Cart Team",
//               style: TextStyle(color: Colors.white70, fontSize: 13),
//             ),
//           ],
//         ),
//       ),
//
//       // Column 2: Call & Mail
//       Flexible(
//         flex: 1,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text("Call Us", style: _footerHeading),
//             SizedBox(height: 8),
//             Text("084316 55799", style: _footerText),
//             SizedBox(height: 16),
//             Text("Mail Us", style: _footerHeading),
//             SizedBox(height: 8),
//             Text("sadhanacart@gmail.com", style: _footerText),
//           ],
//         ),
//       ),
//
//       // Column 3: Useful Links
//       Flexible(
//         flex: 1,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text("Useful Links", style: _footerHeading),
//             SizedBox(height: 8),
//             _FooterLink("Become a Seller"),
//             _FooterLink("Return Policy"),
//             _FooterLink("Shipping Policy"),
//             _FooterLink("Products"),
//             _FooterLink("Terms & Condition"),
//             _FooterLink("Privacy Policy"),
//             _FooterLink("About Us"),
//             _FooterLink("Contact Us"),
//           ],
//         ),
//       ),
//
//       // Column 4: About Us
//       Flexible(
//         flex: isWide ? 2 : 1,
//         child: const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("About Us", style: _footerHeading),
//             SizedBox(height: 8),
//             Text(
//               "SadhanaCart is a multipurpose Ecommerce Platform best suitable for all kinds of sectors like Electronics, Fashion, Groceries and Vegetables, Flowers, Gift articles, Medical, and more ..",
//               style: _footerText,
//             ),
//           ],
//         ),
//       ),
//     ];
//   }
// }
//
// const TextStyle _footerHeading = TextStyle(
//   color: Colors.white,
//   fontSize: 16,
//   fontWeight: FontWeight.bold,
// );
//
// const TextStyle _footerText = TextStyle(
//   color: Colors.white70,
//   fontSize: 14,
//   height: 1.6,
// );
//
// class _FooterLink extends StatelessWidget {
//   final String text;
//   const _FooterLink(this.text);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Text(
//         text,
//         style: _footerText,
//       ),
//     );
//   }
// }
//
// // Footer Shape Clip
// class FooterClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height * 0.1);
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }


// updating


import 'package:flutter/material.dart';

class   WebFooterSection extends StatelessWidget {
  final ScrollController? scrollController;
  const WebFooterSection({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: FooterClipper(),
          child: Container(
            color: const Color(0xFF1E2A38),
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 800;
                    return isWide
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _buildFooterColumns(context, isWide: true),
                    )
                        : Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: _buildFooterColumns(context, isWide: false),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // Floating Scroll to Top Button
        Positioned(
          bottom: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              scrollController?.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.deepOrange, width: 2),
              ),
              child: const Icon(Icons.arrow_upward, color: Colors.deepOrange),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFooterColumns(BuildContext context, {required bool isWide}) {
    return [
      // Column 1: Logo + Address + Copyright
      Flexible(
        flex: isWide ? 2 : 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Image(
                  image: AssetImage('assets/images/Sadhana_cart1.png'),
                  width: 45,
                  height: 45,
                ),
                SizedBox(width: 6),
                Text(
                  "SadhanaCart",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text("About Us", style: _footerHeading),
            SizedBox(height: 8),
            Text(
              "SadhanaCart is a multipurpose Ecommerce Platform best suitable for all kinds of sectors like Electronics, Fashion, Groceries and Vegetables, Flowers, Gift articles, Medical, and more ..",
              style: _footerText,
            ),
            const SizedBox(height: 16),
            const Text(
              "Copyright © 2024-2025, All Right\nReserved Sadhan Cart Team",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),

      // Column 2: Call & Mail
      Flexible(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Call Us", style: _footerHeading),
            SizedBox(height: 8),
            Text("+91-94488 10877", style: _footerText),
            SizedBox(height: 16),
            Text("Mail Us", style: _footerHeading),
            SizedBox(height: 8),
            Text("sadhanacart123@gmail.com", style: _footerText),
            SizedBox(height: 16),
            Text("Working Hours", style: _footerHeading),
            SizedBox(height: 8),
            Text("Monday to Saturday", style: _footerText),
            Text("9:00 AM – 6:00 PM", style: _footerText),
          ],
        ),
      ),

      // Column 3: Useful Links
      Flexible(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Useful Links", style: _footerHeading),
            const SizedBox(height: 8),
            // _FooterLink(
            //   "Become a Seller",
            //   onTap: () => _navigateTo(context, '/become'),
            // ),
            _FooterLink(
              "Return Policy",
              onTap: () => _navigateTo(context, '/return-policy'),
            ),
            _FooterLink(
              "Shipping Policy",
              onTap: () => _navigateTo(context, '/shipping-policy'),
            ),
            // _FooterLink(
            //   "Products",
            //   onTap: () => _navigateTo(context, '/products'),
            // ),
            _FooterLink(
              "Terms & Condition",
              onTap: () => _navigateTo(context, '/terms'),
            ),
            _FooterLink(
              "Privacy Policy",
              onTap: () => _navigateTo(context, '/privacy'),
            ),
            _FooterLink(
              "About Us",
              onTap: () => _navigateTo(context, '/about'),
            ),
            // _FooterLink(
            //   "Contact Us",
            //   onTap: () => _navigateTo(context, '/contact'),
            // ),
            _FooterLink(
              "Chat With Us",
              onTap: () => _navigateTo(context, '/chat'),
            ),
            _FooterLink(
              "Faqs",
              onTap: () => _navigateTo(context, '/faqs'),
            ),
          ],
        ),
      ),

      // Column 4: About Us
      Flexible(
        flex: isWide ? 2 : 1,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Located At", style: _footerHeading),
            SizedBox(height: 12),
            Text("Registered Office", style: TextStyle(fontSize: 16,color: Colors.deepOrange),),
            SizedBox(height: 8),
            const Text(
              "Flat No. 3, Sri Mukunda Sri Ganesh Residency,\n1-11-400, 1-11-400/1, 1-11-399, 1-11-399/1,\nNijalingappa Nagar, Raichur,\nKarnataka - 584101",
              style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.6),
            ),
            SizedBox(height: 12),
            Text("Additional Office", style: TextStyle(fontSize: 16,color: Colors.deepOrange),),
            SizedBox(height: 8),
            const Text(
              "Plot No. 12/A, Bommanahal Road,\nNear Bharat Petrol Bunk,\nAndhral Village,Ballari,\nKarnataka - 583101",
              style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.6),
            ),
          ],
        ),
      ),
    ];
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}

const TextStyle _footerHeading = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const TextStyle _footerText = TextStyle(
  color: Colors.white70,
  fontSize: 14,
  height: 1.6,
);

class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const _FooterLink(this.text, {required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            widget.text,
            style: _footerText.copyWith(
              color: _isHovered ? Colors.deepOrange : Colors.white70,
              decoration: _isHovered ? TextDecoration.underline : null,
            ),
          ),
        ),
      ),
    );
  }
}

class FooterClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.1);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
