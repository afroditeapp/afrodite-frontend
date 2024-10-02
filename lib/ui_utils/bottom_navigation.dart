

import 'package:flutter/material.dart';


abstract class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  String title(BuildContext context);
  /// Action bar actions
  List<Widget>? actions(BuildContext context) => null;

  Widget? floatingActionButton(BuildContext context) => null;
}
