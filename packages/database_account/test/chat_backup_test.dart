import 'package:database_account/src/database.dart';
import 'package:database_model/database_model.dart' as dbm;
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:openapi/api.dart' as api;
import 'package:test/test.dart';
import 'package:utils/utils.dart';

void main() {
  group('Chat Backup', () {
    late AccountDatabase db;
    final testAccountId = api.AccountId(aid: 'test-account-123');
    final remoteAccount1 = api.AccountId(aid: 'remote-account-1');
    final remoteAccount2 = api.AccountId(aid: 'remote-account-2');

    setUp(() {
      // Create in-memory database for testing
      db = AccountDatabase(_InMemoryQueryExecutorProvider());
    });

    tearDown(() async {
      await db.close();
    });

    test('creates backup, removes messages, restores and checks order', () async {
      // Step 1: Add example messages to DB
      final message1Time = UtcDateTime.fromUnixEpochMilliseconds(1000);
      final message2Time = UtcDateTime.fromUnixEpochMilliseconds(2000);
      final message3Time = UtcDateTime.fromUnixEpochMilliseconds(3000);
      final message4Time = UtcDateTime.fromUnixEpochMilliseconds(4000);

      final sentTime1 = UtcDateTime.fromUnixEpochMilliseconds(1100);
      final sentTime2 = UtcDateTime.fromUnixEpochMilliseconds(2100);
      final deliveredTime1 = UtcDateTime.fromUnixEpochMilliseconds(1200);
      final seenTime1 = UtcDateTime.fromUnixEpochMilliseconds(1300);

      // Insert messages for account 1
      final localId1 = await db.write.message.insertToBeSentMessage(
        remoteAccount1,
        api.MessageId(id: 'msg-1'),
        dbm.TextMessage.create('Hello 1')!,
      );

      // Manually update the local time and other fields to test ordering and backup
      await (db.update(db.message)..where((t) => t.localId.equals(localId1.id))).write(
        MessageCompanion(
          localUnixTime: Value(message1Time),
          sentUnixTime: Value(sentTime1),
          deliveredUnixTime: Value(deliveredTime1),
          seenUnixTime: Value(seenTime1),
          messageNumber: Value(api.MessageNumber(mn: 10)),
        ),
      );

      final localId2 = await db.write.message.insertToBeSentMessage(
        remoteAccount1,
        api.MessageId(id: 'msg-2'),
        dbm.TextMessage.create('Hello 2')!,
      );

      await (db.update(db.message)..where((t) => t.localId.equals(localId2.id))).write(
        MessageCompanion(
          localUnixTime: Value(message2Time),
          sentUnixTime: Value(sentTime2),
          messageNumber: Value(api.MessageNumber(mn: 20)),
        ),
      );

      // Insert messages for account 2
      final localId3 = await db.write.message.insertToBeSentMessage(
        remoteAccount2,
        api.MessageId(id: 'msg-3'),
        dbm.TextMessage.create('Hello 3')!,
      );

      await (db.update(db.message)..where((t) => t.localId.equals(localId3.id))).write(
        MessageCompanion(localUnixTime: Value(message3Time)),
      );

      // Verify initial messages
      final initialMessages1 = await db.read.message.getAllMessages(remoteAccount1);
      final initialMessages2 = await db.read.message.getAllMessages(remoteAccount2);
      expect(initialMessages1.length, equals(2));
      expect(initialMessages2.length, equals(1));

      // Step 2: Create backup
      final backup = await db.read.backup.createBackup(testAccountId);
      expect(backup.json.accounts.length, equals(2));

      // Find account 1 in backup
      final backupAccount1 = backup.json.accounts.firstWhere(
        (a) => a.accountId.aid == remoteAccount1.aid,
      );
      expect(backupAccount1.messages.length, equals(2));

      // Verify backup contains all fields
      final backupMsg1 = backupAccount1.messages.firstWhere((m) => m.messageId?.id == 'msg-1');
      expect(backupMsg1.sentUnixTime?.toUnixEpochMilliseconds(), equals(1100));
      expect(backupMsg1.deliveredUnixTime?.toUnixEpochMilliseconds(), equals(1200));
      expect(backupMsg1.seenUnixTime?.toUnixEpochMilliseconds(), equals(1300));
      expect(backupMsg1.messageNumber?.mn, equals(10));
      expect(backupMsg1.messageId?.id, equals('msg-1'));

      final backupMsg2 = backupAccount1.messages.firstWhere((m) => m.messageId?.id == 'msg-2');
      expect(backupMsg2.sentUnixTime?.toUnixEpochMilliseconds(), equals(2100));
      expect(backupMsg2.messageNumber?.mn, equals(20));
      expect(backupMsg2.deliveredUnixTime, isNull);
      expect(backupMsg2.seenUnixTime, isNull);

      // Step 3: Remove all messages
      await db.delete(db.message).go();

      // Verify all messages are deleted
      final afterDeleteMessages1 = await db.read.message.getAllMessages(remoteAccount1);
      final afterDeleteMessages2 = await db.read.message.getAllMessages(remoteAccount2);
      expect(afterDeleteMessages1.length, equals(0));
      expect(afterDeleteMessages2.length, equals(0));

      // Step 4: Add new messages to DB (with different times)
      final localId4 = await db.write.message.insertToBeSentMessage(
        remoteAccount1,
        api.MessageId(id: 'msg-4'),
        dbm.TextMessage.create('New message')!,
      );

      await (db.update(db.message)..where((t) => t.localId.equals(localId4.id))).write(
        MessageCompanion(localUnixTime: Value(message4Time)),
      );

      // Verify new message is there
      final beforeRestoreMessages = await db.read.message.getAllMessages(remoteAccount1);
      expect(beforeRestoreMessages.length, equals(1));
      expect((beforeRestoreMessages[0].message as dbm.TextMessage?)?.text, equals('New message'));

      // Step 5: Restore the backup
      await db.write.backup.restoreBackup(backup);

      // Step 6: Check the order of messages
      final restoredMessages1 = await db.read.message.getAllMessages(remoteAccount1);
      final restoredMessages2 = await db.read.message.getAllMessages(remoteAccount2);

      // Should have 3 messages for account 1 (2 from backup + 1 new)
      expect(restoredMessages1.length, equals(3));
      expect(restoredMessages2.length, equals(1));

      // Check ordering by localUnixTime (newest first since getAllMessages returns in DESC order)
      expect(restoredMessages1[0].localUnixTime.toUnixEpochMilliseconds(), equals(4000));
      expect((restoredMessages1[0].message as dbm.TextMessage?)?.text, equals('New message'));

      expect(restoredMessages1[1].localUnixTime.toUnixEpochMilliseconds(), equals(2000));
      expect((restoredMessages1[1].message as dbm.TextMessage?)?.text, equals('Hello 2'));
      expect(restoredMessages1[1].sentUnixTime?.toUnixEpochMilliseconds(), equals(2100));
      expect(restoredMessages1[1].messageNumber?.mn, equals(20));

      expect(restoredMessages1[2].localUnixTime.toUnixEpochMilliseconds(), equals(1000));
      expect((restoredMessages1[2].message as dbm.TextMessage?)?.text, equals('Hello 1'));
      expect(restoredMessages1[2].sentUnixTime?.toUnixEpochMilliseconds(), equals(1100));
      expect(restoredMessages1[2].deliveredUnixTime?.toUnixEpochMilliseconds(), equals(1200));
      expect(restoredMessages1[2].seenUnixTime?.toUnixEpochMilliseconds(), equals(1300));
      expect(restoredMessages1[2].messageNumber?.mn, equals(10));

      // Check account 2 messages
      expect(restoredMessages2[0].localUnixTime.toUnixEpochMilliseconds(), equals(3000));
      expect((restoredMessages2[0].message as dbm.TextMessage?)?.text, equals('Hello 3'));
    });

    test('does not add duplicate messages when restoring', () async {
      // Add a message
      final messageId = api.MessageId(id: 'msg-unique-1');
      await db.write.message.insertToBeSentMessage(
        remoteAccount1,
        messageId,
        dbm.TextMessage.create('Original message')!,
      );

      // Create backup
      final backup = await db.read.backup.createBackup(testAccountId);

      // Restore backup (should not duplicate the message)
      await db.write.backup.restoreBackup(backup);

      // Verify we still have only 1 message
      final messages = await db.read.message.getAllMessages(remoteAccount1);
      expect(messages.length, equals(1));
    });

    test('updates keys when backup has newer key ID', () async {
      // Set initial keys
      await db.write.key.setMessageKeys(
        private: dbm.PrivateKeyBytes(data: Uint8List.fromList([1, 2, 3])),
        public: dbm.PublicKeyBytes(data: Uint8List.fromList([4, 5, 6])),
        publicKeyId: api.PublicKeyId(id: 10),
        publicKeyIdOnServer: api.PublicKeyId(id: 30),
      );

      // Create a backup with newer keys
      final newerMetadata = dbm.BackupMetadata(
        createdAt: UtcDateTime.now(),
        accountId: testAccountId,
        privateKeyData: Uint8List.fromList([7, 8, 9]),
        publicKeyData: Uint8List.fromList([10, 11, 12]),
        publicKeyId: 20, // Higher ID
      );

      final backup = dbm.ChatBackupData(
        json: dbm.BackupJson(metadata: newerMetadata, accounts: []),
        blobStore: dbm.BackupBlobStore([]),
      );

      // Restore backup
      await db.write.backup.restoreBackup(backup);

      // Verify keys were updated
      final keys = await db.read.key.getMessageKeys();
      expect(keys, isNotNull);
      expect(keys!.publicKeyId.id, equals(20));
      expect(keys.private.data, equals(Uint8List.fromList([7, 8, 9])));
      expect(keys.publicKeyIdOnServer.id, equals(30));
    });

    test('does not update keys when backup has older key ID', () async {
      // Set initial keys with higher ID
      await db.write.key.setMessageKeys(
        private: dbm.PrivateKeyBytes(data: Uint8List.fromList([1, 2, 3])),
        public: dbm.PublicKeyBytes(data: Uint8List.fromList([4, 5, 6])),
        publicKeyId: api.PublicKeyId(id: 20),
        publicKeyIdOnServer: api.PublicKeyId(id: 30),
      );

      // Create a backup with older keys
      final olderMetadata = dbm.BackupMetadata(
        createdAt: UtcDateTime.now(),
        accountId: testAccountId,
        privateKeyData: Uint8List.fromList([7, 8, 9]),
        publicKeyData: Uint8List.fromList([10, 11, 12]),
        publicKeyId: 10, // Lower ID
      );

      final backup = dbm.ChatBackupData(
        json: dbm.BackupJson(metadata: olderMetadata, accounts: []),
        blobStore: dbm.BackupBlobStore([]),
      );

      // Restore backup
      await db.write.backup.restoreBackup(backup);

      // Verify keys were NOT updated
      final keys = await db.read.key.getMessageKeys();
      expect(keys, isNotNull);
      expect(keys!.publicKeyId.id, equals(20));
      expect(keys.private.data, equals(Uint8List.fromList([1, 2, 3])));
      expect(keys.publicKeyIdOnServer.id, equals(30));
    });

    test('orders messages by localId when localUnixTime is the same', () async {
      // Create multiple messages with the same localUnixTime but different localIds
      final sameTime = UtcDateTime.fromUnixEpochMilliseconds(5000);

      // Insert first message
      final localId1 = await db.write.message.insertToBeSentMessage(
        remoteAccount1,
        api.MessageId(id: 'msg-same-time-1'),
        dbm.TextMessage.create('Message 1')!,
      );

      await (db.update(db.message)..where((t) => t.localId.equals(localId1.id))).write(
        MessageCompanion(localUnixTime: Value(sameTime)),
      );

      // Insert second message
      final localId2 = await db.write.message.insertToBeSentMessage(
        remoteAccount1,
        api.MessageId(id: 'msg-same-time-2'),
        dbm.TextMessage.create('Message 2')!,
      );

      await (db.update(db.message)..where((t) => t.localId.equals(localId2.id))).write(
        MessageCompanion(localUnixTime: Value(sameTime)),
      );

      // Insert third message
      final localId3 = await db.write.message.insertToBeSentMessage(
        remoteAccount1,
        api.MessageId(id: 'msg-same-time-3'),
        dbm.TextMessage.create('Message 3')!,
      );

      await (db.update(db.message)..where((t) => t.localId.equals(localId3.id))).write(
        MessageCompanion(localUnixTime: Value(sameTime)),
      );

      // Create backup and restore to trigger sorting
      final backup = await db.read.backup.createBackup(testAccountId);
      await db.delete(db.message).go();
      await db.write.backup.restoreBackup(backup);

      // Get restored messages
      final restoredMessages = await db.read.message.getAllMessages(remoteAccount1);

      // Verify we have all 3 messages
      expect(restoredMessages.length, equals(3));

      // All messages should have the same localUnixTime
      expect(restoredMessages[0].localUnixTime.toUnixEpochMilliseconds(), equals(5000));
      expect(restoredMessages[1].localUnixTime.toUnixEpochMilliseconds(), equals(5000));
      expect(restoredMessages[2].localUnixTime.toUnixEpochMilliseconds(), equals(5000));

      // Messages should be ordered by localId descending (getAllMessages returns DESC order)
      // So the message with highest localId should be first
      expect(restoredMessages[0].localId.id, greaterThan(restoredMessages[1].localId.id));
      expect(restoredMessages[1].localId.id, greaterThan(restoredMessages[2].localId.id));

      // Verify the content to ensure correct ordering
      expect((restoredMessages[0].message as dbm.TextMessage?)?.text, equals('Message 3'));
      expect((restoredMessages[1].message as dbm.TextMessage?)?.text, equals('Message 2'));
      expect((restoredMessages[2].message as dbm.TextMessage?)?.text, equals('Message 1'));
    });
  });
}

// Helper class for in-memory database testing
class _InMemoryQueryExecutorProvider implements QueryExcecutorProvider {
  @override
  QueryExecutor getQueryExcecutor() {
    return NativeDatabase.memory();
  }
}
