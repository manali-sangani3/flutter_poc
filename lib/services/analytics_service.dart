import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {

  Future<void> logPurchase() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'purchase',
      parameters: {'amount': 499},
    );
  }
}
