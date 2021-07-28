// ignore_for_file: avoid_print, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:sambapos_test_skills_project/screens/home.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SambaPos',
      home: Home(),
    );
  }
}
