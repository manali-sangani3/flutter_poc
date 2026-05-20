import 'package:flutter/foundation.dart';

import '../model/task_model.dart';

class AnalyticsResult {
  final int completed;
  final int pending;
  final double productivity;

  AnalyticsResult({
    required this.completed,
    required this.pending,
    required this.productivity,
  });
}

// Concurrency & Isolates
Future<AnalyticsResult> generateAnalytics(List<TaskModel> tasks) async {
  return compute(_calculateAnalytics, tasks);
}

AnalyticsResult _calculateAnalytics(List<TaskModel> tasks) {
  int completed = 0;
  int pending = 0;

  for (var task in tasks) {
    if (task.completed) {
      completed++;
    } else {
      pending++;
    }
  }

  double productivity = (completed / tasks.length) * 100;

  return AnalyticsResult(
    completed: completed,
    pending: pending,
    productivity: productivity,
  );
}
