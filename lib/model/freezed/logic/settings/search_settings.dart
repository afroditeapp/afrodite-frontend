import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/utils/age.dart';
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
    @Default(MIN_AGE) int minAge,
    @Default(MAX_AGE) int maxAge,
    @Default(GenderSearchSettingsAll()) GenderSearchSettingsAll genderSearchSettingsAll,
    Gender? gender,
    required ProfileAppNotificationSettings profileSettings,

    int? editedMinAge,
    int? editedMaxAge,
    GenderSearchSettingsAll? editedGenderSearchSettingsAll,
    Gender? editedGender,
    bool? editedSearchDistanceFilters,
    bool? editedSearchAttributeFilters,
    bool? editedSearchNewProfiles,
    int? editedSearchWeekdays,
  }) = _SearchSettingsData;

  int valueMinAge() => editedMinAge ?? minAge;
  int valueMaxAge() => editedMaxAge ?? maxAge;
  GenderSearchSettingsAll valueGenderSearchSettingsAll() =>
    editedGenderSearchSettingsAll ?? genderSearchSettingsAll;
  Gender? valueGender() => editedGender ?? gender;
  // TODO(prod): Update
  // bool valueSearchDistanceFilters() => editedSearchDistanceFilters ?? profileSettings.automaticProfileSearchDistanceFilters;
  // bool valueSearchAttributeFilters() => editedSearchAttributeFilters ?? profileSettings.automaticProfileSearchAttributeFilters;
  // bool valueSearchNewProfiles() => editedSearchNewProfiles ?? profileSettings.automaticProfileSearchNewProfiles;
  // int valueSearchWeekdays() => editedSearchWeekdays ?? profileSettings.automaticProfileSearchWeekdays;
  bool valueSearchDistanceFilters() => editedSearchDistanceFilters ?? false;
  bool valueSearchAttributeFilters() => editedSearchAttributeFilters ?? false;
  bool valueSearchNewProfiles() => editedSearchNewProfiles ?? false;
  int valueSearchWeekdays() => editedSearchWeekdays ?? 0;

  bool unsavedChanges() => editedMinAge != null ||
    editedMaxAge != null ||
    editedGenderSearchSettingsAll != null ||
    editedGender != null ||
    editedSearchDistanceFilters != null ||
    editedSearchAttributeFilters != null ||
    editedSearchNewProfiles != null ||
    editedSearchWeekdays != null;
}
