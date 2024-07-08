// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_filtering_settings.dart';

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
final _privateConstructorErrorEditProfileFilteringSettingsData = UnsupportedError(
    'Private constructor EditProfileFilteringSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditProfileFilteringSettingsData {
  bool get showOnlyFavorites => throw _privateConstructorErrorEditProfileFilteringSettingsData;
  UnmodifiableList<ProfileAttributeFilterValueUpdate> get attributeFilters => throw _privateConstructorErrorEditProfileFilteringSettingsData;
  LastSeenTimeFilter? get lastSeenTimeFilter => throw _privateConstructorErrorEditProfileFilteringSettingsData;

  EditProfileFilteringSettingsData copyWith({
    bool? showOnlyFavorites,
    UnmodifiableList<ProfileAttributeFilterValueUpdate>? attributeFilters,
    LastSeenTimeFilter? lastSeenTimeFilter,
  }) => throw _privateConstructorErrorEditProfileFilteringSettingsData;
}

/// @nodoc
abstract class _EditProfileFilteringSettingsData implements EditProfileFilteringSettingsData {
  factory _EditProfileFilteringSettingsData({
    bool showOnlyFavorites,
    UnmodifiableList<ProfileAttributeFilterValueUpdate> attributeFilters,
    LastSeenTimeFilter? lastSeenTimeFilter,
  }) = _$EditProfileFilteringSettingsDataImpl;
}

/// @nodoc
class _$EditProfileFilteringSettingsDataImpl with DiagnosticableTreeMixin implements _EditProfileFilteringSettingsData {
  static const bool _showOnlyFavoritesDefaultValue = false;
  static const UnmodifiableList<ProfileAttributeFilterValueUpdate> _attributeFiltersDefaultValue = UnmodifiableList<ProfileAttributeFilterValueUpdate>.empty();
  
  _$EditProfileFilteringSettingsDataImpl({
    this.showOnlyFavorites = _showOnlyFavoritesDefaultValue,
    this.attributeFilters = _attributeFiltersDefaultValue,
    this.lastSeenTimeFilter,
  });

  @override
  final bool showOnlyFavorites;
  @override
  final UnmodifiableList<ProfileAttributeFilterValueUpdate> attributeFilters;
  @override
  final LastSeenTimeFilter? lastSeenTimeFilter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditProfileFilteringSettingsData(showOnlyFavorites: $showOnlyFavorites, attributeFilters: $attributeFilters, lastSeenTimeFilter: $lastSeenTimeFilter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites))
      ..add(DiagnosticsProperty('attributeFilters', attributeFilters))
      ..add(DiagnosticsProperty('lastSeenTimeFilter', lastSeenTimeFilter));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditProfileFilteringSettingsDataImpl &&
        (identical(other.showOnlyFavorites, showOnlyFavorites) ||
          other.showOnlyFavorites == showOnlyFavorites) &&
        (identical(other.attributeFilters, attributeFilters) ||
          other.attributeFilters == attributeFilters) &&
        (identical(other.lastSeenTimeFilter, lastSeenTimeFilter) ||
          other.lastSeenTimeFilter == lastSeenTimeFilter)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showOnlyFavorites,
    attributeFilters,
    lastSeenTimeFilter,
  );

  @override
  EditProfileFilteringSettingsData copyWith({
    Object? showOnlyFavorites,
    Object? attributeFilters,
    Object? lastSeenTimeFilter = _detectDefaultValueInCopyWith,
  }) => _$EditProfileFilteringSettingsDataImpl(
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
    attributeFilters: (attributeFilters ?? this.attributeFilters) as UnmodifiableList<ProfileAttributeFilterValueUpdate>,
    lastSeenTimeFilter: (lastSeenTimeFilter == _detectDefaultValueInCopyWith ? this.lastSeenTimeFilter : lastSeenTimeFilter) as LastSeenTimeFilter?,
  );
}
