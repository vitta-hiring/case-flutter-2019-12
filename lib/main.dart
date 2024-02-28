import 'package:app_movie/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:app_movie/pages/home_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: MyHomePage(),
    );
  }
}
