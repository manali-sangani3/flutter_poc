import 'dart:async';
import '../model/task_model.dart';

class TaskService {

  Future<List<TaskModel>> fetchTasks() async {

    // Simulating API delay
    await Future.delayed(
      const Duration(seconds: 2),
    );

    return List.generate(
      3000,
          (index) => TaskModel(
        id: index,
        title: "Task $index",
        completed: index % 3 == 0,
        category: index % 2 == 0
            ? "Work"
            : "Personal",
      ),
    );
  }
}