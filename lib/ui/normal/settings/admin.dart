

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/server_software_update.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/server_system_info.dart';


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
    return BlocBuilder<AccountBloc, AccountData>(
      builder: (context, state) {
        List<Setting> settings = [];

        if (state.capabilities.adminModerateImages ?? false) {
          settings.add(Setting.createSetting(Icons.image, "Moderate images", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ModerateImagesPage()),)
          ));
        }
        if (state.capabilities.adminServerMaintentanceViewInfo ?? false) {
          settings.add(Setting.createSetting(Icons.info_outline, "Server system info", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ServerSystemInfoPage()),)
          ));
        }
        if ((state.capabilities.adminServerMaintentanceViewInfo ?? false) &&
            (state.capabilities.adminServerMaintentanceUpdateSoftware ?? false)) {
          settings.add(Setting.createSetting(Icons.system_update_alt, "Server software update", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ServerSoftwareUpdatePage()),)
          ));
        }

        return ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                print(index);
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
