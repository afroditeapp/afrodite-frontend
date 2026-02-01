import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin.dart';
import 'package:app/ui/normal/settings/admin/edit_maintenance_notification.dart';
import 'package:app/ui/normal/settings/admin/server_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/bot_config.dart';
import 'package:app/ui/normal/settings/admin/server_software_update.dart';
import 'package:app/ui/normal/settings/admin/server_system_info.dart';

class ServerPage extends MyScreenPageLimited<()> {
  ServerPage({required String title}) : super(builder: (_) => ServerScreen(title: title));
}

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
          child: Column(children: [...settings.map((setting) => setting.toListTile())]),
        );
      },
    );
  }

  List<Setting> settingsList(BuildContext context, AdminSettingsPermissions permissions) {
    List<Setting> settings = [];

    final r = context.read<RepositoryInstances>();

    if (permissions.adminServerEditBotConfig || permissions.adminServerViewBotConfig) {
      settings.add(
        Setting.createSetting(
          Icons.settings,
          "Bots",
          () => MyNavigator.pushLimited(context, BotConfigPage(r)),
        ),
      );
    }
    if (permissions.adminServerViewInfo) {
      settings.add(
        Setting.createSetting(
          Icons.info_outline,
          "Server system info",
          () => MyNavigator.pushLimited(context, ServerSystemInfoPage(r)),
        ),
      );
    }
    if (permissions.adminServerRestart || permissions.adminServerDataReset) {
      settings.add(
        Setting.createSetting(
          Icons.schedule,
          "Server tasks",
          () => MyNavigator.pushLimited(
            context,
            ServerTasksPage(r, permissions: permissions.apiPermissions),
          ),
        ),
      );
    }
    if (permissions.adminServerSoftwareUpdate) {
      settings.add(
        Setting.createSetting(
          Icons.system_update_alt,
          "Server software update",
          () => MyNavigator.pushLimited(context, ServerSoftwareUpdatePage(r)),
        ),
      );
    }
    if (permissions.adminServerEditMaintenanceNotification) {
      settings.add(
        Setting.createSetting(
          Icons.settings,
          "Edit maintenance notification",
          () => MyNavigator.pushLimited(context, EditMaintenanceNotificationPage(r)),
        ),
      );
    }
    return settings;
  }
}
