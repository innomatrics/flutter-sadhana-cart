// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'customer_bottom_navigationber_layout.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );
//
//     // Expansion and Contraction Animation
//     _animation = TweenSequence([
//       TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 6.0), weight: 50), // Expand
//       TweenSequenceItem(tween: Tween<double>(begin: 6.0, end: 0.0), weight: 50), // Contract
//     ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     // Start animation
//     _controller.forward();
//
//     // Navigate after animation
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         Future.delayed(const Duration(milliseconds: 500), () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const HomeScreen()),
//           );
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenSize = MediaQuery.of(context).size.width * 2; // Ensure full coverage
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // White Background
//           Container(color: Colors.white),
//
//           // Expanding & Contracting Circular Gradient
//           Center(
//             child: AnimatedBuilder(
//               animation: _animation,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _animation.value,
//                   child: Container(
//                     width: screenSize,
//                     height: screenSize,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF6A11CB), Color(0xFF2575FC), Color(0xFF2575FC)],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           // Centered Logo and Text
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/Sadhana_cart1.png', // Your logo
//                   height: 120,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "SadhanaCart",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:async';

import 'customer_bottom_navigationber_layout.dart';

class WebSplashScreen extends StatefulWidget {
  const WebSplashScreen({super.key});

  @override
  State<WebSplashScreen> createState() => _WebSplashScreenState();
}

class _WebSplashScreenState extends State<WebSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.1416).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.1, end: 3.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WebHomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Expanding + Rotating Gradient Circle
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Container(
                      width: screenSize.width,
                      height: screenSize.width,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            Color(0xFF64DD17), // Light Green
                            Color(0xFFF57F17), // Amber
                            Color(0xFFE65100), // Deep Orange
                            Color(0xFF64DD17), // Loop back
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Optional soft white overlay for fade-in effect
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.1)),
          ),

          // Centered logo and text with fade-in
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Sadhana_cart1.png',
                    height: 120,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "SadhanaCart",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'customer_bottom_navigationber_layout.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );
//
//     // Expansion and Contraction Animation
//     _animation = TweenSequence([
//       TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 6.0), weight: 50), // Expand
//       TweenSequenceItem(tween: Tween<double>(begin: 6.0, end: 0.0), weight: 50), // Contract
//     ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     // Start animation
//     _controller.forward();
//
//     // Navigate after animation
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         Future.delayed(const Duration(milliseconds: 500), () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//           );
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenSize = MediaQuery.of(context).size.width * 2; // Ensure full coverage
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Full-Screen Gradient Background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//
//           // Expanding & Contracting White Circle
//           Center(
//             child: AnimatedBuilder(
//               animation: _animation,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _animation.value,
//                   child: Container(
//                     width: screenSize,
//                     height: screenSize,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white, // White expanding circle
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           // Centered Logo and Text
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/Sadhana_cart1.png', // Your logo
//                   height: 120,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "SadhanacCart",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black, // Text is black for visibility
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

