import 'package:app/data/login_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/ui/normal/settings/admin.dart';
import 'package:app/ui/normal/settings/admin/profile_statistics_history.dart';
import 'package:app/ui/normal/settings/admin/view_client_version_statistics.dart';
import 'package:app/ui/normal/settings/admin/view_ip_country_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/view_perf_data.dart';

class MetricsScreen extends StatelessWidget {
  final String title;
  const MetricsScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: settingsListWidget(context),
    );
  }

  Widget settingsListWidget(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        List<Setting> settings = settingsList(context, AdminSettingsPermissions(state.permissions));
        return SingleChildScrollView(
          child: Column(children: [...settings.map((setting) => setting.toListTile())]),
        );
      },
    );
  }

  List<Setting> settingsList(BuildContext context, AdminSettingsPermissions permissions) {
    final api = LoginRepository.getInstance().repositories.api;
    final ipCountryDataAttribution = context
        .read<ClientFeaturesConfigBloc>()
        .state
        .ipCountryDataAttribution(context);
    List<Setting> settings = [];

    if (permissions.adminServerMaintenanceViewInfo) {
      const title = "View server perf data";
      settings.add(
        Setting.createSetting(
          Icons.query_stats,
          title,
          () => openViewPerfDataScreen(context, title, api),
        ),
      );
      const clientVersionStatistics = "Client version statistics (hourly)";
      settings.add(
        Setting.createSetting(
          Icons.query_stats,
          clientVersionStatistics,
          () => openViewClientVersionStatisticsScreen(context, clientVersionStatistics, api),
        ),
      );
      const clientVersionStatisticsDaily = "Client version statistics (daily)";
      settings.add(
        Setting.createSetting(
          Icons.query_stats,
          clientVersionStatisticsDaily,
          () => openViewClientVersionStatisticsScreen(
            context,
            clientVersionStatisticsDaily,
            api,
            daily: true,
          ),
        ),
      );
      const ipCountryStatisticsHourly = "IP country statistics (hourly)";
      settings.add(
        Setting.createSetting(
          Icons.query_stats,
          ipCountryStatisticsHourly,
          () => openViewIpCountryStatisticsScreen(
            context,
            ipCountryStatisticsHourly,
            api,
            dataAttribution: ipCountryDataAttribution,
          ),
        ),
      );
      const ipCountryStatisticsDaily = "IP country statistics (daily)";
      settings.add(
        Setting.createSetting(
          Icons.query_stats,
          ipCountryStatisticsDaily,
          () => openViewIpCountryStatisticsScreen(
            context,
            ipCountryStatisticsDaily,
            api,
            daily: true,
            dataAttribution: ipCountryDataAttribution,
          ),
        ),
      );
      const ipCountryStatisticsCounters = "IP country statistics (counters)";
      settings.add(
        Setting.createSetting(
          Icons.query_stats,
          ipCountryStatisticsCounters,
          () => openViewIpCountryStatisticsScreen(
            context,
            ipCountryStatisticsCounters,
            api,
            fromRam: true,
            dataAttribution: ipCountryDataAttribution,
          ),
        ),
      );
    }
    if (permissions.adminProfileStatistics) {
      settings.add(
        Setting.createSetting(
          Icons.query_stats,
          context.strings.profile_statistics_history_screen_title,
          () => openProfileStatisticsHistoryScreen(context),
        ),
      );
    }
    return settings;
  }
}
