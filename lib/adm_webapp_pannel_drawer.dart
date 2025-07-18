import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/webapp_app_banner_image_upload.dart';
import 'package:sadhana_cart/webapp_logo_upload_screen.dart';
import 'package:sadhana_cart/webapp_mission_image_upload_screen.dart';


class WebAdminDashboard extends StatefulWidget {
  const WebAdminDashboard({super.key});

  @override
  State<WebAdminDashboard> createState() => _WebAdminDashboardState();
}

class _WebAdminDashboardState extends State<WebAdminDashboard> {
  String _selectedPage = 'home';

  void _navigateTo(String page) {
    setState(() {
      _selectedPage = page;
    });
  }

  Widget _getPageContent() {
    switch (_selectedPage) {
      case 'upload_banner':
        return const WebBannerUploadPage();
      case 'change_logo':
        return const WebLogoUploadPage();
      case 'mission_image':
        return const WebMissionUploadPage();
      default:
        return const Center(
          child: Text(
            'Welcome to Admin Panel',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
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
              const Text(
                'Admin Dashboard',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              HoverButton(
                label: 'Upload Banner',
                icon: Icons.cloud_upload_outlined,
                onPressed: () => _navigateTo('upload_banner'),
              ),
              const SizedBox(width: 16),
              HoverButton(
                label: 'Change Logo',
                icon: Icons.image_outlined,
                onPressed: () => _navigateTo('change_logo'),
              ),
              HoverButton(
                label: 'Mission Image',
                icon: Icons.image_outlined,
                onPressed: () => _navigateTo('mission_image'),
              ),
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _getPageContent(),
      ),
    );
  }
}
class HoverButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const HoverButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.blue[50] : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, color: Colors.blueAccent),
          label: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

