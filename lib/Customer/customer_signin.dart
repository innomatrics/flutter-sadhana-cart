import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sadhana_cart/Customer/customer_bottom_navigationber_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSigninScreen extends StatefulWidget {
  const CustomerSigninScreen({super.key});

  @override
  _CustomerSigninScreenState createState() => _CustomerSigninScreenState();
}

class _CustomerSigninScreenState extends State<CustomerSigninScreen> {
  final bool _isPasswordVisible = false;
  bool isSigning = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Future<void> _signInUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       // Attempt to sign in using Firebase Authentication
  //       await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //
  //       // Navigate to Home Screen on successful login
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeScreen()),
  //       );
  //     } on FirebaseAuthException catch (e) {
  //       // Handle errors
  //       String message;
  //       if (e.code == 'user-not-found') {
  //         message = 'No user found for this email.';
  //       } else if (e.code == 'wrong-password') {
  //         message = 'Incorrect password.';
  //       } else {
  //         message = 'An error occurred. Please try again.';
  //       }
  //
  //       // Show error message
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  //     }
  //   }
  // }

  // Future<void> _signInUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       // Attempt to sign in using Firebase Authentication
  //       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //
  //       // Update the user's status to 'loggedin' in Firestore
  //       final String userId = userCredential.user!.uid;
  //       await FirebaseFirestore.instance.collection('customers').doc(userId).update({
  //         'status': 'loggedin',
  //       });
  //
  //       // Navigate to Home Screen on successful login
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeScreen()),
  //       );
  //     } on FirebaseAuthException catch (e) {
  //       // Handle errors
  //       String message;
  //       if (e.code == 'user-not-found') {
  //         message = 'No user found for this email.';
  //       } else if (e.code == 'wrong-password') {
  //         message = 'Incorrect password.';
  //       } else {
  //         message = 'An error occurred. Please try again.';
  //       }
  //
  //       // Show error message
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  //     } catch (e) {
  //       // Handle other errors
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('An unexpected error occurred: $e')),
  //       );
  //     }
  //   }
  // }

  Future<void> _signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      setState(() => isSigning = true);

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          final userRef =
              FirebaseFirestore.instance.collection('customers').doc(user.uid);

          final docSnapshot = await userRef.get();
          if (!docSnapshot.exists) {
            await userRef.set({
              'email': user.email,
              'name': user.displayName,
              'createdAt': FieldValue.serverTimestamp(),
              'status': 'loggedIn', // Store loggedIn status
            });
          } else {
            await userRef.update({
              'status': 'loggedIn'
            }); // Update status to loggedIn if user exists
          }

          // Save login status locally
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);

          setState(() => isSigning = false);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      }
    } catch (e) {
      setState(() => isSigning = false);
      Fluttertoast.showToast(msg: "Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background with Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Illustration
                  Image.asset(
                    'assets/images/Sadhana_cart1.png', // Add an attractive illustration
                    height: 150,
                  ),

                  const SizedBox(height: 20),

                  // Glassmorphic Card for Sign-In Form
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Welcome Text
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Sign in to continue",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Google Sign-In Button with Animation
                        GestureDetector(
                          onTap: _signInWithGoogle,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google_log_off.png', // Ensure correct path
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                    fontSize: 16,
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
