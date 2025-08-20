import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class MyKeyPair extends SingleRowTable {
  BlobColumn get privateKeyData =>
      blob().map(const NullAwareTypeConverter.wrap(PrivateKeyBytesConverter())).nullable()();
  BlobColumn get publicKeyData =>
      blob().map(const NullAwareTypeConverter.wrap(PublicKeyBytesConverter())).nullable()();
  IntColumn get publicKeyId =>
      integer().map(const NullAwareTypeConverter.wrap(PublicKeyIdConverter())).nullable()();
}

class PublicKey extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();

  BlobColumn get publicKeyData => blob().nullable()();
  IntColumn get publicKeyId =>
      integer().map(const NullAwareTypeConverter.wrap(PublicKeyIdConverter())).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

// Conversation list related data
class ConversationList extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();

  IntColumn get conversationLastChangedTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  // If column is not null, then it is in the specific group.
  // The time is the time when the profile was added to the group.
  IntColumn get isInConversationList =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  // Sent blocks is here to make conversation list updates faster.
  IntColumn get isInSentBlocks =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class DailyLikesLeft extends SingleRowTable {
  IntColumn get dailyLikesLeft => integer().nullable()();
  IntColumn get dailyLikesLeftSyncVersion => integer().nullable()();
}

class Message extends Table {
  /// Local message ID
  IntColumn get id => integer().autoIncrement()();
  TextColumn get localAccountId => text().map(const AccountIdConverter())();
  TextColumn get remoteAccountId => text().map(const AccountIdConverter())();
  BlobColumn get message =>
      blob().map(const NullAwareTypeConverter.wrap(MessageConverter())).nullable()();
  IntColumn get localUnixTime => integer().map(const UtcDateTimeConverter())();
  IntColumn get messageState => integer()();
  BlobColumn get symmetricMessageEncryptionKey => blob().nullable()();

  // Server sends valid values for the next colums.
  IntColumn get messageId =>
      integer().map(const NullAwareTypeConverter.wrap(MessageIdConverter())).nullable()();
  IntColumn get unixTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  BlobColumn get backendSignedPgpMessage => blob().nullable()();
}
