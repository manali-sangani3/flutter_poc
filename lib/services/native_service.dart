import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('native/device');

  Future<String> getBatteryLevel() async {
    final result = await platform.invokeMethod('getBattery');

    return result.toString();
  }

  Future<String> getDeviceInfo() async {
    final result = await platform.invokeMethod('getDeviceInfo');

    return result.toString();
  }
}
