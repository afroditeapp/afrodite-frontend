import 'package:database_account_foreground/src/database.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'message.g.dart';

@DriftAccessor(tables: [schema.Message])
class DaoReadMessage extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoReadMessageMixin {
  DaoReadMessage(super.db);

  /// Number of all messages in the database
  Future<int?> countMessagesInConversation(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
  ) async {
    final messageCount = message.id.count();
    final q = (selectOnly(message)
      ..where(message.localAccountId.equals(localAccountId.aid))
      ..where(message.remoteAccountId.equals(remoteAccountId.aid))
      ..addColumns([messageCount]));
    return await q.map((r) => r.read(messageCount)).getSingleOrNull();
  }

  /// Get message with given index in a conversation.
  /// The index 0 is the latest message.
  Future<dbm.MessageEntry?> getMessage(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
    int index,
  ) async {
    return await (select(message)
          ..where((t) => t.localAccountId.equals(localAccountId.aid))
          ..where((t) => t.remoteAccountId.equals(remoteAccountId.aid))
          ..limit(1, offset: index)
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
        .map((m) => _fromMessage(m))
        .getSingleOrNull();
  }

  Stream<dbm.MessageEntry?> watchLatestMessage(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
  ) {
    return (select(message)
          ..where((t) => t.localAccountId.equals(localAccountId.aid))
          ..where((t) => t.remoteAccountId.equals(remoteAccountId.aid))
          ..limit(1)
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
        .map((m) => _fromMessage(m))
        .watchSingleOrNull();
  }

  /// Get list of messages starting from startId. The next ID is smaller.
  Future<List<dbm.MessageEntry>> getMessageListUsingLocalMessageId(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
    dbm.LocalMessageId startId,
    int limit,
  ) async {
    final list =
        await (select(message)
              ..where((t) => t.localAccountId.equals(localAccountId.aid))
              ..where((t) => t.remoteAccountId.equals(remoteAccountId.aid))
              ..where((t) => t.id.isSmallerOrEqualValue(startId.id))
              ..limit(limit)
              ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
            .map((m) => _fromMessage(m))
            .get();

    return list.nonNulls.toList();
  }

  Future<dbm.MessageEntry?> getMessageUsingLocalMessageId(dbm.LocalMessageId localId) {
    return (select(message)
          ..where((t) => t.id.equals(localId.id))
          ..limit(1))
        .map((m) => _fromMessage(m))
        .getSingleOrNull();
  }

  Stream<dbm.MessageEntry?> getMessageUpdatesUsingLocalMessageId(dbm.LocalMessageId localId) {
    return (select(
      message,
    )..where((t) => t.id.equals(localId.id))).map((m) => _fromMessage(m)).watchSingleOrNull();
  }

  dbm.MessageEntry? _fromMessage(MessageData m) {
    final dbm.MessageState? messageState = dbm.MessageState.fromInt(m.messageState);
    if (messageState == null) {
      return null;
    }

    return dbm.MessageEntry(
      localId: dbm.LocalMessageId(m.id),
      localAccountId: m.localAccountId,
      remoteAccountId: m.remoteAccountId,
      message: m.message,
      localUnixTime: m.localUnixTime,
      messageState: messageState,
      messageId: m.messageId,
      unixTime: m.unixTime,
      deliveredUnixTime: m.deliveredUnixTime,
    );
  }

  Future<dbm.MessageEntry?> getLatestSentMessage(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
  ) {
    return (select(message)
          ..where((t) => t.localAccountId.equals(localAccountId.aid))
          ..where((t) => t.remoteAccountId.equals(remoteAccountId.aid))
          ..where(
            (t) => t.messageState.isBetweenValues(
              dbm.MessageState.MIN_VALUE_SENT_MESSAGE,
              dbm.MessageState.MAX_VALUE_SENT_MESSAGE,
            ),
          )
          ..limit(1)
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
        .map((m) => _fromMessage(m))
        .getSingleOrNull();
  }

  /// First message is the latest message.
  Future<List<dbm.MessageEntry>> getAllMessages(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
  ) async {
    final int startLocalKey;
    final latestMessage = await getMessage(localAccountId, remoteAccountId, 0);
    if (latestMessage != null) {
      startLocalKey = latestMessage.localId.id;
    } else {
      startLocalKey = 0;
    }
    final messages =
        await (select(message)
              ..where((t) => t.localAccountId.equals(localAccountId.aid))
              ..where((t) => t.remoteAccountId.equals(remoteAccountId.aid))
              ..where((t) => t.id.isSmallerOrEqualValue(startLocalKey))
              ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
            .map((m) => _fromMessage(m))
            .get();
    return messages.nonNulls.toList();
  }

  Future<dbm.MessageEntry?> getMessageUsingMessageId(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
    api.MessageId messageId,
  ) {
    return (select(message)
          ..where((t) => t.localAccountId.equals(localAccountId.aid))
          ..where((t) => t.remoteAccountId.equals(remoteAccountId.aid))
          ..where((t) => t.messageId.equals(messageId.id))
          ..limit(1))
        .map((m) => _fromMessage(m))
        .getSingleOrNull();
  }

  Future<Uint8List?> getBackendSignedPgpMessage(dbm.LocalMessageId localId) {
    return (select(message)
          ..where((t) => t.id.equals(localId.id))
          ..limit(1))
        .map((m) => m.backendSignedPgpMessage)
        .getSingleOrNull();
  }

  Future<Uint8List?> getSymmetricMessageEncryptionKey(dbm.LocalMessageId localId) {
    return (select(message)
          ..where((t) => t.id.equals(localId.id))
          ..limit(1))
        .map((m) => m.symmetricMessageEncryptionKey)
        .getSingleOrNull();
  }
}
