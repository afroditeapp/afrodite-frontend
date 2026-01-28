import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'privacy_settings.freezed.dart';

@freezed
class PrivacySettingsData with _$PrivacySettingsData, UpdateStateProvider {
  PrivacySettingsData._();
  factory PrivacySettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(false) bool messageStateSeen,
    @Default(false) bool typingIndicator,
    @Default(false) bool lastSeenTime,
    @Default(false) bool onlineStatus,
    @Default(false) bool profilePrivacyLoading,
    @Default(false) bool profilePrivacyLoadError,
    required EditedPrivacySettingsData edited,
  }) = _PrivacySettingsData;

  bool valueMessageStateSeen() => edited.messageStateSeen ?? messageStateSeen;
  bool valueTypingIndicator() => edited.typingIndicator ?? typingIndicator;
  bool valueLastSeenTime() => edited.lastSeenTime ?? lastSeenTime;
  bool valueOnlineStatus() => edited.onlineStatus ?? onlineStatus;

  bool unsavedChanges() =>
      edited.messageStateSeen != null ||
      edited.typingIndicator != null ||
      edited.lastSeenTime != null ||
      edited.onlineStatus != null;
}

@freezed
class EditedPrivacySettingsData with _$EditedPrivacySettingsData {
  EditedPrivacySettingsData._();
  factory EditedPrivacySettingsData({
    bool? messageStateSeen,
    bool? typingIndicator,
    bool? lastSeenTime,
    bool? onlineStatus,
  }) = _EditedPrivacySettingsData;
}
