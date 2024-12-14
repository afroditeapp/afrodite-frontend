// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_filtering_settings.dart';

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
final _privateConstructorErrorProfileFilteringSettingsData = UnsupportedError(
    'Private constructor ProfileFilteringSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ProfileFilteringSettingsData {
  UpdateState get updateState => throw _privateConstructorErrorProfileFilteringSettingsData;
  bool get showOnlyFavorites => throw _privateConstructorErrorProfileFilteringSettingsData;
  GetProfileFilteringSettings? get filteringSettings => throw _privateConstructorErrorProfileFilteringSettingsData;

  ProfileFilteringSettingsData copyWith({
    UpdateState? updateState,
    bool? showOnlyFavorites,
    GetProfileFilteringSettings? filteringSettings,
  }) => throw _privateConstructorErrorProfileFilteringSettingsData;
}

/// @nodoc
abstract class _ProfileFilteringSettingsData extends ProfileFilteringSettingsData {
  factory _ProfileFilteringSettingsData({
    UpdateState updateState,
    bool showOnlyFavorites,
    GetProfileFilteringSettings? filteringSettings,
  }) = _$ProfileFilteringSettingsDataImpl;
  const _ProfileFilteringSettingsData._() : super._();
}

/// @nodoc
class _$ProfileFilteringSettingsDataImpl extends _ProfileFilteringSettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _showOnlyFavoritesDefaultValue = false;
  
  _$ProfileFilteringSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.showOnlyFavorites = _showOnlyFavoritesDefaultValue,
    this.filteringSettings,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final bool showOnlyFavorites;
  @override
  final GetProfileFilteringSettings? filteringSettings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileFilteringSettingsData(updateState: $updateState, showOnlyFavorites: $showOnlyFavorites, filteringSettings: $filteringSettings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites))
      ..add(DiagnosticsProperty('filteringSettings', filteringSettings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ProfileFilteringSettingsDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.showOnlyFavorites, showOnlyFavorites) ||
          other.showOnlyFavorites == showOnlyFavorites) &&
        (identical(other.filteringSettings, filteringSettings) ||
          other.filteringSettings == filteringSettings)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    showOnlyFavorites,
    filteringSettings,
  );

  @override
  ProfileFilteringSettingsData copyWith({
    Object? updateState,
    Object? showOnlyFavorites,
    Object? filteringSettings = _detectDefaultValueInCopyWith,
  }) => _$ProfileFilteringSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
    filteringSettings: (filteringSettings == _detectDefaultValueInCopyWith ? this.filteringSettings : filteringSettings) as GetProfileFilteringSettings?,
  );
}
