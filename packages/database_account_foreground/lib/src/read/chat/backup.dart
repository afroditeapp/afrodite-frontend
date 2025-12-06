import 'package:database_account_foreground/src/database.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';

import '../../schema.dart' as schema;

part 'backup.g.dart';

@DriftAccessor(tables: [schema.Message, schema.MyKeyPair])
class DaoReadBackup extends DatabaseAccessor<AccountForegroundDatabase> with _$DaoReadBackupMixin {
  DaoReadBackup(super.db);

  /// Create a chat backup from the database
  Future<dbm.ChatBackupData> createBackup(api.AccountId accountId) async {
    final blobStore = dbm.BackupBlobStore([]);
    final accounts = <dbm.BackupAccountJson>[];

    // Get current key pair
    final myKeys = await (select(
      db.myKeyPair,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();

    final metadata = dbm.BackupMetadata(
      createdAt: UtcDateTime.now(),
      accountId: accountId,
      privateKeyData: myKeys?.privateKeyData?.data,
      publicKeyData: myKeys?.publicKeyData?.data,
      publicKeyId: myKeys?.publicKeyId?.id,
    );

    // Group messages by remote account ID
    final allMessages = await select(db.message).get();
    final messagesByAccount = <String, List<MessageData>>{};

    for (final msg in allMessages) {
      final accountKey = msg.remoteAccountId.aid;
      messagesByAccount.putIfAbsent(accountKey, () => []).add(msg);
    }

    // Create backup accounts with messages
    for (final entry in messagesByAccount.entries) {
      final remoteAccountId = api.AccountId(aid: entry.key);
      final messages = <dbm.BackupMessageJson>[];

      for (final msg in entry.value) {
        // Add symmetric key to blob store if present
        int? symmetricKeyBlobIndex;
        if (msg.symmetricMessageEncryptionKey != null) {
          symmetricKeyBlobIndex = blobStore.add(msg.symmetricMessageEncryptionKey);
        }

        // Add backend signed PGP message to blob store if present
        int? backendSignedPgpMessageBlobIndex;
        if (msg.backendSignedPgpMessage != null) {
          backendSignedPgpMessageBlobIndex = blobStore.add(msg.backendSignedPgpMessage);
        }

        // Add message data to blob store if present
        int? messageBlobIndex;
        if (msg.message != null) {
          messageBlobIndex = blobStore.add(msg.message!.toMessagePacket());
        }

        messages.add(
          dbm.BackupMessageJson(
            localId: msg.localId,
            localUnixTime: msg.localUnixTime,
            messageState: msg.messageState,
            symmetricKeyBlobIndex: symmetricKeyBlobIndex,
            backendSignedPgpMessageBlobIndex: backendSignedPgpMessageBlobIndex,
            sentUnixTime: msg.sentUnixTime,
            deliveredUnixTime: msg.deliveredUnixTime,
            seenUnixTime: msg.seenUnixTime,
            messageBlobIndex: messageBlobIndex,
            messageId: msg.messageId,
            messageNumber: msg.messageNumber,
          ),
        );
      }

      accounts.add(dbm.BackupAccountJson(accountId: remoteAccountId, messages: messages));
    }

    final backupJson = dbm.BackupJson(metadata: metadata, accounts: accounts);

    return dbm.ChatBackupData(json: backupJson, blobStore: blobStore);
  }
}
