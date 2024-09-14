import 'dart:async';

import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/utils/result.dart';

class MessageDatabaseIterator {
  int startLocalKey = 0;
  int nextLocalKey = 0;
  AccountId localAccountId = AccountId(aid: "");
  AccountId remoteAccountId = AccountId(aid: "");
  final AccountDatabaseManager db;
  MessageDatabaseIterator(this.db);

  /// Start iterating another conversation
  Future<void> switchConversation(AccountId local, AccountId remote) async {
    localAccountId = local;
    remoteAccountId = remote;
    await resetToLatest();
  }

  /// Resets the iterator to the latest message of the current conversation
  Future<void> resetToLatest() async {
    final latestMessage = await db.messageData((db) => db.getMessage(localAccountId, remoteAccountId, 0)).ok();
    if (latestMessage != null) {
      startLocalKey = latestMessage.localId.id;
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
    localAccountId = AccountId(aid: "");
    remoteAccountId = AccountId(aid: "");
  }

  // Get max 10 next messages.
  Future<List<MessageEntry>> nextList() async {
    if (nextLocalKey < 0) {
      return [];
    }

    const queryCount = 10;
    final messages = await db.messageData((db) => db.getMessageListUsingLocalMessageId(
      localAccountId,
      remoteAccountId,
      LocalMessageId(nextLocalKey),
      queryCount
    )).ok() ?? [];

    final id = messages.lastOrNull?.localId;
    if (id != null) {
      nextLocalKey = id.id - 1;
    }
    return messages;
  }
}
