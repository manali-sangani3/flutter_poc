import 'package:flutter/services.dart';

class StepCounterService {
  static const EventChannel _channel =
  EventChannel(
    'step_counter_plugin/steps',
  );

  Stream<int> get steps {
    return _channel
        .receiveBroadcastStream()
        .map(
          (event) => event as int,
    );
  }
}