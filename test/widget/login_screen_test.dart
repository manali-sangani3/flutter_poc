import 'package:flutter/material.dart';
import 'package:flutter_poc/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login Screen Widget Tests', () {
    testWidgets('Verify screen widgets', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Verify 2 text fields
      expect(find.byType(TextField), findsNWidgets(2));

      // Verify Login button
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Verify Login text
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Login Success Test', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      await tester.enterText(
        find.byKey(const Key('emailField')),
        'test@gmail.com',
      );

      await tester.enterText(find.byKey(const Key('passwordField')), '123456');

      await tester.tap(find.byKey(const Key('loginButton')));

      await tester.pump();

      expect(find.text('Login Success'), findsOneWidget);
    });

    testWidgets('Invalid Login Test', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      await tester.enterText(find.byKey(const Key('emailField')), '');

      await tester.enterText(find.byKey(const Key('passwordField')), '123');

      await tester.tap(find.byKey(const Key('loginButton')));

      await tester.pump();

      expect(find.text('Invalid Credentials'), findsOneWidget);
    });

    testWidgets('Button Tap Changes UI', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      await tester.enterText(
        find.byKey(const Key('emailField')),
        'demo@gmail.com',
      );

      await tester.enterText(
        find.byKey(const Key('passwordField')),
        'password123',
      );

      await tester.tap(find.byKey(const Key('loginButton')));

      await tester.pump();

      expect(find.text('Login Success'), findsOneWidget);
    });
  });
}
