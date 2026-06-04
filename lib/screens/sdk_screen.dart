import 'dart:io';

import 'package:flutter/material.dart';

import '../services/analytics_service.dart';
import '../services/crashlytics_service.dart';

class SdkScreen extends StatelessWidget {
  const SdkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsService analytics = AnalyticsService();
    return Scaffold(
      appBar: AppBar(title: const Text("Third party SDK")),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                analytics.logPurchase();
              },

              child: const Text('Track Event (Analytics)'),
            ),

            SizedBox(height: 12),

            if(Platform.isAndroid)
            ElevatedButton(
              onPressed: () {
                CrashlyticsService.testCrash();
              },

              child: const Text('Generate Error (Crashlytics)'),
            ),
            SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/payment-screen');
              },

              child: const Text('Stripe Payment SDK'),
            ),
          ],
        ),
      ),
    );
  }
}
