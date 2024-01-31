import 'dart:io';
import 'dart:developer' as console;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_yap_plugin/my_yap_plugin.dart';

class NativeViewer extends StatefulWidget {
  final String title;
  final String nativeScreen;
  final Map<String, dynamic> viewParams;

  const NativeViewer(
      {super.key,
      required this.title,
      required this.viewParams,
      required this.nativeScreen});

  @override
  State<NativeViewer> createState() => _NativeViewerState();
}

class _NativeViewerState extends State<NativeViewer> {
  late Map<String, dynamic> creationParams;
  late MethodChannel channel;
  late dynamic backButton;
  @override
  void initState() {
    super.initState();
    backButton = Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back;
    creationParams = widget.viewParams;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
        ),
        leading: IconButton(
            icon: Icon(backButton),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: FutureBuilder(
            future: MyYapPlugin().showNativeScreen(viewParams: creationParams),
            builder: (context, snapshot) {
              console.log('snapshot is : ${snapshot.toString()}');
              if (snapshot.hasData) {
                return snapshot.data!;
              } else if (snapshot.hasError) {
                return Text(
                    'snapshot.data error: ${snapshot.error.toString()}');
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
