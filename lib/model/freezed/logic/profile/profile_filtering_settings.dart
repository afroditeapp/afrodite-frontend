

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'profile_filtering_settings.freezed.dart';

@freezed
class ProfileFilteringSettingsData with _$ProfileFilteringSettingsData {
  const ProfileFilteringSettingsData._();

  factory ProfileFilteringSettingsData({
    @Default(false) bool showOnlyFavorites,
  }) = _ProfileFilteringSettingsData;

  bool isSomeFilterEnabled() {
    return showOnlyFavorites;
  }
}
