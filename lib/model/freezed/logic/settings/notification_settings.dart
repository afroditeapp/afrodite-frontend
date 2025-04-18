import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'notification_settings.freezed.dart';

@freezed
class NotificationSettingsData with _$NotificationSettingsData {
  factory NotificationSettingsData({
    @Default(false) bool areNotificationsEnabled,
    @Default(true) bool categoryEnabledMessages,
    @Default(true) bool categoryEnabledLikes,
    @Default(true) bool categoryEnabledMediaContentModerationCompleted,
    @Default(true) bool categoryEnabledNews,
    @Default(true) bool categorySystemEnabledMessages,
    @Default(true) bool categorySystemEnabledLikes,
    @Default(true) bool categorySystemEnabledMediaContentModerationCompleted,
    @Default(true) bool categorySystemEnabledNews,
  }) = _NotificationSettingsData;
}
