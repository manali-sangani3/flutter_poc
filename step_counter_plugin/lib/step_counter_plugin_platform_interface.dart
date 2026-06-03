import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'step_counter_plugin_method_channel.dart';

abstract class StepCounterPluginPlatform extends PlatformInterface {
  /// Constructs a StepCounterPluginPlatform.
  StepCounterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static StepCounterPluginPlatform _instance = MethodChannelStepCounterPlugin();

  /// The default instance of [StepCounterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelStepCounterPlugin].
  static StepCounterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StepCounterPluginPlatform] when
  /// they register themselves.
  static set instance(StepCounterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
