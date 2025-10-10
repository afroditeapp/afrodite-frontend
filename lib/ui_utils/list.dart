import 'package:flutter/material.dart';
import 'package:app/ui_utils/consts/padding.dart';

Widget buildListReplacementMessage({required Widget child}) {
  return Align(
    alignment: const FractionalOffset(0.5, 0.20),
    child: Padding(padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING), child: child),
  );
}

Widget buildListReplacementMessageSimple(BuildContext context, String text) {
  return buildListReplacementMessage(
    child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
  );
}

class ListReplacementMessage extends StatelessWidget {
  final String title;
  final String body;
  const ListReplacementMessage({required this.title, this.body = "", super.key});

  @override
  Widget build(BuildContext context) {
    return buildListReplacementMessage(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Padding(padding: EdgeInsets.all(8)),
          Text(body),
        ],
      ),
    );
  }
}
