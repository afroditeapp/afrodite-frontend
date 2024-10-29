

import 'package:async/async.dart';
import 'package:database/src/background/account/dao_local_notification_settings.dart';
import 'package:database/src/background/account/dao_user_interface_settings.dart';
import 'package:database/src/background/conversations_table.dart';
import 'package:database/src/background/new_received_likes_available_table.dart';
import 'package:database/src/background/new_message_notification_table.dart';
import 'package:database/src/background/profile_table.dart';
import 'package:database/src/message_entry.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import '../utils.dart';

part 'account_database.g.dart';

const ACCOUNT_DB_DATA_ID = Value(0);
const PROFILE_FILTER_FAVORITES_DEFAULT = false;

/// Account related data which can be accessed when app is in background
class AccountBackground extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuidAccountId => text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();

  // DaoNotificationSettings

  BoolColumn get localNotificationSettingMessages => boolean().nullable()();
  BoolColumn get localNotificationSettingLikes => boolean().nullable()();
  BoolColumn get localNotificationSettingModerationRequestStatus => boolean().nullable()();

  // DaoUserInterfaceSettings

  BoolColumn get userInterfaceSettingShowNonAcceptedProfileNames => boolean().nullable()();
}

@DriftDatabase(
  tables: [
    AccountBackground,
    ProfilesBackground,
    ConversationsBackground,
    NewMessageNotification,
    NewReceivedLikesAvailable,
  ],
  daos: [
    // Related to AccountBackground table
    DaoLocalNotificationSettings,
    DaoUserInterfaceSettings,
    // Related to ProfilesBackground table
    DaoProfilesBackground,
    // Related to ConversationsBackground table
    DaoConversationsBackground,
    // Related to NewMessageNotification table
    DaoNewMessageNotification,
    // Related to NewReceivedLikesAvailable table
    DaoNewReceivedLikesAvailable,
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
