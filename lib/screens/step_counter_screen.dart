import 'dart:async';

import 'package:flutter/material.dart';
import 'package:step_counter_plugin/step_counter_plugin.dart';

class StepCounterScreen extends StatefulWidget {
  const StepCounterScreen({super.key});

  @override
  State<StepCounterScreen> createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  int steps = 0;

  StreamSubscription<int>? _stepSubscription;

  @override
  void initState() {
    super.initState();

    _stepSubscription = StepCounterPlugin.steps.listen((value) {
      if (!mounted) return;

      setState(() {
        steps = value;
      });

      print("Steps: $value");
    });
  }

  @override
  void dispose() {
    _stepSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step Counter')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(Icons.directions_walk, size: 80),

            Text('$steps', style: const TextStyle(fontSize: 48)),

            const Text('Steps Today'),
          ],
        ),
      ),
    );
  }
}
