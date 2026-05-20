import 'package:flutter/material.dart';

import '../inherited/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// -------------------------------------
    /// INHERITED WIDGET ACCESS
    /// -------------------------------------
    ///
    /// Access shared data using context
    ///
    final appState = AppState.of(context); // Context Propagation: because data flows through widget tree context.

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: SwitchListTile(
        title: const Text("Dark Theme"),

        value: appState.isDark,

        onChanged: (_) {
          appState.toggleTheme();
        },
      ),
    );
  }
}
