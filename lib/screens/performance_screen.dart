import 'package:flutter/material.dart';

import '../services/performance_service.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  String result = '';

  bool loading = false;

  Future<void> calculate() async {
    setState(() {
      loading = true;
    });

    final stopwatch = Stopwatch()..start();

    final sum = await PerformanceService.calculateSum(10000000);

    stopwatch.stop();

    setState(() {
      result =
          'Sum = $sum\n\n'
          'Time = '
          '${stopwatch.elapsedMilliseconds} ms';

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Native Performance')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            ElevatedButton(
              onPressed: calculate,

              child: const Text('Run Native Task'),
            ),

            const SizedBox(height: 20),

            if (loading) const CircularProgressIndicator(),

            Text(result),
          ],
        ),
      ),
    );
  }
}
