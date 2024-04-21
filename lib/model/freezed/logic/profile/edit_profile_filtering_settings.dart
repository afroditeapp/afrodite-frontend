

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'edit_profile_filtering_settings.freezed.dart';

@freezed
class EditProfileFilteringSettingsData with _$EditProfileFilteringSettingsData {
  factory EditProfileFilteringSettingsData({
    @Default(false) bool showOnlyFavorites,
  }) = _EditProfileFilteringSettingsData;
}
