
import 'package:database_account_background/database_account_background.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'app_notification_settings.g.dart';

@DriftAccessor(
  tables: [
    schema.AppNotificationSettings,
  ]
)
class DaoWriteAppNotificationSettings extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoWriteAppNotificationSettingsMixin {
  DaoWriteAppNotificationSettings(super.db);

  Future<void> updateAccountNotificationSettings(api.AccountAppNotificationSettings value) async {
    await into(appNotificationSettings).insertOnConflictUpdate(
      AppNotificationSettingsCompanion.insert(
        id: SingleRowTable.ID,
        news: Value(value.news),
      ),
    );
  }

  Future<void> updateProfileNotificationSettings(api.ProfileAppNotificationSettings value) async {
    await into(appNotificationSettings).insertOnConflictUpdate(
      AppNotificationSettingsCompanion.insert(
        id: SingleRowTable.ID,
        profileTextModerationCompleted: Value(value.profileTextModeration),
        automaticProfileSearch: Value(value.automaticProfileSearch),
        automaticProfileSearchDistanceFilters: Value(value.automaticProfileSearchDistanceFilters),
        automaticProfileSearchAttributeFilters: Value(value.automaticProfileSearchAttributeFilters),
        automaticProfileSearchNewProfiles: Value(value.automaticProfileSearchNewProfiles),
        automaticProfileSearchWeekdays: Value(value.automaticProfileSearchWeekdays),
      ),
    );
  }

  Future<void> updateMediaNotificationSettings(api.MediaAppNotificationSettings value) async {
    await into(appNotificationSettings).insertOnConflictUpdate(
      AppNotificationSettingsCompanion.insert(
        id: SingleRowTable.ID,
        mediaContentModerationCompleted: Value(value.mediaContentModeration),
      ),
    );
  }

  Future<void> updateChatNotificationSettings(api.ChatAppNotificationSettings value) async {
    await into(appNotificationSettings).insertOnConflictUpdate(
      AppNotificationSettingsCompanion.insert(
        id: SingleRowTable.ID,
        likes: Value(value.likes),
        messages: Value(value.messages),
      ),
    );
  }
}
