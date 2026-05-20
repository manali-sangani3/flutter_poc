import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';

class TaskInput extends StatelessWidget {
  const TaskInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              // Access provider without listening for UI updates.
              controller: context.read<AppProvider>().controller,
              decoration: const InputDecoration(
                hintText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              context.read<AppProvider>().addTask(
                context.read<AppProvider>().controller.text,
              );

              context.read<AppProvider>().controller.clear();
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
// context.watch()
//
// Listens to provider changes and rebuilds widget automatically.