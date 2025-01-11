import 'package:app/ui/normal/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/account/news/news_count.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/news/news_count.dart';
import 'package:app/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:app/ui/normal/settings/admin.dart';
import 'package:app/ui/normal/settings/debug.dart';
import 'package:app/ui/normal/settings/my_profile.dart';
import 'package:app/ui/normal/settings/news/news_list.dart';
import 'package:app/ui/normal/settings/profile_statistics.dart';
import 'package:app/ui_utils/bottom_navigation.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/app_bar/common_actions.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/scroll_controller.dart';

class MenuView extends BottomNavigationScreen {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();

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
    return context.strings.menu_screen_title;
  }
}

class _MenuViewState extends State<MenuView> {
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
          Setting.createSetting(Icons.account_box, context.strings.view_profile_screen_my_profile_title, () =>
            MyNavigator.push(context, const MaterialPage<void>(child: MyProfileScreen()))
          ),
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
          Setting.createSetting(Icons.settings, context.strings.settings_screen_title, () {
              MyNavigator.push(context, const MaterialPage<void>(child:
                SettingsScreen()
              ));
            }
          ),
        ];

        // TODO(prod): Remove/hide admin settings from production build?
        if (AdminSettingsPermissions(state.permissions).somePermissionEnabled()) {
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
