import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:database_model/database_model.dart';
import 'package:utils/utils.dart';
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
    schema.ProfileDataCleanupState,
    schema.News,
    schema.PushNotification,
    schema.AppUpdateAvailableDialog,
    schema.ClientVersionInfo,
    schema.Profile,
    schema.ProfileExtra,
    schema.ProfileContent,
  ],
)
class DaoWriteApp extends DatabaseAccessor<AccountDatabase> with _$DaoWriteAppMixin {
  DaoWriteApp(super.db);

  static const _profileCleanupRunInterval = Duration(days: 1);
  static const _unusedProfileThreshold = Duration(days: 90);

  Future<int> cleanupUnusedProfileDataIfNeeded() async {
    final now = UtcDateTime.now();
    return await transaction(() async {
      final state = await (select(
        profileDataCleanupState,
      )..where((t) => t.id.equals(SingleRowTable.ID.value))).getSingleOrNull();

      final lastCleanupTime = state?.lastCleanupTime;
      if (lastCleanupTime != null && now.difference(lastCleanupTime) < _profileCleanupRunInterval) {
        return 0;
      }

      final staleBefore = now.substract(_unusedProfileThreshold);
      final staleBeforeUnixEpochMilliseconds = staleBefore.toUnixEpochMilliseconds();
      final staleProfileAccountIds =
          await (select(profileExtra)..where(
                (t) =>
                    (t.profileDataRefreshTime.isNotNull() &
                        t.profileDataRefreshTime.isSmallerOrEqualValue(
                          staleBeforeUnixEpochMilliseconds,
                        )) |
                    (t.privateProfileErrorTime.isNotNull() &
                        t.privateProfileErrorTime.isSmallerOrEqualValue(
                          staleBeforeUnixEpochMilliseconds,
                        )),
              ))
              .map((t) => t.accountId.aid)
              .get();

      if (staleProfileAccountIds.isNotEmpty) {
        await (delete(profile)..where((t) => t.accountId.isIn(staleProfileAccountIds))).go();
        await (delete(profileContent)..where((t) => t.accountId.isIn(staleProfileAccountIds))).go();
        await (delete(profileExtra)..where((t) => t.accountId.isIn(staleProfileAccountIds))).go();
      }

      await into(profileDataCleanupState).insertOnConflictUpdate(
        ProfileDataCleanupStateCompanion.insert(id: SingleRowTable.ID, lastCleanupTime: Value(now)),
      );

      return staleProfileAccountIds.length;
    });
  }

  Future<void> updateClientVersionInfo(api.ClientVersion value) async {
    final existingVersion = await (select(
      clientVersionInfo,
    )..where((table) => table.id.equals(SingleRowTable.ID.value))).getSingleOrNull();

    if (existingVersion != null &&
        existingVersion.majorVersion == value.major &&
        existingVersion.minorVersion == value.minor &&
        existingVersion.patchVersion == value.patch_) {
      return;
    }

    await into(clientVersionInfo).insertOnConflictUpdate(
      ClientVersionInfoCompanion.insert(
        id: SingleRowTable.ID,
        majorVersion: value.major,
        minorVersion: value.minor,
        patchVersion: value.patch_,
      ),
    );
  }

  Future<void> setUnreadNewsCount({
    required api.NewsSyncVersion version,
    required api.UnreadNewsCount unreadNewsCount,
  }) async {
    await transaction(() async {
      await into(news).insertOnConflictUpdate(
        NewsCompanion.insert(
          id: SingleRowTable.ID,
          newsCount: Value(unreadNewsCount),
          syncVersionNews: Value(version.version),
        ),
      );
    });
  }

  Future<void> resetNewsSyncVersion() async {
    await into(news).insertOnConflictUpdate(
      NewsCompanion.insert(id: SingleRowTable.ID, syncVersionNews: Value(null)),
    );
  }

  Future<void> updateDeviceToken(api.PushNotificationDeviceToken? token) async {
    await into(pushNotification).insertOnConflictUpdate(
      PushNotificationCompanion.insert(
        id: SingleRowTable.ID,
        pushNotificationDeviceToken: Value(token),
      ),
    );
  }

