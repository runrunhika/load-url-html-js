import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pattern2 extends StatefulWidget {
  const Pattern2({Key? key}) : super(key: key);

  @override
  _Pattern2State createState() => _Pattern2State();
}

class _Pattern2State extends State<Pattern2> {
  late WebViewController _controller;
  late bool isSubmitting;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //System go back

        if (await _controller.canGoBack()) {
          _controller.goBack();

          //Stay in app
          return false;
        } else {
          //Leave app
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('WebView'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.backspace_rounded),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                _controller.goBack();
              }
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _controller.reload();
                },
                icon: Icon(Icons.replay_outlined)),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              color: Colors.red,
              backgroundColor: Colors.black,
            ),
            Expanded(
              child: WebView(
                //andorid<app<src<main<AndroidManifest
                //ios<info.plist
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://m.facebook.com',
                onWebViewCreated: (controller) {
                  this._controller = controller;
                },
                onPageStarted: (url) {
                  print("New Website $url");
                },
                onPageFinished: (url) {
                  if (isSubmitting) {
                    _controller.loadUrl('https://m.facebook.com');
                    isSubmitting = false;
                  }
                },
                onProgress: (progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.import_export,
            size: 32,
          ),
          onPressed: () async {
            //facebook look in
            final email = 'girugamessyukami@gmail.com';
            final password = 'girukunn';

            _controller.evaluateJavascript(
                "document.getElementById('m_login_email').value='$email'");
            _controller.evaluateJavascript(
                "document.getElementById('m_login_password').value='$password'");

            await Future.delayed(Duration(seconds: 1));
            isSubmitting = true;
            await _controller.evaluateJavascript('document.forms[0].submit()');
          },
        ),
      ),
    );
  }
}
