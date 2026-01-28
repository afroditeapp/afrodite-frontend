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
  GenderSearchSettingsAll get genderSearchSettingsAll => throw _privateConstructorErrorSearchSettingsData;
  Gender? get gender => throw _privateConstructorErrorSearchSettingsData;
  AutomaticProfileSearchSettings get automaticProfileSearchSettings => throw _privateConstructorErrorSearchSettingsData;
  GenderSearchSettingsAll? get editedGenderSearchSettingsAll => throw _privateConstructorErrorSearchSettingsData;
  Gender? get editedGender => throw _privateConstructorErrorSearchSettingsData;
  bool? get editedSearchDistanceFilters => throw _privateConstructorErrorSearchSettingsData;
  bool? get editedSearchAttributeFilters => throw _privateConstructorErrorSearchSettingsData;
  bool? get editedSearchNewProfiles => throw _privateConstructorErrorSearchSettingsData;
  int? get editedSearchWeekdays => throw _privateConstructorErrorSearchSettingsData;

  SearchSettingsData copyWith({
    UpdateState? updateState,
    GenderSearchSettingsAll? genderSearchSettingsAll,
    Gender? gender,
    AutomaticProfileSearchSettings? automaticProfileSearchSettings,
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
    GenderSearchSettingsAll genderSearchSettingsAll,
    Gender? gender,
    required AutomaticProfileSearchSettings automaticProfileSearchSettings,
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
  static const GenderSearchSettingsAll _genderSearchSettingsAllDefaultValue = GenderSearchSettingsAll();

  _$SearchSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.genderSearchSettingsAll = _genderSearchSettingsAllDefaultValue,
    this.gender,
    required this.automaticProfileSearchSettings,
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
  final GenderSearchSettingsAll genderSearchSettingsAll;
  @override
  final Gender? gender;
  @override
  final AutomaticProfileSearchSettings automaticProfileSearchSettings;
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
    return 'SearchSettingsData(updateState: $updateState, genderSearchSettingsAll: $genderSearchSettingsAll, gender: $gender, automaticProfileSearchSettings: $automaticProfileSearchSettings, editedGenderSearchSettingsAll: $editedGenderSearchSettingsAll, editedGender: $editedGender, editedSearchDistanceFilters: $editedSearchDistanceFilters, editedSearchAttributeFilters: $editedSearchAttributeFilters, editedSearchNewProfiles: $editedSearchNewProfiles, editedSearchWeekdays: $editedSearchWeekdays)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('genderSearchSettingsAll', genderSearchSettingsAll))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('automaticProfileSearchSettings', automaticProfileSearchSettings))
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
        (identical(other.genderSearchSettingsAll, genderSearchSettingsAll) ||
          other.genderSearchSettingsAll == genderSearchSettingsAll) &&
        (identical(other.gender, gender) ||
          other.gender == gender) &&
        (identical(other.automaticProfileSearchSettings, automaticProfileSearchSettings) ||
          other.automaticProfileSearchSettings == automaticProfileSearchSettings) &&
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
    genderSearchSettingsAll,
    gender,
    automaticProfileSearchSettings,
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
    Object? genderSearchSettingsAll,
    Object? gender = _detectDefaultValueInCopyWith,
    Object? automaticProfileSearchSettings,
    Object? editedGenderSearchSettingsAll = _detectDefaultValueInCopyWith,
    Object? editedGender = _detectDefaultValueInCopyWith,
    Object? editedSearchDistanceFilters = _detectDefaultValueInCopyWith,
    Object? editedSearchAttributeFilters = _detectDefaultValueInCopyWith,
    Object? editedSearchNewProfiles = _detectDefaultValueInCopyWith,
    Object? editedSearchWeekdays = _detectDefaultValueInCopyWith,
  }) => _$SearchSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    genderSearchSettingsAll: (genderSearchSettingsAll ?? this.genderSearchSettingsAll) as GenderSearchSettingsAll,
    gender: (gender == _detectDefaultValueInCopyWith ? this.gender : gender) as Gender?,
    automaticProfileSearchSettings: (automaticProfileSearchSettings ?? this.automaticProfileSearchSettings) as AutomaticProfileSearchSettings,
    editedGenderSearchSettingsAll: (editedGenderSearchSettingsAll == _detectDefaultValueInCopyWith ? this.editedGenderSearchSettingsAll : editedGenderSearchSettingsAll) as GenderSearchSettingsAll?,
    editedGender: (editedGender == _detectDefaultValueInCopyWith ? this.editedGender : editedGender) as Gender?,
    editedSearchDistanceFilters: (editedSearchDistanceFilters == _detectDefaultValueInCopyWith ? this.editedSearchDistanceFilters : editedSearchDistanceFilters) as bool?,
    editedSearchAttributeFilters: (editedSearchAttributeFilters == _detectDefaultValueInCopyWith ? this.editedSearchAttributeFilters : editedSearchAttributeFilters) as bool?,
    editedSearchNewProfiles: (editedSearchNewProfiles == _detectDefaultValueInCopyWith ? this.editedSearchNewProfiles : editedSearchNewProfiles) as bool?,
    editedSearchWeekdays: (editedSearchWeekdays == _detectDefaultValueInCopyWith ? this.editedSearchWeekdays : editedSearchWeekdays) as int?,
  );
}
