

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepCounterApp extends StatefulWidget {
  const StepCounterApp({super.key});

  @override
  _StepCounterAppState createState() => _StepCounterAppState();
}

class _StepCounterAppState extends State<StepCounterApp> {
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    _initPedometer();
  }

  void _initPedometer() {
    Pedometer.stepCountStream.listen((event) {
      setState(() {
        _steps = event.steps;
      });
    }, onError: (error) {
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Step Counter")),
        body: Center(
          child: Text(
            "Steps: $_steps",
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
