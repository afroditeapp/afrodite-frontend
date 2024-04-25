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
  int? get minAge => throw _privateConstructorErrorSearchSettingsData;
  int? get maxAge => throw _privateConstructorErrorSearchSettingsData;
  SearchGroups? get searchGroups => throw _privateConstructorErrorSearchSettingsData;

  SearchSettingsData copyWith({
    UpdateState? updateState,
    int? minAge,
    int? maxAge,
    SearchGroups? searchGroups,
  }) => throw _privateConstructorErrorSearchSettingsData;
}

/// @nodoc
abstract class _SearchSettingsData extends SearchSettingsData {
  factory _SearchSettingsData({
    UpdateState updateState,
    int? minAge,
    int? maxAge,
    SearchGroups? searchGroups,
  }) = _$SearchSettingsDataImpl;
  _SearchSettingsData._() : super._();
}

/// @nodoc
class _$SearchSettingsDataImpl extends _SearchSettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  
  _$SearchSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.minAge,
    this.maxAge,
    this.searchGroups,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final int? minAge;
  @override
  final int? maxAge;
  @override
  final SearchGroups? searchGroups;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchSettingsData(updateState: $updateState, minAge: $minAge, maxAge: $maxAge, searchGroups: $searchGroups)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('minAge', minAge))
      ..add(DiagnosticsProperty('maxAge', maxAge))
      ..add(DiagnosticsProperty('searchGroups', searchGroups));
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
        (identical(other.searchGroups, searchGroups) ||
          other.searchGroups == searchGroups)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    minAge,
    maxAge,
    searchGroups,
  );

  @override
  SearchSettingsData copyWith({
    Object? updateState,
    Object? minAge = _detectDefaultValueInCopyWith,
    Object? maxAge = _detectDefaultValueInCopyWith,
    Object? searchGroups = _detectDefaultValueInCopyWith,
  }) => _$SearchSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    minAge: (minAge == _detectDefaultValueInCopyWith ? this.minAge : minAge) as int?,
    maxAge: (maxAge == _detectDefaultValueInCopyWith ? this.maxAge : maxAge) as int?,
    searchGroups: (searchGroups == _detectDefaultValueInCopyWith ? this.searchGroups : searchGroups) as SearchGroups?,
  );
}
