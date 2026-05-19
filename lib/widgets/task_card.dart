import 'package:flutter/material.dart';
import 'package:flutter_poc/theme/app_colors.dart';

import '../model/task_model.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final VoidCallback onComplete;

  const TaskCard({super.key, required this.task, required this.onComplete});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool completed = false;

  @override
  void initState() {
    completed = widget.task.completed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),

      margin: const EdgeInsets.symmetric(vertical: 8),

      decoration: BoxDecoration(
        color: completed ? AppColors.green100 : Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
      ),

      child: ListTile(
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),

          child: completed
              ? const Icon(
                  Icons.check_circle,
                  key: ValueKey(1),
                  color: AppColors.green,
                )
              : const Icon(Icons.radio_button_unchecked, key: ValueKey(2)),
        ),

        title: Text(
          widget.task.title,

          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: completed ? Colors.black : null,
            decoration: completed ? TextDecoration.lineThrough : null,
            decorationColor: completed ? Colors.black : null,
          ),
        ),

        subtitle: Text(
          widget.task.category,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: completed ? Colors.black : null,
          ),
        ),

        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          onPressed: () {
            setState(() {
              completed = !completed;
            });

            widget.onComplete();
          },

          child: Text(completed ? "Undo" : "Done"),
        ),
      ),
    );
  }
}
