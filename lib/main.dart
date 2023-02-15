import 'package:flutter/material.dart';
import 'package:notes_project/view/CreateNote.dart';
import 'package:notes_project/view/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'homePage',
      routes: {
          'homePage': (context) => homePage(),
          'create_notes':(context) => createNote(),
      },
    );
  }
}