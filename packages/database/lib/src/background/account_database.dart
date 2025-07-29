

import 'package:async/async.dart' show StreamExtensions;
import 'package:database/src/background/admin_notification_table.dart';
import 'package:database/src/background/app_notification_settings_table.dart';
import 'package:database/src/background/automatic_profile_search_completed_notification_table.dart';
import 'package:database/src/background/conversations_table.dart';
import 'package:database/src/background/media_content_moderation_completed_notification_table.dart';
import 'package:database/src/background/new_received_likes_available_table.dart';
import 'package:database/src/background/new_message_notification_table.dart';
import 'package:database/src/background/news_table.dart';
import 'package:database/src/background/profile_table.dart';
import 'package:database/src/background/profile_text_moderation_completed_notification_table.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:database_utils/database_utils.dart';

part 'account_database.g.dart';

const ACCOUNT_DB_DATA_ID = Value(0);
const PROFILE_FILTER_FAVORITES_DEFAULT = false;

/// Account related data which can be accessed when app is in background
class AccountBackground extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuidAccountId => text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
}

@DriftDatabase(
  tables: [
    AccountBackground,
    ProfilesBackground,
    ConversationsBackground,
    NewMessageNotificationTable,
    NewReceivedLikesAvailable,
    News,
    MediaContentModerationCompletedNotificationTable,
    ProfileTextModerationCompletedNotificationTable,
    AutomaticProfileSearchCompletedNotificationTable,
    AdminNotificationTable,
    AppNotificationSettingsTable,
  ],
  daos: [
    // Related to ProfilesBackground table
    DaoProfilesBackground,
    // Related to ConversationsBackground table
    DaoConversationsBackground,
    // Related to NewMessageNotificationTable table
    DaoNewMessageNotificationTable,
    // Related to NewReceivedLikesAvailable table
    DaoNewReceivedLikesAvailable,
    // Related to News table
    DaoNews,
    // Related to MediaContentModerationCompletedNotificationTable
    DaoMediaContentModerationCompletedNotificationTable,
    // Related to ProfileTextModerationCompletedNotificationTable
    DaoProfileTextModerationCompletedNotificationTable,
    // Related to AutomaticProfileSearchCompletedNotificationTable
    DaoAutomaticProfileSearchCompletedNotificationTable,
    // Related to AdminNotificationTable
    DaoAdminNotificationTable,
    // Related to AppNotificationSettingsTable
    DaoAppNotificationSettingsTable,
  ],
)
class AccountBackgroundDatabase extends _$AccountBackgroundDatabase {
  AccountBackgroundDatabase(QueryExcecutorProvider dbProvider) :
    super(dbProvider.getQueryExcecutor());

  @override
  int get schemaVersion => 1;

  Future<void> setAccountIdIfNull(AccountId id) async {
    await transaction(() async {
      final currentAccountId = await watchAccountId().firstOrNull;
      if (currentAccountId == null) {
        await into(accountBackground).insertOnConflictUpdate(
          AccountBackgroundCompanion.insert(
            id: ACCOUNT_DB_DATA_ID,
            uuidAccountId: Value(id),
          ),
        );
      }
    });
  }

  Stream<AccountId?> watchAccountId() =>
    watchColumn((r) => r.uuidAccountId);

  Future<void> resetSyncVersions() async {
    await transaction(() async {
      await daoNewReceivedLikesAvailable.resetSyncVersion();
      await daoNews.resetSyncVersion();
    });
  }

  SimpleSelectStatement<$AccountBackgroundTable, AccountBackgroundData> _selectFromDataId() {
    return select(accountBackground)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value));
  }

  Stream<T?> watchColumn<T extends Object>(T? Function(AccountBackgroundData) extractColumn) {
    return _selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }
}

mixin AccountBackgroundTools on DatabaseAccessor<AccountBackgroundDatabase> {
  $AccountBackgroundTable get _accountBackground => attachedDatabase.accountBackground;

  SimpleSelectStatement<$AccountBackgroundTable, AccountBackgroundData> selectFromDataId() {
    return select(_accountBackground)
      ..where((t) => t.id.equals(ACCOUNT_DB_DATA_ID.value));
  }

  Stream<T?> watchColumn<T extends Object>(T? Function(AccountBackgroundData) extractColumn) {
    return selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
