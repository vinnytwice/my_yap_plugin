import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_yap_plugin_method_channel.dart';

abstract class MyYapPluginPlatform extends PlatformInterface {
  /// Constructs a MyYapPluginPlatform.
  MyYapPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyYapPluginPlatform _instance = MethodChannelMyYapPlugin();

  /// The default instance of [MyYapPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyYapPlugin].
  static MyYapPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyYapPluginPlatform] when
  /// they register themselves.
  static set instance(MyYapPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Widget> showNativeScreen({required Map<String, dynamic> viewParams}) {
    throw UnimplementedError();
  }
}
