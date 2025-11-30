import 'dart:async';

import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';

sealed class IteratorMessage {}

final class IteratorMessageEntry extends IteratorMessage {
  final MessageEntry entry;
  IteratorMessageEntry(this.entry);
}

final class MessageDateChange extends IteratorMessage {
  final DateTime date;
  MessageDateChange(this.date);
}

/// MessageDatabaseIterator must only create new system message
/// IteratorMessages together with new MessageEntries.
class MessageDatabaseIterator {
  int startLocalKey = 0;
  int nextLocalKey = 0;
  AccountId localAccountId = AccountId(aid: "");
  AccountId remoteAccountId = AccountId(aid: "");
  MessageEntry? previousMessage;
  final AccountDatabaseManager db;
  MessageDatabaseIterator(this.db);

  /// Start iterating another conversation
  Future<void> switchConversation(AccountId local, AccountId remote) async {
    localAccountId = local;
    remoteAccountId = remote;
    previousMessage = null;
    await resetToLatest();
  }

  /// Resets the iterator to the latest message of the current conversation
  Future<void> resetToLatest() async {
    final latestMessage = await db
        .accountData((db) => db.message.getMessage(localAccountId, remoteAccountId, 0))
        .ok();
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
    previousMessage = null;
  }

  /// Clear all iterator state.
  /// Iterator must be initialized with switchConversation after calling this.
  void resetToInitialState() {
    startLocalKey = 0;
    nextLocalKey = 0;
    localAccountId = AccountId(aid: "");
    remoteAccountId = AccountId(aid: "");
    previousMessage = null;
  }

  // Get max 10 next messages.
  Future<List<IteratorMessage>> nextList() async {
    if (nextLocalKey < 0) {
      return [];
    }

    const queryCount = 10;
    final messages =
        await db
            .accountData(
              (db) => db.message.getMessageListUsingLocalMessageId(
                localAccountId,
                remoteAccountId,
                LocalMessageId(nextLocalKey),
                queryCount,
              ),
            )
            .ok() ??
        [];

    final id = messages.lastOrNull?.localId;
    if (id != null) {
      nextLocalKey = id.id - 1;
    }

    // Insert date change markers
    final List<IteratorMessage> result = [];
    for (final message in messages) {
      final messageDate = message.userVisibleTime().dateTime.toLocal();
      final messageDateOnly = DateTime(messageDate.year, messageDate.month, messageDate.day);

      final prevDate = previousMessage?.userVisibleTime().dateTime.toLocal();
      if (prevDate != null) {
        final prevDateOnly = DateTime(prevDate.year, prevDate.month, prevDate.day);
        if (!messageDateOnly.isAtSameMomentAs(prevDateOnly)) {
          result.add(MessageDateChange(messageDateOnly));
        }
      }

      result.add(IteratorMessageEntry(message));
      previousMessage = message;
    }

    return result;
  }
}
