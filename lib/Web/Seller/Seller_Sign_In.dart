// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sadhana_cart/Seller/seller_bottom_nav_layout.dart';
// import 'package:sadhana_cart/Seller/seller_registration_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
//
//
// class SellerSignInScreen extends StatefulWidget {
//   @override
//   _SellerSignInScreenState createState() => _SellerSignInScreenState();
// }
//
// class _SellerSignInScreenState extends State<SellerSignInScreen> {
//   late bool isSigning = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }
//
//   Future<void> _checkLoginStatus() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//
//     if (isLoggedIn) {
//       // If user is already logged in, navigate to the home screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
//       );
//     }
//   }
//
//   // Future<void> _signInWithGoogle() async {
//   //   final FirebaseAuth auth = FirebaseAuth.instance;
//   //   final GoogleSignIn googleSignIn = GoogleSignIn();
//   //
//   //   try {
//   //     setState(() => isSigning = true);
//   //
//   //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//   //
//   //     if (googleSignInAccount != null) {
//   //       final GoogleSignInAuthentication googleSignInAuthentication =
//   //       await googleSignInAccount.authentication;
//   //
//   //       final AuthCredential credential = GoogleAuthProvider.credential(
//   //         idToken: googleSignInAuthentication.idToken,
//   //         accessToken: googleSignInAuthentication.accessToken,
//   //       );
//   //
//   //       UserCredential userCredential = await auth.signInWithCredential(credential);
//   //       User? user = userCredential.user;
//   //
//   //       if (user != null) {
//   //         final userRef = FirebaseFirestore.instance.collection('seller').doc(user.uid);
//   //
//   //         final docSnapshot = await userRef.get();
//   //         if (!docSnapshot.exists) {
//   //           await userRef.set({
//   //             'email': user.email,
//   //             'name': user.displayName,
//   //             'createdAt': FieldValue.serverTimestamp(),
//   //             'status': 'loggedIn', // Store loggedIn status
//   //           });
//   //         } else {
//   //           await userRef.update({'status': 'loggedIn'}); // Update status to loggedIn if user exists
//   //         }
//   //
//   //         // Save login status locally
//   //         final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //         await prefs.setBool('isLoggedIn', true);
//   //
//   //         setState(() => isSigning = false);
//   //
//   //         Navigator.pushReplacement(
//   //           context,
//   //           MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
//   //         );
//   //       }
//   //     }
//   //   } catch (e) {
//   //     setState(() => isSigning = false);
//   //     Fluttertoast.showToast(msg: "Error $e");
//   //   }
//   // }
//
// // 3/3/2025
// //
// //   Future<void> _signInWithGoogle() async {
// //     final FirebaseAuth auth = FirebaseAuth.instance;
// //     final GoogleSignIn googleSignIn = GoogleSignIn();
// //
// //
// //     try {
// //       setState(() => isSigning = true);
// //
// //       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
// //
// //       if (googleSignInAccount != null) {
// //         final GoogleSignInAuthentication googleSignInAuthentication =
// //         await googleSignInAccount.authentication;
// //
// //         final AuthCredential credential = GoogleAuthProvider.credential(
// //           idToken: googleSignInAuthentication.idToken,
// //           accessToken: googleSignInAuthentication.accessToken,
// //         );
// //
// //         UserCredential userCredential = await auth.signInWithCredential(credential);
// //         User? user = userCredential.user;
// //
// //         if (user != null) {
// //           final userRef = FirebaseFirestore.instance.collection('seller').doc(user.uid);
// //
// //           final docSnapshot = await userRef.get();
// //           if (!docSnapshot.exists) {
// //             // If the seller is not registered, navigate to the registration screen
// //             Navigator.pushReplacement(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (_) => SellerRegistrationScreen(user: user),
// //               ),
// //             );
// //           } else {
// //             // If the seller is already registered, update status and navigate to the home screen
// //             await userRef.update({'status': 'loggedIn'});
// //
// //             // Save login status locally
// //             final SharedPreferences prefs = await SharedPreferences.getInstance();
// //             await prefs.setBool('isLoggedIn', true);
// //
// //             setState(() => isSigning = false);
// //
// //             Navigator.pushReplacement(
// //               context,
// //               MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
// //             );
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       setState(() => isSigning = false);
// //       Fluttertoast.showToast(msg: "Error $e");
// //     }
// //   }
//
//   // web
//
//
//   Future<void> _signInWithGoogle() async {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     UserCredential? userCredential;
//
//     try {
//       setState(() => isSigning = true);
//
//       if (kIsWeb) {
//         // 👉 Web Google Sign-In
//         GoogleAuthProvider googleProvider = GoogleAuthProvider();
//
//         userCredential = await auth.signInWithPopup(googleProvider);
//       } else {
//         // 👉 Android Google Sign-In
//         final GoogleSignIn googleSignIn = GoogleSignIn();
//         final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//
//         if (googleSignInAccount != null) {
//           final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//
//           final AuthCredential credential = GoogleAuthProvider.credential(
//             idToken: googleSignInAuthentication.idToken,
//             accessToken: googleSignInAuthentication.accessToken,
//           );
//
//           userCredential = await auth.signInWithCredential(credential);
//         }
//       }
//
//       if (userCredential != null) {
//         User? user = userCredential.user;
//
//         if (user != null) {
//           final userRef = FirebaseFirestore.instance.collection('seller').doc(user.uid);
//           final docSnapshot = await userRef.get();
//
//           if (!docSnapshot.exists) {
//             // If the seller is not registered, navigate to registration
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => SellerRegistrationScreen(user: user),
//               ),
//             );
//           } else {
//             // If the seller is already registered, update status
//             await userRef.update({'status': 'loggedIn'});
//
//             // Save login status locally
//             final SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.setBool('isLoggedIn', true);
//
//             setState(() => isSigning = false);
//
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
//             );
//           }
//         }
//       }
//     } catch (e) {
//       setState(() => isSigning = false);
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 55,
//               width: 325,
//               child: ElevatedButton(
//                 onPressed: _signInWithGoogle,
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       WidgetSpan(
//                         alignment: PlaceholderAlignment.middle,
//                         child: Image.asset(
//                           'assets/images/google_log_off.png',
//                           width: 24,
//                           height: 24,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'oogle',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//fucking

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sadhana_cart/Seller/seller_bottom_nav_layout.dart';
// import 'package:sadhana_cart/Seller/seller_registration_screen.dart';
// import 'package:sadhana_cart/Seller/hold_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// class SellerSignInScreen extends StatefulWidget {
//   const SellerSignInScreen({super.key});
//
//   @override
//   _SellerSignInScreenState createState() => _SellerSignInScreenState();
// }
//
// class _SellerSignInScreenState extends State<SellerSignInScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late AnimationController _slideController;
//   late Animation<Offset> _slideAnimation;
//   late bool isSigning = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//
//     // Expansion animation controller
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );
//     _animation = TweenSequence([
//       TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 6.0), weight: 10),
//     ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//     _controller.forward();
//
//     // Slide up-down animation controller
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true); // Repeats animation forever
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, -0.05),
//       end: const Offset(0, 0.05),
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _checkLoginStatus() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//
//     if (isLoggedIn) {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final userRef =
//             FirebaseFirestore.instance.collection('seller').doc(user.uid);
//         final docSnapshot = await userRef.get();
//
//         if (docSnapshot.exists) {
//           final status = docSnapshot['status'];
//
//           if (status == 'accepted') {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
//             );
//           } else if (status == 'pending') {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const HoldScreen()),
//             );
//           } else if (status == 'rejected') {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => const SellerRegistrationScreen()),
//             );
//           }
//         }
//       }
//     }
//   }
//
//   Future<void> _signInWithGoogle() async {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     UserCredential? userCredential;
//
//     try {
//       setState(() => isSigning = true);
//
//       if (kIsWeb) {
//         GoogleAuthProvider googleProvider = GoogleAuthProvider();
//         userCredential = await auth.signInWithPopup(googleProvider);
//       } else {
//         final GoogleSignIn googleSignIn = GoogleSignIn();
//         final GoogleSignInAccount? googleSignInAccount =
//             await googleSignIn.signIn();
//
//         if (googleSignInAccount != null) {
//           final GoogleSignInAuthentication googleSignInAuthentication =
//               await googleSignInAccount.authentication;
//
//           final AuthCredential credential = GoogleAuthProvider.credential(
//             idToken: googleSignInAuthentication.idToken,
//             accessToken: googleSignInAuthentication.accessToken,
//           );
//
//           userCredential = await auth.signInWithCredential(credential);
//         }
//       }
//
//       if (userCredential != null) {
//         User? user = userCredential.user;
//
//         if (user != null) {
//           final userRef =
//               FirebaseFirestore.instance.collection('seller').doc(user.uid);
//           final docSnapshot = await userRef.get();
//
//           if (!docSnapshot.exists) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const SellerRegistrationScreen(),
//               ),
//             );
//           } else {
//             final status = docSnapshot['status'];
//             final SharedPreferences prefs =
//                 await SharedPreferences.getInstance();
//             await prefs.setBool('isLoggedIn', true);
//
//             setState(() => isSigning = false);
//
//             if (status == 'approved') {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
//               );
//             } else if (status == 'pending') {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const HoldScreen()),
//               );
//             } else if (status == 'rejected') {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => const SellerRegistrationScreen()),
//               );
//             }
//           }
//         }
//       }
//     } catch (e) {
//       setState(() => isSigning = false);
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SizedBox(
//         child: Center(
//           child: Column(
//             spacing: size.height * 0.02,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: size.height * 0.20),
//               Stack(
//                 children: [
//                   Container(color: Colors.white),
//                   Center(
//                     child: AnimatedBuilder(
//                       animation: _animation,
//                       builder: (context, child) {
//                         return Transform.scale(
//                           scale: _animation.value,
//                           child: Container(
//                             width: size.height * 1,
//                             height: size.width * 1,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               gradient: LinearGradient(
//                                 colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SlideTransition(
//                           position: _slideAnimation,
//                           child: Image.asset(
//                             'assets/images/Sadhana_cart1.png',
//                             height: 120,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         const Text(
//                           "Sadhana Cart",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 height: 55,
//                 width: 325,
//                 child: ElevatedButton(
//                   onPressed: _signInWithGoogle,
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black,
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         WidgetSpan(
//                           alignment: PlaceholderAlignment.middle,
//                           child: Image.asset(
//                             'assets/images/google_log_off.png',
//                             width: 24,
//                             height: 24,
//                           ),
//                         ),
//                         const TextSpan(
//                           text: 'oogle',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




//with upgraded frontend


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/Web/Seller/hold_screen.dart';
import 'package:sadhana_cart/Web/Seller/seller_bottom_nav_layout.dart';
import 'package:sadhana_cart/Web/Seller/seller_registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class WebSellerSignInScreen extends StatefulWidget {
  const WebSellerSignInScreen({super.key});

  @override
  State<WebSellerSignInScreen> createState() => _WebSellerSignInScreenState();
}

class _WebSellerSignInScreenState extends State<WebSellerSignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isSigning = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _googleSignIn = GoogleSignIn(
    clientId: kIsWeb ? '126398142924-t5s8i5vnvlh2v4fdhohfrpitin6bvcp6.apps.googleusercontent.com' : null,
    scopes: ['email', 'profile'],
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _checkLoginStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _redirectSeller(user.uid);
      }
    }
  }

  Future<void> _redirectSeller(String uid) async {
    final userRef = FirebaseFirestore.instance.collection('seller').doc(uid);
    final docSnapshot = await userRef.get();

    if (!docSnapshot.exists) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WebSellerRegistrationScreen()),
      );
    } else {
      final status = docSnapshot['status'];
      if (status == 'approved') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WebBottomNavBarScreen()),
        );
      } else if (status == 'pending') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WebHoldScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WebSellerRegistrationScreen()),
        );
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() => _isSigning = true);
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) return;

      final googleAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await _redirectSeller(userCredential.user!.uid);
      }
    } catch (e) {
      _showError("Google sign-in failed: ${e.toString()}");
    } finally {
      if (mounted) setState(() => _isSigning = false);
    }
  }

  Future<void> _signInWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => _isSigning = true);
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await _redirectSeller(userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Authentication failed");
    } finally {
      if (mounted) setState(() => _isSigning = false);
    }
  }

  void _showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.shade800,
                  Colors.deepOrange.shade700,
                ],
              ),
            ),
          ).animate(controller: _controller).shimmer(
            duration: 3000.ms,
            color: Colors.white.withOpacity(0.1),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with Animation
                  Image.asset(
                    'assets/images/Sadhana_cart1.png',
                    height: isSmallScreen ? 80 : 120,
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .scale(begin: const Offset(0.9, 0.9)),

                  const SizedBox(height: 20),

                  Text(
                    "Seller Portal",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 24 : 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Sign-in Card
                  Container(
                    width: isSmallScreen ? double.infinity : 500,
                    padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Sign In to Your Seller Account",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) => value!.isEmpty ? 'Enter email' : null,
                          ).animate().fadeIn(delay: 200.ms),

                          const SizedBox(height: 16),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) => value!.isEmpty ? 'Enter password' : null,
                          ).animate().fadeIn(delay: 300.ms),

                          const SizedBox(height: 24),

                          // Sign In Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isSigning ? null : _signInWithEmail,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isSigning
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ).animate().fadeIn(delay: 400.ms),

                          const SizedBox(height: 24),
                          const Text("OR").animate().fadeIn(delay: 500.ms),
                          const SizedBox(height: 24),

                          // Google Sign In
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton.icon(
                              icon: Image.asset(
                                'assets/images/google_log_off.png',
                                height: 24,
                              ),
                              label: const Text("Continue with Google"),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _isSigning ? null : _signInWithGoogle,
                            ),
                          ).animate().fadeIn(delay: 600.ms),

                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Back to customer screen
                            },
                            child: const Text("Back to Customer Login"),
                          ).animate().fadeIn(delay: 700.ms),
                        ],
                      ),
                    ),
                  ).animate().scale(begin: const Offset(0.95, 0.95)),
                ],
              ),
            ),
          ),

          // Loading Overlay
          if (_isSigning)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


