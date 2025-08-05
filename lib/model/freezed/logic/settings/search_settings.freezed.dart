// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_settings.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
class _DetectDefaultValueInCopyWith {
  const _DetectDefaultValueInCopyWith();
}

/// @nodoc
const _detectDefaultValueInCopyWith = _DetectDefaultValueInCopyWith();

/// @nodoc
final _privateConstructorErrorSearchSettingsData = UnsupportedError(
    'Private constructor SearchSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SearchSettingsData {
  UpdateState get updateState => throw _privateConstructorErrorSearchSettingsData;
  int get minAge => throw _privateConstructorErrorSearchSettingsData;
  int get maxAge => throw _privateConstructorErrorSearchSettingsData;
  GenderSearchSettingsAll get genderSearchSettingsAll => throw _privateConstructorErrorSearchSettingsData;
  Gender? get gender => throw _privateConstructorErrorSearchSettingsData;
  AutomaticProfileSearchSettings get automaticProfileSearchSettings => throw _privateConstructorErrorSearchSettingsData;
  int? get editedMinAge => throw _privateConstructorErrorSearchSettingsData;
  int? get editedMaxAge => throw _privateConstructorErrorSearchSettingsData;
  GenderSearchSettingsAll? get editedGenderSearchSettingsAll => throw _privateConstructorErrorSearchSettingsData;
  Gender? get editedGender => throw _privateConstructorErrorSearchSettingsData;
  bool? get editedSearchDistanceFilters => throw _privateConstructorErrorSearchSettingsData;
  bool? get editedSearchAttributeFilters => throw _privateConstructorErrorSearchSettingsData;
  bool? get editedSearchNewProfiles => throw _privateConstructorErrorSearchSettingsData;
  int? get editedSearchWeekdays => throw _privateConstructorErrorSearchSettingsData;

  SearchSettingsData copyWith({
    UpdateState? updateState,
    int? minAge,
    int? maxAge,
    GenderSearchSettingsAll? genderSearchSettingsAll,
    Gender? gender,
    AutomaticProfileSearchSettings? automaticProfileSearchSettings,
    int? editedMinAge,
    int? editedMaxAge,
    GenderSearchSettingsAll? editedGenderSearchSettingsAll,
    Gender? editedGender,
    bool? editedSearchDistanceFilters,
    bool? editedSearchAttributeFilters,
    bool? editedSearchNewProfiles,
    int? editedSearchWeekdays,
  }) => throw _privateConstructorErrorSearchSettingsData;
}

/// @nodoc
abstract class _SearchSettingsData extends SearchSettingsData {
  factory _SearchSettingsData({
    UpdateState updateState,
    int minAge,
    int maxAge,
    GenderSearchSettingsAll genderSearchSettingsAll,
    Gender? gender,
    required AutomaticProfileSearchSettings automaticProfileSearchSettings,
    int? editedMinAge,
    int? editedMaxAge,
    GenderSearchSettingsAll? editedGenderSearchSettingsAll,
    Gender? editedGender,
    bool? editedSearchDistanceFilters,
    bool? editedSearchAttributeFilters,
    bool? editedSearchNewProfiles,
    int? editedSearchWeekdays,
  }) = _$SearchSettingsDataImpl;
  _SearchSettingsData._() : super._();
}

