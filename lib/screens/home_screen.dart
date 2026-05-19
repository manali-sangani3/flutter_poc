import 'package:flutter/material.dart';
import 'package:flutter_poc/screens/employee_salary_screen.dart';
import 'package:flutter_poc/screens/task_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final demos = [
      {
        "title": "Core Dart & Programming",
        "screen": const EmployeeSalaryScreen(),
      },
      {
        "title":
            "Asynchronous & Concurrent Programming, UI Architecture & Advanced Rendering",
        "screen": const TaskScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Upskilling"),
        actions: [
          IconButton(
            onPressed: onThemeChanged,

            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),

              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },

              child: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,

                key: ValueKey(isDark),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: demos.length,
        itemBuilder: (_, index) {
          final item = demos[index];

          return ListTile(
            title: Text(item["title"] as String),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item["screen"] as Widget),
              );
            },
          );
        },
      ),
    );
  }
}
