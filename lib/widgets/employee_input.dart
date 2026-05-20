import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/employee_cubit.dart';

class EmployeeInput extends StatefulWidget {
  const EmployeeInput({super.key});

  @override
  State<EmployeeInput> createState() =>
      _EmployeeInputState();
}

class _EmployeeInputState
    extends State<EmployeeInput> {
  final TextEditingController controller =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Employee Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              context
                  .read<EmployeeCubit>()
                  .addEmployee(controller.text);

              controller.clear();
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}