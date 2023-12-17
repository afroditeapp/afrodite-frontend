

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/configure_backend.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/server_software_update.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/server_system_info.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/view_perf_data.dart';


class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin")),
      body: settingsList(context),
    );
  }

  Widget settingsList(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        List<Setting> settings = [];

        if (state.capabilities.adminModerateImages) {
          settings.add(Setting.createSetting(Icons.image, "Moderate images", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ModerateImagesPage()),)
          ));
        }
        if (state.capabilities.adminServerMaintenanceRebootBackend ||
            state.capabilities.adminServerMaintenanceSaveBackendConfig ||
            state.capabilities.adminServerMaintenanceViewBackendConfig) {
          settings.add(Setting.createSetting(Icons.settings, "Configure backend", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ConfigureBackendPage()),)
          ));
        }
        if (state.capabilities.adminServerMaintenanceViewInfo) {
          settings.add(Setting.createSetting(Icons.info_outline, "Server system info", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ServerSystemInfoPage()),)
          ));
        }
        if (state.capabilities.adminServerMaintenanceViewInfo &&
            state.capabilities.adminServerMaintenanceUpdateSoftware) {
          settings.add(Setting.createSetting(Icons.system_update_alt, "Server software update", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ServerSoftwareUpdatePage()),)
          ));
        }
        if (state.capabilities.adminServerMaintenanceViewInfo) {
          settings.add(Setting.createSetting(Icons.query_stats, "View server perf data", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ViewPerfDataPage()))
          ));
        }

        return ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                settings[index].action();
              },
              title: settings[index].widget,
            );
          },
        );
      }
    );
  }
}
