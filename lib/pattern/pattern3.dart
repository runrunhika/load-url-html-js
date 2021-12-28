import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pattern3 extends StatefulWidget {
  const Pattern3({Key? key}) : super(key: key);

  @override
  _Pattern3State createState() => _Pattern3State();
}

class _Pattern3State extends State<Pattern3> {
  late WebViewController wController;

  // final html = '''<!DOCTYPE html>
  // <html>
  // <body>
  
  // <h1>This is heading 1</h1>
  // <h1>This is heading 2</h2>
  // <h1>This is heading 3</h3>
  // <h1>This is heading 4</h4>
  // <h1>This is heading 5</h5>
  // <h1>This is heading 6</h6>

  // </body>
  // </html>''';

  void loadLocalHtml() async {
    final html = await rootBundle.loadString('assets/index.html');
    final url = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    wController.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webview"),
        centerTitle: true,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://netflix.com',
        onWebViewCreated: (controller) {
          this.wController = controller;

          loadLocalHtml();
        },
      ),
    );
  }
}
