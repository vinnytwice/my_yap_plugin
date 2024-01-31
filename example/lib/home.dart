import 'dart:developer' as console;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'native_viewer.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, required this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MethodChannel channel;
  late MethodChannel nativeViewerPlatformCahannel;
  @override
  void initState() {
    super.initState();
    channel = const MethodChannel('test_platform_channel');
    channel.invokeMethod('test', []).catchError((e) {
      console.log('Home screen: test message error;:  $e');
    });
    channel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'swift_to_flutter':
          console.log(
              'Home swift_to_flutter 📞 received in Home with args ${call.arguments}');

          break;
        default:
      }
      return call.arguments;
    });

    nativeViewerPlatformCahannel =
        const MethodChannel('native_viewer_platform_channel');
    nativeViewerPlatformCahannel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'switch_to_screen':
          console.log(
              'Home switch_to_screen 📞 received with args ${call.arguments}');
          break;
        default:
      }
      return call.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    console.log('Home build');
    Map<String, dynamic> params = <String, dynamic>{};
    String nativeViewTitle = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'ViewController';
                params.clear();
                params = {
                  'screen': 'viewController',
                  'param 1': 'close native',
                  'param 2': 'goto VC2'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
              },
              child: const Text(
                'Navigate to ViewController',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'TableView';
                params.clear();
                params = {
                  'screen': 'viewController2',
                  'param 1': 'close native',
                  'param 2': 'goto VC1'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
              },
              child: const Text(
                'Navigate to TableView',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'ScrollView';
                params.clear();
                params = {
                  'screen': 'viewController3',
                  'param 1': 'close native',
                  'param 2': 'goto VC1'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
              },
              child: const Text(
                'Navigate to ScrollView',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'MapView';
                params.clear();
                params = {
                  'screen': 'viewController4',
                  'param 1': 'close native',
                  'param 2': 'goto VC1'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
              },
              child: const Text(
                'Navigate to MapView',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                nativeViewTitle = 'VCMapView';
                params.clear();
                params = {
                  'screen': 'viewController5',
                  'param 1': 'close native',
                  'param 2': 'goto VC1'
                };
                pushNativeView(
                    context: context,
                    nativeViewTitle: nativeViewTitle,
                    params: params);
              },
              child: const Text(
                'Navigate to VCMapView',
              ),
            )
          ],
        ),
      ),
    );
  }

  void callNative() async {
    await channel.invokeMethod("test", []).catchError((e) {
      console.log('invokeMethod test error: $e');
    });
  }

  void pushNativeView(
      {required BuildContext context,
      required String nativeViewTitle,
      required Map<String, dynamic> params}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NativeViewer(
            nativeScreen: "", title: nativeViewTitle, viewParams: params),
      ),
    );
  }
}
