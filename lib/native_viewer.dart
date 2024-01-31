import 'dart:io';
import 'dart:developer' as console;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adaptive_platform_view.dart';

class NativeViewer extends StatefulWidget {
  // final String nativeScreen;
  final Map<String, dynamic> viewParams;

  const NativeViewer({
    super.key,
    required this.viewParams,
    // required this.nativeScreen
  });

  @override
  State<NativeViewer> createState() => _NativeViewerState();
}

class _NativeViewerState extends State<NativeViewer> {
  // late MethodChannel channel; // = const MethodChannel('test_platform_channel');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String viewType = 'native_screen';
    final Map<String, dynamic> creationParams = widget.viewParams;

    return AdatptivePlatformView(
      // nativeScreen: widget.nativeScreen,
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
