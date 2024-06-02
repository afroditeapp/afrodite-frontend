


import 'package:database/src/profile_entry.dart';
import 'package:openapi/api.dart' show AccountId;
import 'account_database.dart';

import 'package:drift/drift.dart';
import '../utils.dart';

part 'new_message_notification_table.g.dart';

class NewMessageNotification extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();
}

@DriftAccessor(tables: [NewMessageNotification])
class DaoNewMessageNotification extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoNewMessageNotificationMixin {
  DaoNewMessageNotification(AccountBackgroundDatabase db) : super(db);

  /// The IDs begin from 0.
  Future<NewMessageNotificationId> getOrCreateNewMessageNotificationId(AccountId id) async {
    return await transaction(() async {
      final r = await (select(newMessageNotification)
        ..where((t) => t.uuidAccountId.equals(id.accountId))
      )
        .getSingleOrNull();

      if (r == null) {
        final r = await into(newMessageNotification).insertReturning(
          NewMessageNotificationCompanion.insert(
            uuidAccountId: id,
          ),
        );
        return NewMessageNotificationId(r.id);
      } else {
        return NewMessageNotificationId(r.id);
      }
    });
  }

  Future<AccountId?> getAccountId(NewMessageNotificationId notificationId) async {
    final r = await (select(newMessageNotification)
        ..where((t) => t.id.equals(notificationId.id))
      )
        .getSingleOrNull();
    return r?.uuidAccountId;
  }
}
