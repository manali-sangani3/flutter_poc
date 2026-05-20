import 'package:flutter/material.dart';
import 'package:flutter_poc/model/todo_model.dart';

class AppProvider extends ChangeNotifier {
  final List<TodoModel> _tasks = [];

  List<TodoModel> get tasks => _tasks;

  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  // Task Methods
  void addTask(String title) {
    if (title.trim().isEmpty) return;

    _tasks.add(TodoModel(title: title));
    notifyListeners();
    // Notifies all listening widgets to rebuild with updated data.
  }

  void toggleTask(int index) {
    _tasks[index].isCompleted = !(_tasks[index].isCompleted);
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
