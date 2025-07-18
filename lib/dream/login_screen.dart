// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sadhana_cart/dream/auth_service.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final user = await authService.signInWithGoogle();
//             if (user != null) {
//               // Check if user is admin (you can set this manually in Firestore)
//               Navigator.pushReplacementNamed(
//                 context,
//                 user.email == "admin@example.com" ? '/admin' : '/customer',
//               );
//             }
//           },
//           child: const Text("Sign in with Google"),
//         ),
//       ),
//     );
//   }
// }