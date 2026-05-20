import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key});

  @override
  Widget build(BuildContext context) {
    // Listens to provider changes and rebuilds only specific widgets.
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        if (provider.tasks.isEmpty) {
          return const Center(child: Text("No Tasks Added"));
        }

        return ListView.builder(
          itemCount: provider.tasks.length,
          itemBuilder: (context, index) {
            final task = provider.tasks[index];

            return ListTile(
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (_) {
                  provider.toggleTask(index);
                },
              ),

              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),

              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  provider.removeTask(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
