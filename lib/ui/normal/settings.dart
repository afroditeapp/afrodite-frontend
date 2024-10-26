import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/account/account_details.dart';
import 'package:pihka_frontend/logic/account/news/news_count.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/logic/settings/edit_search_settings.dart';
import 'package:pihka_frontend/logic/settings/privacy_settings.dart';
import 'package:pihka_frontend/logic/settings/search_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/account/news/news_count.dart';
import 'package:pihka_frontend/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/ui/normal/settings/account_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin.dart';
import 'package:pihka_frontend/ui/normal/settings/data_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/debug.dart';
import 'package:pihka_frontend/ui/normal/settings/general_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/media/current_moderation_request.dart';
import 'package:pihka_frontend/ui/normal/settings/my_profile.dart';
import 'package:pihka_frontend/ui/normal/settings/news/news_list.dart';
import 'package:pihka_frontend/ui/normal/settings/notification_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/privacy_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/search_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/profile_statistics.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/app_bar/common_actions.dart';
import 'package:pihka_frontend/ui_utils/app_bar/menu_actions.dart';
import 'package:pihka_frontend/ui_utils/scroll_controller.dart';
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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollEventListener);
  }

  void scrollEventListener() {
    bool isScrolled;
    if (!_scrollController.hasClients) {
      isScrolled = false;
    } else {
      isScrolled = _scrollController.position.pixels > 0;
    }
    updateIsScrolled(isScrolled);
  }

  void updateIsScrolled(bool isScrolled) {
    BottomNavigationStateBlocInstance.getInstance()
      .bloc
      .updateIsScrolled(
        isScrolled,
        BottomNavigationScreenId.settings,
        (state) => state.isScrolledSettings,
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        List<Setting> settings = [
          Setting.createSettingWithCustomIcon(
            BlocBuilder<NewsCountBloc, NewsCountData>(
              builder: (context, state) {
                const icon = Icon(Icons.newspaper);
                final count = state.newsCountForUi();
                if (count == 0) {
                  return icon;
                } else {
                  return Badge.count(count: count, child: icon);
                }
              }
            ),
            context.strings.news_list_screen_title, () => openNewsList(context),
          ),
          Setting.createSetting(Icons.bar_chart, context.strings.profile_statistics_screen_title, () =>
            openProfileStatisticsScreen(context)
          ),
          Setting.createSetting(Icons.account_box, context.strings.view_profile_screen_my_profile_title, () =>
            MyNavigator.push(context, const MaterialPage<void>(child: MyProfileScreen()))
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
          Setting.createSetting(Icons.image_rounded, context.strings.current_moderation_request_screen_title, () {
              final currentModerationRequestBloc = context.read<CurrentModerationRequestBloc>();
              MyNavigator.push(context, MaterialPage<void>(child:
                CurrentModerationRequestScreen(currentModerationRequestBloc: currentModerationRequestBloc)
              ));
            }
          ),
          Setting.createSetting(Icons.person, context.strings.account_settings_screen_title, () {
              final accountDetailsBloc = context.read<AccountDetailsBloc>();
              MyNavigator.push(context, MaterialPage<void>(child:
                AccountSettingsScreen(
                  accountDetailsBloc: accountDetailsBloc,
                )
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

        // TODO(prod): Remove/hide admin settings from production build?
        if (state.permissions.adminSettingsVisible()) {
          settings.add(Setting.createSetting(Icons.admin_panel_settings, context.strings.admin_settings_title, () =>
            MyNavigator.push(context, const MaterialPage<void>(child: AdminSettingsPage()))
          ));
        }

        // TODO(prod): Remove/hide debug settings
        settings.add(Setting.createSetting(Icons.bug_report_rounded, "Debug", () =>
          MyNavigator.push(context, MaterialPage<void>(child: DebugSettingsPage()))
        ));

        return NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) {
            final isScrolled = notification.metrics.pixels > 0;
            updateIsScrolled(isScrolled);
            return true;
          },
          child: BlocListener<BottomNavigationStateBloc, BottomNavigationStateData>(
            listenWhen: (previous, current) => previous.isTappedAgainSettings != current.isTappedAgainSettings,
            listener: (context, state) {
              if (state.isTappedAgainSettings) {
                context.read<BottomNavigationStateBloc>().add(SetIsTappedAgainValue(BottomNavigationScreenId.settings, false));
                _scrollController.bottomNavigationRelatedJumpToBeginningIfClientsConnected();
              }
            },
            child: list(settings),
          ),
        );
      }
    );
  }

  Widget list(List<Setting> settings) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...settings.map((setting) => setting.toListTile()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    super.dispose();
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
