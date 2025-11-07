import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/edit_admin_notifications.dart';
import 'package:app/ui/normal/settings/admin/moderator_tasks.dart';
import 'package:app/ui/normal/settings/admin/open_account_admin_settings.dart';
import 'package:app/ui/normal/settings/admin/view_accounts.dart';
import 'package:app/ui/normal/settings/admin/view_admins.dart';
import 'package:app/ui/normal/settings/server.dart';
import 'package:app/ui/normal/settings/metrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui/normal/settings.dart';

class AdminSettingsPage extends MyScreenPage<()> with SimpleUrlParser<AdminSettingsPage> {
  AdminSettingsPage() : super(builder: (_) => AdminSettingsScreen());

  @override
  AdminSettingsPage create() => AdminSettingsPage();
}

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

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
          child: Column(children: [...settings.map((setting) => setting.toListTile())]),
        );
      },
    );
  }

  List<Setting> settingsList(BuildContext context, AdminSettingsPermissions permissions) {
    List<Setting> settings = [];

    final r = context.read<RepositoryInstances>();

    if (permissions.adminModerateMediaContent ||
        permissions.adminModerateProfileNames ||
        permissions.adminModerateProfileTexts ||
        permissions.adminProcessReports) {
      settings.add(
        Setting.createSetting(
          Icons.task,
          "Moderator tasks (show todo list)",
          () => MyNavigator.push(context, ModeratorTasksPage(r)),
        ),
      );
      settings.add(
        Setting.createSetting(
          Icons.task,
          "Moderator tasks (show all)",
          () => MyNavigator.push(context, ModeratorTasksPage(r, showAll: true)),
        ),
      );
    }
    if (permissions.adminServerMaintenanceSaveBackendConfig ||
        permissions.adminServerMaintenanceViewBackendConfig ||
        permissions.adminServerMaintenanceViewInfo ||
        permissions.adminServerMaintenanceRebootBackend ||
        permissions.adminServerMaintenanceResetData ||
        permissions.adminServerMaintenanceUpdateSoftware ||
        permissions.adminServerMaintenanceEditNotification) {
      const title = "Server";
      settings.add(
        Setting.createSetting(
          Icons.settings,
          title,
          () => MyNavigator.pushLimited(context, ServerPage(title: title)),
        ),
      );
    }
    if (permissions.adminServerMaintenanceViewInfo || permissions.adminProfileStatistics) {
      const title = "Metrics";
      settings.add(
        Setting.createSetting(
          Icons.query_stats,
          title,
          () => MyNavigator.pushLimited(context, MetricsPage(title: title)),
        ),
      );
    }
    if (permissions.adminFindAccountByEmailAddress) {
      settings.add(
        Setting.createSetting(
          Icons.account_box,
          "Open account admin tools",
          () => MyNavigator.pushLimited(context, OpenAccountAdminSettingsPage()),
        ),
      );
    }
    if (permissions.adminViewPermissions) {
      settings.add(
        Setting.createSetting(
          Icons.admin_panel_settings,
          "View admins",
          () => MyNavigator.pushLimited(context, ViewAdminsPage(r)),
        ),
      );
    }
    if (permissions.adminViewAllProfiles) {
      settings.add(
        Setting.createSetting(
          Icons.group,
          "View accounts",
          () => MyNavigator.pushLimited(context, ViewAccountsPage(r)),
        ),
      );
    }
    if (permissions.adminSubscribeAdminNotifications) {
      settings.add(
        Setting.createSetting(
          Icons.notifications,
          ADMIN_NOTIFICATIONS_TITLE,
          () => openAdminNotificationsScreen(context),
        ),
      );
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
  bool get adminServerMaintenanceSaveBackendConfig =>
      _permissions.adminServerMaintenanceSaveBackendConfig;
  bool get adminServerMaintenanceViewBackendConfig =>
      _permissions.adminServerMaintenanceViewBackendConfig;
  bool get adminServerMaintenanceViewInfo => _permissions.adminServerMaintenanceViewInfo;
  bool get adminServerMaintenanceUpdateSoftware =>
      _permissions.adminServerMaintenanceUpdateSoftware;
  bool get adminServerMaintenanceResetData => _permissions.adminServerMaintenanceResetData;
  bool get adminServerMaintenanceEditNotification =>
      _permissions.adminServerMaintenanceEditNotification;
  bool get adminProfileStatistics => _permissions.adminProfileStatistics;
  bool get adminFindAccountByEmailAddress => _permissions.adminFindAccountByEmailAddress;
  bool get adminSubscribeAdminNotifications => _permissions.adminSubscribeAdminNotifications;
  AdminSettingsPermissions(this._permissions);

  Permissions get apiPermissions => _permissions;

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
        adminFindAccountByEmailAddress ||
        adminSubscribeAdminNotifications;
  }
}
