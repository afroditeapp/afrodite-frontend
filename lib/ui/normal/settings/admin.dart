
import 'package:app/data/login_repository.dart';
import 'package:app/ui/normal/settings/admin/edit_admin_notifications.dart';
import 'package:app/ui/normal/settings/admin/edit_maintenance_notification.dart';
import 'package:app/ui/normal/settings/admin/moderator_tasks.dart';
import 'package:app/ui/normal/settings/admin/open_account_admin_settings.dart';
import 'package:app/ui/normal/settings/admin/server_tasks.dart';
import 'package:app/ui/normal/settings/admin/view_accounts.dart';
import 'package:app/ui/normal/settings/admin/view_admins.dart';
import 'package:app/ui/normal/settings/admin/view_client_version_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/configure_backend.dart';
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
    final api = LoginRepository.getInstance().repositories.api;
    List<Setting> settings = [];

    if (
      permissions.adminModerateMediaContent ||
      permissions.adminModerateProfileNames ||
      permissions.adminModerateProfileTexts ||
      permissions.adminProcessReports
    ) {
      settings.add(Setting.createSetting(Icons.task, "Moderator tasks (show todo list)", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: ModeratorTasksScreen()))
      ));
      settings.add(Setting.createSetting(Icons.task, "Moderator tasks (show all)", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: ModeratorTasksScreen(showAll: true)))
      ));
    }
    if (permissions.adminServerMaintenanceSaveBackendConfig ||
        permissions.adminServerMaintenanceViewBackendConfig) {
      settings.add(Setting.createSetting(Icons.settings, "Configure backend", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: ConfigureBackendPage()),)
      ));
    }
    if (permissions.adminServerMaintenanceViewInfo) {
      settings.add(Setting.createSetting(Icons.info_outline, "Server system info", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: ServerSystemInfoPage()),)
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
        MyNavigator.push(context, const MaterialPage<void>(child: ServerSoftwareUpdatePage()),)
      ));
    }
    if (permissions.adminServerMaintenanceViewInfo) {
      const title = "View server perf data";
      settings.add(Setting.createSetting(Icons.query_stats, title, () =>
        openViewPerfDataScreen(context, title, api)
      ));
      const clientVersionStatistics = "Client version statistics (hourly)";
      settings.add(Setting.createSetting(Icons.query_stats, clientVersionStatistics, () =>
        openViewClientVersionStatisticsScreen(context, clientVersionStatistics, api)
      ));
      const clientVersionStatisticsDaily = "Client version statistics (daily)";
      settings.add(Setting.createSetting(Icons.query_stats, clientVersionStatisticsDaily, () =>
        openViewClientVersionStatisticsScreen(context, clientVersionStatisticsDaily, api, daily: true)
      ));
    }
    if (permissions.adminServerMaintenanceEditNotification) {
      settings.add(Setting.createSetting(Icons.settings, "Edit maintenance notification", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: EditMaintenanceNotificationScreen()))
      ));
    }
    if (permissions.adminProfileStatistics) {
      settings.add(Setting.createSetting(Icons.query_stats, context.strings.profile_statistics_history_screen_title, () =>
        openProfileStatisticsHistoryScreen(context),
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
    if (permissions.adminSubscribeAdminNotifications) {
      settings.add(Setting.createSetting(Icons.notifications, ADMIN_NOTIFICATIONS_TITLE, () =>
        openAdminNotificationsScreen(context),
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
  bool get adminServerMaintenanceRebootBackend => _permissions.adminServerMaintenanceRestartBackend;
  bool get adminServerMaintenanceSaveBackendConfig => _permissions.adminServerMaintenanceSaveBackendConfig;
  bool get adminServerMaintenanceViewBackendConfig => _permissions.adminServerMaintenanceViewBackendConfig;
  bool get adminServerMaintenanceViewInfo => _permissions.adminServerMaintenanceViewInfo;
  bool get adminServerMaintenanceUpdateSoftware => _permissions.adminServerMaintenanceUpdateSoftware;
  bool get adminServerMaintenanceResetData => _permissions.adminServerMaintenanceResetData;
  bool get adminServerMaintenanceEditNotification => _permissions.adminServerMaintenanceEditNotification;
  bool get adminProfileStatistics => _permissions.adminProfileStatistics;
  bool get adminFindAccountByEmail => _permissions.adminFindAccountByEmail;
  bool get adminSubscribeAdminNotifications => _permissions.adminSubscribeAdminNotifications;
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
      adminServerMaintenanceEditNotification ||
      adminProfileStatistics ||
      adminFindAccountByEmail ||
      adminSubscribeAdminNotifications;
  }
}
