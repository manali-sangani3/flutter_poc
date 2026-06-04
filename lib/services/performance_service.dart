import 'package:flutter/services.dart';

class PerformanceService {
  static const _channel = MethodChannel('native/performance');

  static Future<int> calculateSum(int count) async {
    return await _channel.invokeMethod('calculateSum', {'count': count});
  }
}
