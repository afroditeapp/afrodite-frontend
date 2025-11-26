import 'package:database_account_foreground/src/database.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'message.g.dart';

@DriftAccessor(tables: [schema.Message])
class DaoWriteMessage extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteMessageMixin {
  DaoWriteMessage(super.db);

  /// Returns ID of last inserted row.
  Future<dbm.LocalMessageId> _insert(dbm.NewMessageEntry entry) async {
    final localId = await into(message).insert(
      MessageCompanion.insert(
        localAccountId: entry.localAccountId,
        remoteAccountId: entry.remoteAccountId,
        message: Value(entry.message),
        localUnixTime: entry.localUnixTime,
        messageState: entry.messageState.number,
        messageId: Value(entry.messageId),
        unixTime: Value(entry.unixTime),
        backendSignedPgpMessage: Value(entry.backendSignedPgpMessage),
        symmetricMessageEncryptionKey: Value(entry.symmetricMessageEncryptionKey),
      ),
    );

    return dbm.LocalMessageId(localId);
  }

  Future<dbm.LocalMessageId> insertToBeSentMessage(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
    dbm.Message message,
  ) async {
    final newMessageEntry = dbm.NewMessageEntry(
      localAccountId: localAccountId,
      remoteAccountId: remoteAccountId,
      message: message,
      localUnixTime: UtcDateTime.now(),
      messageState: dbm.SentMessageState.pending.toDbState(),
    );

    return await transaction(() async {
      await db.write.conversationList.setCurrentTimeToConversationLastChanged(remoteAccountId);
      return await _insert(newMessageEntry);
    });
  }

  /// Null values are not updated.
  Future<void> updateSentMessageState(
    dbm.LocalMessageId localId, {
    dbm.SentMessageState? sentState,
    api.UnixTime? unixTimeFromServer,
    api.MessageId? messageIdFromServer,
    Uint8List? backendSignePgpMessage,
    UtcDateTime? deliveredUnixTime,
    UtcDateTime? seenUnixTime,
  }) async {
    final UtcDateTime? unixTime;
    if (unixTimeFromServer != null) {
      unixTime = UtcDateTime.fromUnixEpochMilliseconds(unixTimeFromServer.ut * 1000);
    } else {
      unixTime = null;
    }
    await (update(message)..where((t) => t.id.equals(localId.id))).write(
      MessageCompanion(
        messageState: Value.absentIfNull(sentState?.toDbState().number),
        unixTime: Value.absentIfNull(unixTime),
        messageId: Value.absentIfNull(messageIdFromServer),
        backendSignedPgpMessage: Value.absentIfNull(backendSignePgpMessage),
        deliveredUnixTime: Value.absentIfNull(deliveredUnixTime),
        seenUnixTime: Value.absentIfNull(seenUnixTime),
      ),
    );
  }

  Future<void> insertReceivedMessage(
    api.AccountId localAccountId,
    api.AccountId senderAccountId,
    api.MessageId messageId,
    UtcDateTime serverTime,
    Uint8List backendSignedPgpMessage,
    dbm.Message? decryptedMessage,
    Uint8List? symmetricMessageEncryptionKey,
    dbm.ReceivedMessageState state,
  ) async {
    final message = dbm.NewMessageEntry(
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
      await db.write.conversationList.setCurrentTimeToConversationLastChanged(senderAccountId);
    });
  }

  Future<void> insertInfoMessage(
    api.AccountId localAccountId,
    api.AccountId remoteAccountId,
    dbm.InfoMessageState state,
  ) async {
    final message = dbm.NewMessageEntry(
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
    dbm.LocalMessageId localId,
    dbm.ReceivedMessageState receivedMessageState, {
    dbm.Message? messageValue,
    Uint8List? symmetricMessageEncryptionKey,
  }) async {
    await (update(message)..where((t) => t.id.equals(localId.id))).write(
      MessageCompanion(
        messageState: Value(receivedMessageState.toDbState().number),
        message: Value.absentIfNull(messageValue),
        symmetricMessageEncryptionKey: Value.absentIfNull(symmetricMessageEncryptionKey),
      ),
    );
  }

  Future<void> updateSymmetricMessageEncryptionKey(
    dbm.LocalMessageId localId,
    Uint8List symmetricMessageEncryptionKey,
  ) async {
    await (update(message)..where((t) => t.id.equals(localId.id))).write(
      MessageCompanion(symmetricMessageEncryptionKey: Value(symmetricMessageEncryptionKey)),
    );
  }

  Future<void> deleteMessage(dbm.LocalMessageId localId) async {
    await (delete(message)..where((t) => t.id.equals(localId.id))).go();
  }
}
