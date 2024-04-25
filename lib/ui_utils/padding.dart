import 'package:flutter/material.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';

/// Wrap widget with horizontal padding
Widget hPad(Widget child) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
    child: child,
  );
}
