import 'package:flutter/material.dart';

class dateTimeText extends StatelessWidget {
  const dateTimeText({super.key, required this.time});
  final String time;

  @override
  Widget build(BuildContext context) {
    return Text(time, style: TextStyle(color: Color.fromARGB(147, 255, 255, 255)),);
  }
}