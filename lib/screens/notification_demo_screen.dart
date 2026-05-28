import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import '../services/notification_service.dart';

class NotificationDemoScreen extends StatefulWidget {
  const NotificationDemoScreen({super.key});

  @override
  State<NotificationDemoScreen> createState() => _NotificationDemoScreenState();
}

class _NotificationDemoScreenState extends State<NotificationDemoScreen> {
  final service = NotificationService();

  @override
  void initState() {
    super.initState();

    initialize();
  }

  Future<void> initialize() async {
    await service.initialize();

    Workmanager().registerPeriodicTask(
      "sync-task",

      "backgroundSync",

      frequency: const Duration(minutes: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Push Notifications")),

      body: const Center(child: Text("Push Notification Demo")),
    );
  }
}
