import 'package:flutter/material.dart';

class settings extends StatelessWidget {
  settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World settings'),
        ),
    );
  }
}