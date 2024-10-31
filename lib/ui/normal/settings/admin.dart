

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/configure_backend.dart';
import 'package:app/ui/normal/settings/admin/moderate_images.dart';
import 'package:app/ui/normal/settings/admin/profile_name_moderation.dart';
import 'package:app/ui/normal/settings/admin/profile_statistics_history.dart';
import 'package:app/ui/normal/settings/admin/server_software_update.dart';
import 'package:app/ui/normal/settings/admin/server_system_info.dart';
import 'package:app/ui/normal/settings/admin/view_perf_data.dart';


class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.admin_settings_title)),
      body: settingsList(context),
    );
  }

  Widget settingsList(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        List<Setting> settings = [];

        if (state.permissions.adminModerateImages) {
          settings.add(Setting.createSetting(Icons.image, "Moderate images (initial moderation)", () =>
            MyNavigator.push(context, MaterialPage<void>(child: const ModerateImagesPage(queueType: ModerationQueueType.initialMediaModeration)),)
          ));
          settings.add(Setting.createSetting(Icons.image, "Moderate images (normal)", () =>
            MyNavigator.push(context, MaterialPage<void>(child: const ModerateImagesPage(queueType: ModerationQueueType.mediaModeration)),)
          ));
        }
        if (state.permissions.adminServerMaintenanceRebootBackend ||
            state.permissions.adminServerMaintenanceSaveBackendConfig ||
            state.permissions.adminServerMaintenanceViewBackendConfig) {
          settings.add(Setting.createSetting(Icons.settings, "Configure backend", () =>
            MyNavigator.push(context, MaterialPage<void>(child: const ConfigureBackendPage()),)
          ));
        }
        if (state.permissions.adminServerMaintenanceViewInfo) {
          settings.add(Setting.createSetting(Icons.info_outline, "Server system info", () =>
            MyNavigator.push(context, MaterialPage<void>(child: const ServerSystemInfoPage()),)
          ));
        }
        if (state.permissions.adminServerMaintenanceViewInfo &&
            state.permissions.adminServerMaintenanceUpdateSoftware) {
          settings.add(Setting.createSetting(Icons.system_update_alt, "Server software update", () =>
            MyNavigator.push(context, MaterialPage<void>(child: const ServerSoftwareUpdatePage()),)
          ));
        }
        if (state.permissions.adminServerMaintenanceViewInfo) {
          settings.add(Setting.createSetting(Icons.query_stats, "View server perf data", () =>
            MyNavigator.push(context, MaterialPage<void>(child: const ViewPerfDataPage()))
          ));
        }
        if (state.permissions.adminProfileStatistics) {
          settings.add(Setting.createSetting(Icons.query_stats, context.strings.profile_statistics_history_screen_title, () =>
            openProfileStatisticsHistoryScreen(context),
          ));
        }
        if (state.permissions.adminModerateProfileNames) {
          settings.add(Setting.createSetting(Icons.text_fields, context.strings.moderate_profile_names_screen_title, () =>
            openProfileNameModerationScreen(context),
          ));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ...settings.map((setting) => setting.toListTile()),
            ],
          ),
        );
      }
    );
  }
}
