
// ======================================================
// REUSABLE EMPLOYEE CARD
// CONST OPTIMIZATION
// ======================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/employee.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  final String employeeType;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.employeeType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(employee.name),
        subtitle: Text(employeeType),
        trailing: Text("₹${employee.salary}"),
      ),
    );
  }
}