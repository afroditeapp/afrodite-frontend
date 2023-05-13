import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings/admin.dart';
import 'package:pihka_frontend/ui/normal/settings/profile.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountData>(
      builder: (context, state) {
        List<Setting> settings = [
          Setting.createSetting(Icons.account_circle, "My profile", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const MyProfilePage()),)
          ),
        ];

        if (state.capabilities.adminSettingsVisible()) {
          settings.add(Setting.createSetting(Icons.admin_panel_settings, "Admin", () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const AdminSettingsPage()),)
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

class Setting {
  final Widget widget;
  final void Function() action;
  Setting(this.widget, this.action);

  factory Setting.createSetting(IconData icon, String text, void Function() action) {
    Widget widget = Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Icon(icon, size: 50,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Text(text),
        ],
      ),
    );
    return Setting(widget, action);
  }
}

extension GetCapabilities on Capabilities {
  bool adminSettingsVisible() {
    return adminModerateImages ?? false;
  }
}
