import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sadhana_cart/shedule_your_walk.dart';
import 'package:sadhana_cart/step_history_screen.dart';

class FootstepApp extends StatelessWidget {
  const FootstepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Footstep Tracker',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.tealAccent,
          secondary: Colors.teal,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const FootstepScreen(),
    );
  }
}

class FootstepScreen extends StatefulWidget {
  const FootstepScreen({super.key});

  @override
  _FootstepScreenState createState() => _FootstepScreenState();
}

class _FootstepScreenState extends State<FootstepScreen> {
  int _steps = 0;
  int _dailyGoal = 5000;
  String _status = 'Initializing...';
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  int _baseSteps = 0;
  int _lastRawStepCount = 0;


  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      initPlatformState();
    } else {
      setState(() {
        _status = 'Permission denied';
      });
    }
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _stepCountStream = Pedometer.stepCountStream;

    _stepCountStream.listen((StepCount event) {
      print("New steps: ${event.steps}");
      _onStepCount(event);
    }).onError((error) {
      setState(() {
        _status = 'Step Count Error: $error';
      });
    });

    _pedestrianStatusStream.listen((PedestrianStatus event) {
      print("Pedestrian status: ${event.status}");
      _onPedestrianStatusChanged(event);
    }).onError((error) {
      print("Pedestrian Status error: $error");
    });
  }

  // void _onStepCount(StepCount event) {
  //   setState(() {
  //     _steps = event.steps;
  //     _status = 'Counting steps...';
  //   });
  //   _saveStepsToFirestore();
  // }

  void _onStepCount(StepCount event) {
    _lastRawStepCount = event.steps;
    setState(() {
      _steps = event.steps - _baseSteps;
      _status = 'Counting steps...';
    });
  }



  void _onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }
  //
  // void _saveStepsToFirestore() async {
  //   try {
  //     final stepsRef = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc('demo_user')
  //         .collection('step_history');
  //
  //     await stepsRef.add({
  //       'steps': _steps,
  //       'timestamp': Timestamp.now(),
  //     });
  //   } catch (e) {
  //     print("Firestore error: $e");
  //   }
  // }

  void _saveStepsToFirestore() async {
    try {
      final stepsRef = FirebaseFirestore.instance
          .collection('users')
          .doc('demo_user')
          .collection('steps');

      await stepsRef.add({
        'steps': _steps,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print("Firestore error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    double percent = (_steps / _dailyGoal).clamp(0, 1);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.tealAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.teal),
              title: const Text('Schedule Your Walk'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ScheduleWalkPage(),
                    transitionsBuilder: (_, animation, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        )),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StepHistoryScreen()),
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: const Text("🚶‍♂️ Step Tracker"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: initPlatformState,
            tooltip: 'Reinitialize pedometer',
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Stay Active! 💪',
                      textStyle: const TextStyle(fontSize: 24, color: Colors.tealAccent)),
                  WavyAnimatedText('Track Your Steps 🚶',
                      textStyle: const TextStyle(fontSize: 24, color: Colors.tealAccent)),
                ],
                repeatForever: true,
              ),
              const SizedBox(height: 20),
              Text(
                _status,
                style: TextStyle(
                  color: _status.contains('Error') || _status.contains('denied')
                      ? Colors.red
                      : Colors.tealAccent,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 15.0,
                animation: true,
                percent: percent,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$_steps",
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Steps",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.tealAccent,
                backgroundColor: Colors.teal.withOpacity(0.2),
              ),
              const SizedBox(height: 40),
              Text("Daily Goal: $_dailyGoal steps", style: const TextStyle(fontSize: 16)),
              Slider(
                value: _dailyGoal.toDouble(),
                min: 1000,
                max: 20000,
                divisions: 38,
                label: "$_dailyGoal",
                onChanged: (value) {
                  setState(() {
                    _dailyGoal = value.toInt();
                  });
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _baseSteps = _lastRawStepCount;
                        _steps = 0;
                        _status = 'Counter reset';
                      });
                      _saveStepsToFirestore();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reset Steps"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_steps <= 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("❌ You need to walk more than 1 step to save!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        _saveStepsToFirestore();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("✅ Steps saved to Firestore!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        setState(() {
                          _baseSteps = _lastRawStepCount;
                          _steps = 0;
                        });
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save Steps"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}