


import 'package:flutter/material.dart';
import 'package:app/ui_utils/consts/padding.dart';

Widget buildListReplacementMessage({required Widget child}) {
  return Align(
    alignment: const FractionalOffset(0.5, 0.20),
    child: Padding(
      padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
      child: child,
    ),
  );
}

Widget buildListReplacementMessageSimple(BuildContext context, String text) {
  return buildListReplacementMessage(child: Text(
    text,
    style: Theme.of(context).textTheme.bodyLarge,
  ));
}
