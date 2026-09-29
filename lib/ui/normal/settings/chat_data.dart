import 'dart:typed_data';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class ChatDataPage extends MyScreenPage<()> with SimpleUrlParser<ChatDataPage> {
  final RepositoryInstances r;
  ChatDataPage(this.r) : super(builder: (_) => ChatDataScreen(r));

  @override
  ChatDataPage create() => ChatDataPage(r);
}

class ChatDataScreen extends StatefulWidget {
  final AccountDatabaseManager accountDb;
  final AccountId accountId;

  ChatDataScreen(RepositoryInstances r, {super.key})
    : accountDb = r.accountDb,
      accountId = r.accountId;

  @override
  State<ChatDataScreen> createState() => _ChatDataScreenState();
}

class _ChatDataScreenState extends State<ChatDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat data")),
      body: settingsList(context),
    );
  }

  Widget settingsList(BuildContext context) {
    List<Setting> settings = [];

    settings.add(
      Setting.createSetting(
        Icons.delete_sweep,
        "Clear all messages from DB",
        () => clearAllMessages(context),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.add_comment,
        "Add normal chat messages to first conversation (3 days + 1 month + 1 year ago)",
        () => addMessagesToFirstConversation(context),
      ),
    );

    return SingleChildScrollView(
      child: Column(children: settings.map((setting) => setting.toListTile()).toList()),
    );
  }

  Future<void> clearAllMessages(BuildContext context) async {
    final r = await widget.accountDb.accountAction((db) => db.message.deleteAllMessages());
    if (r.isOk()) {
      showSnackBar('Success: All messages cleared');
    } else {
      showSnackBar('Failed: Could not clear messages');
    }
  }

  Future<void> addMessagesToFirstConversation(BuildContext context) async {
    final List<AccountId> conversationList =
        await widget.accountDb
            .accountData((db) => db.conversationList.getConversationListNoBlocked(0, 1))
            .ok() ??
        [];
    final firstConversation = conversationList.firstOrNull;
    if (firstConversation == null) {
      showSnackBar('Failed: No conversations found');
      return;
    }

    // 2 messages per day for the 3 previous days, 2 for the previous month
    // and 2 for the previous year. Total of 10 messages.
    //
    // Local ID 0 is the oldest message and +1 is a newer message, so insert
    // messages from oldest to newest.
    final now = UtcDateTime.now();
    final messages = <(UtcDateTime, String)>[
      // Previous year
      (now.subtract(const Duration(days: 365)), "Message 1"),
      (now.subtract(const Duration(days: 365)).add(const Duration(hours: 2)), "Message 2"),
      // Previous month
      (now.subtract(const Duration(days: 30)), "Message 3"),
      (now.subtract(const Duration(days: 30)).add(const Duration(hours: 2)), "Message 4"),
      // Previous days (oldest first)
      (now.subtract(const Duration(days: 3)), "Message 5"),
      (now.subtract(const Duration(days: 3)).add(const Duration(hours: 2)), "Message 6"),
      (now.subtract(const Duration(days: 2)), "Message 7"),
      (now.subtract(const Duration(days: 2)).add(const Duration(hours: 2)), "Message 8"),
      (now.subtract(const Duration(days: 1)), "Message 9"),
      (now.subtract(const Duration(days: 1)).add(const Duration(hours: 2)), "Message 10"),
    ];

    var messageNumber = 1;
    for (final (time, text) in messages) {
      final message = TextMessage.create(text);
      if (message == null) {
        continue;
      }
      final r = await widget.accountDb.accountAction(
        (db) => db.message.insertReceivedMessage(
          firstConversation,
          MessageNumber(mn: messageNumber),
          MessageId(id: "debug-$messageNumber"),
          time,
          Uint8List(0),
          message,
          null,
          ReceivedMessageState.received,
        ),
      );
      if (r.isErr()) {
        showSnackBar('Failed: Could not insert message');
        return;
      }
      messageNumber++;
    }

    showSnackBar('Success: Added ${messages.length} messages to first conversation');
  }
}
