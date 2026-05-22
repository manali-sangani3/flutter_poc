import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../stores/expense_store.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseStore store;

  const ExpenseTile({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Observer(
      // Listens to observable changes and rebuilds UI automatically.
      builder: (_) {
        if (store.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (store.filteredExpenses.isEmpty) {
          return const Center(child: Text("No Expenses"));
        }

        return ListView.builder(
          itemCount: store.filteredExpenses.length,

          itemBuilder: (context, index) {
            final expense = store.filteredExpenses[index];

            return ListTile(
              title: Text(expense.title),

              subtitle: Text(expense.category),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹${expense.amount}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      store.removeExpense(index);
                    },
                    icon: Icon(Icons.remove_circle),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
