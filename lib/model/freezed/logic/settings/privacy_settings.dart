import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'privacy_settings.freezed.dart';

@freezed
class PrivacySettingsData with _$PrivacySettingsData, UpdateStateProvider {
  PrivacySettingsData._();
  factory PrivacySettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(false) bool messageStateDelivered,
    @Default(false) bool messageStateSent,
    @Default(false) bool typingIndicator,
    required EditedPrivacySettingsData edited,
  }) = _PrivacySettingsData;

  bool valueMessageStateDelivered() => edited.messageStateDelivered ?? messageStateDelivered;
  bool valueMessageStateSent() => edited.messageStateSent ?? messageStateSent;
  bool valueTypingIndicator() => edited.typingIndicator ?? typingIndicator;

  bool unsavedChanges() =>
      edited.messageStateDelivered != null ||
      edited.messageStateSent != null ||
      edited.typingIndicator != null;
}

@freezed
class EditedPrivacySettingsData with _$EditedPrivacySettingsData {
  EditedPrivacySettingsData._();
  factory EditedPrivacySettingsData({
    bool? messageStateDelivered,
    bool? messageStateSent,
    bool? typingIndicator,
  }) = _EditedPrivacySettingsData;
}
