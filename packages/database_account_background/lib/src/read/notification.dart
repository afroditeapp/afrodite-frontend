import 'package:database_account_background/database_account_background.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'notification.g.dart';

@DriftAccessor(
  tables: [
    schema.AdminNotification,
    schema.NotificationStatus,
    schema.UnreadMessagesCount,
    schema.NewMessageNotification,
    schema.NewReceivedLikesCount,
  ],
)
class DaoReadNotification extends DatabaseAccessor<AccountBackgroundDatabase>
    with _$DaoReadNotificationMixin {
  DaoReadNotification(super.db);

  Future<api.AdminNotification?> getAdminNotification() async {
    return await (select(adminNotification)..where((t) => t.id.equals(SingleRowTable.ID.value)))
        .map((r) => r.jsonViewedNotification?.value)
        .getSingleOrNull();
  }

  Future<api.ConversationId?> getConversationId(api.AccountId id) async {
    return await (select(
      newMessageNotification,
    )..where((t) => t.accountId.equals(id.aid))).map((r) => r.conversationId).getSingleOrNull();
  }

  Future<api.AccountId?> convertConversationIdToAccountId(api.ConversationId conversationId) async {
    return await (select(newMessageNotification)
          ..where((t) => t.conversationId.equals(conversationId.id)))
        .map((r) => r.accountId)
        .getSingleOrNull();
  }

  Future<bool> getNewMessageNotificationShown(api.AccountId accountId) async {
    final r = await (select(
      newMessageNotification,
    )..where((t) => t.accountId.equals(accountId.aid))).getSingleOrNull();
    return r?.notificationShown ?? false;
  }
}
