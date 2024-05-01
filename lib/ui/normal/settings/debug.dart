

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/general/notification/state/moderation_request_status.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
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
      MyNavigator.push(context, MaterialPage<void>(child: ChatViewDebuggerPage(AccountId(accountId: ""))))
    ));

    settings.add(Setting.createSetting(Icons.chat_bubble_rounded, "Chat with messages", () =>
      MyNavigator.push(context, MaterialPage<void>(child: ChatViewDebuggerPage(AccountId(accountId: ""), initialMsgCount: 5)))
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Test notification", () =>
      NotificationModerationRequestStatus.getInstance().show(ModerationRequestStateSimple.accepted)
    ));

    return SingleChildScrollView(
      child: Column(
        children: [
          ...settings.map((setting) => setting.toListTile()),
        ],
      ),
    );
  }
}
