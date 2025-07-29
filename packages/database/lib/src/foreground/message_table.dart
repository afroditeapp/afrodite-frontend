


import 'package:database/src/converter/account.dart';
import 'package:database/src/converter/app.dart';
import 'package:database/src/converter/chat.dart';
import 'package:database/src/model/chat.dart';
import 'package:database/src/model/chat/message.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';

part 'message_table.g.dart';

class MessageTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidLocalAccountId => text().map(const AccountIdConverter())();
  TextColumn get uuidRemoteAccountId => text().map(const AccountIdConverter())();
  BlobColumn get message => blob().map(const NullAwareTypeConverter.wrap(MessageConverter())).nullable()();
  IntColumn get localUnixTime => integer().map(const UtcDateTimeConverter())();
  IntColumn get messageState => integer()();
  BlobColumn get symmetricMessageEncryptionKey => blob().nullable()();

  // Server sends valid values for the next colums.
  IntColumn get messageId => integer().map(const NullAwareTypeConverter.wrap(MessageIdConverter())).nullable()();
  IntColumn get unixTime => integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  BlobColumn get backendSignedPgpMessage => blob().nullable()();
}

@DriftAccessor(tables: [MessageTable])
class DaoMessageTable extends DatabaseAccessor<AccountDatabase> with _$DaoMessageTableMixin {
  DaoMessageTable(super.db);
  /// Number of all messages in the database
  Future<int?> countMessagesInConversation(
    AccountId localAccountId,
    AccountId remoteAccountId,
  ) async {
    final messageCount = messageTable.id.count();
    final q = (selectOnly(messageTable)
      ..where(messageTable.uuidLocalAccountId.equals(localAccountId.aid))
      ..where(messageTable.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..addColumns([messageCount])
    );
    return await q.map((r) => r.read(messageCount)).getSingleOrNull();
  }

  /// Returns ID of last inserted row.
  Future<LocalMessageId> _insert(NewMessageEntry entry) async {
    final localId = await into(messageTable).insert(MessageTableCompanion.insert(
      uuidLocalAccountId: entry.localAccountId,
      uuidRemoteAccountId: entry.remoteAccountId,
      message: Value(entry.message),
      localUnixTime: entry.localUnixTime,
      messageState: entry.messageState.number,
      messageId: Value(entry.messageId),
      unixTime: Value(entry.unixTime),
      backendSignedPgpMessage: Value(entry.backendSignedPgpMessage),
      symmetricMessageEncryptionKey: Value(entry.symmetricMessageEncryptionKey),
    ));

    return LocalMessageId(localId);
  }

  Future<LocalMessageId> insertToBeSentMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    Message message,
  ) async {
    final newMessageEntry = NewMessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: remoteAccountId,
      message: message,
      localUnixTime: UtcDateTime.now(),
      messageState: SentMessageState.pending.toDbState(),
    );

