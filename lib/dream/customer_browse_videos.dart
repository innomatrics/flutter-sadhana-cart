import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/dream/customer_video_cart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VideoShare")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('videos').snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final videos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (ctx, i) => VideoCard(
              title: videos[i]['title'],
              category: videos[i]['category'],
              videoUrl: videos[i]['url'],
            ),
          );
        },
      ),
    );
  }
}

