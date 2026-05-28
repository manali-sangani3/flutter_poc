import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_poc/inherited/app_state.dart';
import 'package:flutter_poc/provider/app_provider.dart';
import 'package:flutter_poc/screens/accessibility_localization_screen.dart';
import 'package:flutter_poc/screens/counter_demo_screen.dart';
import 'package:flutter_poc/screens/crypto_screen.dart';
import 'package:flutter_poc/screens/employee_salary_screen.dart';
import 'package:flutter_poc/screens/employee_screen.dart';
import 'package:flutter_poc/screens/expense_screen.dart';
import 'package:flutter_poc/screens/home_screen.dart';
import 'package:flutter_poc/screens/inventory_screen.dart';
import 'package:flutter_poc/screens/library_screen.dart';
import 'package:flutter_poc/screens/movie_screen.dart';
import 'package:flutter_poc/screens/native_sdk_screen.dart';
import 'package:flutter_poc/screens/notification_demo_screen.dart';
import 'package:flutter_poc/screens/secure_login_screen.dart';
import 'package:flutter_poc/screens/secure_testing_screen.dart';
import 'package:flutter_poc/screens/secure_vault_screen.dart';
import 'package:flutter_poc/screens/settings_screen.dart';
import 'package:flutter_poc/screens/task_screen.dart';
import 'package:flutter_poc/screens/todo_screen.dart';
import 'package:flutter_poc/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'cubit/employee_cubit.dart';
import 'cubit/language_cubit.dart';
import 'l10n/app_localizations.dart';
import 'locator/service_locator.dart';
import 'observer/app_bloc_observer.dart';
import 'services/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Workmanager().initialize(callbackDispatcher);
  // A centralized object that provides dependencies globally.
  setupLocator();
  Bloc.observer = AppBlocObserver();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();

  await Hive.openBox('productsBox');

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

                '/mobx': (_) => const ExpenseScreen(),

                '/dependency_injection': (_) => LibraryScreen(),

                '/rest-graph': (_) => MovieScreen(),

                '/graph-websocket': (_) => CryptoScreen(),

                '/secure-vault': (_) => const SecureVaultScreen(),

                '/app-security': (_) => const SecureLoginScreen(),

                '/testing-data': (_) => const SecureTestingScreen(),

                '/native-sdk': (_) => const NativeSdkScreen(),

                '/notification': (_) => const NotificationDemoScreen(),
              },
            );
          },
        ),
      ),
    );
  }
}
