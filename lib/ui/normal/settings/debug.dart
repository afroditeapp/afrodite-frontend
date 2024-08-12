

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/general/notification/state/like_received.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/general/notification/state/moderation_request_status.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/ui/normal/chat/debug_page.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/utils/result.dart';


class DebugSettingsPage extends StatelessWidget {
  DebugSettingsPage({super.key});

  final AccountBackgroundDatabaseManager accountBackgroundDatabaseManager = LoginRepository.getInstance().repositories.accountBackgroundDb;

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
      openConversationDebugScreen(context, 0),
    ));

    settings.add(Setting.createSetting(Icons.chat_bubble_rounded, "Chat with messages", () =>
      openConversationDebugScreen(context, 5),
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: Image moderation status", () =>
      NotificationModerationRequestStatus.getInstance().show(ModerationRequestStateSimple.accepted, accountBackgroundDatabaseManager)
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: Likes", () =>
      NotificationLikeReceived.getInstance().incrementReceivedLikesCount(accountBackgroundDatabaseManager)
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (first chat)", () async {
      final matchList = await DatabaseManager.getInstance().profileData((db) => db.getMatchesList(0, 1)).ok();
      final match = matchList?.firstOrNull;
      if (match == null) {
        return;
      }
      await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1, accountBackgroundDatabaseManager);
    }));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (second chat)", () async {
      final matchList = await DatabaseManager.getInstance().profileData((db) => db.getMatchesList(0, 2)).ok();
      final match = matchList?.lastOrNull;
      if (match == null) {
        return;
      }
      await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1, accountBackgroundDatabaseManager);
    }));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (chats 1-5)", () async {
      final List<AccountId> matchList = await DatabaseManager.getInstance().profileData((db) => db.getMatchesList(0, 5)).ok() ?? [];
      for (final match in matchList) {
        await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1, accountBackgroundDatabaseManager);
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
