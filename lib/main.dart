import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bahnhofsfotos',
      theme: ThemeData(
        primaryColor: Color(0xffc71c4d),
        accentColor: Color(0xffD0C332),
      ),
      home: Container(),
    );
  }
}
