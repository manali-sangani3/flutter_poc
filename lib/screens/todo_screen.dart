import 'package:flutter/material.dart';

import '../widgets/task_input.dart';
import '../widgets/task_tile.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider State Management")),
      body: Column(
        children: const [
          SizedBox(height: 16),

          TaskInput(),

          Expanded(child: TaskTile()),
        ],
      ),
    );
  }
}
