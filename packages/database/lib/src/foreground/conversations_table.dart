


import 'package:database/src/message_entry.dart';
import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:utils/utils.dart';
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../profile_entry.dart';
import '../utils.dart';

part 'conversations_table.g.dart';

/// Conversation related data moved from Profile table
class Conversations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  TextColumn get publicKeyData => text().map(const NullAwareTypeConverter.wrap(PublicKeyDataConverter())).nullable()();
  IntColumn get publicKeyId => integer().map(const NullAwareTypeConverter.wrap(PublicKeyIdConverter())).nullable()();
  IntColumn get publicKeyVersion => integer().map(const NullAwareTypeConverter.wrap(PublicKeyVersionConverter())).nullable()();
}

@DriftAccessor(tables: [Conversations])
class DaoConversations extends DatabaseAccessor<AccountDatabase> with _$DaoConversationsMixin {
  DaoConversations(AccountDatabase db) : super(db);

  Future<void> updatePublicKey(
    AccountId accountId,
    api.PublicKey? value,
  ) async {
    await into(conversations).insert(
      ConversationsCompanion.insert(
        uuidAccountId: accountId,
        publicKeyData: Value(value?.data),
        publicKeyId: Value(value?.id),
        publicKeyVersion: Value(value?.version),
      ),
      onConflict: DoUpdate((old) => ConversationsCompanion(
        publicKeyData: Value(value?.data),
        publicKeyId: Value(value?.id),
        publicKeyVersion: Value(value?.version),
      ),
        target: [conversations.uuidAccountId]
      ),
    );
  }

  Future<api.PublicKey?> getPublicKey(AccountId accountId) async {
    final r = await (select(conversations)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    final data = r?.publicKeyData;
    final id = r?.publicKeyId;
    final version = r?.publicKeyVersion;

    if (data != null && id != null && version != null) {
      return api.PublicKey(data: data, id: id, version: version);
    } else {
      return null;
    }
  }
}
