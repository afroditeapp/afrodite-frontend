
import 'package:openapi/api.dart' as api;

import 'package:database/src/background/account_database.dart';

import 'package:drift/drift.dart';

part 'app_notification_settings_table.g.dart';

class AppNotificationSettingsTable extends Table {
  // Only one row exists with ID ACCOUNT_DB_DATA_ID.
  IntColumn get id => integer().autoIncrement()();

  BoolColumn get messages => boolean().nullable()();
  BoolColumn get likes => boolean().nullable()();
  BoolColumn get mediaContentModerationCompleted => boolean().nullable()();
  BoolColumn get profileTextModerationCompleted => boolean().nullable()();
  BoolColumn get news => boolean().nullable()();

  BoolColumn get automaticProfileSearch => boolean().nullable()();
  BoolColumn get automaticProfileSearchDistance => boolean().nullable()();
  BoolColumn get automaticProfileSearchFilters => boolean().nullable()();
  BoolColumn get automaticProfileSearchNewProfiles => boolean().nullable()();
  IntColumn get automaticProfileSearchWeekdays => integer().nullable()();
}

@DriftAccessor(tables: [AppNotificationSettingsTable])
class DaoAppNotificationSettingsTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoAppNotificationSettingsTableMixin {
  DaoAppNotificationSettingsTable(super.db);

  Future<void> updateAccountNotificationSettings(api.AccountAppNotificationSettings value) async {
    await into(appNotificationSettingsTable).insertOnConflictUpdate(
      AppNotificationSettingsTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        news: Value(value.news),
      ),
    );
  }

  Future<void> updateProfileNotificationSettings(api.ProfileAppNotificationSettings value) async {
    await into(appNotificationSettingsTable).insertOnConflictUpdate(
      AppNotificationSettingsTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        profileTextModerationCompleted: Value(value.profileTextModeration),
        automaticProfileSearch: Value(value.automaticProfileSearch),
        automaticProfileSearchDistance: Value(value.automaticProfileSearchDistance),
        automaticProfileSearchFilters: Value(value.automaticProfileSearchFilters),
        automaticProfileSearchNewProfiles: Value(value.automaticProfileSearchNewProfiles),
        automaticProfileSearchWeekdays: Value(value.automaticProfileSearchWeekdays),
      ),
    );
  }

  Future<void> updateMediaNotificationSettings(api.MediaAppNotificationSettings value) async {
    await into(appNotificationSettingsTable).insertOnConflictUpdate(
      AppNotificationSettingsTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        mediaContentModerationCompleted: Value(value.mediaContentModeration),
      ),
    );
  }

  Future<void> updateChatNotificationSettings(api.ChatAppNotificationSettings value) async {
    await into(appNotificationSettingsTable).insertOnConflictUpdate(
      AppNotificationSettingsTableCompanion.insert(
        id: ACCOUNT_DB_DATA_ID,
        likes: Value(value.likes),
        messages: Value(value.messages),
      ),
    );
  }

  Stream<bool?> watchMessages() =>
    _watchColumn((r) => r.messages);
  Stream<bool?> watchLikes() =>
    _watchColumn((r) => r.likes);
  Stream<bool?> watchMediaContentModerationCompleted() =>
    _watchColumn((r) => r.mediaContentModerationCompleted);
  Stream<bool?> watchNews() =>
    _watchColumn((r) => r.news);

  Stream<api.ProfileAppNotificationSettings?> watchProfileAppNotificationSettings() =>
    _watchColumn((r) {
      final profileTextModerationCompleted = r.profileTextModerationCompleted;
      final automaticProfileSearch = r.automaticProfileSearch;
      final automaticProfileSearchDistance = r.automaticProfileSearchDistance;
      final automaticProfileSearchFilters = r.automaticProfileSearchFilters;
      final automaticProfileSearchNewProfiles = r.automaticProfileSearchNewProfiles;
      final automaticProfileSearchWeekdays = r.automaticProfileSearchWeekdays;

      if (
        profileTextModerationCompleted == null ||
        automaticProfileSearch == null ||
        automaticProfileSearchDistance == null ||
        automaticProfileSearchFilters == null ||
        automaticProfileSearchNewProfiles == null ||
        automaticProfileSearchWeekdays == null
      ) {
        return null;
      }

      return api.ProfileAppNotificationSettings(
        profileTextModeration: profileTextModerationCompleted,
        automaticProfileSearch: automaticProfileSearch,
        automaticProfileSearchDistance: automaticProfileSearchDistance,
        automaticProfileSearchFilters: automaticProfileSearchFilters,
        automaticProfileSearchNewProfiles: automaticProfileSearchNewProfiles,
        automaticProfileSearchWeekdays: automaticProfileSearchWeekdays,
      );
    });

  SimpleSelectStatement<$AppNotificationSettingsTableTable, AppNotificationSettingsTableData> _selectFromDataId() {
    return select(appNotificationSettingsTable)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value));
  }

  Stream<T?> _watchColumn<T extends Object>(T? Function(AppNotificationSettingsTableData) extractColumn) {
    return _selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
