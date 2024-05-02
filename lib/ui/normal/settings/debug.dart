

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/general/notification/state/like_received.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/general/notification/state/moderation_request_status.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/ui/normal/chat/debug_page.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/utils/result.dart';


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

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: Image moderation status", () =>
      NotificationModerationRequestStatus.getInstance().show(ModerationRequestStateSimple.accepted)
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: Likes", () =>
      NotificationLikeReceived.getInstance().incrementReceivedLikesCount()
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (first chat)", () async {
      final matchList = await DatabaseManager.getInstance().profileData((db) => db.getMatchesList(0, 1)).ok();
      final match = matchList?.firstOrNull;
      if (match == null) {
        return;
      }
      await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1);
    }));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (second chat)", () async {
      final matchList = await DatabaseManager.getInstance().profileData((db) => db.getMatchesList(0, 2)).ok();
      final match = matchList?.lastOrNull;
      if (match == null) {
        return;
      }
      await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1);
    }));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (chats 1-5)", () async {
      final List<AccountId> matchList = await DatabaseManager.getInstance().profileData((db) => db.getMatchesList(0, 5)).ok() ?? [];
      for (final match in matchList) {
        await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1);
      }
    }));

    return SingleChildScrollView(
      child: Column(
        children: [
          ...settings.map((setting) => setting.toListTile()),
        ],
      ),
    );
  }
}
