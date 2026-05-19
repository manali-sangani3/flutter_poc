import 'package:flutter/foundation.dart';

Future<List<int>> processLargeData() async {
  return compute(heavyTask, 100000000);
}

List<int> heavyTask(int count) {
  List<int> numbers = [];

  for (int i = 0; i < count; i++) {
    if (i % 10000000 == 0) {
      numbers.add(i);
    }
  }

  return numbers;
}