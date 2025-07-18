// import 'package:flutter/material.dart';
//
// class SaqerServicesScreen extends StatelessWidget {
//   const SaqerServicesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Top Asset Image
//                 // SizedBox(
//                 //   height: 400,
//                 //   child: Image.asset(
//                 //     'assets/images/pexels-cottonbro-4606332.jpg', // Replace with your image
//                 //     fit: BoxFit.contain,
//                 //   ),
//                 // ),
//
//                 Container(
//                   width: double.infinity,
//                   height: MediaQuery.of(context).size.height * 0.4, // 40% of screen height
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/pexels-cottonbro-4606332.jpg'),
//                       fit: BoxFit.cover, // or BoxFit.fitWidth if you prefer no cropping
//                     ),
//                   ),
//                 ),
//
//
//                 const SizedBox(height: 10),
//
//
//                 // Title Text
//                 const Text(
//                   'Welcome To',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const Text(
//                   'SAQER SERVICES',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Subtitle Text
//                 Padding(
//                   padding: const EdgeInsets.only(top: 115.0),
//                   child: const Text(
//                     'Proceed as',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Buttons Row
//                 Row(
//                   children: [
//                     // Customer Button
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigate to Customer Screen
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                           padding: const EdgeInsets.symmetric(vertical: 15), // Removed horizontal
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 4,
//                         ),
//                         child: const Text(
//                           'Customer',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(width: 20), // spacing between buttons
//
//                     // Driver Button
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Navigate to Driver Screen
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black87,
//                           padding: const EdgeInsets.symmetric(vertical: 15), // Removed horizontal
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 4,
//                         ),
//                         child: const Text(
//                           'Driver',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



//


