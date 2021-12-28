import 'package:flutter/material.dart';
import 'package:load_url_html_js_sample/pattern/pattern1.dart';
import 'package:load_url_html_js_sample/pattern/pattern2.dart';
import 'package:load_url_html_js_sample/pattern/pattern3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Pattern1(),
    );
  }
}

