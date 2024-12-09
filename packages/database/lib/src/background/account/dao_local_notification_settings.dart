
import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_local_notification_settings.g.dart';

@DriftAccessor(tables: [AccountBackground])
class DaoLocalNotificationSettings extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoLocalNotificationSettingsMixin, AccountBackgroundTools {
  DaoLocalNotificationSettings(super.db);

  Future<void> updateMessages(bool value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingMessages: Value(value),
      ),
    );
  }

  Future<void> updateLikes(bool value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingLikes: Value(value),
      ),
    );
  }

  Future<void> updateInitialContentModeration(bool value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingInitialContentModeration: Value(value),
      ),
    );
  }

  Future<void> updateNews(bool value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingNewsItemAvailable: Value(value),
      ),
    );
  }

  Stream<bool?> watchMessages() =>
    watchColumn((r) => r.localNotificationSettingMessages);
  Stream<bool?> watchLikes() =>
    watchColumn((r) => r.localNotificationSettingLikes);
  Stream<bool?> watchInitialContentModeration() =>
    watchColumn((r) => r.localNotificationSettingInitialContentModeration);
  Stream<bool?> watchNewsItemAvailable() =>
    watchColumn((r) => r.localNotificationSettingNewsItemAvailable);
}
