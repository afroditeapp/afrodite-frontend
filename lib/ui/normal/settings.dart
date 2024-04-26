import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/logic/settings/edit_search_settings.dart';
import 'package:pihka_frontend/logic/settings/privacy_settings.dart';
import 'package:pihka_frontend/logic/settings/search_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/ui/normal/settings/account_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin.dart';
import 'package:pihka_frontend/ui/normal/settings/data_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/debug.dart';
import 'package:pihka_frontend/ui/normal/settings/media/current_moderation_request.dart';
import 'package:pihka_frontend/ui/normal/settings/my_profile.dart';
import 'package:pihka_frontend/ui/normal/settings/privacy_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/search_settings.dart';
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
          Setting.createSetting(Icons.person, context.strings.account_settings_screen, () {
              MyNavigator.push(context, const MaterialPage<void>(child:
                AccountSettingsScreen()
              ));
            }
          ),
          Setting.createSetting(Icons.search, context.strings.search_settings_screen_title, () {
            final pageKey = PageKey();
            final searchSettingsBloc = context.read<SearchSettingsBloc>();
            final editSearchSettingsBloc = context.read<EditSearchSettingsBloc>();
            MyNavigator.pushWithKey(
              context,
              MaterialPage<void>(child: SearchSettingsScreen(
                pageKey: pageKey,
                searchSettingsBloc: searchSettingsBloc,
                editSearchSettingsBloc: editSearchSettingsBloc,
              )),
              pageKey,
            );
          }),
          Setting.createSetting(Icons.lock_rounded, context.strings.privacy_settings_screen_title, () {
            final pageKey = PageKey();
            final privacySettingsBloc = context.read<PrivacySettingsBloc>();
            final accountBloc = context.read<AccountBloc>();
            MyNavigator.pushWithKey(
              context,
              MaterialPage<void>(child: PrivacySettingsScreen(
                pageKey: pageKey,
                privacySettingsBloc: privacySettingsBloc,
                accountBloc: accountBloc,
              )),
              pageKey,
            );
          }),
          Setting.createSetting(Icons.image_rounded, context.strings.current_moderation_request_screen_title, () {
              final currentModerationRequestBloc = context.read<CurrentModerationRequestBloc>();
              MyNavigator.push(context, MaterialPage<void>(child:
                CurrentModerationRequestScreen(currentModerationRequestBloc: currentModerationRequestBloc)
              ));
            }
          ),
          Setting.createSetting(Icons.storage, context.strings.data_settings_screen, () {
              MyNavigator.push(context, const MaterialPage<void>(child:
                DataSettingsScreen()
              ));
            }
          ),
        ];

        // TODO(prod): Remove/hide admin settings from production build?
        if (state.capabilities.adminSettingsVisible()) {
          settings.add(Setting.createSetting(Icons.admin_panel_settings, context.strings.admin_settings_title, () =>
            MyNavigator.push(context, const MaterialPage<void>(child: AdminSettingsPage()))
          ));
        }

        // TODO(prod): Remove/hide debug settings
        settings.add(Setting.createSetting(Icons.bug_report_rounded, "Debug", () =>
          MyNavigator.push(context, const MaterialPage<void>(child: DebugSettingsPage()))
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
