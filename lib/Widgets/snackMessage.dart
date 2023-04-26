import 'package:flutter/material.dart';

class SnackMessage {
  static dynamic showSnackbarMessage({
    required BuildContext context,
    required String message,
    required Color backgroudColor,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: backgroudColor, content: Text(message)));
}
