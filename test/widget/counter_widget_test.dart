import 'package:flutter/material.dart';
import 'package:flutter_poc/screens/testing_demo_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter Increment Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TestingDemoScreen()));

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
