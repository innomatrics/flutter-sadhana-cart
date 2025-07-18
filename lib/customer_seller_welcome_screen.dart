

// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
//
// import 'Customer/customer_splash_screen.dart';
// import 'Seller/Seller_Sign_In.dart';
//
// class CustomerSellerWelcomeScreen extends StatefulWidget {
//   const CustomerSellerWelcomeScreen({super.key});
//
//   @override
//   State<CustomerSellerWelcomeScreen> createState() => _CustomerSellerWelcomeScreenState();
// }
//
// class _CustomerSellerWelcomeScreenState extends State<CustomerSellerWelcomeScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _textController;
//   late AnimationController _buttonController;
//   late AnimationController _bubbleController;
//   late Animation<double> _scaleAnimation;
//
//   final List<Bubble> bubbles = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize animations
//     _logoController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     )..repeat(reverse: true);
//
//     _textController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _buttonController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _bubbleController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 10),
//     )..repeat();
//
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     // Start staggered animations
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _textController.forward();
//     });
//     Future.delayed(const Duration(milliseconds: 500), () {
//       _buttonController.forward();
//     });
//
//     // Create bubbles
//     _createBubbles();
//   }
//
//   void _createBubbles() {
//     final bubbleSpecs = [
//       {'size': 40.0, 'left': 0.1, 'delay': 0, 'duration': 8},
//       {'size': 20.0, 'left': 0.2, 'delay': 1, 'duration': 5},
//       {'size': 50.0, 'left': 0.35, 'delay': 2, 'duration': 7},
//       {'size': 80.0, 'left': 0.5, 'delay': 0, 'duration': 11},
//       {'size': 35.0, 'left': 0.55, 'delay': 1, 'duration': 6},
//       {'size': 45.0, 'left': 0.65, 'delay': 3, 'duration': 8},
//       {'size': 25.0, 'left': 0.75, 'delay': 2, 'duration': 7},
//       {'size': 80.0, 'left': 0.8, 'delay': 1, 'duration': 6},
//     ];
//
//     for (var spec in bubbleSpecs) {
//       bubbles.add(Bubble(
//         size: spec['size'] as double,
//         left: spec['left'] as double,
//         delay: spec['delay'] as int,
//         duration: spec['duration'] as int,
//       ));
//     }
//   }
//
//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     _buttonController.dispose();
//     _bubbleController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient Background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
//               ),
//             ),
//           ),
//
//           // Bubbles
//           for (var bubble in bubbles)
//             Positioned(
//               left: bubble.left * MediaQuery.of(context).size.width,
//               bottom: -bubble.size,
//               child: AnimatedBuilder(
//                 animation: _bubbleController,
//                 builder: (context, child) {
//                   final anim = CurvedAnimation(
//                     parent: _bubbleController,
//                     curve: Interval(
//                       bubble.delay / 15,
//                       (bubble.delay + bubble.duration) / 15,
//                       curve: Curves.easeIn,
//                     ),
//                   );
//
//                   return Transform.translate(
//                     offset: Offset(
//                       0,
//                       -anim.value * (MediaQuery.of(context).size.height + bubble.size),
//                     ),
//                     child: Transform.translate(
//                       offset: Offset(anim.value * 100, 0),
//                       child: Opacity(
//                         opacity: 1 - anim.value,
//                         child: Container(
//                           width: bubble.size,
//                           height: bubble.size,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.1),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//           // Content
//           Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Asset Image with scale animation
//                     AnimatedBuilder(
//                       animation: _scaleAnimation,
//                       builder: (context, child) {
//                         return Transform.scale(
//                           scale: _scaleAnimation.value,
//                           child: child,
//                         );
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 30),
//                         child: Image.asset(
//                           'assets/images/Sadhana_cart1.png', // Replace with your asset path
//                           height: 250,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//
//                     // Title with fade-in animation
//                     FadeTransition(
//                       opacity: _textController,
//                       child: SlideTransition(
//                         position: Tween<Offset>(
//                           begin: const Offset(0, 0.2),
//                           end: Offset.zero,
//                         ).animate(
//                           CurvedAnimation(
//                             parent: _textController,
//                             curve: Curves.easeOut,
//                           ),
//                         ),
//                         child: const Text(
//                           'Welcome!',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     // Subtitle with fade-in animation
//                     FadeTransition(
//                       opacity: _textController,
//                       child: SlideTransition(
//                         position: Tween<Offset>(
//                           begin: const Offset(0, 0.2),
//                           end: Offset.zero,
//                         ).animate(
//                           CurvedAnimation(
//                             parent: _textController,
//                             curve: Curves.easeOut,
//                           ),
//                         ),
//                         child: const Text(
//                           'Please select your role to continue',
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 16,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 40),
//
//                     // Role Selection Buttons with fade-in animation
//                     FadeTransition(
//                       opacity: _buttonController,
//                       child: SlideTransition(
//                         position: Tween<Offset>(
//                           begin: const Offset(0, 0.2),
//                           end: Offset.zero,
//                         ).animate(
//                           CurvedAnimation(
//                             parent: _buttonController,
//                             curve: Curves.easeOut,
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             // Customer Button
//                             AnimatedButton(
//                               onPressed: () {
//                                 // Handle customer selection
//
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => SplashScreen(),
//                                   ),
//                                 );
//                               },
//                               label: 'Continue as Customer',
//                               icon: Icons.shopping_cart,
//                               color: Colors.blueAccent,
//                             ),
//
//                             const SizedBox(height: 20),
//
//                             // Seller Button
//                             AnimatedButton(
//                               onPressed: () {
//                                 // Handle seller selection
//
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => SellerSignInScreen(),
//                                   ),
//                                 );
//                               },
//                               label: 'Continue as Seller',
//                               icon: Icons.store,
//                               color: Colors.purpleAccent,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AnimatedButton extends StatefulWidget {
//   final VoidCallback onPressed;
//   final String label;
//   final IconData icon;
//   final Color color;
//
//   const AnimatedButton({
//     super.key,
//     required this.onPressed,
//     required this.label,
//     required this.icon,
//     required this.color,
//   });
//
//   @override
//   State<AnimatedButton> createState() => _AnimatedButtonState();
// }
//
// class _AnimatedButtonState extends State<AnimatedButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );
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
//     return GestureDetector(
//       onTapDown: (_) => _controller.forward(),
//       onTapUp: (_) {
//         _controller.reverse();
//         widget.onPressed();
//       },
//       onTapCancel: () => _controller.reverse(),
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           decoration: BoxDecoration(
//             color: widget.color.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: widget.color, width: 2),
//             boxShadow: [
//               BoxShadow(
//                 color: widget.color.withOpacity(0.3),
//                 blurRadius: 10,
//                 spreadRadius: 1,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(widget.icon, color: Colors.white, size: 24),
//               const SizedBox(width: 15),
//               Text(
//                 widget.label,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Bubble {
//   final double size;
//   final double left;
//   final int delay;
//   final int duration;
//
//   Bubble({
//     required this.size,
//     required this.left,
//     required this.delay,
//     required this.duration,
//   });
// }




// web



import 'package:flutter/material.dart';

import 'Customer/customer_splash_screen.dart';
import 'Seller/Seller_Sign_In.dart';
import 'Web/Customer/customer_splash_screen.dart';
import 'Web/Seller/Seller_Sign_In.dart';

class webCustomerSellerWelcomeScreen extends StatefulWidget {
  const webCustomerSellerWelcomeScreen({super.key});

  @override
  State<webCustomerSellerWelcomeScreen> createState() =>
      _webCustomerSellerWelcomeScreenState();
}

class _webCustomerSellerWelcomeScreenState
    extends State<webCustomerSellerWelcomeScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _buttonController;
  late AnimationController _bubbleController;
  late Animation<double> _scaleAnimation;

  final List<Bubble> bubbles = [];

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _textController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      _buttonController.forward();
    });

    _createBubbles();
  }

  void _createBubbles() {
    final bubbleSpecs = [
      {'size': 40.0, 'left': 0.1, 'delay': 0, 'duration': 8},
      {'size': 20.0, 'left': 0.2, 'delay': 1, 'duration': 5},
      {'size': 50.0, 'left': 0.35, 'delay': 2, 'duration': 7},
      {'size': 80.0, 'left': 0.5, 'delay': 0, 'duration': 11},
      {'size': 35.0, 'left': 0.55, 'delay': 1, 'duration': 6},
      {'size': 45.0, 'left': 0.65, 'delay': 3, 'duration': 8},
      {'size': 25.0, 'left': 0.75, 'delay': 2, 'duration': 7},
      {'size': 80.0, 'left': 0.8, 'delay': 1, 'duration': 6},
    ];

    for (var spec in bubbleSpecs) {
      bubbles.add(Bubble(
        size: spec['size'] as double,
        left: spec['left'] as double,
        delay: spec['delay'] as int,
        duration: spec['duration'] as int,
      ));
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double imageSize = width > 800 ? 300 : 200;

          return Stack(
            children: [
              // Gradient background
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ),
                ),
              ),

              // Bubbles
              ...bubbles.map((bubble) {
                final anim = CurvedAnimation(
                  parent: _bubbleController,
                  curve: Interval(
                    bubble.delay / 15,
                    (bubble.delay + bubble.duration) / 15,
                    curve: Curves.easeIn,
                  ),
                );

                return Positioned(
                  left: bubble.left * MediaQuery.of(context).size.width,
                  bottom: -bubble.size,
                  child: AnimatedBuilder(
                    animation: _bubbleController,
                    builder: (_, __) => Transform.translate(
                      offset: Offset(
                        anim.value * 100,
                        -anim.value *
                            (MediaQuery.of(context).size.height +
                                bubble.size),
                      ),
                      child: Opacity(
                        opacity: 1 - anim.value,
                        child: Container(
                          width: bubble.size,
                          height: bubble.size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Main content
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: child,
                          ),
                          child: Image.asset(
                            'assets/images/Sadhana_cart1.png',
                            height: imageSize,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Title
                        FadeTransition(
                          opacity: _textController,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.2),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _textController,
                                curve: Curves.easeOut,
                              ),
                            ),
                            child: const Text(
                              'Welcome!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Subtitle
                        FadeTransition(
                          opacity: _textController,
                          child: const Text(
                            'Please select your role to continue',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Buttons
                        FadeTransition(
                          opacity: _buttonController,
                          child: Column(
                            children: [
                              AnimatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebSplashScreen(),
                                    ),
                                  );
                                },
                                label: 'Continue as Customer',
                                icon: Icons.shopping_cart,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(height: 20),
                              AnimatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WebSellerSignInScreen(),
                                    ),
                                  );
                                },
                                label: 'Continue as Seller',
                                icon: Icons.store,
                                color: Colors.purpleAccent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Color color;

  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: widget.color, width: 2),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: Colors.white, size: 24),
              const SizedBox(width: 15),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bubble {
  final double size;
  final double left;
  final int delay;
  final int duration;

  Bubble({
    required this.size,
    required this.left,
    required this.delay,
    required this.duration,
  });
}
