import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_poc/services/crashlytics_service.dart';

import '../services/analytics_service.dart';
import '../services/logger_service.dart';

class LoggingDemoScreen extends StatelessWidget {
  const LoggingDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logging & Monitoring')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                LoggerService.debug('Debug Log');
              },

              child: const Text('Debug Log'),
            ),

            SizedBox(height: 12,),

            ElevatedButton(
              onPressed: () {
                LoggerService.info('User Login');

                AnalyticsService.logLogin();
              },

              child: const Text('Track Login'),
            ),

            SizedBox(height: 12,),

            ElevatedButton(
              onPressed: () {
                LoggerService.warning('Low Memory');
              },

              child: const Text('Warning Log'),
            ),

            SizedBox(height: 12,),

            ElevatedButton(
              onPressed: () {
                try {
                  throw Exception('Demo Exception');
                } catch (e, stack) {
                  CrashlyticsService.recordError(e, stack);
                }
              },

              child: const Text('Log Error'),
            ),

            SizedBox(height: 12,),

            if (Platform.isAndroid)
              ElevatedButton(
                onPressed: () {
                  CrashlyticsService.testCrash();
                },

                child: const Text('Test Crash'),
              ),
          ],
        ),
      ),
    );
  }
}
