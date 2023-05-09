import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    List<Setting> settings = [
      createSetting(Icons.account_circle, "My profile", () => {}),
      createSetting(Icons.admin_panel_settings, "Admin", () => {}),
    ];
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

  Setting createSetting(IconData icon, String text, void Function() action) {
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

class Setting {
  final Widget widget;
  final void Function() action;
  Setting(this.widget, this.action);
}
