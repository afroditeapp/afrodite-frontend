
import 'package:openapi/api.dart' as api;

import '../account_database.dart';

import 'package:drift/drift.dart';

part 'dao_local_notification_settings.g.dart';

@DriftAccessor(tables: [AccountBackground])
class DaoLocalNotificationSettings extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoLocalNotificationSettingsMixin, AccountBackgroundTools {
  DaoLocalNotificationSettings(super.db);

  Future<void> updateAccountNotificationSettings(api.AccountAppNotificationSettings value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingNewsItemAvailable: Value(value.news),
      ),
    );
  }

  Future<void> updateProfileNotificationSettings(api.ProfileAppNotificationSettings value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingProfileTextModerationCompleted: Value(value.profileTextModeration),
      ),
    );
  }

  Future<void> updateMediaNotificationSettings(api.MediaAppNotificationSettings value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingMediaContentModerationCompleted: Value(value.mediaContentModeration),
      ),
    );
  }

  Future<void> updateChatNotificationSettings(api.ChatAppNotificationSettings value) async {
    await into(accountBackground).insertOnConflictUpdate(
      AccountBackgroundCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        localNotificationSettingLikes: Value(value.likes),
        localNotificationSettingMessages: Value(value.messages),
      ),
    );
  }

  Stream<bool?> watchMessages() =>
    watchColumn((r) => r.localNotificationSettingMessages);
  Stream<bool?> watchLikes() =>
    watchColumn((r) => r.localNotificationSettingLikes);
  Stream<bool?> watchMediaContentModerationCompleted() =>
    watchColumn((r) => r.localNotificationSettingMediaContentModerationCompleted);
  Stream<bool?> watchProfileTextModerationCompleted() =>
    watchColumn((r) => r.localNotificationSettingProfileTextModerationCompleted);
  Stream<bool?> watchNewsItemAvailable() =>
    watchColumn((r) => r.localNotificationSettingNewsItemAvailable);
}
