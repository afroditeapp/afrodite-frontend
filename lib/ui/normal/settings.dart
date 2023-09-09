import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings/admin.dart';
import 'package:pihka_frontend/ui/normal/settings/profile.dart';
import 'package:pihka_frontend/ui/utils.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends BottomNavigationView {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();

  @override
  List<Widget> actions(BuildContext context) {
    return [
      PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(value: "about", child: Text(AppLocalizations.of(context).pageSettingsAboutAction)),
          ];
        },
        onSelected: (value) {
          switch (value) {
            case "about": {
              showAboutDialog(
                context: context,
                applicationName: "Pihka",
                applicationVersion: "0.1.0",
                applicationIcon: null,
                applicationLegalese: "© 2023 Pihka",
              );
            }
          }
        },
      ),
    ];
  }

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageSettingsTitle;
  }
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountData>(
      builder: (context, state) {
        List<Setting> settings = [
          Setting.createSetting(Icons.account_circle, AppLocalizations.of(context).pageMyProfileTitle, () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const MyProfilePage()),)
          ),
          Setting.createSetting(Icons.logout, AppLocalizations.of(context).pageSettingsLogoutTitle, () =>
            showConfirmDialog(context, AppLocalizations.of(context).pageSettingsLogoutTitle)
              .then((value) {
                if (value == true) {
                  context.read<AccountBloc>().add(DoLogout());
                }
              })
          ),
        ];

        if (state.capabilities.adminSettingsVisible()) {
          settings.add(Setting.createSetting(Icons.admin_panel_settings, AppLocalizations.of(context).pageAdminTitle, () =>
            Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const AdminSettingsPage()),)
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

class Setting {
  final Widget widget;
  final void Function() action;
  Setting(this.widget, this.action);

  factory Setting.createSetting(IconData icon, String text, void Function() action) {
    Widget widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 45,),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
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
