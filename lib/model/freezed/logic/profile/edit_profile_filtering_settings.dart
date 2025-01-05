

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/immutable_list.dart';

part 'edit_profile_filtering_settings.freezed.dart';

@freezed
class EditProfileFilteringSettingsData with _$EditProfileFilteringSettingsData {
  factory EditProfileFilteringSettingsData({
    @Default(false) bool showOnlyFavorites,
    @Default(UnmodifiableList<ProfileAttributeFilterValueUpdate>.empty())
      UnmodifiableList<ProfileAttributeFilterValueUpdate> attributeFilters,
    LastSeenTimeFilter? lastSeenTimeFilter,
    bool? unlimitedLikesFilter,
    MaxDistanceKm? maxDistanceKmFilter,
    AccountCreatedTimeFilter? accountCreatedFilter,
    ProfileEditedTimeFilter? profileEditedFilter,
    @Default(false) bool randomProfileOrder,
  }) = _EditProfileFilteringSettingsData;
}
