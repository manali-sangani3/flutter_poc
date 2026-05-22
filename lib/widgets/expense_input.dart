import 'package:flutter/material.dart';

import '../model/expense_model.dart';
import '../stores/expense_store.dart';

class ExpenseInput extends StatefulWidget {
  final ExpenseStore store;

  const ExpenseInput({super.key, required this.store});

  @override
  State<ExpenseInput> createState() => _ExpenseInputState();
}

class _ExpenseInputState extends State<ExpenseInput> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  String category = "Food";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),

      child: Column(
        children: [
          TextField(
            controller: titleController,

            decoration: const InputDecoration(hintText: "Expense Title"),
          ),

          TextField(
            controller: amountController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(hintText: "Amount"),
          ),

          const SizedBox(height: 20),

          DropdownMenu<String>(
            initialSelection: category,
            width: double.infinity,

            onSelected: (value) {
              setState(() {
                category = value!;
              });
            },

            dropdownMenuEntries: const [
              DropdownMenuEntry(value: "Food", label: "Food"),

              DropdownMenuEntry(value: "Travel", label: "Travel"),

              DropdownMenuEntry(value: "Shopping", label: "Shopping"),
            ],
          ),

          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              widget.store.addExpense(
                ExpenseModel(
                  title: titleController.text,

                  amount: double.parse(amountController.text),

                  category: category,
                ),
              );

              titleController.clear();
              amountController.clear();
            },

            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
