import 'package:flutter/material.dart';
import 'package:flutter_poc/screens/employee_salary_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Salary Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const EmployeeSalaryScreen(),
    );
  }
}
