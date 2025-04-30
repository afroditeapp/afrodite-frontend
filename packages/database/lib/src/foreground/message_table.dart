


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
  IntColumn get messageState => integer()();
  BlobColumn get symmetricMessageEncryptionKey => blob().nullable()();

  // Server sends valid values for the next colums.
  IntColumn get messageNumber => integer().map(const NullAwareTypeConverter.wrap(MessageNumberConverter())).nullable()();
  IntColumn get unixTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  BlobColumn get backendSignedPgpMessage => blob().nullable()();
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
      messageState: entry.messageState.number,
      messageNumber: Value(entry.messageNumber),
      unixTime: Value(entry.unixTime),
      backendSignedPgpMessage: Value(entry.backendSignedPgpMessage),
      symmetricMessageEncryptionKey: Value(entry.symmetricMessageEncryptionKey),
    ));

    return LocalMessageId(localId);
  }

  Future<LocalMessageId> insertToBeSentMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    String messageText,
  ) async {
    final message = NewMessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: remoteAccountId,
      messageText: messageText,
      localUnixTime: UtcDateTime.now(),
      messageState: SentMessageState.pending.toDbState(),
    );

    return await transaction(() async {
      await db.daoConversationList.setCurrentTimeToConversationLastChanged(remoteAccountId);
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
      Uint8List? backendSignePgpMessage,
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
      messageState: Value.absentIfNull(sentState?.toDbState().number),
      unixTime: Value.absentIfNull(unixTime),
      messageNumber: Value.absentIfNull(messageNumberFromServer),
      backendSignedPgpMessage: Value.absentIfNull(backendSignePgpMessage),
    ));
  }

  Future<void> insertReceivedMessage(
    AccountId localAccountId,
    AccountId senderAccountId,
    MessageNumber messageNumber,
    UtcDateTime serverTime,
    Uint8List backendSignedPgpMessage,
    String decryptedMessage,
    Uint8List? symmetricMessageEncryptionKey,
    ReceivedMessageState state,
  ) async {
    final message = NewMessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: senderAccountId,
      localUnixTime: UtcDateTime.now(),
      messageText: decryptedMessage,
      messageState: state.toDbState(),
      messageNumber: messageNumber,
      unixTime: serverTime,
      backendSignedPgpMessage: backendSignedPgpMessage,
      symmetricMessageEncryptionKey: symmetricMessageEncryptionKey,
    );
    await transaction(() async {
      await _insert(message);
      await db.daoConversationList.setCurrentTimeToConversationLastChanged(senderAccountId);
    });
  }

  Future<void> insertInfoMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    InfoMessageState state,
  ) async {
    final message = NewMessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: remoteAccountId,
      localUnixTime: UtcDateTime.now(),
      messageText: "",
      messageState: state.toDbState(),
    );
    await transaction(() async {
      await _insert(message);
    });
  }

  /// Null values are not updated
  Future<void> updateReceivedMessageState(
    LocalMessageId localId,
    ReceivedMessageState receivedMessageState,
    {
      String? messageText,
      Uint8List? symmetricMessageEncryptionKey,
    }
  ) async {
    await (update(messages)
      ..where((t) => t.id.equals(localId.id))
    ).write(MessagesCompanion(
      messageState: Value(receivedMessageState.toDbState().number),
      messageText: Value.absentIfNull(messageText),
      symmetricMessageEncryptionKey: Value.absentIfNull(symmetricMessageEncryptionKey),
    ));
  }

  Future<void> updateSymmetricMessageEncryptionKey(
    LocalMessageId localId,
    Uint8List symmetricMessageEncryptionKey,
  ) async {
    await (update(messages)
      ..where((t) => t.id.equals(localId.id))
    ).write(MessagesCompanion(
      symmetricMessageEncryptionKey: Value(symmetricMessageEncryptionKey),
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
    final list = await (select(messages)
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

    return list.nonNulls.toList();
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

  MessageEntry? _fromMessage(Message m) {
    final MessageState? messageState = MessageState.fromInt(m.messageState);
    if (messageState == null) {
      return null;
    }

    return MessageEntry(
      localId: LocalMessageId(m.id),
      localAccountId: m.uuidLocalAccountId,
      remoteAccountId: m.uuidRemoteAccountId,
      messageText: m.messageText,
      localUnixTime: m.localUnixTime,
      messageState: messageState,
      messageNumber: m.messageNumber,
      unixTime: m.unixTime,
    );
  }

  Future<MessageEntry?> getLatestSentMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
  ) {
    return (select(messages)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.aid))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..where((t) => t.messageState.isBetweenValues(MessageState.MIN_VALUE_SENT_MESSAGE, MessageState.MAX_VALUE_SENT_MESSAGE))
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

  Future<void> deleteMessage(
    LocalMessageId localId,
  ) async {
    await (delete(messages)
      ..where((t) => t.id.equals(localId.id))
    )
      .go();
  }

  Future<Uint8List?> getBackendSignedPgpMessage(
    LocalMessageId localId,
  ) {
    return (select(messages)
      ..where((t) => t.id.equals(localId.id))
      ..limit(1)
    )
      .map((m) => m.backendSignedPgpMessage)
      .getSingleOrNull();
  }
}
