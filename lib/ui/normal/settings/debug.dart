

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/general/notification/state/like_received.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/general/notification/state/moderation_request_status.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/ui/normal/chat/debug_page.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/utils/result.dart';


class DebugSettingsPage extends StatefulWidget {
  DebugSettingsPage({super.key});

  @override
  State<DebugSettingsPage> createState() => _DebugSettingsPageState();
}

class _DebugSettingsPageState extends State<DebugSettingsPage> {
  final AccountBackgroundDatabaseManager accountBackgroundDb = LoginRepository.getInstance().repositories.accountBackgroundDb;

  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;

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
      NotificationModerationRequestStatus.getInstance().show(ModerationRequestStateSimple.accepted, accountBackgroundDb)
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: Likes", () =>
      NotificationLikeReceived.getInstance().incrementReceivedLikesCount(accountBackgroundDb)
    ));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (first chat)", () async {
      final matchList = await accountDb.accountData((db) => db.daoConversationList.getConversationListNoBlocked(0, 1)).ok();
      final match = matchList?.firstOrNull;
      if (match == null) {
        return;
      }
      await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1, accountBackgroundDb);
    }));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (second chat)", () async {
      final matchList = await accountDb.accountData((db) => db.daoConversationList.getConversationListNoBlocked(0, 2)).ok();
      final match = matchList?.lastOrNull;
      if (match == null) {
        return;
      }
      await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1, accountBackgroundDb);
    }));

    settings.add(Setting.createSetting(Icons.notification_add, "Notification: New message (chats 1-5)", () async {
      final List<AccountId> matchList = await accountDb.accountData((db) => db.daoConversationList.getConversationListNoBlocked(0, 5)).ok() ?? [];
      for (final match in matchList) {
        await NotificationMessageReceived.getInstance().updateMessageReceivedCount(match, 1, accountBackgroundDb);
      }
    }));

    final checkboxes = [
      CheckboxListTile(
        value: _debugLogic.conversationLastUpdateTimeChanger,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              _debugLogic.startConversationLastUpdateTimeChanger();
            } else {
              _debugLogic.stopConversationLastUpdateTimeChanger();
            }
          });
        },
        title: const Text("Update conversation last updated time automatically"),
      )
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          ...settings.map((setting) => setting.toListTile()),
          ...checkboxes,
        ],
      ),
    );
  }
}

final _debugRandom = Random();
final _debugLogic = DebugLogic();

class DebugLogic {
  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;

  bool conversationLastUpdateTimeChanger = false;
  StreamSubscription<void>? _conversationLastUpdateTimeChangerSubscription;

  void startConversationLastUpdateTimeChanger() {
    conversationLastUpdateTimeChanger = true;
    _startConversationLastUpdateTimeChanger();
  }

  void _startConversationLastUpdateTimeChanger() async {
    await _conversationLastUpdateTimeChangerSubscription?.cancel();
    _conversationLastUpdateTimeChangerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (_) async {
        final matches = await accountDb.accountData((db) => db.daoConversationList.getConversationListNoBlocked(0, 1000)).ok();
        if (matches == null || matches.isEmpty) {
          return;
        }
        final randomMatch = matches[_debugRandom.nextInt(matches.length)];
        await accountDb.accountAction((db) => db.daoConversationList.setCurrentTimeToConversationLastChanged(randomMatch));
      }
    )
      .listen((_) {});
  }

  void stopConversationLastUpdateTimeChanger() {
    conversationLastUpdateTimeChanger = false;
    _stopConversationLastUpdateTimeChanger();
  }

  void _stopConversationLastUpdateTimeChanger() async {
    await _conversationLastUpdateTimeChangerSubscription?.cancel();
  }
}
