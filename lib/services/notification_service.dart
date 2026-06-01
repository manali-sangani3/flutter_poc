import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final navigatorKey = GlobalKey<NavigatorState>();

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await messaging.requestPermission();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    await localNotifications.initialize(
      settings: const InitializationSettings(android: androidSettings),

      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          _handlePayload(response.payload!);
        }
      },
    );

    /// Foreground
    FirebaseMessaging.onMessage.listen(showForegroundNotification);

    /// Background Click
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    /// Terminated Click
    final initialMessage = await messaging.getInitialMessage();

    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }

    final token = await messaging.getToken();

    debugPrint("FCM Token: $token");
  }

  Future<void> showForegroundNotification(RemoteMessage message) async {
    await localNotifications.show(
      id: 0,

      title: message.notification?.title,

      body: message.notification?.body,

      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'demo_channel',
          'Demo Notifications',
        ),
      ),

      payload: jsonEncode(message.data),
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    final screen = message.data['/notification'];

    if (screen != null) {
      navigatorKey.currentState?.pushNamed(screen);
    }
  }

  void _handlePayload(String payload) {
    final data = jsonDecode(payload);

    final screen = data['/notification'];

    if (screen != null) {
      navigatorKey.currentState?.pushNamed(screen);
    }
  }
}
