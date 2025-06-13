import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'privacy_settings.freezed.dart';

@freezed
class PrivacySettingsData with _$PrivacySettingsData, UpdateStateProvider {
  PrivacySettingsData._();
  factory PrivacySettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(ProfileVisibility.pendingPrivate) ProfileVisibility visiblity,
    ProfileVisibility? editedVisibility,
  }) = _PrivacySettingsData;

  ProfileVisibility valueVisibility() => editedVisibility ?? visiblity;
}
