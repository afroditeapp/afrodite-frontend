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
  SearchGroups? get searchGroups => throw _privateConstructorErrorEditSearchSettingsData;

  EditSearchSettingsData copyWith({
    int? minAge,
    int? maxAge,
    SearchGroups? searchGroups,
  }) => throw _privateConstructorErrorEditSearchSettingsData;
}

/// @nodoc
abstract class _EditSearchSettingsData extends EditSearchSettingsData {
  factory _EditSearchSettingsData({
    int? minAge,
    int? maxAge,
    SearchGroups? searchGroups,
  }) = _$EditSearchSettingsDataImpl;
  _EditSearchSettingsData._() : super._();
}

/// @nodoc
class _$EditSearchSettingsDataImpl extends _EditSearchSettingsData with DiagnosticableTreeMixin {
  _$EditSearchSettingsDataImpl({
    this.minAge,
    this.maxAge,
    this.searchGroups,
  }) : super._();

  @override
  final int? minAge;
  @override
  final int? maxAge;
  @override
  final SearchGroups? searchGroups;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditSearchSettingsData(minAge: $minAge, maxAge: $maxAge, searchGroups: $searchGroups)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditSearchSettingsData'))
      ..add(DiagnosticsProperty('minAge', minAge))
      ..add(DiagnosticsProperty('maxAge', maxAge))
      ..add(DiagnosticsProperty('searchGroups', searchGroups));
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
        (identical(other.searchGroups, searchGroups) ||
          other.searchGroups == searchGroups)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    minAge,
    maxAge,
    searchGroups,
  );

  @override
  EditSearchSettingsData copyWith({
    Object? minAge = _detectDefaultValueInCopyWith,
    Object? maxAge = _detectDefaultValueInCopyWith,
    Object? searchGroups = _detectDefaultValueInCopyWith,
  }) => _$EditSearchSettingsDataImpl(
    minAge: (minAge == _detectDefaultValueInCopyWith ? this.minAge : minAge) as int?,
    maxAge: (maxAge == _detectDefaultValueInCopyWith ? this.maxAge : maxAge) as int?,
    searchGroups: (searchGroups == _detectDefaultValueInCopyWith ? this.searchGroups : searchGroups) as SearchGroups?,
  );
}
