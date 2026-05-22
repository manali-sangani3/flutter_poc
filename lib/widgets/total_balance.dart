import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../stores/expense_store.dart';

class TotalBalance
    extends StatelessWidget {

  final ExpenseStore store;

  const TotalBalance({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {

    return Observer(
      builder: (_) {
        return Padding(
          padding:
          const EdgeInsets.all(20),

          child: Text(
            "Total Expense: ₹${store.totalExpense}",

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}