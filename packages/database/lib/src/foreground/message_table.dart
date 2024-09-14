


import 'package:openapi/api.dart';
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../message_entry.dart';
import '../utils.dart';

part 'message_table.g.dart';

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidLocalAccountId => text().map(const AccountIdConverter())();
  TextColumn get uuidRemoteAccountId => text().map(const AccountIdConverter())();
  TextColumn get messageText => text()();
  IntColumn get localUnixTime => integer().map(const UtcDateTimeConverter())();
  IntColumn get sentMessageState => integer().nullable()();
  IntColumn get receivedMessageState => integer().nullable()();
  IntColumn get senderMessageId => integer().map(const NullAwareTypeConverter.wrap(SenderMessageIdConverter())).nullable()();

  // Server sends valid values for the next two colums.
  IntColumn get messageNumber => integer().map(const NullAwareTypeConverter.wrap(MessageNumberConverter())).nullable()();
  IntColumn get unixTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
}

@DriftAccessor(tables: [Messages])
class DaoMessages extends DatabaseAccessor<AccountDatabase> with _$DaoMessagesMixin {
  DaoMessages(AccountDatabase db) : super(db);
  /// Number of all messages in the database
  Future<int?> countMessagesInConversation(
    AccountId localAccountId,
    AccountId remoteAccountId,
  ) async {
    final messageCount = messages.id.count();
    final q = (selectOnly(messages)
      ..where(messages.uuidLocalAccountId.equals(localAccountId.aid))
      ..where(messages.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..addColumns([messageCount])
    );
    return await q.map((r) => r.read(messageCount)).getSingleOrNull();
  }

  /// Returns ID of last inserted row.
  Future<LocalMessageId> _insert(NewMessageEntry entry) async {
    final localId = await into(messages).insert(MessagesCompanion.insert(
      uuidLocalAccountId: entry.localAccountId,
      uuidRemoteAccountId: entry.remoteAccountId,
      messageText: entry.messageText,
      localUnixTime: entry.localUnixTime,
      sentMessageState: Value(entry.sentMessageState?.number),
      receivedMessageState: Value(entry.receivedMessageState?.number),
      messageNumber: Value(entry.messageNumber),
      unixTime: Value(entry.unixTime),
      senderMessageId: Value(entry.senderMessageId),
    ));

    return LocalMessageId(localId);
  }

  Future<LocalMessageId> insertToBeSentMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    String messageText,
    SenderMessageId senderMessageId,
  ) async {
    final message = NewMessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: remoteAccountId,
      messageText: messageText,
      localUnixTime: UtcDateTime.now(),
      sentMessageState: SentMessageState.pending,
      senderMessageId: senderMessageId,
    );

