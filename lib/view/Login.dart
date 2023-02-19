import 'package:flutter/material.dart';

class login extends StatelessWidget {
  login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: SafeArea(
          child: Center(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}