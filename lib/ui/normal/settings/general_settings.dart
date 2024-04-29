

import 'package:flutter/material.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/general/image_settings.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.general_settings_screen_title),
      ),
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
        imageSettings(context),
      ],
    );
  }

  Widget imageSettings(BuildContext context) {
    return Setting.createSetting(Icons.image, context.strings.image_quality_settings_screen_title, () {
        MyNavigator.push(context, const MaterialPage<void>(child:
          ImageSettingsScreen()
        ));
      }
    ).toListTile();
  }
}
