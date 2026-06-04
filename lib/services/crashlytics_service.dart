import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static Future<void> recordError(dynamic error, StackTrace stack) async {
    await FirebaseCrashlytics.instance.recordError(error, stack);
  }

  static Future<void> testCrash() async {
    FirebaseCrashlytics.instance.crash();
  }
}
