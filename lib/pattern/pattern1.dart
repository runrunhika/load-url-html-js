import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pattern1 extends StatefulWidget {
  const Pattern1({Key? key}) : super(key: key);

  @override
  _Pattern1State createState() => _Pattern1State();
}

class _Pattern1State extends State<Pattern1> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.backspace_rounded),
          onPressed: () async {
            if (await controller.canGoBack()) {
              controller.goBack();
            }
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: Icon(Icons.replay_outlined)),
          IconButton(
              onPressed: () {
                controller.clearCache();
                CookieManager().clearCookies();
              },
              icon: Icon(Icons.clear)),
        ],
      ),
      body: WebView(
        //andorid<app<src<main<AndroidManifest
        //ios<info.plist
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://amazon.com',
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onPageStarted: (url) {
          print("New Website $url");

          //Remove Header
          if (url.contains('www.amazon.com')) {
            Future.delayed(Duration(milliseconds: 300), () {
              controller.evaluateJavascript(
                  "document.getElementsByTagName('header')[0].style.display='none'");

              controller.evaluateJavascript(
                  "document.getElementsByTagName('footer')[0].style.display='none'");
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.import_export,
          size: 32,
        ),
        onPressed: () async {
          final url = await controller.currentUrl();
          print("Previous Website: $url");

          controller.loadUrl('https://m.youtube.com');
        },
      ),
    );
  }
}
