import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> logLogin() async {
    await analytics.logLogin();
  }

  Future<void> logPurchase() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'purchase',
      parameters: {'amount': 499},
    );
  }

  static Future<void> logScreen(String screenName) async {
    await analytics.logScreenView(screenName: screenName);
  }
}
