import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StepHistoryScreen extends StatelessWidget {
  const StepHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyRef = FirebaseFirestore.instance
        .collection('users')
        .doc('demo_user')
        .collection('steps')
        .orderBy('timestamp', descending: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Steps History'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: historyRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data?.docs ?? [];

          if (data.isEmpty) {
            return const Center(child: Text('No step history found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final stepData = data[index];
              final steps = stepData['steps'];
              final timestamp = stepData['timestamp'] as Timestamp;
              final date = DateFormat('MMM dd, yyyy – hh:mm a').format(timestamp.toDate());

              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.directions_walk, color: Colors.white),
                  ),
                  title: Text('$steps steps',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(date),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
