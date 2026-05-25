import 'package:flutter/material.dart';

import 'package:flutter_poc/model/employee.dart';
import 'package:flutter_poc/widgets/employee_card.dart';
import 'package:flutter_poc/widgets/info_card.dart' show infoCard;

class EmployeeSalaryScreen extends StatefulWidget {
  const EmployeeSalaryScreen({super.key});

  @override
  State<EmployeeSalaryScreen> createState() => _EmployeeSalaryScreenState();
}

class _EmployeeSalaryScreenState extends State<EmployeeSalaryScreen> {
  // ======================================================
  // MEMORY OPTIMIZATION
  // ======================================================

  final TextEditingController nameController = TextEditingController();

  final TextEditingController salaryController = TextEditingController();

  final FocusNode nameFn = FocusNode();

  final FocusNode salaryFn = FocusNode();

  final ValueNotifier<double> totalSalaryNotifier = ValueNotifier<double>(0);

  // ======================================================
  // GENERICS + COLLECTIONS
  // ======================================================

  final List<Employee> employees = [
    Developer(id: 1, name: "Emily", salary: 50000, technology: "Flutter"),
    Manager(id: 2, name: "John", salary: 70000, teamSize: 10),
  ];

  // ======================================================
  // INIT STATE
  // ======================================================

  @override
  void initState() {
    super.initState();

    calculateTotalSalary();

    debugPrint("Screen Initialized");
  }

  // ======================================================
  // DISPOSE
  // ======================================================

  @override
  void dispose() {
    nameController.dispose();

    salaryController.dispose();

    totalSalaryNotifier.dispose();

    super.dispose();
  }

  // ======================================================
  // FUNCTIONAL PROGRAMMING
  // ======================================================

  void calculateTotalSalary() {
    final total = employees
        .map((e) => e.salary)
        .fold(0.0, (prev, element) => prev + element); // Reduce list into single value

    totalSalaryNotifier.value = total;
  }

  // ======================================================
  // ADD EMPLOYEE
  // ======================================================

  void addEmployee() {
    if (nameController.text.isEmpty || salaryController.text.isEmpty) {
      return;
    }

    final employee = Developer(
      id: employees.length + 1,
      name: nameController.text,
      salary: double.parse(salaryController.text),
      technology: "Flutter",
    );

    setState(() {
      employees.add(employee);
    });

    calculateTotalSalary();

    nameController.clear();
    salaryController.clear();
  }

  // ======================================================
  // ADVANCED DART
  // RECORDS Dart Records for multiple return values without creating an additional model class
  // ======================================================

  (String, double) highestSalaryEmployee() {
    employees.sort((a, b) => b.salary.compareTo(a.salary)); // desc order

    return (employees.first.name, employees.first.salary);
  }

  // ======================================================
  // PATTERN MATCHING
  // ======================================================

  String employeeType(Employee emp) {
    return switch (emp) {
      Developer() => "Developer (${emp.technology})",

      Manager() => "Manager (Team: ${emp.teamSize})",

      _ => "Unknown",
    };
  }

  // ======================================================
  // GENERIC METHOD
  // ======================================================

  String printData<T>(T value) {
    return "Generic Value: $value";
  }

  @override
  Widget build(BuildContext context) {
    final highest = highestSalaryEmployee();

    // ======================================================
    // FUNCTIONAL PROGRAMMING
    // ======================================================

    final highEarners = employees.where((e) => e.salary > 60000).toList();

    final employeeNames = employees.map((e) => e.name).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Employee Salary Tracker")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // INPUT SECTION
            // ======================================================
            const Text(
              "Add Employee",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              focusNode: nameFn,
              decoration: const InputDecoration(
                labelText: "Employee Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: salaryController,
              focusNode: salaryFn,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Salary",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: addEmployee,
              child: const Text("Add Employee"),
            ),

            const SizedBox(height: 30),

            // ======================================================
            // MEMORY OPTIMIZATION
            // ======================================================
            const Text(
              "Total Salary",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ValueListenableBuilder<double>(
              valueListenable: totalSalaryNotifier,
              builder: (_, total, child) {
                return Text(
                  "₹${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // ======================================================
            // ADVANCED DART
            // ======================================================
            const Text(
              "Advanced Dart Features",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            infoCard(
              context: context,
              title: "Highest Salary Employee (Record)",
              value: "${highest.$1} : ₹${highest.$2}",
            ),

            infoCard(
              context: context,
              title: "Generic Method",
              value: printData<String>("Flutter Generics"),
            ),

            const SizedBox(height: 30),

            // ======================================================
            // FUNCTIONAL PROGRAMMING
            // ======================================================
            const Text(
              "Functional Programming",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            infoCard(
              context: context,
              title: "Employee Names (map)",
              value: employeeNames.toString(),
            ),

            infoCard(
              context: context,
              title: "High Earners (where)",
              value: highEarners.map((e) => e.name).toList().toString(),
            ),

            infoCard(
              context: context,
              title: "Total Salary (fold)",
              value: "₹${totalSalaryNotifier.value}",
            ),

            const SizedBox(height: 30),

            // ======================================================
            // EMPLOYEE LIST
            // ======================================================
            const Text(
              "Employee List",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ======================================================
            // PERFORMANCE OPTIMIZATION
            // LISTVIEW.BUILDER
            // ======================================================
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];

                return RepaintBoundary(
                  child: EmployeeCard(
                    employee: employee,
                    employeeType: employeeType(employee),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
// ======================================================
// INHERITANCE + POLYMORPHISM
// ======================================================

class Developer extends Employee {
  final String technology;

  Developer({
    required super.id,
    required super.name,
    required super.salary,
    required this.technology,
  });

  @override
  String getRole() {
    return "Developer";
  }
}

class Manager extends Employee {
  final int teamSize;

  Manager({
    required super.id,
    required super.name,
    required super.salary,
    required this.teamSize,
  });

  @override
  String getRole() {
    return "Manager";
  }
}
