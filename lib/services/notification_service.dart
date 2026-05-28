import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
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
    );

    FirebaseMessaging.onMessage.listen(showForegroundNotification);

    final token = await messaging.getToken();

    print("FCM Token: $token");
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
    );
  }
}
