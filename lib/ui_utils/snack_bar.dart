


import 'package:flutter/material.dart';
import 'package:app/main.dart';

void showSnackBar(String text) {
  Future.delayed(Duration.zero, () {
    globalScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    globalScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating)
    );
  });
}
