import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../stores/expense_store.dart';
import '../widgets/expense_input.dart';
import '../widgets/expense_tile.dart';
import '../widgets/total_balance.dart';

// MobX is Reactive Because UI automatically reacts to observable state changes without manual listeners.

/*
autorun
Autorun will run every time specific observable changes.

autorun((_) {
  print(counter.value);
});
 */
class ExpenseScreen extends StatefulWidget {
  ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final ExpenseStore store = ExpenseStore();

  late ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = reaction((_) => store.totalExpense, (value) {
      debugPrint('Total Changed: $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MobX Expense Tracker")),

      body: Column(
        children: [
          ExpenseInput(store: store),

          TotalBalance(store: store),

          Expanded(child: ExpenseTile(store: store)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    disposer();

    super.dispose();
  }
}
