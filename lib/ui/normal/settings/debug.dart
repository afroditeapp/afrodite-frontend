

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/ui/normal/chat/debug_page.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';


class DebugSettingsPage extends StatelessWidget {
  const DebugSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug")),
      body: settingsList(context),
    );
  }

  Widget settingsList(BuildContext context) {
    List<Setting> settings = [];

    settings.add(Setting.createSetting(Icons.chat_bubble_outline_rounded, "Chat without messages", () =>
      Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ChatViewDebuggerPage(AccountId(accountId: ""))))
    ));

    settings.add(Setting.createSetting(Icons.chat_bubble_rounded, "Chat with messages", () =>
      Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ChatViewDebuggerPage(AccountId(accountId: ""), initialMsgCount: 5)))
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Test notification", () =>
      NotificationManager.getInstance().sendNotification()
    ));

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
}
