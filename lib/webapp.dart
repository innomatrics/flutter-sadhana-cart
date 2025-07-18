// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sadhana_cart/webapp_screen_footer.dart';
//
// class StudyWebapp extends StatefulWidget {
//   const StudyWebapp({super.key});
//
//   @override
//   State<StudyWebapp> createState() => _StudyWebappState();
// }
//
// class _StudyWebappState extends State<StudyWebapp>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _rotationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _rotationController = AnimationController(
//       duration: const Duration(seconds: 10),
//       vsync: this,
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _rotationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             AnimatedBuilder(
//               animation: _rotationController,
//               builder: (context, child) {
//                 return Transform.rotate(
//                   angle: _rotationController.value * 2 * pi,
//                   child: child,
//                 );
//               },
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('adm')
//                     .doc('main')
//                     .collection('logos')
//                     .orderBy('timestamp', descending: true)
//                     .limit(1)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const SizedBox(
//                       width: 40,
//                       height: 40,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     );
//                   }
//
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Icon(Icons.image_not_supported, size: 40, color: Colors.grey);
//                   }
//
//                   final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
//                   final logoUrl = data['imageUrl'];
//
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       logoUrl,
//                       width: 40,
//                       height: 40,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.broken_image, size: 40),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               'Neutill',
//               style: TextStyle(
//                 color: Colors.blue.shade800,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: _AnimatedHomeButton(
//               onPressed: () {
//                 // TODO: Handle Home button action
//                 debugPrint("Home button clicked!");
//               },
//             ),
//           ),
//         ],
//       ),
// body: Column(
//   children: [
//     const SizedBox(height: 40),
//     const FooterScreen(),
//   ],
// ),
//     );
//   }
//
//  }
//
// class _AnimatedHomeButton extends StatefulWidget {
//   final VoidCallback onPressed;
//
//   const _AnimatedHomeButton({Key? key, required this.onPressed}) : super(key: key);
//
//   @override
//   State<_AnimatedHomeButton> createState() => _AnimatedHomeButtonState();
// }
//
// class _AnimatedHomeButtonState extends State<_AnimatedHomeButton> {
//   bool _hovering = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _hovering = true),
//       onExit: (_) => setState(() => _hovering = false),
//       child: AnimatedScale(
//         duration: const Duration(milliseconds: 200),
//         scale: _hovering ? 1.1 : 1.0,
//         child: ElevatedButton.icon(
//           onPressed: widget.onPressed,
//           icon: const Icon(Icons.home, size: 18),
//           label: const Text("Home"),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: _hovering ? Colors.blue[700] : Colors.blue[800],
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30),
//             ),
//             elevation: _hovering ? 6 : 2,
//             textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//         ),
//       ),
//     );
//   }
// }



//




import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/webapp_screen_footer.dart';
import 'package:sadhana_cart/webapp_home_screen.dart';
// Add other screen imports here

class StudyWebapp extends StatefulWidget {
  const StudyWebapp({super.key});

  @override
  State<StudyWebapp> createState() => _StudyWebappState();
}

class _StudyWebappState extends State<StudyWebapp>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _rotationController;
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  final List<String> _appBarTitles = ['Home', 'Learn', 'Explore', 'Account'];
  final List<Widget> _screens = [
    StudyWebappHome(), // Replace with actual widgets
    Center(child: Text('Learn Page')),
    Center(child: Text('Explore Page')),
    Center(child: Text('Account Page')),
  ];

  @override
  void initState() {
    super.initState();

    // Logo rotation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2 * pi,
                    child: child,
                  );
                },
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('adm')
                      .doc('main')
                      .collection('logos')
                      .orderBy('timestamp', descending: true)
                      .limit(1)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Icon(Icons.image_not_supported, size: 40, color: Colors.grey);
                    }

                    final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                    final logoUrl = data['imageUrl'];

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        logoUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 40),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Neutill',
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (isDesktop)
                Row(
                  children: List.generate(_appBarTitles.length, (index) {
                    final isSelected = _currentIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextButton(
                        onPressed: () => setState(() => _currentIndex = index),
                        style: TextButton.styleFrom(
                          foregroundColor: isSelected ? Colors.blue.shade900 : Colors.black87,
                        ),
                        child: Text(
                          _appBarTitles[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }),
                )
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
    );
  }
}

