
import 'package:database/database.dart';
import 'package:database/src/background/account_database.dart';
import 'package:openapi/api.dart' show AccountId;

import 'package:drift/drift.dart';
import '../utils.dart';

part 'new_message_notification_table.g.dart';

class NewMessageNotification extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuidAccountId => text().map(const AccountIdConverter()).unique()();
  BoolColumn get notificationShown => boolean().withDefault(const Constant(false))();
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

  Future<bool> getNotificationShown(AccountId accountId) async {
    final r = await (select(newMessageNotification)
        ..where((t) => t.uuidAccountId.equals(accountId.accountId))
      )
        .getSingleOrNull();
    return r?.notificationShown ?? false;
  }

  Future<void> setNotificationShown(AccountId accountId, bool value) async {
    await into(newMessageNotification).insert(
      NewMessageNotificationCompanion.insert(
        uuidAccountId: accountId,
        notificationShown: Value(value),
      ),
      onConflict: DoUpdate(
        (old) => NewMessageNotificationCompanion(
          notificationShown: Value(value),
        ),
        target: [newMessageNotification.uuidAccountId]
      ),
    );
  }
}