  Future<void> updatePushNotificationInfo(api.GetPushNotificationInfo info) async {
    await into(pushNotification).insertOnConflictUpdate(
      PushNotificationCompanion.insert(
        id: SingleRowTable.ID,
        pushNotificationDeviceToken: Value(info.deviceToken),
        vapidPublicKey: Value(info.vapidPublicKey),
        syncVersionPushNotificationInfo: Value(info.syncVersion.version),
      ),
    );
  }

  Future<void> resetPushNotificationSyncVersion() async {
    await into(pushNotification).insertOnConflictUpdate(
      PushNotificationCompanion.insert(
        id: SingleRowTable.ID,
        syncVersionPushNotificationInfo: Value(null),
      ),
    );
  }

  Future<void> updateAppUpdateAvailableLatestEventTime(UtcDateTime time) async {
    await into(appUpdateAvailableDialog).insertOnConflictUpdate(
      AppUpdateAvailableDialogCompanion.insert(id: SingleRowTable.ID, latestEventTime: Value(time)),
    );
  }

  Future<void> removeAppUpdateDialogEventTimeAndBlockDialogsUntil(
    UtcDateTime? blockDialogsUntil,
  ) async {
    await into(appUpdateAvailableDialog).insertOnConflictUpdate(
      AppUpdateAvailableDialogCompanion.insert(
        id: SingleRowTable.ID,
        latestEventTime: Value(null),
        blockDialogsUntil: Value(blockDialogsUntil),
      ),
    );
  }

  Future<void> updateAppUpdateAvailableDialogBlockUntil(UtcDateTime? time) async {
    await into(appUpdateAvailableDialog).insertOnConflictUpdate(
      AppUpdateAvailableDialogCompanion.insert(
        id: SingleRowTable.ID,
        blockDialogsUntil: Value(time),
      ),
    );
  }

  Future<void> updateLoginSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneLoginRepository: Value(value),
      ),
    );
  }

  Future<void> updateAccountSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneAccountRepository: Value(value),
      ),
    );
  }

  Future<void> updateMediaSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneMediaRepository: Value(value),
      ),
    );
  }

  Future<void> updateProfileSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneProfileRepository: Value(value),
      ),
    );
  }

  Future<void> updateChatSyncDone(bool value) async {
    await into(initialSync).insertOnConflictUpdate(
      InitialSyncCompanion.insert(
        id: SingleRowTable.ID,
        initialSyncDoneChatRepository: Value(value),
      ),
    );
  }

  Future<void> updateInitialSetupSkipped(bool skipped) async {
    await into(initialSetupSkipped).insertOnConflictUpdate(
      InitialSetupSkippedCompanion.insert(
        id: SingleRowTable.ID,
        initialSetupSkipped: Value(skipped),
      ),
    );
  }

  Future<void> updateProfileFilterFavorites(bool value) async {
    await into(profileFilterFavorites).insertOnConflictUpdate(
      ProfileFilterFavoritesCompanion.insert(
        id: SingleRowTable.ID,
        profileFilterFavorites: Value(value),
      ),
    );
  }

  Future<void> updateShowAdvancedFilters(bool value) async {
    await into(showAdvancedProfileFilters).insertOnConflictUpdate(
      ShowAdvancedProfileFiltersCompanion.insert(
        id: SingleRowTable.ID,
        advancedFilters: Value(value),
      ),
    );
  }

  Future<void> updateGridSettings(GridSettings value) async {
    await into(gridSettings).insertOnConflictUpdate(
      GridSettingsCompanion.insert(
        id: SingleRowTable.ID,
        gridItemSizeMode: Value(value.itemSizeMode),
        gridPaddingMode: Value(value.paddingMode),
      ),
    );
  }

  Future<void> updateChatBackupReminderInterval(int? days) async {
    await into(chatBackupReminder).insertOnConflictUpdate(
      ChatBackupReminderCompanion.insert(id: SingleRowTable.ID, reminderIntervalDays: Value(days)),
    );
  }

  Future<void> updateChatBackupLastBackupTime(UtcDateTime time) async {
    await into(chatBackupReminder).insertOnConflictUpdate(
      ChatBackupReminderCompanion.insert(id: SingleRowTable.ID, lastBackupTime: Value(time)),
    );
  }

  Future<void> updateChatBackupLastDialogOpenedTime(UtcDateTime time) async {
    await into(chatBackupReminder).insertOnConflictUpdate(
      ChatBackupReminderCompanion.insert(id: SingleRowTable.ID, lastDialogOpenedTime: Value(time)),
    );
  }
}
