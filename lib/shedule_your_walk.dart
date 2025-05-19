import 'package:flutter/material.dart';

class ScheduleWalkPage extends StatefulWidget {
  const ScheduleWalkPage({super.key});

  @override
  State<ScheduleWalkPage> createState() => _ScheduleWalkPageState();
}

class _ScheduleWalkPageState extends State<ScheduleWalkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📅 Schedule Your Walk"),
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.directions_walk, size: 80, color: Colors.teal),
                const SizedBox(height: 20),
                const Text(
                  "Set your walking time & goals here!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("🚧 Coming Soon..."),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  icon: const Icon(Icons.alarm),
                  label: const Text("Set Reminder"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
