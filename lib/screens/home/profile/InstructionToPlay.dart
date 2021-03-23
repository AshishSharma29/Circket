import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstructionToPlay extends StatefulWidget {
  @override
  _InstructionToPlayState createState() => _InstructionToPlayState();
}

class _InstructionToPlayState extends State<InstructionToPlay> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
    );
  }
}
