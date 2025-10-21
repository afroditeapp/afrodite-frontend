import 'package:app/ui_utils/common_update_logic.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'email_notification_settings.freezed.dart';

@freezed
class EmailNotificationSettingsData with _$EmailNotificationSettingsData, UpdateStateProvider {
  EmailNotificationSettingsData._();
  factory EmailNotificationSettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    required EmailNotificationCategoryData categories,
    required EditedEmailNotificationSettingsData edited,
  }) = _EmailNotificationSettingsData;

  bool valueMessages() => edited.messages ?? categories.messages;
  bool valueLikes() => edited.likes ?? categories.likes;

  bool unsavedChanges() => edited.messages != null || edited.likes != null;
}

@freezed
class EmailNotificationCategoryData with _$EmailNotificationCategoryData {
  EmailNotificationCategoryData._();
  factory EmailNotificationCategoryData({@Default(true) bool messages, @Default(true) bool likes}) =
      _EmailNotificationCategoryData;
}

@freezed
class EditedEmailNotificationSettingsData with _$EditedEmailNotificationSettingsData {
  EditedEmailNotificationSettingsData._();
  factory EditedEmailNotificationSettingsData({bool? messages, bool? likes}) =
      _EditedEmailNotificationSettingsData;
}
