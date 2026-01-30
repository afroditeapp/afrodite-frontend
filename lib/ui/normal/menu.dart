import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/logic/profile/automatic_profile_search_badge.dart';
import 'package:app/logic/server/maintenance.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/profile/automatic_profile_search_badge.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/notifications/automatic_profile_search_results.dart';
import 'package:app/utils/time.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
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
import 'package:app/ui/normal/settings/statistics.dart';
import 'package:app/ui_utils/bottom_navigation.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/app_bar/common_actions.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/scroll_controller.dart';
import 'package:openapi/api.dart';

class MenuView extends BottomNavigationScreen {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();

  @override
  List<Widget> actions(BuildContext context) {
    return [
      menuActions([
        commonActionOpenAboutDialog(context, context.read<ClientFeaturesConfigBloc>().state),
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
    BottomNavigationStateBlocInstance.getInstance().updateIsScrolled(
      isScrolled,
      BottomNavigationScreenId.settings,
      (state) => state.isScrolledSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
          builder: (context, clientFeatures) {
            List<Setting> settings = menuItems(context, state.permissions, clientFeatures.config);
            return NotificationListener<ScrollMetricsNotification>(
              onNotification: (notification) {
                final isScrolled = notification.metrics.pixels > 0;
                updateIsScrolled(isScrolled);
                return true;
              },
              child: BlocListener<BottomNavigationStateBloc, BottomNavigationStateData>(
                listenWhen: (previous, current) =>
                    previous.isTappedAgainSettings != current.isTappedAgainSettings,
                listener: (context, state) {
                  if (state.isTappedAgainSettings) {
                    context.read<BottomNavigationStateBloc>().add(
                      SetIsTappedAgainValue(BottomNavigationScreenId.settings, false),
                    );
                    _scrollController.bottomNavigationRelatedJumpToBeginningIfClientsConnected();
                  }
                },
                child: BlocListener<BottomNavigationStateBloc, BottomNavigationStateData>(
                  listenWhen: (previous, current) => previous.screen != current.screen,
                  listener: (context, state) {
                    if (state.screen == BottomNavigationScreenId.settings) {
                      context.read<ServerMaintenanceBloc>().add(ViewServerMaintenanceInfo());
                    }
                  },
                  child: list(settings),
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Setting> menuItems(
    BuildContext context,
    Permissions permissions,
    ClientFeaturesConfig clientFeatures,
  ) {
    final r = context.read<RepositoryInstances>();
    List<Setting> settings = [
      Setting.createSetting(
        Icons.account_box,
        context.strings.view_profile_screen_my_profile_title,
        () => openMyProfileScreen(context),
      ),
      if (clientFeatures.news != null)
        Setting.createSettingWithCustomIcon(
          BlocBuilder<NewsCountBloc, NewsCountData>(
            builder: (context, state) {
              const icon = Icon(Icons.newspaper);
              final count = state.newsCountForUi(clientFeatures);
              if (count == 0) {
                return icon;
              } else {
                return Badge.count(count: count, child: icon);
              }
            },
          ),
          context.strings.news_list_screen_title,
          () => openNewsList(context),
        ),
      Setting.createSetting(
        Icons.bar_chart,
        context.strings.statistics_screen_title,
        () => openStatisticsScreen(context),
      ),
      Setting.createSettingWithCustomIcon(
        BlocBuilder<AutomaticProfileSearchBadgeBloc, AutomaticProfileSearchBadgeData>(
          builder: (context, state) {
            const icon = Icon(Icons.auto_awesome);
            final count = state.profileCount();
            if (count == 0) {
              return icon;
            } else {
              return Badge.count(count: count, child: icon);
            }
          },
        ),
        context.strings.automatic_profile_search_results_screen_title,
        () => openAutomaticProfileSearchResultsScreen(context),
      ),
      Setting.createSetting(
        Icons.settings,
        context.strings.settings_screen_title,
        () => openSettingsScreen(context),
      ),
    ];

    if (AdminSettingsPermissions(permissions).somePermissionEnabled()) {
      settings.add(
        Setting.createSetting(
          Icons.admin_panel_settings,
          context.strings.admin_settings_title,
          () => MyNavigator.push(context, AdminSettingsPage()),
        ),
      );
    }

    if (!kReleaseMode) {
      settings.add(
        Setting.createSetting(
          Icons.bug_report_rounded,
          "Debug",
          () => MyNavigator.push(context, DebugSettingsPage(r)),
        ),
      );
    }

    return settings;
  }

  Widget list(List<Setting> settings) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [viewServerMaintenanceInfo(), ...settings.map((setting) => setting.toListTile())],
      ),
    );
  }

  Widget viewServerMaintenanceInfo() {
    return BlocBuilder<ServerMaintenanceBloc, ServerMaintenanceInfo>(
      builder: (context, state) {
        final startTime = state.startTime;
        if (startTime == null) {
          return const SizedBox.shrink();
        }

        if (context.read<BottomNavigationStateBloc>().state.screen ==
            BottomNavigationScreenId.settings) {
          context.read<ServerMaintenanceBloc>().add(ViewServerMaintenanceInfo());
        }

        final startTimeString = fullTimeString(startTime);
        final endTime = state.endTime;
        String endTimeString;
        if (endTime == null) {
          endTimeString = "";
        } else {
          endTimeString = fullTimeString(endTime);
          final startDate = startTimeString.split(" ").firstOrNull;
          if (startDate != null && endTimeString.startsWith(startDate)) {
            endTimeString = endTimeString.replaceFirst(startDate, "").trimLeft();
          }
          endTimeString = " - $endTimeString";
        }
        return Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(right: 16)),
                Icon(Icons.info, color: Theme.of(context).colorScheme.onPrimaryContainer),
                const Padding(padding: EdgeInsets.only(right: 16)),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.strings.menu_screen_server_maintenance_title),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    Text("$startTimeString$endTimeString"),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(right: 16)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    super.dispose();
  }
}
