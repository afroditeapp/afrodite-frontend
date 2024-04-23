


import 'package:flutter/widgets.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';

Widget buildListReplacementMessage({required Widget child}) {
  return Align(
    alignment: const FractionalOffset(0.5, 0.20),
    child: Padding(
      padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
      child: child,
    ),
  );
}
