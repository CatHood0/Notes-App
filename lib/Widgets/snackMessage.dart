import 'package:flutter/material.dart';

class SnackMessage {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackbarMessage({
    required BuildContext context,
    required String message,
    Duration? duration = const Duration(seconds: 2),
    required Color backgroudColor,
  }) =>
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: backgroudColor,
            content: Text(message, style: TextStyle(color: Colors.white),),
            duration: duration!,
          ));
}
