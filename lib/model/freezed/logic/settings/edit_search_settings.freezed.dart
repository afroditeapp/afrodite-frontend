// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_search_settings.dart';

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
final _privateConstructorErrorEditSearchSettingsData = UnsupportedError(
    'Private constructor EditSearchSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditSearchSettingsData {
  int? get minAge => throw _privateConstructorErrorEditSearchSettingsData;
  int? get maxAge => throw _privateConstructorErrorEditSearchSettingsData;
  Gender? get gender => throw _privateConstructorErrorEditSearchSettingsData;
  GenderSearchSettingsAll get genderSearchSetting => throw _privateConstructorErrorEditSearchSettingsData;

  EditSearchSettingsData copyWith({
    int? minAge,
    int? maxAge,
    Gender? gender,
    GenderSearchSettingsAll? genderSearchSetting,
  }) => throw _privateConstructorErrorEditSearchSettingsData;
}

/// @nodoc
abstract class _EditSearchSettingsData extends EditSearchSettingsData {
  factory _EditSearchSettingsData({
    int? minAge,
    int? maxAge,
    Gender? gender,
    GenderSearchSettingsAll genderSearchSetting,
  }) = _$EditSearchSettingsDataImpl;
  _EditSearchSettingsData._() : super._();
}

/// @nodoc
class _$EditSearchSettingsDataImpl extends _EditSearchSettingsData with DiagnosticableTreeMixin {
  static const GenderSearchSettingsAll _genderSearchSettingDefaultValue = GenderSearchSettingsAll();
  
  _$EditSearchSettingsDataImpl({
    this.minAge,
    this.maxAge,
    this.gender,
    this.genderSearchSetting = _genderSearchSettingDefaultValue,
  }) : super._();

  @override
  final int? minAge;
  @override
  final int? maxAge;
  @override
  final Gender? gender;
  @override
  final GenderSearchSettingsAll genderSearchSetting;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditSearchSettingsData(minAge: $minAge, maxAge: $maxAge, gender: $gender, genderSearchSetting: $genderSearchSetting)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditSearchSettingsData'))
      ..add(DiagnosticsProperty('minAge', minAge))
      ..add(DiagnosticsProperty('maxAge', maxAge))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('genderSearchSetting', genderSearchSetting));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditSearchSettingsDataImpl &&
        (identical(other.minAge, minAge) ||
          other.minAge == minAge) &&
        (identical(other.maxAge, maxAge) ||
          other.maxAge == maxAge) &&
        (identical(other.gender, gender) ||
          other.gender == gender) &&
        (identical(other.genderSearchSetting, genderSearchSetting) ||
          other.genderSearchSetting == genderSearchSetting)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    minAge,
    maxAge,
    gender,
    genderSearchSetting,
  );

  @override
  EditSearchSettingsData copyWith({
    Object? minAge = _detectDefaultValueInCopyWith,
    Object? maxAge = _detectDefaultValueInCopyWith,
    Object? gender = _detectDefaultValueInCopyWith,
    Object? genderSearchSetting,
  }) => _$EditSearchSettingsDataImpl(
    minAge: (minAge == _detectDefaultValueInCopyWith ? this.minAge : minAge) as int?,
    maxAge: (maxAge == _detectDefaultValueInCopyWith ? this.maxAge : maxAge) as int?,
    gender: (gender == _detectDefaultValueInCopyWith ? this.gender : gender) as Gender?,
    genderSearchSetting: (genderSearchSetting ?? this.genderSearchSetting) as GenderSearchSettingsAll,
  );
}
