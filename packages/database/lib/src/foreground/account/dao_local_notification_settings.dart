
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_local_notification_settings.g.dart';

@DriftAccessor(tables: [Account])
class DaoLocalNotificationSettings extends DatabaseAccessor<AccountDatabase> with _$DaoLocalNotificationSettingsMixin, AccountTools {
  DaoLocalNotificationSettings(super.db);

  Future<void> updateMessages(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingMessages: Value(value),
      ),
    );
  }

  Future<void> updateLikes(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingLikes: Value(value),
      ),
    );
  }

  Future<void> updateModerationRequestStatus(bool value) async {
    await into(account).insertOnConflictUpdate(
      AccountCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingModerationRequestStatus: Value(value),
      ),
    );
  }

  Stream<bool?> watchMessages() =>
    watchColumn((r) => r.localNotificationSettingMessages);
  Stream<bool?> watchLikes() =>
    watchColumn((r) => r.localNotificationSettingLikes);
  Stream<bool?> watchModerationRequestStatus() =>
    watchColumn((r) => r.localNotificationSettingModerationRequestStatus);
}
