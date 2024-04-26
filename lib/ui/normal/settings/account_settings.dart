

import 'package:flutter/material.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/my_profile.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.account_settings_screen),
      ),
      body: Column(
        children: [
          myProfile(),
        ],
      ),
    );
  }

  Widget myProfile() {
    return Setting.createSetting(Icons.account_box, context.strings.view_profile_screen_my_profile_title, () =>
      MyNavigator.push(context, const MaterialPage<void>(child: MyProfileScreen()))
    ).toListTile();
  }
}
