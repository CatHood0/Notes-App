import 'package:flutter/material.dart';
import 'package:notes_project/UI/Home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: notesPage(),
    );
  }
}