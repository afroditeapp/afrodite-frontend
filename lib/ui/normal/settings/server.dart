
import 'package:app/ui/normal/settings/admin.dart';
import 'package:app/ui/normal/settings/admin/edit_maintenance_notification.dart';
import 'package:app/ui/normal/settings/admin/server_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/configure_backend.dart';
import 'package:app/ui/normal/settings/admin/server_software_update.dart';
import 'package:app/ui/normal/settings/admin/server_system_info.dart';

class ServerScreen extends StatelessWidget {
  final String title;
  const ServerScreen({required this.title, super.key});

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
        MyNavigator.push(context, MaterialPage<void>(child: ServerTasksScreen(permissions: permissions.apiPermissions)))
      ));
    }
    if (permissions.adminServerMaintenanceUpdateSoftware) {
      settings.add(Setting.createSetting(Icons.system_update_alt, "Server software update", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: ServerSoftwareUpdatePage()),)
      ));
    }
    if (permissions.adminServerMaintenanceEditNotification) {
      settings.add(Setting.createSetting(Icons.settings, "Edit maintenance notification", () =>
        MyNavigator.push(context, const MaterialPage<void>(child: EditMaintenanceNotificationScreen()))
      ));
    }
    return settings;
  }
}
