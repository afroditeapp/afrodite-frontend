import 'dart:async';
import 'dart:math';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/general/notification/state/like_received.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/ui/normal/chat/debug_page.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/utils/result.dart';

class DebugSettingsPage extends MyScreenPageLimited<()> {
  DebugSettingsPage(RepositoryInstances r) : super(builder: (_) => DebugSettingsScreen(r));
}

class DebugSettingsScreen extends StatefulWidget {
  final ApiManager api;
  final ProfileRepository profile;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountDatabaseManager accountDb;

  DebugSettingsScreen(RepositoryInstances r, {super.key})
    : api = r.api,
      profile = r.profile,
      accountBackgroundDb = r.accountBackgroundDb,
      accountDb = r.accountDb;

  @override
  State<DebugSettingsScreen> createState() => _DebugSettingsScreenState();
}

class _DebugSettingsScreenState extends State<DebugSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug")),
      body: settingsList(context),
    );
  }

  Widget settingsList(BuildContext context) {
    List<Setting> settings = [];

    settings.add(
      Setting.createSetting(
        Icons.chat_bubble_outline_rounded,
        "Chat without messages",
        () => openConversationDebugScreen(context, 0),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.chat_bubble_rounded,
        "Chat with messages",
        () => openConversationDebugScreen(context, 5),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.notification_add,
        "Notification: Likes",
        () => NotificationLikeReceived.getInstance().incrementReceivedLikesCount(
          widget.accountBackgroundDb,
        ),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.notification_add,
        "Notification: New message (first chat)",
        () => showConversationNotifications(take: 1),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.notification_add,
        "Notification: New message (second chat)",
        () => showConversationNotifications(skip: 1, take: 1),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.notification_add,
        "Notification: New message (chats 1-5)",
        () => showConversationNotifications(take: 5),
      ),
    );

    final checkboxes = [
      CheckboxListTile(
        value: _debugLogic.conversationLastUpdateTimeChanger,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              _debugLogic.startConversationLastUpdateTimeChanger(widget.accountDb);
            } else {
              _debugLogic.stopConversationLastUpdateTimeChanger();
            }
          });
        },
        title: const Text("Update conversation last updated time automatically"),
      ),
    ];

    return SingleChildScrollView(
      child: Column(children: [...settings.map((setting) => setting.toListTile()), ...checkboxes]),
    );
  }

  Future<void> showConversationNotifications({int skip = 0, required int take}) async {
    final List<AccountId> matchList =
        await widget.profile.getConversationListUpdates().firstOrNull ?? [];
    final match = matchList.firstOrNull;
    if (match == null) {
      return;
    }

    for (final a in matchList.skip(skip).take(take)) {
      ConversationId? conversationId = await widget.accountBackgroundDb
          .accountData((db) => db.notification.getConversationId(a))
          .ok();
      if (conversationId == null) {
        final r = await widget.api.chat((api) => api.getConversationId(a.aid)).ok();
        conversationId = r?.value;
      }
      await NotificationMessageReceived.getInstance().updateMessageReceivedCount(
        a,
        1,
        conversationId,
        widget.accountBackgroundDb,
      );
    }
  }
}

final _debugRandom = Random();
final _debugLogic = DebugLogic();

class DebugLogic {
  bool conversationLastUpdateTimeChanger = false;
  StreamSubscription<void>? _conversationLastUpdateTimeChangerSubscription;

  void startConversationLastUpdateTimeChanger(AccountDatabaseManager accountDb) {
    conversationLastUpdateTimeChanger = true;
    _startConversationLastUpdateTimeChanger(accountDb);
  }

  void _startConversationLastUpdateTimeChanger(AccountDatabaseManager accountDb) async {
    await _conversationLastUpdateTimeChangerSubscription?.cancel();
    _conversationLastUpdateTimeChangerSubscription = Stream.periodic(const Duration(seconds: 1), (
      _,
    ) async {
      final matches = await accountDb
          .accountData((db) => db.conversationList.getConversationListNoBlocked(0, 1000))
          .ok();
      if (matches == null || matches.isEmpty) {
        return;
      }
      final randomMatch = matches[_debugRandom.nextInt(matches.length)];
      await accountDb.accountAction(
        (db) => db.conversationList.setCurrentTimeToConversationLastChanged(randomMatch),
      );
    }).listen((_) {});
  }

  void stopConversationLastUpdateTimeChanger() {
    conversationLastUpdateTimeChanger = false;
    _stopConversationLastUpdateTimeChanger();
  }

  void _stopConversationLastUpdateTimeChanger() async {
    await _conversationLastUpdateTimeChangerSubscription?.cancel();
  }
}
