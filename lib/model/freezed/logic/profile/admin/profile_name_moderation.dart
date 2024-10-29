

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'profile_name_moderation.freezed.dart';

@freezed
class ProfileNameModerationData with _$ProfileNameModerationData {
  factory ProfileNameModerationData({
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    GetProfileNamePendingModerationList? item,
    @Default({}) Set<ProfileNamePendingModeration> selected,
  }) = _ProfileNameModerationData;
}
