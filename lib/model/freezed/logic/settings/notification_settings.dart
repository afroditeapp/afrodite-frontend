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

    // Automatic profile search
    @Default(ProfileAppNotificationSettingsDefaults.distanceDefault) bool searchDistance,
    @Default(ProfileAppNotificationSettingsDefaults.filtersDefault) bool searchFilters,
    @Default(ProfileAppNotificationSettingsDefaults.newProfilesDefault) bool searchNewProfiles,
    @Default(ProfileAppNotificationSettingsDefaults.weekdaysDefault) int searchWeekdays,

    // Edited
    bool? editedMessages,
    bool? editedLikes,
    bool? editedMediaContent,
    bool? editedProfileText,
    bool? editedNews,
    bool? editedAutomaticProfileSearch,
    bool? editedSearchDistance,
    bool? editedSearchFilters,
    bool? editedSearchNewProfiles,
    int? editedSearchWeekdays,
  }) = _NotificationSettingsData;

  bool valueMessages() => editedMessages ?? categories.messages;
  bool valueLikes() => editedLikes ?? categories.likes;
  bool valueMediaContent() => editedMediaContent ?? categories.mediaContentModerationCompleted;
  bool valueProfileText() => editedProfileText ?? categories.profileTextModerationCompleted;
  bool valueNews() => editedNews ?? categories.news;
  bool valueAutomaticProfileSearch() => editedAutomaticProfileSearch ?? categories.automaticProfileSearch;
  bool valueSearchDistance() => editedSearchDistance ?? searchDistance;
  bool valueSearchFilters() => editedSearchFilters ?? searchFilters;
  bool valueSearchNewProfiles() => editedSearchNewProfiles ?? searchNewProfiles;
  int valueSearchWeekdays() => editedSearchWeekdays ?? searchWeekdays;

  bool unsavedChanges() => editedMessages != null ||
    editedLikes != null ||
    editedMediaContent != null ||
    editedProfileText != null ||
    editedNews != null ||
    editedAutomaticProfileSearch != null ||
    editedSearchDistance != null ||
    editedSearchFilters != null ||
    editedSearchNewProfiles != null ||
    editedSearchWeekdays != null;
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
