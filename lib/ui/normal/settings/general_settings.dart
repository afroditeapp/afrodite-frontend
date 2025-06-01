

import 'package:flutter/material.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/general/image_settings.dart';
import 'package:app/ui/normal/settings/general/profile_grid_settings.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({
    super.key,
  });

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
        Setting.createSetting(Icons.image, context.strings.image_quality_settings_screen_title, () {
          MyNavigator.push(context, const MaterialPage<void>(child:
            ImageSettingsScreen()
          ));
        }).toListTile(),
        Setting.createSetting(Icons.grid_view_rounded, context.strings.profile_grid_settings_screen_title, () {
          openProfileGridSettingsScreen(context);
        }).toListTile(),
      ],
    );
  }
}
