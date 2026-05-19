import 'package:flutter/material.dart';
import 'package:flutter_poc/screens/home_screen.dart';
import 'package:flutter_poc/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Default Theme
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      title: 'Employee Salary Tracker',
      home: HomeScreen(
        onThemeChanged: toggleTheme,
        isDark: isDark,
      ),
    );
  }
}
