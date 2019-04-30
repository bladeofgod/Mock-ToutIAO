import 'package:flutter/material.dart';
import 'page/main_page.dart';
import 'page/flash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "仿头条",
      theme: ThemeData(
          primarySwatch: Colors.red
      ),
      initialRoute: 'flash',
      routes: {
        'flash': (context) => FlashPage(),
        'main_page': (context) => MainPage(),
      },
    );
  }
}
