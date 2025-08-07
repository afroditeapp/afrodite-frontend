import 'package:app/model/freezed/logic/account/initial_setup.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:openapi/api.dart';

part 'search_settings.freezed.dart';

@freezed
class SearchSettingsData with _$SearchSettingsData, UpdateStateProvider {
  SearchSettingsData._();
  factory SearchSettingsData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(GenderSearchSettingsAll()) GenderSearchSettingsAll genderSearchSettingsAll,
    Gender? gender,
    required AutomaticProfileSearchSettings automaticProfileSearchSettings,

    GenderSearchSettingsAll? editedGenderSearchSettingsAll,
    Gender? editedGender,
    bool? editedSearchDistanceFilters,
    bool? editedSearchAttributeFilters,
    bool? editedSearchNewProfiles,
    int? editedSearchWeekdays,
  }) = _SearchSettingsData;

  GenderSearchSettingsAll valueGenderSearchSettingsAll() =>
    editedGenderSearchSettingsAll ?? genderSearchSettingsAll;
  Gender? valueGender() => editedGender ?? gender;
  bool valueSearchDistanceFilters() => editedSearchDistanceFilters ?? automaticProfileSearchSettings.distanceFilters;
  bool valueSearchAttributeFilters() => editedSearchAttributeFilters ?? automaticProfileSearchSettings.attributeFilters;
  bool valueSearchNewProfiles() => editedSearchNewProfiles ?? automaticProfileSearchSettings.newProfiles;
  int valueSearchWeekdays() => editedSearchWeekdays ?? automaticProfileSearchSettings.weekdays;

  bool unsavedChanges() => editedGenderSearchSettingsAll != null ||
    editedGender != null ||
    editedSearchDistanceFilters != null ||
    editedSearchAttributeFilters != null ||
    editedSearchNewProfiles != null ||
    editedSearchWeekdays != null;
}
