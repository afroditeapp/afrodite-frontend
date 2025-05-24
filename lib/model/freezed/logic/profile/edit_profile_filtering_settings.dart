

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'edit_profile_filtering_settings.freezed.dart';

@freezed
class EditProfileFilteringSettingsData with _$EditProfileFilteringSettingsData {
  factory EditProfileFilteringSettingsData({
    @Default(false) bool showOnlyFavorites,
    @Default({}) Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndFilterValueMap,
    LastSeenTimeFilter? lastSeenTimeFilter,
    bool? unlimitedLikesFilter,
    MaxDistanceKm? maxDistanceKmFilter,
    ProfileCreatedTimeFilter? profileCreatedFilter,
    ProfileEditedTimeFilter? profileEditedFilter,
    ProfileTextMinCharactersFilter? profileTextMinCharactersFilter,
    ProfileTextMaxCharactersFilter? profileTextMaxCharactersFilter,
    @Default(false) bool randomProfileOrder,
  }) = _EditProfileFilteringSettingsData;
}
