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
  ProfileAttributeFilterList? get attributeFilters => throw _privateConstructorErrorProfileFilteringSettingsData;

  ProfileFilteringSettingsData copyWith({
    UpdateState? updateState,
    bool? showOnlyFavorites,
    ProfileAttributeFilterList? attributeFilters,
  }) => throw _privateConstructorErrorProfileFilteringSettingsData;
}

/// @nodoc
abstract class _ProfileFilteringSettingsData extends ProfileFilteringSettingsData {
  factory _ProfileFilteringSettingsData({
    UpdateState updateState,
    bool showOnlyFavorites,
    ProfileAttributeFilterList? attributeFilters,
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
    this.attributeFilters,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final bool showOnlyFavorites;
  @override
  final ProfileAttributeFilterList? attributeFilters;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileFilteringSettingsData(updateState: $updateState, showOnlyFavorites: $showOnlyFavorites, attributeFilters: $attributeFilters)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites))
      ..add(DiagnosticsProperty('attributeFilters', attributeFilters));
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
        (identical(other.attributeFilters, attributeFilters) ||
          other.attributeFilters == attributeFilters)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    showOnlyFavorites,
    attributeFilters,
  );

  @override
  ProfileFilteringSettingsData copyWith({
    Object? updateState,
    Object? showOnlyFavorites,
    Object? attributeFilters = _detectDefaultValueInCopyWith,
  }) => _$ProfileFilteringSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
    attributeFilters: (attributeFilters == _detectDefaultValueInCopyWith ? this.attributeFilters : attributeFilters) as ProfileAttributeFilterList?,
  );
}
