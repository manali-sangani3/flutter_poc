import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Demo')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              key: const Key('emailField'),
              controller: emailController,
            ),

            TextField(
              key: const Key('passwordField'),
              controller: passwordController,
            ),

            ElevatedButton(
              key: const Key('loginButton'),

              onPressed: () {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.length >= 6) {
                  setState(() {
                    message = 'Login Success';
                  });
                } else {
                  setState(() {
                    message = 'Invalid Credentials';
                  });
                }
              },

              child: const Text('Login'),
            ),

            Text(message),
          ],
        ),
      ),
    );
  }
}
