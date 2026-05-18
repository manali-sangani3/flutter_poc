// ======================================================
// OOP IMPLEMENTATION
// ABSTRACTION
// ======================================================

abstract class Employee {
  final int id;
  final String name;
  final double salary;

  Employee({required this.id, required this.name, required this.salary});

  String getRole();
}
