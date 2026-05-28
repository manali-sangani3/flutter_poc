import 'package:flutter/material.dart';

import '../services/native_service.dart';

class NativeSdkScreen extends StatefulWidget {
  const NativeSdkScreen({super.key});

  @override
  State<NativeSdkScreen> createState() => _NativeSdkScreenState();
}

class _NativeSdkScreenState extends State<NativeSdkScreen> {
  final service = NativeService();

  String battery = '';

  String device = '';

  Future<void> loadData() async {
    final batteryResult = await service.getBatteryLevel();

    final deviceResult = await service.getDeviceInfo();

    setState(() {
      battery = batteryResult;

      device = deviceResult;
    });
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Native SDK Demo")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("Battery: $battery"),

            const SizedBox(height: 20),

            Text("Device: $device"),
          ],
        ),
      ),
    );
  }
}
