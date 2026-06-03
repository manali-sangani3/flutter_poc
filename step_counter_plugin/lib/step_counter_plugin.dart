import 'dart:async';

import 'package:flutter/services.dart';

class StepCounterPlugin {
  static const EventChannel _stepChannel = EventChannel(
    'step_counter_plugin/steps',
  );

  static Stream<int> get steps {
    return _stepChannel.receiveBroadcastStream().map((event) => event as int);
  }
}
