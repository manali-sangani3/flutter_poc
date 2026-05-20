import 'package:flutter/material.dart';

class CounterDemoScreen
    extends StatefulWidget {

  const CounterDemoScreen({
    super.key,
  });

  @override
  State<CounterDemoScreen>
  createState() =>
      _CounterDemoScreenState();
}

class _CounterDemoScreenState
    extends State<CounterDemoScreen> {

  int counter = 0;

  /// Lifting State Up
  void incrementCounter() {

    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text(
          "Counter Demo",
        ),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Text(
              "$counter",

              style:
              const TextStyle(
                fontSize: 40,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(

              onPressed:
              incrementCounter,

              child:
              const Text(
                "Increment",
              ),
            ),
          ],
        ),
      ),
    );
  }
}