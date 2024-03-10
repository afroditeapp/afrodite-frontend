import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings/admin.dart';
import 'package:pihka_frontend/ui/normal/settings/blocked_profiles.dart';
import 'package:pihka_frontend/ui/normal/settings/debug.dart';
import 'package:pihka_frontend/ui/normal/settings/location.dart';
import 'package:pihka_frontend/ui/normal/settings/my_profile.dart';
import 'package:pihka_frontend/ui/normal/settings/profile_visibility.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/app_bar/common_actions.dart';
import 'package:pihka_frontend/ui_utils/app_bar/menu_actions.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';

class SettingsView extends BottomNavigationScreen {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();

  @override
  List<Widget> actions(BuildContext context) {
    return [
      menuActions([
        commonActionOpenAboutDialog(context),
      ]),
    ];
  }

  @override
  String title(BuildContext context) {
    return context.strings.pageSettingsTitle;
  }
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        List<Setting> settings = [
          Setting.createSetting(Icons.account_circle, context.strings.pageMyProfileTitle, () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const MyProfilePage()))
          ),
          Setting.createSetting(Icons.location_on, context.strings.pageLocationTitle, () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const LocationPage()))
          ),
          Setting.createSetting(Icons.public, "Profile visiblity", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ProfileVisibilityPage()))
          ),
          Setting.createSetting(Icons.block, "Blocked profiles", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const BlockedProfilesPage()))
          ),
          Setting.createSetting(Icons.logout, context.strings.pageSettingsLogoutTitle, () =>
            showConfirmDialog(context, context.strings.pageSettingsLogoutTitle)
              .then((value) {
                if (value == true) {
                  context.read<AccountBloc>().add(DoLogout());
                }
              })
          ),
        ];

        if (state.capabilities.adminSettingsVisible()) {
          settings.add(Setting.createSetting(Icons.admin_panel_settings, context.strings.pageAdminTitle, () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const AdminSettingsPage()))
          ));
        }

        settings.add(Setting.createSetting(Icons.bug_report_rounded, "Debug", () =>
          Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const DebugSettingsPage()))
        ));

        return ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                settings[index].action();
              },
              title: settings[index].widget,
            );
          },
        );
      }
    );
  }
}

class Setting {
  final Widget widget;
  final void Function() action;
  Setting(this.widget, this.action);

  factory Setting.createSetting(IconData icon, String text, void Function() action) {
    Widget widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 45,),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Text(text),
        ],
      ),
    );
    return Setting(widget, action);
  }
}

extension GetCapabilities on Capabilities {
  bool adminSettingsVisible() {
    // TODO: Add missing capabilities once
    // capability properies are non-nullable
    return adminModerateImages ?? false;
  }
}
