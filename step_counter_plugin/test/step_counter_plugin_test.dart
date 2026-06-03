import 'package:flutter_test/flutter_test.dart';
import 'package:step_counter_plugin/step_counter_plugin.dart';
import 'package:step_counter_plugin/step_counter_plugin_platform_interface.dart';
import 'package:step_counter_plugin/step_counter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockStepCounterPluginPlatform
    with MockPlatformInterfaceMixin
    implements StepCounterPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

