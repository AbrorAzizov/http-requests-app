import 'package:flutter/material.dart';
import 'package:flutter_rest_api/pages/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData.light() ,

      debugShowCheckedModeBanner: false,

      home: HomePage(),
    );
  }
}
