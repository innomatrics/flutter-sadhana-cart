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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sadhana_cart/Seller/seller_bottom_nav_layout.dart';
import 'package:sadhana_cart/Seller/seller_registration_screen.dart';
import 'package:sadhana_cart/Seller/hold_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SellerSignInScreen extends StatefulWidget {
  const SellerSignInScreen({super.key});

  @override
  _SellerSignInScreenState createState() => _SellerSignInScreenState();
}

class _SellerSignInScreenState extends State<SellerSignInScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late bool isSigning = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

    // Expansion animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 6.0), weight: 10),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();

    // Slide up-down animation controller
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Repeats animation forever

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: const Offset(0, 0.05),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userRef =
            FirebaseFirestore.instance.collection('seller').doc(user.uid);
        final docSnapshot = await userRef.get();

        if (docSnapshot.exists) {
          final status = docSnapshot['status'];

          if (status == 'accepted') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
            );
          } else if (status == 'pending') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HoldScreen()),
            );
          } else if (status == 'rejected') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => const SellerRegistrationScreen()),
            );
          }
        }
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential? userCredential;

    try {
      setState(() => isSigning = true);

      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();

        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken,
          );

          userCredential = await auth.signInWithCredential(credential);
        }
      }

      if (userCredential != null) {
        User? user = userCredential.user;

        if (user != null) {
          final userRef =
              FirebaseFirestore.instance.collection('seller').doc(user.uid);
          final docSnapshot = await userRef.get();

          if (!docSnapshot.exists) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const SellerRegistrationScreen(),
              ),
            );
          } else {
            final status = docSnapshot['status'];
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);

            setState(() => isSigning = false);

            if (status == 'approved') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BottomNavBarScreen()),
              );
            } else if (status == 'pending') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HoldScreen()),
              );
            } else if (status == 'rejected') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const SellerRegistrationScreen()),
              );
            }
          }
        }
      }
    } catch (e) {
      setState(() => isSigning = false);
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Column(
            spacing: size.height * 0.02,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.20),
              Stack(
                children: [
                  Container(color: Colors.white),
                  Center(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animation.value,
                          child: Container(
                            width: size.height * 1,
                            height: size.width * 1,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: _slideAnimation,
                          child: Image.asset(
                            'assets/images/Sadhana_cart1.png',
                            height: 120,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Sadhana Cart",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 55,
                width: 325,
                child: ElevatedButton(
                  onPressed: _signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            'assets/images/google_log_off.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const TextSpan(
                          text: 'oogle',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




//with upgraded frontend


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
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
//       );
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
//             // Navigate to seller registration if not registered
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => SellerRegistrationScreen(user: user)),
//             );
//           } else {
//             await userRef.update({'status': 'loggedIn'});
//
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100], // Light background
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Placeholder for Logo
//               Container(
//                 height: 200,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/Sadhana_cart1.png'), // Replace with your actual logo path
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Welcome Text
//               Text(
//                 "Welcome Seller!",
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               SizedBox(height: 10),
//
//               // Subtitle
//               Text(
//                 "Sign in to manage your products & sales",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[700],
//                 ),
//               ),
//               SizedBox(height: 40),
//
//               // Google Sign-In Button
//               Container(
//                 height: 55,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _signInWithGoogle,
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black,
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     elevation: 3,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/images/google_log_off.png', // Ensure this image exists in assets
//                         width: 24,
//                         height: 24,
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         'Continue with Google',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 10),
//
//               // Loading indicator during sign-in
//               if (isSigning)
//                 Padding(
//                   padding: EdgeInsets.only(top: 20),
//                   child: CircularProgressIndicator(
//                     color: Colors.blue,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




