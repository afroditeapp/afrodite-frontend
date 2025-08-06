

import 'package:database_account_background/src/read/app_notification_settings.dart';
import 'package:database_account_background/src/read/login_session.dart';
import 'package:database_account_background/src/read/new_received_likes_count.dart';
import 'package:database_account_background/src/read/news.dart';
import 'package:database_account_background/src/read/notification.dart';
import 'package:database_account_background/src/read/profile.dart';
import 'package:database_account_background/src/read/unread_messages_count.dart';
import 'package:database_account_background/src/write/login_session.dart';
import 'package:database_account_background/src/write/app_notification_settings.dart';
import 'package:database_account_background/src/write/new_received_likes_count.dart';
import 'package:database_account_background/src/write/news.dart';
import 'package:database_account_background/src/write/notification.dart';
import 'package:database_account_background/src/write/profile.dart';
import 'package:database_account_background/src/write/unread_messages_count.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'schema.dart' as schema;

part 'database.g.dart';

/// Account specific data which can be accessed when app is in background
@DriftDatabase(
  tables: [
    schema.AccountId,
    schema.AdminNotification,
    schema.AppNotificationSettings,
    schema.NotificationStatus,
    schema.UnreadMessagesCount,
    schema.NewMessageNotification,
    schema.NewReceivedLikesCount,
    schema.News,
    schema.Profile,
    schema.AutomaticProfileSearchBadgeState,
  ],
  daos: [
    // Read
    DaoReadAppNotificationSettings,
    DaoReadLoginSession,
    DaoReadNotification,
    DaoReadNews,
    DaoReadNewReceivedLikesCount,
    DaoReadUnreadMessagesCount,
    DaoReadProfile,
    // Write
    DaoWriteAppNotificationSettings,
    DaoWriteLoginSession,
    DaoWriteNotification,
    DaoWriteNews,
    DaoWriteNewReceivedLikesCount,
    DaoWriteUnreadMessagesCount,
    DaoWriteProfile,
  ]
)
class AccountBackgroundDatabase extends _$AccountBackgroundDatabase {
  AccountBackgroundDatabase(QueryExcecutorProvider dbProvider) :
    super(dbProvider.getQueryExcecutor());

  AccountBackgroundDatabaseRead get read => AccountBackgroundDatabaseRead(this);
  AccountBackgroundDatabaseWrite get write => AccountBackgroundDatabaseWrite(this);

  @override
  int get schemaVersion => 1;

  Future<void> resetSyncVersions() async {
    await transaction(() async {
      await daoWriteNewReceivedLikesCount.resetReceivedLikesSyncVersion();
      await daoWriteNews.resetSyncVersion();
    });
  }
}

class AccountBackgroundDatabaseRead {
  final AccountBackgroundDatabase db;
  AccountBackgroundDatabaseRead(this.db);
  DaoReadAppNotificationSettings get appNotificationSettings => db.daoReadAppNotificationSettings;
  DaoReadLoginSession get loginSession => db.daoReadLoginSession;
  DaoReadNotification get notification => db.daoReadNotification;
  DaoReadNews get news => db.daoReadNews;
  DaoReadNewReceivedLikesCount get newReceivedLikesCount => db.daoReadNewReceivedLikesCount;
  DaoReadUnreadMessagesCount get unreadMessagesCount => db.daoReadUnreadMessagesCount;
  DaoReadProfile get profile => db.daoReadProfile;
}

class AccountBackgroundDatabaseWrite {
  final AccountBackgroundDatabase db;
  AccountBackgroundDatabaseWrite(this.db);
  DaoWriteAppNotificationSettings get appNotificationSettings => db.daoWriteAppNotificationSettings;
  DaoWriteLoginSession get loginSession => db.daoWriteLoginSession;
  DaoWriteNotification get notification => db.daoWriteNotification;
  DaoWriteNews get news => db.daoWriteNews;
  DaoWriteNewReceivedLikesCount get newReceivedLikesCount => db.daoWriteNewReceivedLikesCount;
  DaoWriteUnreadMessagesCount get unreadMessagesCount => db.daoWriteUnreadMessagesCount;
  DaoWriteProfile get profile => db.daoWriteProfile;

  Future<void> resetSyncVersions() => db.resetSyncVersions();
}
