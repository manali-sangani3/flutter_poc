import 'package:flutter/material.dart';

class TestingDemoScreen extends StatefulWidget {
  const TestingDemoScreen({super.key});

  @override
  State<TestingDemoScreen> createState() => _TestingDemoScreenState();
}

class _TestingDemoScreenState extends State<TestingDemoScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testing Demo')),

      body: Center(child: Text('$counter', key: const Key('counterText'))),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
