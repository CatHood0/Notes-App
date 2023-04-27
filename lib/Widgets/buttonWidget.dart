import 'package:flutter/material.dart';

class ButtonNotesWidget extends StatelessWidget {
  const ButtonNotesWidget({
    Key? key,
    required this.message,
    required this.icon,
    required this.onPressed,
    required this.textStyle,
    required this.buttonStyle,
  }) : super(key: key);

  final String message;
  final Icon icon;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final ButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        message,
        style: textStyle,
      ),
      style: buttonStyle,
    );
  }
}