/// @nodoc
class _$SearchSettingsDataImpl extends _SearchSettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const int _minAgeDefaultValue = MIN_AGE;
  static const int _maxAgeDefaultValue = MAX_AGE;
  static const GenderSearchSettingsAll _genderSearchSettingsAllDefaultValue = GenderSearchSettingsAll();
  
  _$SearchSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.minAge = _minAgeDefaultValue,
    this.maxAge = _maxAgeDefaultValue,
    this.genderSearchSettingsAll = _genderSearchSettingsAllDefaultValue,
    this.gender,
    required this.automaticProfileSearchSettings,
    this.editedMinAge,
    this.editedMaxAge,
    this.editedGenderSearchSettingsAll,
    this.editedGender,
    this.editedSearchDistanceFilters,
    this.editedSearchAttributeFilters,
    this.editedSearchNewProfiles,
    this.editedSearchWeekdays,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final int minAge;
  @override
  final int maxAge;
  @override
  final GenderSearchSettingsAll genderSearchSettingsAll;
  @override
  final Gender? gender;
  @override
  final AutomaticProfileSearchSettings automaticProfileSearchSettings;
  @override
  final int? editedMinAge;
  @override
  final int? editedMaxAge;
  @override
  final GenderSearchSettingsAll? editedGenderSearchSettingsAll;
  @override
  final Gender? editedGender;
  @override
  final bool? editedSearchDistanceFilters;
  @override
  final bool? editedSearchAttributeFilters;
  @override
  final bool? editedSearchNewProfiles;
  @override
  final int? editedSearchWeekdays;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchSettingsData(updateState: $updateState, minAge: $minAge, maxAge: $maxAge, genderSearchSettingsAll: $genderSearchSettingsAll, gender: $gender, automaticProfileSearchSettings: $automaticProfileSearchSettings, editedMinAge: $editedMinAge, editedMaxAge: $editedMaxAge, editedGenderSearchSettingsAll: $editedGenderSearchSettingsAll, editedGender: $editedGender, editedSearchDistanceFilters: $editedSearchDistanceFilters, editedSearchAttributeFilters: $editedSearchAttributeFilters, editedSearchNewProfiles: $editedSearchNewProfiles, editedSearchWeekdays: $editedSearchWeekdays)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('minAge', minAge))
      ..add(DiagnosticsProperty('maxAge', maxAge))
      ..add(DiagnosticsProperty('genderSearchSettingsAll', genderSearchSettingsAll))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('automaticProfileSearchSettings', automaticProfileSearchSettings))
      ..add(DiagnosticsProperty('editedMinAge', editedMinAge))
      ..add(DiagnosticsProperty('editedMaxAge', editedMaxAge))
      ..add(DiagnosticsProperty('editedGenderSearchSettingsAll', editedGenderSearchSettingsAll))
      ..add(DiagnosticsProperty('editedGender', editedGender))
      ..add(DiagnosticsProperty('editedSearchDistanceFilters', editedSearchDistanceFilters))
      ..add(DiagnosticsProperty('editedSearchAttributeFilters', editedSearchAttributeFilters))
      ..add(DiagnosticsProperty('editedSearchNewProfiles', editedSearchNewProfiles))
      ..add(DiagnosticsProperty('editedSearchWeekdays', editedSearchWeekdays));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SearchSettingsDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.minAge, minAge) ||
          other.minAge == minAge) &&
        (identical(other.maxAge, maxAge) ||
          other.maxAge == maxAge) &&
        (identical(other.genderSearchSettingsAll, genderSearchSettingsAll) ||
          other.genderSearchSettingsAll == genderSearchSettingsAll) &&
        (identical(other.gender, gender) ||
          other.gender == gender) &&
        (identical(other.automaticProfileSearchSettings, automaticProfileSearchSettings) ||
          other.automaticProfileSearchSettings == automaticProfileSearchSettings) &&
        (identical(other.editedMinAge, editedMinAge) ||
          other.editedMinAge == editedMinAge) &&
        (identical(other.editedMaxAge, editedMaxAge) ||
          other.editedMaxAge == editedMaxAge) &&
        (identical(other.editedGenderSearchSettingsAll, editedGenderSearchSettingsAll) ||
          other.editedGenderSearchSettingsAll == editedGenderSearchSettingsAll) &&
        (identical(other.editedGender, editedGender) ||
          other.editedGender == editedGender) &&
        (identical(other.editedSearchDistanceFilters, editedSearchDistanceFilters) ||
          other.editedSearchDistanceFilters == editedSearchDistanceFilters) &&
        (identical(other.editedSearchAttributeFilters, editedSearchAttributeFilters) ||
          other.editedSearchAttributeFilters == editedSearchAttributeFilters) &&
        (identical(other.editedSearchNewProfiles, editedSearchNewProfiles) ||
          other.editedSearchNewProfiles == editedSearchNewProfiles) &&
        (identical(other.editedSearchWeekdays, editedSearchWeekdays) ||
          other.editedSearchWeekdays == editedSearchWeekdays)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    minAge,
    maxAge,
    genderSearchSettingsAll,
    gender,
    automaticProfileSearchSettings,
    editedMinAge,
    editedMaxAge,
    editedGenderSearchSettingsAll,
    editedGender,
    editedSearchDistanceFilters,
    editedSearchAttributeFilters,
    editedSearchNewProfiles,
    editedSearchWeekdays,
  );

  @override
  SearchSettingsData copyWith({
    Object? updateState,
    Object? minAge,
    Object? maxAge,
    Object? genderSearchSettingsAll,
    Object? gender = _detectDefaultValueInCopyWith,
    Object? automaticProfileSearchSettings,
    Object? editedMinAge = _detectDefaultValueInCopyWith,
    Object? editedMaxAge = _detectDefaultValueInCopyWith,
    Object? editedGenderSearchSettingsAll = _detectDefaultValueInCopyWith,
    Object? editedGender = _detectDefaultValueInCopyWith,
    Object? editedSearchDistanceFilters = _detectDefaultValueInCopyWith,
    Object? editedSearchAttributeFilters = _detectDefaultValueInCopyWith,
    Object? editedSearchNewProfiles = _detectDefaultValueInCopyWith,
    Object? editedSearchWeekdays = _detectDefaultValueInCopyWith,
  }) => _$SearchSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    minAge: (minAge ?? this.minAge) as int,
    maxAge: (maxAge ?? this.maxAge) as int,
    genderSearchSettingsAll: (genderSearchSettingsAll ?? this.genderSearchSettingsAll) as GenderSearchSettingsAll,
    gender: (gender == _detectDefaultValueInCopyWith ? this.gender : gender) as Gender?,
    automaticProfileSearchSettings: (automaticProfileSearchSettings ?? this.automaticProfileSearchSettings) as AutomaticProfileSearchSettings,
    editedMinAge: (editedMinAge == _detectDefaultValueInCopyWith ? this.editedMinAge : editedMinAge) as int?,
    editedMaxAge: (editedMaxAge == _detectDefaultValueInCopyWith ? this.editedMaxAge : editedMaxAge) as int?,
    editedGenderSearchSettingsAll: (editedGenderSearchSettingsAll == _detectDefaultValueInCopyWith ? this.editedGenderSearchSettingsAll : editedGenderSearchSettingsAll) as GenderSearchSettingsAll?,
    editedGender: (editedGender == _detectDefaultValueInCopyWith ? this.editedGender : editedGender) as Gender?,
    editedSearchDistanceFilters: (editedSearchDistanceFilters == _detectDefaultValueInCopyWith ? this.editedSearchDistanceFilters : editedSearchDistanceFilters) as bool?,
    editedSearchAttributeFilters: (editedSearchAttributeFilters == _detectDefaultValueInCopyWith ? this.editedSearchAttributeFilters : editedSearchAttributeFilters) as bool?,
    editedSearchNewProfiles: (editedSearchNewProfiles == _detectDefaultValueInCopyWith ? this.editedSearchNewProfiles : editedSearchNewProfiles) as bool?,
    editedSearchWeekdays: (editedSearchWeekdays == _detectDefaultValueInCopyWith ? this.editedSearchWeekdays : editedSearchWeekdays) as int?,
  );
}
