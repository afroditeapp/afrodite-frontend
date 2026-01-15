import 'package:database_account/src/database.dart';
import 'package:database_model/database_model.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(
  tables: [
    schema.ProfileFilterFavorites,
    schema.ShowAdvancedProfileFilters,
    schema.InitialSync,
    schema.InitialSetupSkipped,
    schema.GridSettings,
    schema.ChatBackupReminder,
    schema.AdminNotification,
    schema.NotificationStatus,
    schema.News,
    schema.PushNotification,
  ],
)
class DaoReadApp extends DatabaseAccessor<AccountDatabase> with _$DaoReadAppMixin {
  DaoReadApp(super.db);

  Future<api.AdminNotification?> getAdminNotification() async {
    return await (select(adminNotification)..where((t) => t.id.equals(SingleRowTable.ID.value)))
        .map((r) => r.jsonViewedNotification?.value)
        .getSingleOrNull();
  }

  Stream<api.UnreadNewsCount?> watchUnreadNewsCount() {
    return (select(news)..where((t) => t.id.equals(SingleRowTable.ID.value))).map((r) {
      return r.newsCount;
    }).watchSingleOrNull();
  }

  Stream<int?> watchSyncVersionNews() {
    return (select(news)..where((t) => t.id.equals(SingleRowTable.ID.value))).map((r) {
      return r.syncVersionNews;
    }).watchSingleOrNull();
  }

  Stream<api.PushNotificationDeviceToken?> watchPushNotificationDeviceToken() =>
      _watchPushNotificationColumn((r) => r.pushNotificationDeviceToken);

  Stream<api.VapidPublicKey?> watchVapidPublicKey() =>
      _watchPushNotificationColumn((r) => r.vapidPublicKey);

  Stream<int?> watchPushNotificationInfoSyncVersion() =>
      _watchPushNotificationColumn((r) => r.syncVersionPushNotificationInfo);

  Stream<T?> _watchPushNotificationColumn<T extends Object>(
    T? Function(PushNotificationData) extractColumn,
  ) {
    return (select(
      pushNotification,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<bool?> watchLoginSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneLoginRepository);
  Stream<bool?> watchAccountSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneAccountRepository);
  Stream<bool?> watchMediaSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneMediaRepository);
  Stream<bool?> watchProfileSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneProfileRepository);
  Stream<bool?> watchChatSyncDone() =>
      _watchColumnInitialSync((r) => r.initialSyncDoneChatRepository);

  Stream<T?> _watchColumnInitialSync<T extends Object>(T? Function(InitialSyncData) extractColumn) {
    return (select(
      initialSync,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<bool?> watchInitialSetupSkipped() =>
      _watchColumnInitialSetupSkipped((r) => r.initialSetupSkipped);

  Stream<T?> _watchColumnInitialSetupSkipped<T extends Object>(
    T? Function(InitialSetupSkippedData) extractColumn,
  ) {
    return (select(
      initialSetupSkipped,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<bool?> watchProfileFilterFavorites() =>
      _watchColumnProfileFilterFavorite((r) => r.profileFilterFavorites);

  Stream<T?> _watchColumnProfileFilterFavorite<T extends Object>(
    T? Function(ProfileFilterFavorite) extractColumn,
  ) {
    return (select(
      profileFilterFavorites,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<bool?> watchShowAdvancedFilters() {
    return (select(
      showAdvancedProfileFilters,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      return r?.advancedFilters;
    });
  }

  Stream<GridSettings> watchGridSettings() {
    return (select(
      gridSettings,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      return GridSettings(itemSizeMode: r?.gridItemSizeMode, paddingMode: r?.gridPaddingMode);
    });
  }

  Stream<ChatBackupReminder?> watchChatBackupReminder() {
    return (select(
      chatBackupReminder,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).watchSingleOrNull().map((r) {
      return ChatBackupReminder(
        reminderIntervalDays: r?.reminderIntervalDays,
        lastBackupTime: r?.lastBackupTime,
        lastDialogOpenedTime: r?.lastDialogOpenedTime,
      );
    });
  }
}
