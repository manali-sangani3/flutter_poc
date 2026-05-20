import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/employee_cubit.dart';
import '../model/employee_model.dart';

class EmployeeTile extends StatelessWidget {
  final EmployeeModel employee;
  final int index;

  const EmployeeTile({
    super.key,
    required this.employee,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(employee.name),

      subtitle: Text(
        employee.isActive
            ? "Active"
            : "Inactive",
      ),

      leading: Switch(
        value: employee.isActive,
        onChanged: (_) {
          context
              .read<EmployeeCubit>()
              .toggleEmployee(index);
        },
      ),

      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          context
              .read<EmployeeCubit>()
              .removeEmployee(index);
        },
      ),
    );
  }
}