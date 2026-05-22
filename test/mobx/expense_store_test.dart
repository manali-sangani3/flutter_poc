import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_poc/model/expense_model.dart';
import 'package:flutter_poc/stores/expense_store.dart';

void main() {

  group('MobX Tests', () {

    test('Expense added successfully',
            () async {

          final store = ExpenseStore();

          await store.addExpense(
            ExpenseModel(
              title: "Food",
              amount: 200,
              category: "Food",
            ),
          );

          expect(
            store.expenses.length,
            1,
          );
        });

    test('Total expense calculated',
            () async {

          final store = ExpenseStore();

          await store.addExpense(
            ExpenseModel(
              title: "Travel",
              amount: 500,
              category: "Travel",
            ),
          );

          expect(
            store.totalExpense,
            500,
          );
        });
  });
}