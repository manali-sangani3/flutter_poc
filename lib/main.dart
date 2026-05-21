import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/inherited/app_state.dart';
import 'package:flutter_poc/provider/app_provider.dart';
import 'package:flutter_poc/screens/accessibility_localization_screen.dart';
import 'package:flutter_poc/screens/counter_demo_screen.dart';
import 'package:flutter_poc/screens/employee_salary_screen.dart';
import 'package:flutter_poc/screens/employee_screen.dart';
import 'package:flutter_poc/screens/home_screen.dart';
import 'package:flutter_poc/screens/inventory_screen.dart';
import 'package:flutter_poc/screens/settings_screen.dart';
import 'package:flutter_poc/screens/task_screen.dart';
import 'package:flutter_poc/screens/todo_screen.dart';
import 'package:flutter_poc/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'cubit/employee_cubit.dart';
import 'cubit/language_cubit.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    ProviderScope(
      // Root container for all Riverpod providers.
      //
      // Required for Riverpod state access.
      child: ChangeNotifierProvider(
        // Provides the AppProvider object to the widget tree.
        //
        // Makes state accessible globally.
        create: (_) => AppProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Default Theme
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EmployeeCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
      ],
      child: AppState(
        isDark: isDark,

        toggleTheme: toggleTheme,
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              theme: AppTheme.lightTheme,

              darkTheme: AppTheme.darkTheme,

              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

              title: 'Flutter Upskiling',

              /// RTL Support
              locale: locale,

              localizationsDelegates: AppLocalizations.localizationsDelegates,

              supportedLocales: AppLocalizations.supportedLocales,

              initialRoute: '/',

              routes: {
                '/': (_) => HomeScreen(),

                '/core-dart': (_) => const EmployeeSalaryScreen(),

                '/async-programming': (_) => const TaskScreen(),

                '/accessibility': (_) =>
                    const AccessibilityLocalizationScreen(),

                '/counter': (_) => const CounterDemoScreen(),

                '/settings': (_) => const SettingsScreen(),

                '/provider': (_) => const TodoScreen(),

                '/bloc': (_) => const EmployeeScreen(),

                '/riverpod': (_) => const InventoryScreen(),
              },
            );
          },
        ),
      ),
    );
  }
}
