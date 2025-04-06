import 'package:app/logic/media/select_content.dart';
import 'package:app/logic/profile/profile_filtering_settings.dart';
import 'package:app/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:app/ui/normal/profiles/filter_profiles.dart';
import 'package:app/ui/normal/settings/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/edit_search_settings.dart';
import 'package:app/logic/settings/privacy_settings.dart';
import 'package:app/logic/settings/search_settings.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/account_settings.dart';
import 'package:app/ui/normal/settings/data_settings.dart';
import 'package:app/ui/normal/settings/general_settings.dart';
import 'package:app/ui/normal/settings/media/content_management.dart';
import 'package:app/ui/normal/settings/notification_settings.dart';
import 'package:app/ui/normal/settings/privacy_settings.dart';
import 'package:app/ui/normal/settings/profile/search_settings.dart';
import 'package:app/localizations.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.settings_screen_title),
      ),
      body: buildList(context),
    );
  }

  Widget buildList(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        List<Setting> settings = [
          Setting.createSetting(Icons.person, context.strings.account_settings_screen_title, () {
              openAccountSettings(context);
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
          Setting.createSettingWithCustomIcon(
            BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
              builder: (_, state) => Icon(state.icon()),
            ),
            context.strings.profile_filtering_settings_screen_title,
            () => openProfileFilteringSettings(context),
          ),
          Setting.createSetting(Icons.location_on, context.strings.profile_location_screen_title, () {
            MyNavigator.push(context, const MaterialPage<void>(child: LocationScreen()));
          }),
          if (!kIsWeb) Setting.createSetting(Icons.notifications, context.strings.notification_settings_screen_title, () {
              openNotificationSettings(context);
            }
          ),
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
          Setting.createSetting(Icons.image_rounded, context.strings.content_management_screen_title, () {
              final bloc = context.read<SelectContentBloc>();
              MyNavigator.push(context, MaterialPage<void>(child:
                ContentManagementScreen(selectContentBloc: bloc)
              ));
            }
          ),
          Setting.createSetting(Icons.storage, context.strings.data_settings_screen_title, () {
              MyNavigator.push(context, const MaterialPage<void>(child:
                DataSettingsScreen()
              ));
            }
          ),
          Setting.createSetting(Icons.miscellaneous_services, context.strings.general_settings_screen_title, () {
              MyNavigator.push(context, const MaterialPage<void>(child:
                GeneralSettingsScreen()
              ));
            }
          ),
        ];

        return list(settings);
      }
    );
  }

  Widget list(List<Setting> settings) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...settings.map((setting) => setting.toListTile()),
        ],
      ),
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

  factory Setting.createSettingWithCustomIcon(Widget icon, String text, void Function() action) {
    return Setting(
      icon,
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
