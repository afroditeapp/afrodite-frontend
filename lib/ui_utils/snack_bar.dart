


import 'package:flutter/material.dart';
import 'package:pihka_frontend/main.dart';


// TODO: Show details button for displaying more detailed error message
void showSnackBar(String text) {
  Future.delayed(Duration.zero, () {
    globalScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    globalScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating)
    );
  });
}
