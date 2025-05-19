import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/dream/customer_video_cart.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .where('category', isEqualTo: category)
            .snapshots(),
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