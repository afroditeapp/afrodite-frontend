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
  IntColumn get publicKeyIdOnServer =>
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

  /// Sent blocks is here to make conversation list updates faster.
  ///
  /// Values:
  /// * null - Not in local sent blocks
  /// * non-null - Time when added to local sent blocks
  IntColumn get isInSentBlocks =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class DailyLikesLeft extends SingleRowTable {
  IntColumn get dailyLikesLeft => integer().nullable()();
  IntColumn get dailyLikesLeftSyncVersion => integer().nullable()();
}

class ChatPrivacySettings extends SingleRowTable {
  BoolColumn get messageStateDelivered => boolean().withDefault(const Constant(false))();
  BoolColumn get messageStateSent => boolean().withDefault(const Constant(false))();
  BoolColumn get typingIndicator => boolean().withDefault(const Constant(false))();
}

class Message extends Table {
  /// Local message ID
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get remoteAccountId => text().map(const AccountIdConverter())();
  BlobColumn get message =>
      blob().map(const NullAwareTypeConverter.wrap(MessageConverter())).nullable()();
  IntColumn get localUnixTime => integer().map(const UtcDateTimeConverter())();
  IntColumn get messageState => integer()();
  BlobColumn get symmetricMessageEncryptionKey => blob().nullable()();

  // Server sends valid values for the next colums.
  IntColumn get messageNumber =>
      integer().map(const NullAwareTypeConverter.wrap(MessageNumberConverter())).nullable()();
  IntColumn get sentUnixTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  BlobColumn get backendSignedPgpMessage => blob().nullable()();
  IntColumn get deliveredUnixTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();
  IntColumn get seenUnixTime =>
      integer().map(const NullAwareTypeConverter.wrap(UtcDateTimeConverter())).nullable()();

  // Message sender creates this locally. Message receiver gets this with
  // the message.
  TextColumn get messageId =>
      text().map(const NullAwareTypeConverter.wrap(MessageIdConverter())).nullable()();
}

class UnreadMessagesCount extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();
  IntColumn get unreadMessagesCount =>
      integer().map(UnreadMessagesCountConverter()).withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}

class NewMessageNotification extends Table {
  TextColumn get accountId => text().map(const AccountIdConverter())();
  IntColumn get conversationId =>
      integer().map(const NullAwareTypeConverter.wrap(ConversationIdConverter())).nullable()();
  BoolColumn get notificationShown => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {accountId};
}
