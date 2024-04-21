

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';

part 'profile_filtering_settings.freezed.dart';

@freezed
class ProfileFilteringSettingsData with _$ProfileFilteringSettingsData, UpdateStateProvider {
  const ProfileFilteringSettingsData._();

  factory ProfileFilteringSettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(false) bool showOnlyFavorites,
    @Default(false) bool showOnlyFavorites2,
  }) = _ProfileFilteringSettingsData;

  bool isSomeFilterEnabled() {
    return showOnlyFavorites;
  }
}
