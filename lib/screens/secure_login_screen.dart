import 'package:flutter/material.dart';

class SecureLoginScreen extends StatefulWidget {
  const SecureLoginScreen({super.key});

  @override
  State<SecureLoginScreen> createState() => _SecureLoginScreenState();
}

class _SecureLoginScreenState extends State<SecureLoginScreen> {
  final controller = TextEditingController();

  String error = '';

  void validatePin() {
    if (controller.text == "1234") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Access Granted")));
    } else {
      setState(() {
        error = "Invalid PIN";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Secure Login")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: controller,

              obscureText: true,

              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: "PIN",

                errorText: error.isEmpty ? null : error,

                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: validatePin, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
