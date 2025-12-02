import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'profile_visibility.freezed.dart';

@freezed
class ProfileVisibilityData with _$ProfileVisibilityData, UpdateStateProvider {
  ProfileVisibilityData._();
  factory ProfileVisibilityData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(ProfileVisibility.pendingPrivate) ProfileVisibility visiblity,
    ProfileVisibility? editedVisibility,
  }) = _ProfileVisibilityData;

  ProfileVisibility valueVisibility() => editedVisibility ?? visiblity;
}
