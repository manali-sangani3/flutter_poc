// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_poc/provider/app_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppProvider Tests', () {
    test('Task should be added', () {
      final provider = AppProvider();

      provider.addTask("Learn Provider");

      expect(provider.tasks.length, 1);

      expect(provider.tasks.first.title, "Learn Provider");
    });

    test('Task completion should toggle', () {
      final provider = AppProvider();

      provider.addTask("Flutter");

      provider.toggleTask(0);

      expect(provider.tasks[0].isCompleted, true);
    });

    test('Task should be removed', () {
      final provider = AppProvider();

      provider.addTask("Delete Me");

      provider.removeTask(0);

      expect(provider.tasks.isEmpty, true);
    });

    test('Empty task should not add', () {
      final provider = AppProvider();

      provider.addTask("");

      expect(provider.tasks.length, 0);
    });
  });
  test('notifyListeners called', () {
    final provider = AppProvider();

    bool notified = false;

    provider.addListener(() {
      notified = true;
    });

    provider.addTask("Test");

    expect(notified, true);
  });
}
