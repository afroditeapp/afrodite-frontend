
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
}

@DriftAccessor(tables: [AppNotificationSettingsTable])
class DaoAppNotificationSettingsTable extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoAppNotificationSettingsTableMixin {
  DaoAppNotificationSettingsTable(AccountBackgroundDatabase db) : super(db);

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
  Stream<bool?> watchProfileTextModerationCompleted() =>
    _watchColumn((r) => r.profileTextModerationCompleted);
  Stream<bool?> watchNews() =>
    _watchColumn((r) => r.news);

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
