

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'profile_filtering_settings.freezed.dart';

@freezed
class ProfileFilteringSettingsData with _$ProfileFilteringSettingsData, UpdateStateProvider {
  const ProfileFilteringSettingsData._();

  factory ProfileFilteringSettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(false) bool showOnlyFavorites,
    GetProfileFilteringSettings? filteringSettings,
  }) = _ProfileFilteringSettingsData;

  bool isSomeFilterEnabled() {
    return showOnlyFavorites || filteringSettings?.filters.isNotEmpty == true;
  }

  List<ProfileAttributeFilterValueUpdate> currentFiltersCopy() {
    return filteringSettings?.filters.map((e) => ProfileAttributeFilterValueUpdate(
      acceptMissingAttribute: e.acceptMissingAttribute,
      filterValues: [...e.filterValues],
      id: e.id,
    )).toList() ?? [];
  }
}
