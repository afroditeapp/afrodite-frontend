

import 'package:app/ui/normal/settings/admin/moderate_profile_texts.dart';
import 'package:app/ui/normal/settings/admin/open_account_admin_settings.dart';
import 'package:app/ui/normal/settings/admin/report/process_reports.dart';
import 'package:app/ui/normal/settings/admin/server_tasks.dart';
import 'package:app/ui/normal/settings/admin/view_accounts.dart';
import 'package:app/ui/normal/settings/admin/view_admins.dart';
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
      body: settingsListWidget(context),
    );
  }

  Widget settingsListWidget(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        List<Setting> settings = settingsList(context, AdminSettingsPermissions(state.permissions));
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

  List<Setting> settingsList(BuildContext context, AdminSettingsPermissions permissions) {
    List<Setting> settings = [];

    if (permissions.adminModerateMediaContent) {
      settings.add(Setting.createSetting(Icons.image, "Moderate images (initial moderation, bot and human)", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ModerateImagesScreen(queueType: ModerationQueueType.initialMediaModeration, showContentWhichBotsCanModerate: true)),)
      ));
      settings.add(Setting.createSetting(Icons.image, "Moderate images (initial moderation, human)", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ModerateImagesScreen(queueType: ModerationQueueType.initialMediaModeration, showContentWhichBotsCanModerate: false)),)
      ));
      settings.add(Setting.createSetting(Icons.image, "Moderate images (normal, bot and human)", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ModerateImagesScreen(queueType: ModerationQueueType.mediaModeration, showContentWhichBotsCanModerate: true)),)
      ));
      settings.add(Setting.createSetting(Icons.image, "Moderate images (normal, human)", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ModerateImagesScreen(queueType: ModerationQueueType.mediaModeration, showContentWhichBotsCanModerate: false)),)
      ));
    }
    if (permissions.adminServerMaintenanceSaveBackendConfig ||
        permissions.adminServerMaintenanceViewBackendConfig) {
      settings.add(Setting.createSetting(Icons.settings, "Configure backend", () =>
        MyNavigator.push(context, MaterialPage<void>(child: const ConfigureBackendPage()),)
      ));
    }
    if (permissions.adminServerMaintenanceViewInfo) {
      settings.add(Setting.createSetting(Icons.info_outline, "Server system info", () =>
        MyNavigator.push(context, MaterialPage<void>(child: const ServerSystemInfoPage()),)
      ));
    }
    if (
      permissions.adminServerMaintenanceRebootBackend ||
      permissions.adminServerMaintenanceResetData
    ) {
      settings.add(Setting.createSetting(Icons.schedule, "Server tasks", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ServerTasksScreen(permissions: permissions._permissions,)),)
      ));
    }
    if (permissions.adminServerMaintenanceUpdateSoftware) {
      settings.add(Setting.createSetting(Icons.system_update_alt, "Server software update", () =>
        MyNavigator.push(context, MaterialPage<void>(child: const ServerSoftwareUpdatePage()),)
      ));
    }
    if (permissions.adminServerMaintenanceViewInfo) {
      settings.add(Setting.createSetting(Icons.query_stats, "View server perf data", () =>
        MyNavigator.push(context, MaterialPage<void>(child: const ViewPerfDataPage()))
      ));
    }
    if (permissions.adminProfileStatistics) {
      settings.add(Setting.createSetting(Icons.query_stats, context.strings.profile_statistics_history_screen_title, () =>
        openProfileStatisticsHistoryScreen(context),
      ));
    }
    if (permissions.adminModerateProfileNames) {
      settings.add(Setting.createSetting(Icons.text_fields, context.strings.moderate_profile_names_screen_title, () =>
        openProfileNameModerationScreen(context),
      ));
    }
    if (permissions.adminModerateProfileTexts) {
      settings.add(Setting.createSetting(Icons.text_fields, "Moderate profile texts (bot and human)", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ModerateProfileTextsScreen(showTextsWhichBotsCanModerate: true)),)
      ));
      settings.add(Setting.createSetting(Icons.text_fields, "Moderate profile texts (human)", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ModerateProfileTextsScreen(showTextsWhichBotsCanModerate: false)),)
      ));
    }
    if (permissions.adminFindAccountByEmail) {
      settings.add(Setting.createSetting(Icons.account_box, "Open account admin tools", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: OpenAccountAdminSettings()),)
      ));
    }
    if (permissions.adminViewPermissions) {
      settings.add(Setting.createSetting(Icons.admin_panel_settings, "View admins", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: ViewAdminsScreen()),)
      ));
    }
    if (permissions.adminViewAllProfiles) {
      settings.add(Setting.createSetting(Icons.group, "View accounts", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: ViewAccountsScreen()),)
      ));
    }
    if (permissions.adminProcessReports) {
      settings.add(Setting.createSetting(Icons.report, "Process reports", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ProcessReportsScreen()))
      ));
    }
    return settings;
  }
}

class AdminSettingsPermissions {
  final Permissions _permissions;
  bool get adminModerateMediaContent => _permissions.adminModerateMediaContent;
  bool get adminModerateProfileTexts => _permissions.adminModerateProfileTexts;
  bool get adminModerateProfileNames => _permissions.adminModerateProfileNames;
  bool get adminProcessReports => _permissions.adminProcessReports;
  bool get adminViewPermissions => _permissions.adminViewPermissions;
  bool get adminViewAllProfiles => _permissions.adminViewAllProfiles;
  bool get adminServerMaintenanceRebootBackend => _permissions.adminServerMaintenanceRebootBackend;
  bool get adminServerMaintenanceSaveBackendConfig => _permissions.adminServerMaintenanceSaveBackendConfig;
  bool get adminServerMaintenanceViewBackendConfig => _permissions.adminServerMaintenanceViewBackendConfig;
  bool get adminServerMaintenanceViewInfo => _permissions.adminServerMaintenanceViewInfo;
  bool get adminServerMaintenanceUpdateSoftware => _permissions.adminServerMaintenanceUpdateSoftware;
  bool get adminServerMaintenanceResetData => _permissions.adminServerMaintenanceResetData;
  bool get adminProfileStatistics => _permissions.adminProfileStatistics;
  bool get adminFindAccountByEmail => _permissions.adminFindAccountByEmail;
  AdminSettingsPermissions(this._permissions);

  bool somePermissionEnabled() {
    return adminModerateMediaContent ||
      adminModerateProfileTexts ||
      adminModerateProfileNames ||
      adminProcessReports ||
      adminViewPermissions ||
      adminViewAllProfiles ||
      adminServerMaintenanceRebootBackend ||
      adminServerMaintenanceSaveBackendConfig ||
      adminServerMaintenanceViewBackendConfig ||
      adminServerMaintenanceViewInfo ||
      adminServerMaintenanceUpdateSoftware ||
      adminServerMaintenanceResetData ||
      adminProfileStatistics ||
      adminFindAccountByEmail;
  }
}