// import 'package:flutter/material.dart';
//
// class PhoneAuthScreen extends StatelessWidget {
//   const PhoneAuthScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final phoneController = TextEditingController();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Phone Verification',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Enter your phone number to receive a verification code.',
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: 'Phone Number',
//                   prefixText: '+971 ',
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(
//                       'assets/images/dubai_flag_saqer_ser.jpg', // Update with your image path
//                       height: 25, // Adjust height as needed
//                       width: 25, // Adjust width as needed
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // TODO: Validate phone number and navigate to OTP screen
//                     final phoneNumber = phoneController.text;
//                     if (phoneNumber.isEmpty || phoneNumber.length < 10) {
//                       // Show error message
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Please enter a valid phone number.')),
//                       );
//                     } else {
//                       // TODO: Navigate to OTP screen
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Send OTP',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
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


//


// import 'package:flutter/material.dart';
//
// class OtpVerificationScreen extends StatelessWidget {
//   const OtpVerificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());
//     final FocusNode focusNode = FocusNode();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'OTP Verification',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Enter the 4-digit code sent to your phone.',
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//               ),
//               const SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(4, (index) {
//                   return SizedBox(
//                     width: 60, // Adjust width as needed
//                     child: TextField(
//                       controller: otpControllers[index],
//                       keyboardType: TextInputType.number,
//                       maxLength: 1,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         counterText: "",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[100],
//                       ),
//                       onChanged: (value) {
//                         if (value.length == 1 && index < 3) {
//                           FocusScope.of(context).nextFocus(); // Move to the next field
//                         } else if (value.isEmpty && index > 0) {
//                           FocusScope.of(context).previousFocus(); // Move to the previous field
//                         }
//                       },
//                     ),
//                   );
//                 }),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // TODO: Verify OTP and navigate
//                     String otp = otpControllers.map((controller) => controller.text).join();
//                     // Use the otp variable for verification
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Verify OTP',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     // TODO: Resend OTP
//                   },
//                   child: const Text(
//                     "Didn't receive the code? Resend",
//                     style: TextStyle(color: Colors.deepPurple),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// home


// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
//
// class DriverBookingHomeScreen extends StatefulWidget {
//   const DriverBookingHomeScreen({super.key});
//
//   @override
//   State<DriverBookingHomeScreen> createState() => _DriverBookingHomeScreenState();
// }
//
// class _DriverBookingHomeScreenState extends State<DriverBookingHomeScreen> {
//   int _selectedIndex = 0;
//
//   final List<Map<String, dynamic>> _services = [
//     {"title": "Book a Driver", "icon": Icons.person_pin_circle},
//     {"title": "Garage Pickup & Drop", "icon": Icons.local_shipping},
//     {"title": "RTA Vehicle Inspection", "icon": Icons.car_repair},
//     {"title": "Parking Reservation", "icon": Icons.local_parking},
//     {"title": "Car Wash", "icon": Icons.local_car_wash},
//     {"title": "Car Rentals", "icon": Icons.directions_car},
//     {"title": "Goods Delivery", "icon": Icons.delivery_dining},
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: SafeArea(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.deepPurple.shade50,
//                       child: const Icon(Icons.person, color: Colors.deepPurpleAccent),
//                     ),
//                     const SizedBox(width: 12),
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Welcome Back 👋",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         Text(
//                           "Ashoka", // you can dynamically use user's name here
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     'assets/images/driver_app_dummy_logo.jpg',
//                     height: 70,
//                     width: 70,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Our Services",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3),
//               const SizedBox(height: 16),
//               ..._services.map((service) => GestureDetector(
//                 onTap: () {
//                   // Navigate to service page
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 16.0),
//                   padding: const EdgeInsets.all(18.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 10,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 26,
//                             backgroundColor: Colors.deepPurple.shade50,
//                             child: Icon(
//                               service['icon'],
//                               color: Colors.deepPurpleAccent,
//                               size: 28,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Text(
//                               service['title'],
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         'Pay-Per-Minute | Hourly Booking',
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.deepPurpleAccent,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: const Text('Book Now'),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: OutlinedButton(
//                               onPressed: () {},
//                               style: OutlinedButton.styleFrom(
//                                 side: BorderSide(color: Colors.deepPurpleAccent),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'Schedule',
//                                 style: TextStyle(color: Colors.deepPurpleAccent),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
//               ))
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.deepPurpleAccent,
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.directions_car),
//             label: "Cars",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.card_giftcard),
//             label: "Rewards",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore),
//             label: "Trips",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }



//


// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Define deep purple color scheme
//     final deepPurpleTheme = ThemeData(
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: Colors.deepPurple,
//         brightness: Theme.of(context).brightness,
//       ),
//     );
//
//     return Theme(
//       data: deepPurpleTheme,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 1,
//           centerTitle: true,
//           title: const Text(
//             'Profile',
//             style: TextStyle(
//               color: Colors.deepPurple,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.account_circle,
//                           size: 120,
//                           color: Colors.deepPurple,
//                         ),
//                         const SizedBox(height: 20),
//                         Column(
//                           children: [
//                             Text(
//                               'Nicolas Adams',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 color: Colors.deepPurpleAccent,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               '+9714533232345',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Theme.of(context).colorScheme.onSurface,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 30),
//                         Column(
//                           children: [
//                             _buildProfileOption(
//                               context,
//                               icon: Icons.privacy_tip,
//                               text: 'Privacy',
//                             ),
//                             _buildProfileOption(
//                               context,
//                               icon: Icons.history,
//                               text: 'Purchase History',
//                             ),
//                             _buildProfileOption(
//                               context,
//                               icon: Icons.help,
//                               text: 'Help & Support',
//                             ),
//                             _buildProfileOption(
//                               context,
//                               icon: Icons.settings,
//                               text: 'Settings',
//                             ),
//                             _buildProfileOption(
//                               context,
//                               icon: Icons.person_add,
//                               text: 'Invite a Friend',
//                             ),
//                             _buildProfileOption(
//                               context,
//                               icon: Icons.logout,
//                               text: 'Logout',
//                               isLast: true,
//                             ),
//                             const SizedBox(height: 20),
//                           ],
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
//
//   Widget _buildProfileOption(
//       BuildContext context, {
//         required IconData icon,
//         required String text,
//         bool isLast = false,
//       }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: isLast ? 0 : 15),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(
//           icon,
//           color: Colors.deepPurple,
//         ),
//         title: Text(
//           text,
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.onSurface,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         trailing: Icon(
//           Icons.arrow_forward_ios,
//           size: 16,
//           color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//         ),
//         onTap: () {},
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
//
// class AddCarScreen extends StatelessWidget {
//   const AddCarScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Add Your Car',
//           style: TextStyle(
//             color: Colors.deepPurple,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             // Add your input fields here like:
//             // _buildInputLabel + _buildInputField
//             SizedBox(height: 500), // Example space for form inputs
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//         child: SizedBox(
//           width: double.infinity,
//           height: 55,
//           child: ElevatedButton(
//             onPressed: () {
//               // Handle add car logic
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.deepPurple,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               'Add Car',
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//  entire customer app ui


// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
//
// // Screens for each navigation item
// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Center(child: Text('Home Screen'));
// //   }
// // }
//
// class DriverBookingHomeScreen extends StatefulWidget {
//   const DriverBookingHomeScreen({super.key});
//
//   @override
//   State<DriverBookingHomeScreen> createState() => _DriverBookingHomeScreenState();
// }
//
// class _DriverBookingHomeScreenState extends State<DriverBookingHomeScreen> {
//   int _selectedIndex = 0;
//
//   // Screens corresponding to each navigation item
//   final List<Widget> _screens = [
//     const HomeContent(), // We'll keep your original home content here
//     const AddCarScreen(),
//     const RewardsScreen(),
//     const TripsScreen(),
//     const ProfileScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _screens[_selectedIndex], // Display the selected screen
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.deepPurpleAccent,
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.directions_car),
//             label: "Cars",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.card_giftcard),
//             label: "Rewards",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore),
//             label: "Trips",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Your original home content as a separate widget
// class HomeContent extends StatelessWidget {
//   const HomeContent({super.key});
//
//   final List<Map<String, dynamic>> _services = const [
//     {"title": "Book a Driver", "icon": Icons.person_pin_circle},
//     {"title": "Garage Pickup & Drop", "icon": Icons.local_shipping},
//     {"title": "RTA Vehicle Inspection", "icon": Icons.car_repair},
//     {"title": "Parking Reservation", "icon": Icons.local_parking},
//     {"title": "Car Wash", "icon": Icons.local_car_wash},
//     {"title": "Car Rentals", "icon": Icons.directions_car},
//     {"title": "Goods Delivery", "icon": Icons.delivery_dining},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         PreferredSize(
//           preferredSize: const Size.fromHeight(80),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: SafeArea(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.deepPurple.shade50,
//                         child: const Icon(Icons.person, color: Colors.deepPurpleAccent),
//                       ),
//                       const SizedBox(width: 12),
//                       const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Welcome Back 👋",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black54,
//                             ),
//                           ),
//                           Text(
//                             "Ashoka",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.asset(
//                       'assets/images/driver_app_dummy_logo.jpg',
//                       height: 70,
//                       width: 70,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Our Services",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.3),
//                   const SizedBox(height: 16),
//                   ..._services.map((service) => GestureDetector(
//                     onTap: () {
//                       // Navigate to service page
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 16.0),
//                       padding: const EdgeInsets.all(18.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 26,
//                                 backgroundColor: Colors.deepPurple.shade50,
//                                 child: Icon(
//                                   service['icon'],
//                                   color: Colors.deepPurpleAccent,
//                                   size: 28,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: Text(
//                                   service['title'],
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                               const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           const Text(
//                             'Pay-Per-Minute | Hourly Booking',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.deepPurpleAccent,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: const Text('Book Now',style: TextStyle(color: Colors.white),),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: OutlinedButton(
//                                   onPressed: () {},
//                                   style: OutlinedButton.styleFrom(
//                                     side: BorderSide(color: Colors.deepPurpleAccent),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     'Schedule',
//                                     style: TextStyle(color: Colors.deepPurple),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
//                   ))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
// class AddCarScreen extends StatelessWidget {
//   const AddCarScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Add Your Car',
//           style: TextStyle(
//             color: Colors.deepPurple,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             // Add your input fields here like:
//             // _buildInputLabel + _buildInputField
//             SizedBox(height: 500), // Example space for form inputs
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//         child: SizedBox(
//           width: double.infinity,
//           height: 55,
//           child: ElevatedButton(
//             onPressed: () {
//               // Handle add car logic
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.deepPurple,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               'Add Car',
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class RewardsScreen extends StatelessWidget {
//   const RewardsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Your Rewards',
//           style: TextStyle(
//             color: Colors.deepPurple,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             // Add your input fields here like:
//             // _buildInputLabel + _buildInputField
//             SizedBox(height: 500), // Example space for form inputs
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//
//       ),
//     );
//   }
// }
//
// class TripsScreen extends StatelessWidget {
//   const TripsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Your Trips',
//           style: TextStyle(
//             color: Colors.deepPurple,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             // Add your input fields here like:
//             // _buildInputLabel + _buildInputField
//             SizedBox(height: 500), // Example space for form inputs
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//
//       ),
//     );
//   }
// }
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final deepPurpleTheme = ThemeData(
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: Colors.deepPurple,
//         brightness: theme.brightness,
//       ),
//     );
//
//     return Theme(
//       data: deepPurpleTheme,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 1,
//           backgroundColor: Colors.white,
//           title: const Text(
//             'Profile',
//             style: TextStyle(
//               color: Colors.deepPurple,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.deepPurple.shade50,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.deepPurple.withOpacity(0.1),
//                         blurRadius: 12,
//                         offset: const Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   child: const Icon(Icons.account_circle, size: 100, color: Colors.deepPurple),
//                 ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Nicolas Adams',
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ).animate().fadeIn(duration: 500.ms),
//                 const SizedBox(height: 4),
//                 Text(
//                   '+9714533232345',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: theme.colorScheme.onSurface.withOpacity(0.6),
//                   ),
//                 ).animate().fadeIn(duration: 600.ms),
//                 const SizedBox(height: 30),
//                 Column(
//                   children: [
//                     _buildIndividualCard(context, Icons.payment, 'Payment Method'),
//                     _buildIndividualCard(context, Icons.location_on, 'Saved Locations'),
//                     _buildIndividualCard(context, Icons.help_outline, 'Help'),
//                     _buildIndividualCard(context, Icons.description, 'Terms & Conditions'),
//                     _buildIndividualCard(context, Icons.privacy_tip, 'Privacy and Policies'),
//                     _buildIndividualCard(context, Icons.card_giftcard, 'Refer & Earn'),
//                     _buildIndividualCard(context, Icons.logout, 'Logout', isLast: true),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIndividualCard(BuildContext context, IconData icon, String text, {bool isLast = false}) {
//     return GestureDetector(
//       onTap: () {
//         // Navigation or action
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () {},
//           child: ListTile(
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             leading: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.deepPurple.shade50,
//               ),
//               child: Icon(icon, color: Colors.deepPurple),
//             ),
//             title: Text(
//               text,
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.onSurface,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//             trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
//           ),
//         ),
//       ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.95, 0.95)),
//     );
//   }
// }



// welcome screen without logo



// import 'package:flutter/material.dart';
//
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Expanded(
//             flex: 6,
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: Image.asset(
//                     'assets/images/welcome_saqer_services_screen_img.jpg', // replace with your asset path
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     alignment: Alignment.topCenter,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min, // Important for proper alignment
//                       children: [
//                         const Text(
//                           'Welcome to',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 18, // Slightly smaller than the main title
//                             fontWeight: FontWeight.w500, // Medium weight
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 4), // Small gap between texts
//                         const Text(
//                           'SAQER SERVICES',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepPurple,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(top:41.0),
//                     child: Text(
//                       'Continue as',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   SizedBox(
//                     width: double.infinity,
//                     child: OutlinedButton(
//                       onPressed: () {},
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: Colors.black),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: const Text(
//                         'I am a Customer',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: const Text('I am a Driver',style: TextStyle(color: Colors.white),),
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


// good ui


// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
//
// class OtpScreen extends StatelessWidget {
//   const OtpScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),
//
//               /// Heading
//               Text(
//                 'Enter OTP',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ).animate().fadeIn().slideY(begin: 0.3),
//
//               const SizedBox(height: 12),
//
//               /// Subtext
//               Text(
//                 'Enter the One-Time Password (OTP) sent to your mobile number. Please check your messages and verify your identity below.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey[600], fontSize: 14),
//               ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
//
//               const SizedBox(height: 32),
//
//               /// OTP Boxes
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(4, (index) => _buildOtpBox(context, index)),
//               ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),
//
//               const SizedBox(height: 40),
//
//               /// Verify Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 3,
//                   ),
//                   child: const Text(
//                     'Verify',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ).animate().fadeIn(delay: 600.ms).scale(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// OTP Box UI
//   Widget _buildOtpBox(BuildContext context, int index) {
//     return Container(
//       width: 55,
//       height: 55,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade400),
//       ),
//       child: TextField(
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         maxLength: 1,
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         decoration: const InputDecoration(
//           counterText: '',
//           border: InputBorder.none,
//         ),
//         onChanged: (value) {
//           // Optional: move to next field
//         },
//       ),
//     );
//   }
// }
//
//
//
// phone numberscreen ui good
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
//
// class PhoneNumberScreen extends StatelessWidget {
//   const PhoneNumberScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController phoneController = TextEditingController();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),
//
//               /// Heading
//               Text(
//                 'Enter Phone Number',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ).animate().fadeIn().slideY(begin: 0.3),
//
//               const SizedBox(height: 12),
//
//               /// Subtext
//               Text(
//                 'Please enter your mobile number. We’ll send you an OTP code to verify your identity.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//               ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
//
//               const SizedBox(height: 32),
//
//               /// Phone Input Field
//               /// Phone Input Field with UAE flag
//               TextField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//                 decoration: InputDecoration(
//                   labelText: 'Mobile Number',
//                   counterText: '',
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Image.asset(
//                           'assets/images/dubai_flag_saqer_ser.jpg',
//                           width: 24,
//                           height: 24,
//                         ),
//                         const SizedBox(width: 6),
//                         const Text(
//                           '+971',
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),
//
//               const SizedBox(height: 40),
//
//               /// Continue Button (Frontend only)
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Frontend only — no action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 3,
//                   ),
//                   child: const Text(
//                     'Continue',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ).animate().fadeIn(delay: 600.ms).scale(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//



//



import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row – Profile + Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: AssetImage('assets/images/driver_avatar.png'), // Replace with your asset
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome, Ashok',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.circle, color: Colors.green, size: 10),
                              const SizedBox(width: 4),
                              Text(
                                'Online',
                                style: TextStyle(color: Colors.green[700]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  )
                ],
              ).animate().fadeIn().slideY(begin: 0.3),

              const SizedBox(height: 24),

              /// Current Location
              Row(
                children: const [
                  Icon(Icons.location_on_outlined, color: Colors.redAccent),
                  SizedBox(width: 6),
                  Text(
                    'Downtown Dubai',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 24),

              /// Active Booking Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.directions_car, size: 30, color: Colors.deepPurple),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'No active bookings.\nStand by for the next request.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

              const SizedBox(height: 24),

              /// Today's Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(Icons.monetization_on, 'Earnings', 'AED 240'),
                  _buildStatCard(Icons.star, 'Rating', '4.8'),
                  _buildStatCard(Icons.check_circle, 'Jobs', '5'),
                ],
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

              const SizedBox(height: 24),

              /// Next Service Section
              const Text(
                'Upcoming Services',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ).animate().fadeIn(delay: 600.ms),

              const SizedBox(height: 12),
              Column(
                children: [
                  _buildServiceTile(Icons.build, 'Garage Pickup – Toyota Camry', '10:30 AM'),
                  _buildServiceTile(Icons.local_car_wash, 'Car Wash – BMW X5', '1:00 PM'),
                  _buildServiceTile(Icons.delivery_dining, 'Goods Delivery – JLT Area', '3:15 PM'),
                ],
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable Stat Card
  Widget _buildStatCard(IconData icon, String label, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.deepPurple),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  /// Reusable Service Tile
  Widget _buildServiceTile(IconData icon, String title, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        subtitle: Text('Scheduled at $time'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}







