import 'package:database/src/background/account_database.dart';
import 'package:database_converter/database_converter.dart';
import 'package:openapi/api.dart' show AccountId, ConversationId;

import 'package:drift/drift.dart';

part 'new_message_notification_table.g.dart';

class NewMessageNotificationTable extends Table {
  TextColumn get uuidAccountId => text().map(const AccountIdConverter())();
  BoolColumn get notificationShown => boolean().withDefault(const Constant(false))();
  IntColumn get conversationId => integer().map(const NullAwareTypeConverter.wrap(ConversationIdConverter())).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uuidAccountId};
}

@DriftAccessor(tables: [NewMessageNotificationTable])
class DaoNewMessageNotificationTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoNewMessageNotificationTableMixin {
  DaoNewMessageNotificationTable(super.db);

  Future<ConversationId?> getConversationId(AccountId id) async {
    return await (select(newMessageNotificationTable)
      ..where((t) => t.uuidAccountId.equals(id.aid))
    )
      .map((r) => r.conversationId)
      .getSingleOrNull();
  }

  Future<AccountId?> getAccountId(ConversationId conversationId) async {
    return await (select(newMessageNotificationTable)
        ..where((t) => t.conversationId.equals(conversationId.id))
      )
        .map((r) => r.uuidAccountId)
        .getSingleOrNull();
  }

  Future<bool> getNotificationShown(AccountId accountId) async {
    final r = await (select(newMessageNotificationTable)
        ..where((t) => t.uuidAccountId.equals(accountId.aid))
      )
        .getSingleOrNull();
    return r?.notificationShown ?? false;
  }

  Future<void> setConversationId(AccountId accountId, ConversationId value) async {
    await into(newMessageNotificationTable).insert(
      NewMessageNotificationTableCompanion.insert(
        uuidAccountId: accountId,
        conversationId: Value(value),
      ),
      onConflict: DoUpdate(
        (old) => NewMessageNotificationTableCompanion(
          conversationId: Value(value),
        ),
        target: [newMessageNotificationTable.uuidAccountId]
      ),
    );
  }

  Future<void> setNotificationShown(AccountId accountId, bool value) async {
    await into(newMessageNotificationTable).insert(
      NewMessageNotificationTableCompanion.insert(
        uuidAccountId: accountId,
        notificationShown: Value(value),
      ),
      onConflict: DoUpdate(
        (old) => NewMessageNotificationTableCompanion(
          notificationShown: Value(value),
        ),
        target: [newMessageNotificationTable.uuidAccountId]
      ),
    );
  }
}
