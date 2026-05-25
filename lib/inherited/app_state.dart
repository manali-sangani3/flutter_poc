import 'package:flutter/material.dart';

class AppState extends InheritedWidget {

  final bool isDark;

  final VoidCallback toggleTheme;

  const AppState({

    super.key,

    required this.isDark,

    required this.toggleTheme,

    required super.child,
  });

  static AppState of(BuildContext context) {

    final result =
    context.dependOnInheritedWidgetOfExactType<AppState>(); // widgets automatically rebuild

    return result!;
  }

  // notify widgets that inherit from this widget.
  @override
  bool updateShouldNotify(
      AppState oldWidget,
      ) {

    return oldWidget.isDark != isDark;
  }
}