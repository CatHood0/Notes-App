import 'package:flutter/material.dart';

class SnackMessage {
  static dynamic showSnackbarMessage({
    required BuildContext context,
    required String message,
    Duration? duration = const Duration(seconds: 2),
    Color? textColor = Colors.black,
    required Color backgroudColor,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: backgroudColor,
        content: Text(message),
        duration: duration!,
        action: SnackBarAction(
            textColor: textColor, label: '', onPressed: () => null),
      ));
}
