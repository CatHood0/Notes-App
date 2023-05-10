import 'package:flutter/material.dart';

import '../../../Widgets/snackMessage.dart';

class HomeController {
  bool hadConnectionBefore = false, showAdvice = false, showAdviceDisconnected = false;

  void showSnackbarMessage(
      {required BuildContext context,
      required int TIME_OUT,
      required bool hasInternet}) async {
    if (hasInternet && hadConnectionBefore && !showAdvice) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showAdviceDisconnected = false;
      showAdvice = true;
      SnackMessage.showSnackbarMessage(
        context: context,
        message: "Connection established",
        backgroudColor: Colors.green,
      );
    } else if (!hasInternet && TIME_OUT >=8 && !showAdviceDisconnected) {
      showAdviceDisconnected = true;
      hadConnectionBefore = true;
      showAdvice = false;
      SnackMessage.showSnackbarMessage(
        context: context,
        message:
            'Please, check your connection. The changes will not be apply if you dont have a connection',
        duration: const Duration(days: 1),
        backgroudColor: Colors.red,
      );
    }
  }
}
