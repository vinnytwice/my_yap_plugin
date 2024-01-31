import 'package:flutter/widgets.dart';

import 'my_yap_plugin_platform_interface.dart';

class MyYapPlugin {
  Future<String?> getPlatformVersion() {
    return MyYapPluginPlatform.instance.getPlatformVersion();
  }

  Future<Widget> showNativeScreen(
      {required Map<String, dynamic> viewParams}) async {
    return await MyYapPluginPlatform.instance
        .showNativeScreen(viewParams: viewParams);
  }
}
