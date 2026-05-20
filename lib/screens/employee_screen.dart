import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/employee_cubit.dart';
import '../cubit/employee_state.dart';
import '../widgets/employee_input.dart';
import '../widgets/employee_tile.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cubit Advanced Demo")),
      body: Column(
        children: [
          const EmployeeInput(),

          Expanded(
            child: BlocConsumer<EmployeeCubit, EmployeeState>(
              listener: (context, state) {

                if (state is EmployeeLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Employee Updated")),
                  );
                }

                if (state is EmployeeError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },

              builder: (context, state) {
                if (state is EmployeeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is EmployeeLoaded) {
                  if (state.employees.isEmpty) {
                    return const Center(child: Text("No Employees"));
                  }

                  return ListView.builder(
                    itemCount: state.employees.length,
                    itemBuilder: (context, index) {
                      return EmployeeTile(
                        employee: state.employees[index],
                        index: index,
                      );
                    },
                  );
                }

                if (state is EmployeeError) {
                  return Center(child: Text(state.message));
                }

                return const Center(child: Text("Add Employee"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