    return await transaction(() async {
      await db.daoConversationList.setCurrentTimeToConversationLastChanged(remoteAccountId);
      return await _insert(newMessageEntry);
    });
  }

  /// Null values are not updated.
  Future<void> updateSentMessageState(
    LocalMessageId localId,
    {
      SentMessageState? sentState,
      UnixTime? unixTimeFromServer,
      MessageId? messageIdFromServer,
      Uint8List? backendSignePgpMessage,
    }
  ) async {
    final UtcDateTime? unixTime;
    if (unixTimeFromServer != null) {
      unixTime = UtcDateTime.fromUnixEpochMilliseconds(unixTimeFromServer.ut * 1000);
    } else {
      unixTime = null;
    }
    await (update(messageTable)
      ..where((t) => t.id.equals(localId.id))
    ).write(MessageTableCompanion(
      messageState: Value.absentIfNull(sentState?.toDbState().number),
      unixTime: Value.absentIfNull(unixTime),
      messageId: Value.absentIfNull(messageIdFromServer),
      backendSignedPgpMessage: Value.absentIfNull(backendSignePgpMessage),
    ));
  }

  Future<void> insertReceivedMessage(
    AccountId localAccountId,
    AccountId senderAccountId,
    MessageId messageId,
    UtcDateTime serverTime,
    Uint8List backendSignedPgpMessage,
    Message? decryptedMessage,
    Uint8List? symmetricMessageEncryptionKey,
    ReceivedMessageState state,
  ) async {
    final message = NewMessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: senderAccountId,
      localUnixTime: UtcDateTime.now(),
      message: decryptedMessage,
      messageState: state.toDbState(),
      messageId: messageId,
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
      message: null,
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
      Message? message,
      Uint8List? symmetricMessageEncryptionKey,
    }
  ) async {
    await (update(messageTable)
      ..where((t) => t.id.equals(localId.id))
    ).write(MessageTableCompanion(
      messageState: Value(receivedMessageState.toDbState().number),
      message: Value.absentIfNull(message),
      symmetricMessageEncryptionKey: Value.absentIfNull(symmetricMessageEncryptionKey),
    ));
  }

  Future<void> updateSymmetricMessageEncryptionKey(
    LocalMessageId localId,
    Uint8List symmetricMessageEncryptionKey,
  ) async {
    await (update(messageTable)
      ..where((t) => t.id.equals(localId.id))
    ).write(MessageTableCompanion(
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
    return await (select(messageTable)
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
    return (select(messageTable)
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
    final list = await (select(messageTable)
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
    return (select(messageTable)
      ..where((t) => t.id.equals(localId.id))
      ..limit(1)
    )
      .map((m) => _fromMessage(m))
      .getSingleOrNull();
  }

  Stream<MessageEntry?> getMessageUpdatesUsingLocalMessageId(
    LocalMessageId localId,
  ) {
    return (select(messageTable)
      ..where((t) => t.id.equals(localId.id))
    )
      .map((m) => _fromMessage(m))
      .watchSingleOrNull();
  }

  MessageEntry? _fromMessage(MessageTableData m) {
    final MessageState? messageState = MessageState.fromInt(m.messageState);
    if (messageState == null) {
      return null;
    }

    return MessageEntry(
      localId: LocalMessageId(m.id),
      localAccountId: m.uuidLocalAccountId,
      remoteAccountId: m.uuidRemoteAccountId,
      message: m.message,
      localUnixTime: m.localUnixTime,
      messageState: messageState,
      messageId: m.messageId,
      unixTime: m.unixTime,
    );
  }

  Future<MessageEntry?> getLatestSentMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
  ) {
    return (select(messageTable)
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

  Future<MessageEntry?> getMessageUsingMessageId(
    AccountId localAccountId,
    AccountId remoteAccountId,
    MessageId messageId,
  ) {
    return (select(messageTable)
      ..where((t) => t.uuidLocalAccountId.equals(localAccountId.aid))
      ..where((t) => t.uuidRemoteAccountId.equals(remoteAccountId.aid))
      ..where((t) => t.messageId.equals(messageId.id))
      ..limit(1)
    )
      .map((m) => _fromMessage(m))
      .getSingleOrNull();
  }

  Future<void> deleteMessage(
    LocalMessageId localId,
  ) async {
    await (delete(messageTable)
      ..where((t) => t.id.equals(localId.id))
    )
      .go();
  }

  Future<Uint8List?> getBackendSignedPgpMessage(
    LocalMessageId localId,
  ) {
    return (select(messageTable)
      ..where((t) => t.id.equals(localId.id))
      ..limit(1)
    )
      .map((m) => m.backendSignedPgpMessage)
      .getSingleOrNull();
  }

  Future<Uint8List?> getSymmetricMessageEncryptionKey(
    LocalMessageId localId,
  ) {
    return (select(messageTable)
      ..where((t) => t.id.equals(localId.id))
      ..limit(1)
    )
      .map((m) => m.symmetricMessageEncryptionKey)
      .getSingleOrNull();
  }
}
