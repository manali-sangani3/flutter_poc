import 'package:flutter/material.dart';

import '../services/mock_auth_service.dart';
import '../widgets/security_utils.dart';

class SecureTestingScreen extends StatefulWidget {
  const SecureTestingScreen({super.key});

  @override
  State<SecureTestingScreen> createState() => _SecureTestingScreenState();
}

class _SecureTestingScreenState extends State<SecureTestingScreen> {
  final authService = MockAuthService();

  String result = '';

  Future<void> login() async {
    final token = await authService.login("demo@gmail.com", "123456");

    setState(() {
      result = "Secure Login Success";
    });

    /// SAFE LOGGING
    debugPrint("Authentication completed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Testing & Security Demo")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text("Masked Card"),

            Text(SecurityUtils.maskCard("1234567812345678")),

            const SizedBox(height: 20),

            const Text("Masked Email"),

            Text(SecurityUtils.maskEmail("demo@gmail.com")),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: login,

              child: const Text("Mock Secure Login"),
            ),

            const SizedBox(height: 20),

            Text(result),
          ],
        ),
      ),
    );
  }
}
