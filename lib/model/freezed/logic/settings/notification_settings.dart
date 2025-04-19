import 'package:app/ui_utils/common_update_logic.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'notification_settings.freezed.dart';

@freezed
class NotificationSettingsData with _$NotificationSettingsData, UpdateStateProvider {
  NotificationSettingsData._();
  factory NotificationSettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(false) bool areNotificationsEnabled,
    @Default(true) bool categoryEnabledMessages,
    @Default(true) bool categoryEnabledLikes,
    @Default(true) bool categoryEnabledMediaContentModerationCompleted,
    @Default(true) bool categoryEnabledProfileTextModerationCompleted,
    @Default(true) bool categoryEnabledNews,
    @Default(true) bool categorySystemEnabledMessages,
    @Default(true) bool categorySystemEnabledLikes,
    @Default(true) bool categorySystemEnabledMediaContentModerationCompleted,
    @Default(true) bool categorySystemEnabledProfileTextModerationCompleted,
    @Default(true) bool categorySystemEnabledNews,

    // Edited
    bool? editedMessages,
    bool? editedLikes,
    bool? editedMediaContent,
    bool? editedProfileText,
    bool? editedNews,
  }) = _NotificationSettingsData;

  bool valueMessages() => editedMessages ?? categoryEnabledMessages;
  bool valueLikes() => editedLikes ?? categoryEnabledLikes;
  bool valueMediaContent() => editedMediaContent ?? categoryEnabledMediaContentModerationCompleted;
  bool valueProfileText() => editedProfileText ?? categoryEnabledProfileTextModerationCompleted;
  bool valueNews() => editedNews ?? categoryEnabledNews;

  bool unsavedChanges() => editedMessages != null ||
    editedLikes != null ||
    editedMediaContent != null ||
    editedProfileText != null ||
    editedNews != null;
}
