// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:my_yap_plugin/my_yap_plugin.dart';
// import 'package:my_yap_plugin/my_yap_plugin_platform_interface.dart';
// import 'package:my_yap_plugin/my_yap_plugin_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockMyYapPluginPlatform
//     with MockPlatformInterfaceMixin
//     implements MyYapPluginPlatform {
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');

//   @override
//   Future<Widget?> showNativeScreen({required String screen}) {
//     // TODO: implement showNativeScreen
//     throw UnimplementedError();
//   }
// }

// void main() {
//   final MyYapPluginPlatform initialPlatform = MyYapPluginPlatform.instance;

//   test('$MethodChannelMyYapPlugin is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelMyYapPlugin>());
//   });

//   test('getPlatformVersion', () async {
//     MyYapPlugin myYapPlugin = MyYapPlugin();
//     MockMyYapPluginPlatform fakePlatform = MockMyYapPluginPlatform();
//     MyYapPluginPlatform.instance = fakePlatform;

//     expect(await myYapPlugin.getPlatformVersion(), '42');
//   });
// }
