import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/logic/settings/privacy_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings/admin.dart';
import 'package:pihka_frontend/ui/normal/settings/debug.dart';
import 'package:pihka_frontend/ui/normal/settings/media/current_moderation_request.dart';
import 'package:pihka_frontend/ui/normal/settings/my_profile.dart';
import 'package:pihka_frontend/ui/normal/settings/privacy_settings.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/app_bar/common_actions.dart';
import 'package:pihka_frontend/ui_utils/app_bar/menu_actions.dart';
import 'package:pihka_frontend/utils/api.dart';

class SettingsView extends BottomNavigationScreen {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();

  @override
  List<Widget> actions(BuildContext context) {
    return [
      menuActions([
        commonActionOpenAboutDialog(context),
        commonActionLogout(context),
      ]),
    ];
  }

  @override
  String title(BuildContext context) {
    return context.strings.settings_screen_title;
  }
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        List<Setting> settings = [
          Setting.createSetting(Icons.account_circle_rounded, context.strings.view_profile_screen_my_profile_title, () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const MyProfileScreen()))
          ),
          Setting.createSetting(Icons.lock_rounded, context.strings.privacy_settings_screen_title, () {
            final privacySettingsBloc = context.read<PrivacySettingsBloc>();
            final accountBloc = context.read<AccountBloc>();
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => PrivacySettingsScreen(
              privacySettingsBloc: privacySettingsBloc,
              accountBloc: accountBloc,
            )));
          }),
          Setting.createSetting(Icons.image_rounded, context.strings.current_moderation_request_screen_title, () {
              final currentModerationRequestBloc = context.read<CurrentModerationRequestBloc>();
              Navigator.push(context, MaterialPageRoute<void>(builder: (_) =>
                CurrentModerationRequestScreen(currentModerationRequestBloc: currentModerationRequestBloc)
              ));
            }
          ),
        ];

        // TODO(prod): Remove/hide admin settings from production build?
        if (state.capabilities.adminSettingsVisible()) {
          settings.add(Setting.createSetting(Icons.admin_panel_settings, context.strings.admin_settings_title, () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const AdminSettingsPage()))
          ));
        }

        // TODO(prod): Remove/hide debug settings
        settings.add(Setting.createSetting(Icons.bug_report_rounded, "Debug", () =>
          Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const DebugSettingsPage()))
        ));

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...settings.map((setting) => setting.toListTile()),
            ],
          ),
        );
      }
    );
  }
}

class Setting {
  final Widget _iconWidget;
  final Widget _widget;
  final void Function() action;
  Setting(this._iconWidget, this._widget, this.action);

  factory Setting.createSetting(IconData icon, String text, void Function() action) {
    return Setting(
      Icon(icon),
      Text(text),
      action,
    );
  }

  Widget toListTile() {
    return ListTile(
      onTap: () {
        action();
      },
      title: _widget,
      leading: _iconWidget,
    );
  }
}
