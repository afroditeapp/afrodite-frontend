import 'package:async/async.dart';
import 'package:database_account/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:database_model/database_model.dart';
import 'package:database_converter/database_converter.dart';
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
    schema.InitialSetupProgress,
    schema.GridSettings,
    schema.ChatBackupReminder,
    schema.AdminNotification,
    schema.NotificationStatus,
    schema.News,
    schema.PushNotification,
    schema.EditProfileImagePickerIndex,
    schema.EditProfileProgress,
  ],
)
class DaoWriteApp extends DatabaseAccessor<AccountDatabase> with _$DaoWriteAppMixin {
  DaoWriteApp(super.db);

  Future<void> _updateAdminNotificationInternal(api.AdminNotification? notification) async {
    await into(adminNotification).insertOnConflictUpdate(
      AdminNotificationCompanion.insert(
        id: SingleRowTable.ID,
        jsonViewedNotification: Value(notification?.toJsonObject()),
      ),
    );
  }

  Future<void> updateAdminNotification(api.AdminNotification notification) =>
      _updateAdminNotificationInternal(notification);

  Future<void> removeAdminNotification() => _updateAdminNotificationInternal(null);

  late final UpdateNotificationStatus profilesFound = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn(
      (r) => r.jsonAutomaticProfileSearchFoundProfiles,
    ).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonAutomaticProfileSearchFoundProfiles: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus mediaContentAccepted = UpdateNotificationStatus(
    currentValueGetter: () async =>
        await _watchNotificationStatusColumn((r) => r.jsonMediaContentAccepted).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonMediaContentAccepted: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus mediaContentRejected = UpdateNotificationStatus(
    currentValueGetter: () async =>
        await _watchNotificationStatusColumn((r) => r.jsonMediaContentRejected).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonMediaContentRejected: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus mediaContentDeleted = UpdateNotificationStatus(
    currentValueGetter: () async =>
        await _watchNotificationStatusColumn((r) => r.jsonMediaContentDeleted).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonMediaContentDeleted: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus profileNameAccepted = UpdateNotificationStatus(
    currentValueGetter: () async =>
        await _watchNotificationStatusColumn((r) => r.jsonProfileNameAccepted).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileNameAccepted: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus profileNameRejected = UpdateNotificationStatus(
    currentValueGetter: () async =>
        await _watchNotificationStatusColumn((r) => r.jsonProfileNameRejected).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileNameRejected: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus profileTextAccepted = UpdateNotificationStatus(
    currentValueGetter: () async =>
        await _watchNotificationStatusColumn((r) => r.jsonProfileTextAccepted).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileTextAccepted: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus profileTextRejected = UpdateNotificationStatus(
    currentValueGetter: () async =>
        await _watchNotificationStatusColumn((r) => r.jsonProfileTextRejected).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileTextRejected: Value(status.toJsonObject()),
      ),
    ),
  );

  Stream<T?> _watchNotificationStatusColumn<T extends Object>(
    T? Function(NotificationStatusData) extractColumn,
  ) {
    return (select(
      notificationStatus,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
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

  // Initial setup progress updates
  Future<void> updateInitialSetupEmail(String? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, email: Value(value)),
    );
  }

  Future<void> updateInitialSetupIsAdult(bool? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, isAdult: Value(value)),
    );
  }

  Future<void> updateInitialSetupProfileName(String? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, profileName: Value(value)),
    );
  }

  Future<void> updateInitialSetupProfileAge(int? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, profileAge: Value(value)),
    );
  }

  Future<void> updateInitialSetupSecuritySelfie({String? contentId, bool? faceDetected}) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        securitySelfieContentId: Value(contentId),
        securitySelfieFaceDetected: Value(faceDetected),
      ),
    );
  }

  Future<void> updateInitialSetupProfileImages(List<ProfilePictureEntry> images) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileImages: Value(images.toJsonList()),
      ),
    );
  }

  Future<void> updateInitialSetupGender(String? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, gender: Value(value)),
    );
  }

  Future<void> updateInitialSetupGenderSearchSettings({
    bool? men,
    bool? women,
    bool? nonBinary,
  }) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        searchSettingMen: Value(men),
        searchSettingWomen: Value(women),
        searchSettingNonBinary: Value(nonBinary),
      ),
    );
  }

  Future<void> updateInitialSetupSearchAgeRange({bool? initDone, int? min, int? max}) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        searchAgeRangeInitDone: Value(initDone),
        searchAgeRangeMin: Value(min),
        searchAgeRangeMax: Value(max),
      ),
    );
  }

  Future<void> updateInitialSetupLocation(double? latitude, double? longitude) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        latitude: Value(latitude),
        longitude: Value(longitude),
      ),
    );
  }

  Future<void> updateInitialSetupProfileAttributes(
    List<api.ProfileAttributeValueUpdate>? attributes,
  ) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileAttributes: Value(attributes?.toJsonList()),
      ),
    );
  }

  Future<void> updateInitialSetupCurrentPage(String pageName) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, currentPage: Value(pageName)),
    );
  }

  Future<void> updateInitialSetupChatInfoUnderstood(bool? value) async {
    await into(initialSetupProgress).insertOnConflictUpdate(
      InitialSetupProgressCompanion.insert(id: SingleRowTable.ID, chatInfoUnderstood: Value(value)),
    );
  }

  Future<void> clearInitialSetupProgress() async {
    await (delete(initialSetupProgress)..where((t) => t.id.equals(SingleRowTable.ID.value))).go();
  }

  Future<void> updateEditProfileImagePickerIndex(int? index) async {
    await into(editProfileImagePickerIndex).insertOnConflictUpdate(
      EditProfileImagePickerIndexCompanion.insert(
        id: SingleRowTable.ID,
        editProfilePickImageToIndex: Value(index),
      ),
    );
  }

  Future<void> updateEditProfileProgress(EditProfileProgressEntry entry) async {
    await into(editProfileProgress).insertOnConflictUpdate(
      EditProfileProgressCompanion.insert(
        id: SingleRowTable.ID,
        age: Value(entry.age),
        name: Value(entry.name),
        profileText: Value(entry.profileText),
        jsonProfileAttributes: Value(entry.profileAttributes?.toJsonList()),
        unlimitedLikes: Value(entry.unlimitedLikes),
        jsonProfileImages: Value(entry.profileImages?.toJsonList()),
      ),
    );
  }

  Future<void> setProfileEditingInProgressStatus(bool value) async {
    await into(editProfileProgress).insertOnConflictUpdate(
      EditProfileProgressCompanion.insert(id: SingleRowTable.ID, editingInProgress: Value(value)),
    );
  }

  Future<void> setProfileSelectingImageStatus(bool value) async {
    await into(editProfileProgress).insertOnConflictUpdate(
      EditProfileProgressCompanion.insert(id: SingleRowTable.ID, selectingImage: Value(value)),
    );
  }
}

class UpdateNotificationStatus {
  final Future<JsonObject<api.NotificationStatus>?> Function() currentValueGetter;
  final Future<void> Function(api.NotificationStatus) updateValue;
  UpdateNotificationStatus({required this.currentValueGetter, required this.updateValue});

  /// Returns true when notification must be shown
  Future<bool> shouldBeShown(api.NotificationStatus newValue) async {
    final currentStatusJsonObject = await currentValueGetter();
    final currentStatus = currentStatusJsonObject?.value ?? _defaultNotificationStatus();
    await updateValue(newValue);
    return newValue.id.id != currentStatus.id.id || newValue.viewed.id != currentStatus.viewed.id;
  }

  Future<void> updateViewedId(api.NotificationIdViewed newValue) async {
    final currentStatusJsonObject = await currentValueGetter();
    final currentStatus = currentStatusJsonObject?.value ?? _defaultNotificationStatus();
    currentStatus.viewed = newValue;
    await updateValue(currentStatus);
  }

  api.NotificationStatus _defaultNotificationStatus() => api.NotificationStatus(
    id: api.NotificationId(id: 0),
    viewed: api.NotificationIdViewed(id: 0),
  );
}
