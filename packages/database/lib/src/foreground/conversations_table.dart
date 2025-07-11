


import 'package:database/database.dart';
import 'package:openapi/api.dart' show AccountId;
import 'package:openapi/api.dart' as api;
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../utils.dart';

part 'conversations_table.g.dart';

/// Conversation related data moved from Profile table
class Conversations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();

  BlobColumn get publicKeyData => blob().nullable()();
  IntColumn get publicKeyId => integer().map(const NullAwareTypeConverter.wrap(PublicKeyIdConverter())).nullable()();
}

@DriftAccessor(tables: [Conversations])
class DaoConversations extends DatabaseAccessor<AccountDatabase> with _$DaoConversationsMixin {
  DaoConversations(super.db);

  Future<void> updatePublicKeyAndAddInfoMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    Uint8List publicKeyData,
    api.PublicKeyId publicKeyId,
    InfoMessageState? infoState,
  ) async {
    await transaction(() async {
      await into(conversations).insert(
        ConversationsCompanion.insert(
          uuidAccountId: remoteAccountId,
          publicKeyData: Value(publicKeyData),
          publicKeyId: Value(publicKeyId),
        ),
        onConflict: DoUpdate((old) => ConversationsCompanion(
          publicKeyData: Value(publicKeyData),
          publicKeyId: Value(publicKeyId),
        ),
          target: [conversations.uuidAccountId]
        ),
      );
      if (infoState != null) {
        await db.daoMessageTable.insertInfoMessage(localAccountId, remoteAccountId, infoState);
      }
    });
  }

  Future<ForeignPublicKey?> getPublicKey(AccountId accountId) async {
    final r = await (select(conversations)
      ..where((t) => t.uuidAccountId.equals(accountId.aid))
    )
      .getSingleOrNull();

    final data = r?.publicKeyData;
    final id = r?.publicKeyId;

    if (data != null && id != null) {
      return ForeignPublicKey(data: data, id: id);
    } else {
      return null;
    }
  }
}
