

import 'package:flutter/material.dart';
import 'package:pihka_frontend/main.dart';

void showSnackBar(String text) {
  globalScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  globalScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(text), behavior: SnackBarBehavior.floating)
  );
}
