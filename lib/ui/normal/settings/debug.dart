

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/chat/debug_page.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/configure_backend.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/server_software_update.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/server_system_info.dart';


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
