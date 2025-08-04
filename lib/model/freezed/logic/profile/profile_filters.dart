

import 'package:flutter/material.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'profile_filters.freezed.dart';

@freezed
class ProfileFiltersData with _$ProfileFiltersData, UpdateStateProvider {
  const ProfileFiltersData._();

  factory ProfileFiltersData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(false) bool showAdvancedFilters,
    @Default(false) bool showOnlyFavorites,
    GetProfileFilters? filters,
    @Default({}) Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndAttributeFilterMap,
    required EditedFiltersData edited,
  }) = _ProfileFiltersData;

  bool isSomeFilterEnabled() {
    return valueAttributeFilters().values.where((v) => v.enabled).firstOrNull != null ||
      valueLastSeenTimeFilter() != null ||
      valueUnlimitedLikesFilter() != null ||
      valueMinDistanceKmFilter() != null ||
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

  bool unsavedChanges() => edited.attributeIdAndAttributeFilterMap != null ||
    edited.lastSeenTimeFilter.unsavedChanges() ||
    edited.unlimitedLikesFilter.unsavedChanges() ||
    edited.minDistanceKmFilter.unsavedChanges() ||
    edited.maxDistanceKmFilter.unsavedChanges() ||
    edited.profileCreatedFilter.unsavedChanges() ||
    edited.profileEditedFilter.unsavedChanges() ||
    edited.profileTextMinCharactersFilter.unsavedChanges() ||
    edited.profileTextMaxCharactersFilter.unsavedChanges() ||
    edited.randomProfileOrder != null;

  Map<int, ProfileAttributeFilterValueUpdate> valueAttributeFilters() => edited.attributeIdAndAttributeFilterMap ?? attributeIdAndAttributeFilterMap;
  LastSeenTimeFilter? valueLastSeenTimeFilter() => edited.lastSeenTimeFilter.editedValue(filters?.lastSeenTimeFilter);
  bool? valueUnlimitedLikesFilter() => edited.unlimitedLikesFilter.editedValue(filters?.unlimitedLikesFilter);
  MinDistanceKm? valueMinDistanceKmFilter() => edited.minDistanceKmFilter.editedValue(filters?.minDistanceKmFilter);
  MaxDistanceKm? valueMaxDistanceKmFilter() => edited.maxDistanceKmFilter.editedValue(filters?.maxDistanceKmFilter);
  ProfileCreatedTimeFilter? valueProfileCreatedTime() => edited.profileCreatedFilter.editedValue(filters?.profileCreatedFilter);
  ProfileEditedTimeFilter? valueProfileEditedTime() => edited.profileEditedFilter.editedValue(filters?.profileEditedFilter);
  ProfileTextMinCharactersFilter? valueProfileTextMinCharacters() => edited.profileTextMinCharactersFilter.editedValue(filters?.profileTextMinCharactersFilter);
  ProfileTextMaxCharactersFilter? valueProfileTextMaxCharacters() => edited.profileTextMaxCharactersFilter.editedValue(filters?.profileTextMaxCharactersFilter);
  bool valueRandomProfileOrder() => edited.randomProfileOrder ?? filters?.randomProfileOrder ?? false;
}

@freezed
class EditedFiltersData with _$EditedFiltersData {
  factory EditedFiltersData({
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndAttributeFilterMap,
    @Default(NoEdit()) EditValue<LastSeenTimeFilter> lastSeenTimeFilter,
    @Default(NoEdit()) EditValue<bool> unlimitedLikesFilter,
    @Default(NoEdit()) EditValue<MinDistanceKm> minDistanceKmFilter,
    @Default(NoEdit()) EditValue<MaxDistanceKm> maxDistanceKmFilter,
    @Default(NoEdit()) EditValue<ProfileCreatedTimeFilter> profileCreatedFilter,
    @Default(NoEdit()) EditValue<ProfileEditedTimeFilter> profileEditedFilter,
    @Default(NoEdit()) EditValue<ProfileTextMinCharactersFilter> profileTextMinCharactersFilter,
    @Default(NoEdit()) EditValue<ProfileTextMaxCharactersFilter> profileTextMaxCharactersFilter,
    bool? randomProfileOrder,
  }) = _EditedFiltersData;
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
