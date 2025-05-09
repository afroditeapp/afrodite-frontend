import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/utils/api.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'notification_settings.freezed.dart';

@freezed
class NotificationSettingsData with _$NotificationSettingsData, UpdateStateProvider {
  NotificationSettingsData._();
  factory NotificationSettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(false) bool areNotificationsEnabled,
    required NotificationCategoryData categories,
    required NotificationCategoryData systemCategories,
    required EditedNotificationSettingsData edited,

    // Automatic profile search
    @Default(ProfileAppNotificationSettingsDefaults.distanceDefault) bool searchDistance,
    @Default(ProfileAppNotificationSettingsDefaults.filtersDefault) bool searchFilters,
    @Default(ProfileAppNotificationSettingsDefaults.newProfilesDefault) bool searchNewProfiles,
    @Default(ProfileAppNotificationSettingsDefaults.weekdaysDefault) int searchWeekdays,
  }) = _NotificationSettingsData;

  bool valueMessages() => edited.messages ?? categories.messages;
  bool valueLikes() => edited.likes ?? categories.likes;
  bool valueMediaContent() => edited.mediaContent ?? categories.mediaContentModerationCompleted;
  bool valueProfileText() => edited.profileText ?? categories.profileTextModerationCompleted;
  bool valueNews() => edited.news ?? categories.news;
  bool valueAutomaticProfileSearch() => edited.automaticProfileSearch ?? categories.automaticProfileSearch;

  bool unsavedChanges() => edited.messages != null ||
    edited.likes != null ||
    edited.mediaContent != null ||
    edited.profileText != null ||
    edited.news != null ||
    edited.automaticProfileSearch != null;
}

@freezed
class NotificationCategoryData with _$NotificationCategoryData {
  NotificationCategoryData._();
  factory NotificationCategoryData({
    @Default(true) bool messages,
    @Default(true) bool likes,
    @Default(true) bool mediaContentModerationCompleted,
    @Default(true) bool profileTextModerationCompleted,
    @Default(true) bool news,
    @Default(true) bool automaticProfileSearch,
  }) = _NotificationCategoryData;
}

@freezed
class EditedNotificationSettingsData with _$EditedNotificationSettingsData {
  EditedNotificationSettingsData._();
  factory EditedNotificationSettingsData({
    bool? messages,
    bool? likes,
    bool? mediaContent,
    bool? profileText,
    bool? news,
    bool? automaticProfileSearch,
  }) = _EditedNotificationSettingsData;
}
