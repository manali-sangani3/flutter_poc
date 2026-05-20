import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/employee_model.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeInitial());

  final List<EmployeeModel> employees = [];

  Future<void> addEmployee(String name) async {
    try {
      emit(EmployeeLoading());

      await Future.delayed(const Duration(seconds: 1));

      employees.add(EmployeeModel(name: name));

      emit(EmployeeLoaded(List.from(employees)));
    } catch (e) {
      emit(EmployeeError("Failed to add employee"));
    }
  }

  void toggleEmployee(int index) {
    if (state is EmployeeLoaded) {
      employees[index].isActive = !employees[index].isActive;

      emit(EmployeeLoaded(List.from(employees)));
    }
  }

  void removeEmployee(int index) {
    employees.removeAt(index);

    emit(EmployeeLoaded(List.from(employees)));
  }
}
