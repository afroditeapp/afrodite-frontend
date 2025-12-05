import 'dart:typed_data';

import 'package:database_model/src/chat/backup.dart';
import 'package:database_model/src/chat/backup/blob.dart';
import 'package:database_model/src/chat/backup/json.dart';
import 'package:openapi/api.dart';
import 'package:test/test.dart';
import 'package:utils/utils.dart';

void main() {
  group('ChatBackup', () {
    test('serializes and deserializes backup with example data', () {
      // Create example metadata
      final metadata = BackupMetadata(
        createdAt: UtcDateTime.fromUnixEpochMilliseconds(1733443200000), // Dec 6, 2025
        accountId: AccountId(aid: 'test-account-id-123'),
        privateKeyData: Uint8List.fromList([1, 2, 3, 4, 5]),
        publicKeyData: Uint8List.fromList([6, 7, 8, 9, 10]),
        publicKeyId: 42,
      );

      // Create example blob store
      final symmetricKey1 = Uint8List.fromList([11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);
      final symmetricKey2 = Uint8List.fromList([21, 22, 23, 24, 25, 26, 27, 28, 29, 30]);
      final pgpMessage1 = Uint8List.fromList([31, 32, 33, 34, 35, 36, 37, 38, 39, 40]);
      final pgpMessage2 = Uint8List.fromList([41, 42, 43, 44, 45, 46, 47, 48, 49, 50]);

      final blobStore = BackupBlobStore([
        BackupBlob(symmetricKey1), // index 0
        BackupBlob(pgpMessage1), // index 1
        BackupBlob(symmetricKey2), // index 2
        BackupBlob(pgpMessage2), // index 3
      ]);

      // Create example messages for first account
      final account1Messages = [
        BackupMessageJson(
          localId: 1,
          localUnixTime: UtcDateTime.fromUnixEpochMilliseconds(1733443201000),
          messageState: 3, // sent
          symmetricKeyBlobIndex: 0,
          backendSignedPgpMessageBlobIndex: 1,
          sentUnixTime: UtcDateTime.fromUnixEpochMilliseconds(1733443201500),
          deliveredUnixTime: UtcDateTime.fromUnixEpochMilliseconds(1733443202000),
          seenUnixTime: UtcDateTime.fromUnixEpochMilliseconds(1733443203000),
          messageId: MessageId(id: 'msg-id-1'),
          messageNumber: MessageNumber(mn: 100),
        ),
        BackupMessageJson(
          localId: 2,
          localUnixTime: UtcDateTime.fromUnixEpochMilliseconds(1733443204000),
          messageState: 1, // received
          symmetricKeyBlobIndex: 2,
          backendSignedPgpMessageBlobIndex: 3,
          sentUnixTime: UtcDateTime.fromUnixEpochMilliseconds(1733443204500),
          deliveredUnixTime: null,
          seenUnixTime: null,
          messageId: MessageId(id: 'msg-id-2'),
          messageNumber: MessageNumber(mn: 200),
        ),
      ];

      // Create example messages for second account
      final account2Messages = [
        BackupMessageJson(
          localId: 3,
          localUnixTime: UtcDateTime.fromUnixEpochMilliseconds(1733443205000),
          messageState: 0, // pending
          symmetricKeyBlobIndex: null,
          backendSignedPgpMessageBlobIndex: null,
          sentUnixTime: null,
          deliveredUnixTime: null,
          seenUnixTime: null,
          messageId: null,
          messageNumber: null,
        ),
      ];

      // Create accounts
      final accounts = [
        BackupAccountJson(
          accountId: AccountId(aid: 'remote-account-1'),
          messages: account1Messages,
        ),
        BackupAccountJson(
          accountId: AccountId(aid: 'remote-account-2'),
          messages: account2Messages,
        ),
      ];

      // Create backup JSON
      final backupJson = BackupJson(metadata: metadata, accounts: accounts);

      // Create backup data
      final backupData = ChatBackupData(json: backupJson, blobStore: blobStore);

      // Compress and serialize
      final backupFile = backupData.compress();
      final bytes = backupFile.toBytes();

      // Verify header and version
      expect(bytes.sublist(0, 7), equals(backupHeader));
      expect(bytes[7], equals(backupVersion1));

      // Deserialize and decompress
      final restoredFile = ChatBackupFile.fromBytes(bytes);
      final restoredData = restoredFile.decompress();

      // Verify metadata
      expect(
        restoredData.json.metadata.createdAt.toUnixEpochMilliseconds(),
        equals(metadata.createdAt.toUnixEpochMilliseconds()),
      );
      expect(restoredData.json.metadata.accountId.aid, equals(metadata.accountId.aid));
      expect(restoredData.json.metadata.privateKeyData, equals(metadata.privateKeyData));
      expect(restoredData.json.metadata.publicKeyData, equals(metadata.publicKeyData));
      expect(restoredData.json.metadata.publicKeyId, equals(metadata.publicKeyId));

      // Verify accounts
      expect(restoredData.json.accounts.length, equals(2));

      // Verify first account
      expect(restoredData.json.accounts[0].accountId.aid, equals('remote-account-1'));
      expect(restoredData.json.accounts[0].messages.length, equals(2));

      // Verify first message
      final msg1 = restoredData.json.accounts[0].messages[0];
      expect(msg1.localId, equals(1));
      expect(msg1.localUnixTime.toUnixEpochMilliseconds(), equals(1733443201000));
      expect(msg1.messageState, equals(3));
      expect(msg1.symmetricKeyBlobIndex, equals(0));
      expect(msg1.backendSignedPgpMessageBlobIndex, equals(1));
      expect(msg1.sentUnixTime?.toUnixEpochMilliseconds(), equals(1733443201500));
      expect(msg1.deliveredUnixTime?.toUnixEpochMilliseconds(), equals(1733443202000));
      expect(msg1.seenUnixTime?.toUnixEpochMilliseconds(), equals(1733443203000));
      expect(msg1.messageId?.id, equals('msg-id-1'));
      expect(msg1.messageNumber?.mn, equals(100));

      // Verify second message
      final msg2 = restoredData.json.accounts[0].messages[1];
      expect(msg2.localId, equals(2));
      expect(msg2.localUnixTime.toUnixEpochMilliseconds(), equals(1733443204000));
      expect(msg2.messageState, equals(1));
      expect(msg2.symmetricKeyBlobIndex, equals(2));
      expect(msg2.backendSignedPgpMessageBlobIndex, equals(3));
      expect(msg2.sentUnixTime?.toUnixEpochMilliseconds(), equals(1733443204500));
      expect(msg2.deliveredUnixTime, isNull);
      expect(msg2.seenUnixTime, isNull);
      expect(msg2.messageId?.id, equals('msg-id-2'));
      expect(msg2.messageNumber?.mn, equals(200));

      // Verify second account
      expect(restoredData.json.accounts[1].accountId.aid, equals('remote-account-2'));
      expect(restoredData.json.accounts[1].messages.length, equals(1));

      // Verify third message
      final msg3 = restoredData.json.accounts[1].messages[0];
      expect(msg3.localId, equals(3));
      expect(msg3.messageState, equals(0));
      expect(msg3.symmetricKeyBlobIndex, isNull);
      expect(msg3.backendSignedPgpMessageBlobIndex, isNull);
      expect(msg3.sentUnixTime, isNull);
      expect(msg3.deliveredUnixTime, isNull);
      expect(msg3.seenUnixTime, isNull);
      expect(msg3.messageId, isNull);
      expect(msg3.messageNumber, isNull);

      // Verify blobs
      expect(restoredData.blobStore.blobs.length, equals(4));
      expect(restoredData.blobStore.get(0), equals(symmetricKey1));
      expect(restoredData.blobStore.get(1), equals(pgpMessage1));
      expect(restoredData.blobStore.get(2), equals(symmetricKey2));
      expect(restoredData.blobStore.get(3), equals(pgpMessage2));
    });

    test('handles backup with no messages', () {
      final metadata = BackupMetadata(
        createdAt: UtcDateTime.fromUnixEpochMilliseconds(1733443200000),
        accountId: AccountId(aid: 'test-account-id'),
        privateKeyData: null,
        publicKeyData: null,
        publicKeyId: null,
      );

      final backupData = ChatBackupData(
        json: BackupJson(metadata: metadata, accounts: []),
        blobStore: BackupBlobStore([]),
      );

      final bytes = backupData.compress().toBytes();
      final restored = ChatBackupFile.fromBytes(bytes).decompress();

      expect(restored.json.accounts.length, equals(0));
      expect(restored.blobStore.blobs.length, equals(0));
    });

    test('handles backup with minimal message data', () {
      final metadata = BackupMetadata(
        createdAt: UtcDateTime.fromUnixEpochMilliseconds(1733443200000),
        accountId: AccountId(aid: 'test-account-id'),
      );

      final message = BackupMessageJson(
        localId: 1,
        localUnixTime: UtcDateTime.fromUnixEpochMilliseconds(1733443201000),
        messageState: 0,
      );

      final backupData = ChatBackupData(
        json: BackupJson(
          metadata: metadata,
          accounts: [
            BackupAccountJson(
              accountId: AccountId(aid: 'remote-account'),
              messages: [message],
            ),
          ],
        ),
        blobStore: BackupBlobStore([]),
      );

      final bytes = backupData.compress().toBytes();
      final restored = ChatBackupFile.fromBytes(bytes).decompress();

      expect(restored.json.accounts.length, equals(1));
      expect(restored.json.accounts[0].messages.length, equals(1));
      final restoredMsg = restored.json.accounts[0].messages[0];
      expect(restoredMsg.localId, equals(1));
      expect(restoredMsg.symmetricKeyBlobIndex, isNull);
      expect(restoredMsg.backendSignedPgpMessageBlobIndex, isNull);
      expect(restoredMsg.deliveredUnixTime, isNull);
      expect(restoredMsg.seenUnixTime, isNull);
    });
  });
}
