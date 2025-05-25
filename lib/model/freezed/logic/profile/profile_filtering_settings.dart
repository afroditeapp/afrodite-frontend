

import 'package:flutter/material.dart';
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
    @Default({}) Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndFilterValueMap,
    required EditedFilteringSettingsData edited,
  }) = _ProfileFilteringSettingsData;

  bool isSomeFilterEnabled() {
    return valueShowOnlyFavorites() == true ||
      valueAttributes().values.where((v) => v.enabled).firstOrNull != null ||
      valueLastSeenTimeFilter() != null ||
      valueUnlimitedLikesFilter() != null ||
      valueMaxDistanceKmFilter() != null ||
      valueProfileCreatedTime() != null ||
      valueProfileEditedTime() != null ||
      valueProfileTextMinCharacters() != null ||
      valueProfileTextMaxCharacters() != null;
  }

  IconData icon() {
    if (isSomeFilterEnabled()) {
      return Icons.filter_alt_rounded;
    } else {
      return Icons.filter_alt_outlined;
    }
  }

  bool unsavedChanges() => edited.showOnlyFavorites != null ||
    edited.attributeIdAndFilterValueMap != null ||
    edited.lastSeenTimeFilter.unsavedChanges() ||
    edited.unlimitedLikesFilter.unsavedChanges() ||
    edited.maxDistanceKmFilter.unsavedChanges() ||
    edited.profileCreatedFilter.unsavedChanges() ||
    edited.profileEditedFilter.unsavedChanges() ||
    edited.profileTextMinCharactersFilter.unsavedChanges() ||
    edited.profileTextMaxCharactersFilter.unsavedChanges() ||
    edited.randomProfileOrder != null;

  bool valueShowOnlyFavorites() => edited.showOnlyFavorites ?? showOnlyFavorites;
  Map<int, ProfileAttributeFilterValueUpdate> valueAttributes() => edited.attributeIdAndFilterValueMap ?? attributeIdAndFilterValueMap;
  LastSeenTimeFilter? valueLastSeenTimeFilter() => edited.lastSeenTimeFilter.editedValue(filteringSettings?.lastSeenTimeFilter);
  bool? valueUnlimitedLikesFilter() => edited.unlimitedLikesFilter.editedValue(filteringSettings?.unlimitedLikesFilter);
  MaxDistanceKm? valueMaxDistanceKmFilter() => edited.maxDistanceKmFilter.editedValue(filteringSettings?.maxDistanceKmFilter);
  ProfileCreatedTimeFilter? valueProfileCreatedTime() => edited.profileCreatedFilter.editedValue(filteringSettings?.profileCreatedFilter);
  ProfileEditedTimeFilter? valueProfileEditedTime() => edited.profileEditedFilter.editedValue(filteringSettings?.profileEditedFilter);
  ProfileTextMinCharactersFilter? valueProfileTextMinCharacters() => edited.profileTextMinCharactersFilter.editedValue(filteringSettings?.profileTextMinCharactersFilter);
  ProfileTextMaxCharactersFilter? valueProfileTextMaxCharacters() => edited.profileTextMaxCharactersFilter.editedValue(filteringSettings?.profileTextMaxCharactersFilter);
  bool valueRandomProfileOrder() => edited.randomProfileOrder ?? filteringSettings?.randomProfileOrder ?? false;
}

@freezed
class EditedFilteringSettingsData with _$EditedFilteringSettingsData {
  factory EditedFilteringSettingsData({
    bool? showOnlyFavorites,
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndFilterValueMap,
    @Default(NoEdit()) EditValue<LastSeenTimeFilter> lastSeenTimeFilter,
    @Default(NoEdit()) EditValue<bool> unlimitedLikesFilter,
    @Default(NoEdit()) EditValue<MaxDistanceKm> maxDistanceKmFilter,
    @Default(NoEdit()) EditValue<ProfileCreatedTimeFilter> profileCreatedFilter,
    @Default(NoEdit()) EditValue<ProfileEditedTimeFilter> profileEditedFilter,
    @Default(NoEdit()) EditValue<ProfileTextMinCharactersFilter> profileTextMinCharactersFilter,
    @Default(NoEdit()) EditValue<ProfileTextMaxCharactersFilter> profileTextMaxCharactersFilter,
    bool? randomProfileOrder,
  }) = _EditedFilteringSettingsData;
}

/// Type for handling API null values
sealed class EditValue<T extends Object> {
  const EditValue();
  T? editedValue(T? defaultValue) => defaultValue;
  bool unsavedChanges() => false;
}
class NoEdit<T extends Object> extends EditValue<T> {
  const NoEdit();
}
class ChangeToNull<T extends Object> extends EditValue<T> {
  @override
  T? editedValue(T? defaultValue) => null;
  @override
  bool unsavedChanges() => true;
}
class ChangeToValue<T extends Object> extends EditValue<T> {
  final T value;
  const ChangeToValue(this.value);
  @override
  T? editedValue(T? defaultValue) => value;
  @override
  bool unsavedChanges() => true;
}

EditValue<T> editValue<T extends Object>(T? newValue) {
  if (newValue == null) {
    return ChangeToNull();
  } else {
    return ChangeToValue(newValue);
  }
}
