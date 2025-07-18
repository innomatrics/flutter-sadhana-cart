// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sadhana_cart/Customer/customer_bottom_navigationber_layout.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CustomerSigninScreen extends StatefulWidget {
//   const CustomerSigninScreen({super.key});
//
//   @override
//   _CustomerSigninScreenState createState() => _CustomerSigninScreenState();
// }
//
// class _CustomerSigninScreenState extends State<CustomerSigninScreen> {
//   final bool _isPasswordVisible = false;
//   bool isSigning = false;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   // Future<void> _signInUser() async {
//   //   if (_formKey.currentState!.validate()) {
//   //     try {
//   //       // Attempt to sign in using Firebase Authentication
//   //       await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //         email: _emailController.text.trim(),
//   //         password: _passwordController.text.trim(),
//   //       );
//   //
//   //       // Navigate to Home Screen on successful login
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => HomeScreen()),
//   //       );
//   //     } on FirebaseAuthException catch (e) {
//   //       // Handle errors
//   //       String message;
//   //       if (e.code == 'user-not-found') {
//   //         message = 'No user found for this email.';
//   //       } else if (e.code == 'wrong-password') {
//   //         message = 'Incorrect password.';
//   //       } else {
//   //         message = 'An error occurred. Please try again.';
//   //       }
//   //
//   //       // Show error message
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   //     }
//   //   }
//   // }
//
//   // Future<void> _signInUser() async {
//   //   if (_formKey.currentState!.validate()) {
//   //     try {
//   //       // Attempt to sign in using Firebase Authentication
//   //       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //         email: _emailController.text.trim(),
//   //         password: _passwordController.text.trim(),
//   //       );
//   //
//   //       // Update the user's status to 'loggedin' in Firestore
//   //       final String userId = userCredential.user!.uid;
//   //       await FirebaseFirestore.instance.collection('customers').doc(userId).update({
//   //         'status': 'loggedin',
//   //       });
//   //
//   //       // Navigate to Home Screen on successful login
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => HomeScreen()),
//   //       );
//   //     } on FirebaseAuthException catch (e) {
//   //       // Handle errors
//   //       String message;
//   //       if (e.code == 'user-not-found') {
//   //         message = 'No user found for this email.';
//   //       } else if (e.code == 'wrong-password') {
//   //         message = 'Incorrect password.';
//   //       } else {
//   //         message = 'An error occurred. Please try again.';
//   //       }
//   //
//   //       // Show error message
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   //     } catch (e) {
//   //       // Handle other errors
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('An unexpected error occurred: $e')),
//   //       );
//   //     }
//   //   }
//   // }
//
//   Future<void> _signInWithGoogle() async {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//
//     try {
//       setState(() => isSigning = true);
//
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();
//
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken,
//         );
//
//         UserCredential userCredential =
//             await auth.signInWithCredential(credential);
//         User? user = userCredential.user;
//
//         if (user != null) {
//           final userRef =
//               FirebaseFirestore.instance.collection('customers').doc(user.uid);
//
//           final docSnapshot = await userRef.get();
//           if (!docSnapshot.exists) {
//             await userRef.set({
//               'email': user.email,
//               'name': user.displayName,
//               'createdAt': FieldValue.serverTimestamp(),
//               'status': 'loggedIn', // Store loggedIn status
//             });
//           } else {
//             await userRef.update({
//               'status': 'loggedIn'
//             }); // Update status to loggedIn if user exists
//           }
//
//           // Save login status locally
//           final SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setBool('isLoggedIn', true);
//
//           setState(() => isSigning = false);
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => const HomeScreen()),
//           );
//         }
//       }
//     } catch (e) {
//       setState(() => isSigning = false);
//       Fluttertoast.showToast(msg: "Error $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           // Background with Gradient
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // App Illustration
//                   Image.asset(
//                     'assets/images/Sadhana_cart1.png', // Add an attractive illustration
//                     height: 150,
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Glassmorphic Card for Sign-In Form
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     width: 350,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: Colors.white.withOpacity(0.3)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26.withOpacity(0.1),
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         // Welcome Text
//                         const Text(
//                           "Welcome Back!",
//                           style: TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           "Sign in to continue",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white70,
//                           ),
//                         ),
//
//                         const SizedBox(height: 25),
//
//                         // Google Sign-In Button with Animation
//                         GestureDetector(
//                           onTap: _signInWithGoogle,
//                           child: Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 14, horizontal: 20),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.black26,
//                                   blurRadius: 6,
//                                   offset: Offset(2, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   'assets/images/google_log_off.png', // Ensure correct path
//                                   height: 24,
//                                   width: 24,
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const Text(
//                                   "Sign in with Google",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


//



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sadhana_cart/Web/Customer/customer_bottom_navigationber_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/Customer/customer_bottom_navigationber_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WebCustomerSigninScreen extends StatefulWidget {
  const WebCustomerSigninScreen({super.key});

  @override
  State<WebCustomerSigninScreen> createState() => _WebCustomerSigninScreenState();
}

class _WebCustomerSigninScreenState extends State<WebCustomerSigninScreen> {
  bool _isSigning = false;
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _googleSignIn = GoogleSignIn();

  // Future<void> _signInWithGoogle() async {
  //   try {
  //     setState(() => _isSigning = true);
  //
  //     final googleSignInAccount = await _googleSignIn.signIn();
  //     if (googleSignInAccount == null) return;
  //
  //     final googleAuth = await googleSignInAccount.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //       accessToken: googleAuth.accessToken,
  //     );
  //
  //     final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //     final user = userCredential.user;
  //
  //     if (user != null) {
  //       final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
  //       final docSnapshot = await userRef.get();
  //
  //       if (!docSnapshot.exists) {
  //         await userRef.set({
  //           'email': user.email,
  //           'name': user.displayName,
  //           'photoUrl': user.photoURL,
  //           'createdAt': FieldValue.serverTimestamp(),
  //           'status': 'loggedIn',
  //         });
  //       } else {
  //         await userRef.update({'status': 'loggedIn'});
  //       }
  //
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.setBool('isLoggedIn', true);
  //
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (_) => const WebHomeScreen()),
  //       );
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Sign in failed: ${e.toString()}",
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //     );
  //   } finally {
  //     if (mounted) setState(() => _isSigning = false);
  //   }
  // }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() => _isSigning = true);

      // Initialize GoogleSignIn with platform-specific configuration
      final GoogleSignInAccount? googleSignInAccount;

      if (kIsWeb) {
        // Web configuration
        googleSignInAccount = await GoogleSignIn(
          clientId: '126398142924-t5s8i5vnvlh2v4fdhohfrpitin6bvcp6.apps.googleusercontent.com', // Add your web client ID
          scopes: ['email', 'profile'],
        ).signIn();
      } else {
        // Mobile configuration
        googleSignInAccount = await GoogleSignIn().signIn();
      }

      if (googleSignInAccount == null) return;

      final googleAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userRef = FirebaseFirestore.instance.collection('customers').doc(user.uid);
        final docSnapshot = await userRef.get();

        if (!docSnapshot.exists) {
          await userRef.set({
            'email': user.email,
            'name': user.displayName,
            'photoUrl': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
            'status': 'loggedIn',
            'platform': kIsWeb ? 'web' : 'mobile', // Track platform
          });
        } else {
          await userRef.update({
            'status': 'loggedIn',
            'lastLogin': FieldValue.serverTimestamp(),
          });
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WebHomeScreen()),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Sign in failed: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      debugPrint('Google Sign-In Error: $e');
    } finally {
      if (mounted) setState(() => _isSigning = false);
    }
  }

  Future<void> _signInWithEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() => _isSigning = true);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WebHomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: e.message ?? "Authentication failed",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } finally {
        if (mounted) setState(() => _isSigning = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

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
                  Colors.deepOrange.shade800,
                  Colors.deepOrange.shade400,
                ],
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.1)),

          // Decorative floating elements
          ...List.generate(5, (index) => Positioned(
            top: size.height * 0.2 * index,
            left: size.width * 0.1,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ).animate(
                onPlay: (controller) => controller.repeat(reverse: true)
            ).move(
              begin: Offset(0, 0),
              end: Offset(size.width * 0.7, 0),
              duration: (3000 + index * 500).ms,
              curve: Curves.easeInOut,
            ),
          )),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with animation
                  Image.asset(
                    'assets/images/Sadhana_cart1.png',
                    height: 120,
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .scale(begin: const Offset(0.8, 0.8)),

                  const SizedBox(height: 40),

                  // Sign-in card with animation
                  Container(
                    width: size.width > 600 ? 500 : double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Title with animation
                          Text(
                            "Welcome Back",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 200.ms)
                              .slideY(begin: -0.2),

                          const SizedBox(height: 8),

                          Text(
                            "Sign in to continue",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 300.ms),






                          const SizedBox(height: 24),

                          // Google sign-in button
                          OutlinedButton.icon(
                            icon: Image.asset(
                              'assets/images/google_log_off.png',
                              height: 24,
                            ),
                            label: Text(
                              "Continue with Google",
                              style: theme.textTheme.bodyLarge,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _isSigning ? null : _signInWithGoogle,
                          )
                              .animate()
                              .fadeIn(delay: 900.ms)
                              .slideY(begin: 0.2),

                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 100.ms)
                      .scale(begin: const Offset(0.95, 0.95)),
                ],
              ),
            ),
          ),

          // Loading overlay
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