    return await transaction(() async {
      await db.daoMatches.setCurrentTimeToConversationLastChanged(remoteAccountId);
      return await _insert(message);
    });
  }

  /// Null values are not updated.
  Future<void> updateSentMessageState(
    LocalMessageId localId,
    {
      SentMessageState? sentState,
      UnixTime? unixTimeFromServer,
      MessageNumber? messageNumberFromServer,
      SenderMessageId? senderMessageId,
    }
  ) async {
    final UtcDateTime? unixTime;
    if (unixTimeFromServer != null) {
      unixTime = UtcDateTime.fromUnixEpochMilliseconds(unixTimeFromServer.ut * 1000);
    } else {
      unixTime = null;
    }
    await (update(messages)
      ..where((t) => t.id.equals(localId.id))
    ).write(MessagesCompanion(
      sentMessageState: Value.absentIfNull(sentState?.number),
      unixTime: Value.absentIfNull(unixTime),
      messageNumber: Value.absentIfNull(messageNumberFromServer),
    ));
  }

  /// Null message means decrypting failure
  Future<void> insertReceivedMessage(
    AccountId localAccountId,
    PendingMessage entry,
    String decryptedMessage,
    ReceivedMessageState state,
  ) async {
    final unixTime = UtcDateTime.fromUnixEpochMilliseconds(entry.unixTime.ut * 1000);
    final message = NewMessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: entry.id.sender,
      localUnixTime: UtcDateTime.now(),
      messageText: decryptedMessage,
      sentMessageState: null,
      receivedMessageState: state,
      messageNumber: entry.id.mn,
      unixTime: unixTime,
    );
    await transaction(() async {
      await _insert(message);
      final currentUnreadMessageCount = await db.daoConversations.getUnreadMessageCount(entry.id.sender) ?? UnreadMessagesCount(0);
      final updatedValue = UnreadMessagesCount(currentUnreadMessageCount.count + 1);
      await db.daoConversations.setUnreadMessagesCount(entry.id.sender, updatedValue);
      await db.daoMatches.setCurrentTimeToConversationLastChanged(entry.id.sender);
    });
  }

  Future<void> updateReceivedMessageState(
    AccountId localAccountId,
    AccountId remoteAccountId,
    MessageNumber messageNumber,
    ReceivedMessageState receivedMessageState,
  ) async {
    await (update(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.aid))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..where((t) => t.messageNumber.equals(messageNumber.mn))
    ).write(MessagesCompanion(
      receivedMessageState: Value(receivedMessageState.number),
    ));
  }

  /// Get message with given index in a conversation.
  /// The index 0 is the latest message.
  Future<MessageEntry?> getMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    int index,
  ) async {
    return await (select(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.aid))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..limit(1, offset: index)
      ..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ])
    )
      .map((m) => _fromMessage(m))
      .getSingleOrNull();
  }

  Stream<MessageEntry?> watchLatestMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
  ) {
    return (select(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.aid))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..limit(1)
      ..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ])
    )
      .map((m) => _fromMessage(m))
      .watchSingleOrNull();
  }

  /// Get list of messages starting from startId. The next ID is smaller.
  Future<List<MessageEntry>> getMessageListUsingLocalMessageId(
    AccountId localAccountId,
    AccountId remoteAccountId,
    LocalMessageId startId,
    int limit,
  ) async {
    return await (select(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.aid))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..where((t) => t.id.isSmallerOrEqualValue(startId.id))
      ..limit(limit)
      ..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ])
    )
      .map((m) => _fromMessage(m))
      .get();
  }

  Future<MessageEntry?> getMessageUsingLocalMessageId(
    LocalMessageId localId,
  ) {
    return (select(messages)
      ..where((t) => t.id.equals(localId.id))
      ..limit(1)
    )
      .map((m) => _fromMessage(m))
      .getSingleOrNull();
  }

  Stream<MessageEntry?> getMessageUpdatesUsingLocalMessageId(
    LocalMessageId localId,
  ) {
    return (select(messages)
      ..where((t) => t.id.equals(localId.id))
    )
      .map((m) => _fromMessage(m))
      .watchSingleOrNull();
  }

  MessageEntry _fromMessage(Message m) {
    final sentMessageStateNumber = m.sentMessageState;
    final SentMessageState? sentMessageState;
    if (sentMessageStateNumber != null) {
      sentMessageState = SentMessageState.values[sentMessageStateNumber];
    } else {
      sentMessageState = null;
    }

    final receivedMessageStateNumber = m.receivedMessageState;
    final ReceivedMessageState? receivedMessageState;
    if (receivedMessageStateNumber != null) {
      receivedMessageState = ReceivedMessageState.values[receivedMessageStateNumber];
    } else {
      receivedMessageState = null;
    }

    return MessageEntry(
      localId: LocalMessageId(m.id),
      localAccountId: m.uuidLocalAccountId,
      remoteAccountId: m.uuidRemoteAccountId,
      messageText: m.messageText,
      localUnixTime: m.localUnixTime,
      sentMessageState: sentMessageState,
      receivedMessageState: receivedMessageState,
      messageNumber: m.messageNumber,
      unixTime: m.unixTime,
      senderMessageId: m.senderMessageId,
    );
  }

  Future<MessageEntry?> getLatestSentMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
  ) {
    return (select(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.aid))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..where((t) => t.sentMessageState.isNotNull())
      ..limit(1)
      ..orderBy([
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ])
    )
      .map((m) => _fromMessage(m))
      .getSingleOrNull();
  }

  Future<MessageEntry?> getMessageUsingMessageNumber(
    AccountId localAccountId,
    AccountId remoteAccountId,
    MessageNumber messageNumber,
  ) {
    return (select(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.aid))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..where((t) => t.messageNumber.equals(messageNumber.mn))
      ..limit(1)
    )
      .map((m) => _fromMessage(m))
      .getSingleOrNull();
  }

  Future<void> resetSenderMessageIdForAllMessages() async {
    await (update(messages)).write(MessagesCompanion(
      senderMessageId: Value(null),
    ));
  }

  Future<void> deleteMessage(
    LocalMessageId localId,
  ) async {
    await (delete(messages)
      ..where((t) => t.id.equals(localId.id))
    )
      .go();
  }
}
