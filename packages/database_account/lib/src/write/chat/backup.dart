import 'package:database_account/src/database.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../../schema.dart' as schema;

part 'backup.g.dart';

@DriftAccessor(tables: [schema.Message, schema.MyKeyPair, schema.ConversationList])
class DaoWriteBackup extends DatabaseAccessor<AccountForegroundDatabase>
    with _$DaoWriteBackupMixin {
  DaoWriteBackup(super.db);

  /// Restore messages from backup
  ///
  /// The current key info in DB is replaced if the key in backup has greater ID than current in DB.
  /// The messages are merged with the existing messages using [localUnixTime, localID] ordering.
  /// If DB already has remoteAccountId and messageId pair, the message is not added to DB again.
  /// The merging is done one remoteAccount at a time using transactions.
  Future<void> restoreBackup(dbm.ChatBackupData backup) async {
    // Update keys if backup has newer keys
    await _updateKeysIfNewer(backup.json.metadata);

    // Restore messages for each account
    for (final account in backup.json.accounts) {
      await _restoreAccountMessages(account, backup.blobStore);
    }
  }

  Future<void> _updateKeysIfNewer(dbm.BackupMetadata metadata) async {
    if (metadata.privateKeyData == null ||
        metadata.publicKeyData == null ||
        metadata.publicKeyId == null) {
      return;
    }

    final currentKeys = await (select(
      db.myKeyPair,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();

    // Replace keys if backup has greater ID
    if (currentKeys == null ||
        currentKeys.publicKeyId == null ||
        metadata.publicKeyId! > currentKeys.publicKeyId!.id) {
      await into(db.myKeyPair).insertOnConflictUpdate(
        MyKeyPairCompanion.insert(
          id: SingleRowTable.ID,
          privateKeyData: Value(dbm.PrivateKeyBytes(data: metadata.privateKeyData!)),
          publicKeyData: Value(dbm.PublicKeyBytes(data: metadata.publicKeyData!)),
          publicKeyId: Value(api.PublicKeyId(id: metadata.publicKeyId!)),
        ),
      );
    }
  }

  Future<void> _restoreAccountMessages(
    dbm.BackupAccountJson account,
    dbm.BackupBlobStore blobStore,
  ) async {
    await transaction(() async {
      // Get all existing messages for this account
      final existingMessages = await (select(
        db.message,
      )..where((t) => t.remoteAccountId.equals(account.accountId.aid))).get();

      // Create a set of existing (remoteAccountId, messageId) pairs to avoid duplicates
      final existingMessageIds = <String>{};
      for (final msg in existingMessages) {
        if (msg.messageId != null) {
          existingMessageIds.add('${msg.remoteAccountId.aid}_${msg.messageId!.id}');
        }
      }

      // Convert backup messages to MessageData, filtering out duplicates
      final backupMessages = <MessageData>[];
      for (final backupMsg in account.messages) {
        // Get messageId and messageNumber from backup JSON
        final messageId = backupMsg.messageId;
        final messageNumber = backupMsg.messageNumber;

        // Check if this message already exists by messageId
        if (messageId != null) {
          final existingKey = '${account.accountId.aid}_${messageId.id}';
          if (existingMessageIds.contains(existingKey)) {
            continue; // Skip duplicate
          }
        }

        // Get blobs
        final symmetricKey = backupMsg.symmetricKeyBlobIndex != null
            ? blobStore.get(backupMsg.symmetricKeyBlobIndex)
            : null;
        final pgpMessage = backupMsg.backendSignedPgpMessageBlobIndex != null
            ? blobStore.get(backupMsg.backendSignedPgpMessageBlobIndex)
            : null;
        final messageData = backupMsg.messageBlobIndex != null
            ? blobStore.get(backupMsg.messageBlobIndex)
            : null;

        // Parse message if available
        dbm.Message? message;
        if (messageData != null) {
          message = dbm.Message.parseFromBytes(messageData);
        }

        // Create MessageData (we need to reconstruct this from backup data)
        backupMessages.add(
          MessageData(
            localId: backupMsg.localId,
            remoteAccountId: account.accountId,
            message: message,
            localUnixTime: backupMsg.localUnixTime,
            messageState: backupMsg.messageState,
            symmetricMessageEncryptionKey: symmetricKey,
            messageNumber: messageNumber,
            messageId: messageId,
            sentUnixTime: backupMsg.sentUnixTime,
            backendSignedPgpMessage: pgpMessage,
            deliveredUnixTime: backupMsg.deliveredUnixTime,
            seenUnixTime: backupMsg.seenUnixTime,
          ),
        );
      }

      // Merge existing and backup messages
      final allMessages = [...existingMessages, ...backupMessages];

      // Sort by [localUnixTime, localId]
      allMessages.sort((a, b) {
        final timeCompare = a.localUnixTime.toUnixEpochMilliseconds().compareTo(
          b.localUnixTime.toUnixEpochMilliseconds(),
        );
        if (timeCompare != 0) return timeCompare;
        return a.localId.compareTo(b.localId);
      });

      // Delete all existing messages for this account
      await (delete(
        db.message,
      )..where((t) => t.remoteAccountId.equals(account.accountId.aid))).go();

      // Insert sorted messages one by one
      for (final msg in allMessages) {
        await into(db.message).insert(
          MessageCompanion.insert(
            remoteAccountId: msg.remoteAccountId,
            message: Value(msg.message),
            localUnixTime: msg.localUnixTime,
            messageState: msg.messageState,
            symmetricMessageEncryptionKey: Value(msg.symmetricMessageEncryptionKey),
            messageNumber: Value(msg.messageNumber),
            messageId: Value(msg.messageId),
            sentUnixTime: Value(msg.sentUnixTime),
            backendSignedPgpMessage: Value(msg.backendSignedPgpMessage),
            deliveredUnixTime: Value(msg.deliveredUnixTime),
            seenUnixTime: Value(msg.seenUnixTime),
          ),
        );
      }

      final latestMessage = allMessages.lastOrNull;
      if (latestMessage != null) {
        await into(conversationList).insertOnConflictUpdate(
          ConversationListCompanion.insert(
            accountId: latestMessage.remoteAccountId,
            conversationLastChangedTime: Value(latestMessage.sentUnixTime),
          ),
        );
      }
    });
  }
}
