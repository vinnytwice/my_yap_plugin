import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'my_yap_plugin_platform_interface.dart';
import 'native_viewer.dart';

/// An implementation of [MyYapPluginPlatform] that uses method channels.
class MethodChannelMyYapPlugin extends MyYapPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_yap_plugin_channel');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Widget> showNativeScreen(
      {required Map<String, dynamic> viewParams}) async {
    // invoke method not required for PlatformView
    // await methodChannel.invokeMethod<Widget>('showNativeScreen', viewParams);

    return NativeViewer(
      viewParams: viewParams,
    );

    // return const Text('test return widget');
  }
}
