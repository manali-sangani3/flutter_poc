import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_poc/cubit/employee_cubit.dart';
import 'package:flutter_poc/cubit/employee_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmployeeCubit Tests', () {
    blocTest<EmployeeCubit, EmployeeState>(
      'emits loading and loaded states',

      build: () => EmployeeCubit(),

      act: (cubit) {
        cubit.addEmployee("John");
      },
      wait: const Duration(seconds: 2),
      expect: () => [isA<EmployeeLoading>(), isA<EmployeeLoaded>()],
    );
  });
}
