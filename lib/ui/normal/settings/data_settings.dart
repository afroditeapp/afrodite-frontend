

import 'package:flutter/material.dart';
import 'package:pihka_frontend/localizations.dart';

class DataSettingsScreen extends StatefulWidget {
  const DataSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DataSettingsScreen> createState() => _DataSettingsScreenState();
}

class _DataSettingsScreenState extends State<DataSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.data_settings_screen_title),
      ),
      body: const SizedBox.shrink(),
    );
  }
}
