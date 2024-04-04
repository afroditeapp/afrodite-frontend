import 'dart:async';

import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/database/database_manager.dart';

class MessageDatabaseIterator {
  int startLocalKey = 0;
  int nextLocalKey = 0;
  AccountId localAccountId = AccountId(accountId: "");
  AccountId remoteAccountId = AccountId(accountId: "");
  final DatabaseManager db = DatabaseManager.getInstance();
  MessageDatabaseIterator();

  /// Start iterating another conversation
  Future<void> switchConversation(AccountId local, AccountId remote) async {
    localAccountId = local;
    remoteAccountId = remote;
    await resetToLatest();
  }

  /// Resets the iterator to the latest message of the current conversation
  Future<void> resetToLatest() async {
    final latestMessage = await db.messageData((db) => db.getMessage(localAccountId, remoteAccountId, 0));
    final id = latestMessage?.id;
    if (latestMessage != null && id != null) {
      startLocalKey = id;
    } else {
      startLocalKey = 0;
    }
    nextLocalKey = startLocalKey;
  }

  /// Resets the iterator to the beginning
  /// (same position as the previous resetToLatest or switchConversation)
  void reset() {
    nextLocalKey = startLocalKey;
  }

  /// Clear all iterator state.
  /// Iterator must be initialized with switchConversation after calling this.
  void resetToInitialState() {
    startLocalKey = 0;
    nextLocalKey = 0;
    localAccountId = AccountId(accountId: "");
    remoteAccountId = AccountId(accountId: "");
  }

  Future<List<MessageEntry>> nextList() async {
    if (nextLocalKey < 0) {
      return [];
    }

    const queryCount = 10;
    final messages = await db.messageData((db) => db.getMessageListByLocalMessageId(
      localAccountId,
      remoteAccountId,
      nextLocalKey,
      queryCount
    )) ?? [];

    final id = messages.lastOrNull?.id;
    if (id != null) {
      nextLocalKey = id - 1;
    }
    return messages;
  }
}
