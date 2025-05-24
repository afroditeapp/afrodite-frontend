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
  Map<int, ProfileAttributeFilterValueUpdate> get attributeIdAndFilterValueMap => throw _privateConstructorErrorEditProfileFilteringSettingsData;
  LastSeenTimeFilter? get lastSeenTimeFilter => throw _privateConstructorErrorEditProfileFilteringSettingsData;
  bool? get unlimitedLikesFilter => throw _privateConstructorErrorEditProfileFilteringSettingsData;
  MaxDistanceKm? get maxDistanceKmFilter => throw _privateConstructorErrorEditProfileFilteringSettingsData;
  ProfileCreatedTimeFilter? get profileCreatedFilter => throw _privateConstructorErrorEditProfileFilteringSettingsData;
  ProfileEditedTimeFilter? get profileEditedFilter => throw _privateConstructorErrorEditProfileFilteringSettingsData;
  bool get randomProfileOrder => throw _privateConstructorErrorEditProfileFilteringSettingsData;

  EditProfileFilteringSettingsData copyWith({
    bool? showOnlyFavorites,
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndFilterValueMap,
    LastSeenTimeFilter? lastSeenTimeFilter,
    bool? unlimitedLikesFilter,
    MaxDistanceKm? maxDistanceKmFilter,
    ProfileCreatedTimeFilter? profileCreatedFilter,
    ProfileEditedTimeFilter? profileEditedFilter,
    bool? randomProfileOrder,
  }) => throw _privateConstructorErrorEditProfileFilteringSettingsData;
}

/// @nodoc
abstract class _EditProfileFilteringSettingsData implements EditProfileFilteringSettingsData {
  factory _EditProfileFilteringSettingsData({
    bool showOnlyFavorites,
    Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndFilterValueMap,
    LastSeenTimeFilter? lastSeenTimeFilter,
    bool? unlimitedLikesFilter,
    MaxDistanceKm? maxDistanceKmFilter,
    ProfileCreatedTimeFilter? profileCreatedFilter,
    ProfileEditedTimeFilter? profileEditedFilter,
    bool randomProfileOrder,
  }) = _$EditProfileFilteringSettingsDataImpl;
}

/// @nodoc
class _$EditProfileFilteringSettingsDataImpl with DiagnosticableTreeMixin implements _EditProfileFilteringSettingsData {
  static const bool _showOnlyFavoritesDefaultValue = false;
  static const Map<int, ProfileAttributeFilterValueUpdate> _attributeIdAndFilterValueMapDefaultValue = {};
  static const bool _randomProfileOrderDefaultValue = false;
  
  _$EditProfileFilteringSettingsDataImpl({
    this.showOnlyFavorites = _showOnlyFavoritesDefaultValue,
    this.attributeIdAndFilterValueMap = _attributeIdAndFilterValueMapDefaultValue,
    this.lastSeenTimeFilter,
    this.unlimitedLikesFilter,
    this.maxDistanceKmFilter,
    this.profileCreatedFilter,
    this.profileEditedFilter,
    this.randomProfileOrder = _randomProfileOrderDefaultValue,
  });

  @override
  final bool showOnlyFavorites;
  @override
  final Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndFilterValueMap;
  @override
  final LastSeenTimeFilter? lastSeenTimeFilter;
  @override
  final bool? unlimitedLikesFilter;
  @override
  final MaxDistanceKm? maxDistanceKmFilter;
  @override
  final ProfileCreatedTimeFilter? profileCreatedFilter;
  @override
  final ProfileEditedTimeFilter? profileEditedFilter;
  @override
  final bool randomProfileOrder;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditProfileFilteringSettingsData(showOnlyFavorites: $showOnlyFavorites, attributeIdAndFilterValueMap: $attributeIdAndFilterValueMap, lastSeenTimeFilter: $lastSeenTimeFilter, unlimitedLikesFilter: $unlimitedLikesFilter, maxDistanceKmFilter: $maxDistanceKmFilter, profileCreatedFilter: $profileCreatedFilter, profileEditedFilter: $profileEditedFilter, randomProfileOrder: $randomProfileOrder)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites))
      ..add(DiagnosticsProperty('attributeIdAndFilterValueMap', attributeIdAndFilterValueMap))
      ..add(DiagnosticsProperty('lastSeenTimeFilter', lastSeenTimeFilter))
      ..add(DiagnosticsProperty('unlimitedLikesFilter', unlimitedLikesFilter))
      ..add(DiagnosticsProperty('maxDistanceKmFilter', maxDistanceKmFilter))
      ..add(DiagnosticsProperty('profileCreatedFilter', profileCreatedFilter))
      ..add(DiagnosticsProperty('profileEditedFilter', profileEditedFilter))
      ..add(DiagnosticsProperty('randomProfileOrder', randomProfileOrder));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditProfileFilteringSettingsDataImpl &&
        (identical(other.showOnlyFavorites, showOnlyFavorites) ||
          other.showOnlyFavorites == showOnlyFavorites) &&
        (identical(other.attributeIdAndFilterValueMap, attributeIdAndFilterValueMap) ||
          other.attributeIdAndFilterValueMap == attributeIdAndFilterValueMap) &&
        (identical(other.lastSeenTimeFilter, lastSeenTimeFilter) ||
          other.lastSeenTimeFilter == lastSeenTimeFilter) &&
        (identical(other.unlimitedLikesFilter, unlimitedLikesFilter) ||
          other.unlimitedLikesFilter == unlimitedLikesFilter) &&
        (identical(other.maxDistanceKmFilter, maxDistanceKmFilter) ||
          other.maxDistanceKmFilter == maxDistanceKmFilter) &&
        (identical(other.profileCreatedFilter, profileCreatedFilter) ||
          other.profileCreatedFilter == profileCreatedFilter) &&
        (identical(other.profileEditedFilter, profileEditedFilter) ||
          other.profileEditedFilter == profileEditedFilter) &&
        (identical(other.randomProfileOrder, randomProfileOrder) ||
          other.randomProfileOrder == randomProfileOrder)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showOnlyFavorites,
    attributeIdAndFilterValueMap,
    lastSeenTimeFilter,
    unlimitedLikesFilter,
    maxDistanceKmFilter,
    profileCreatedFilter,
    profileEditedFilter,
    randomProfileOrder,
  );

  @override
  EditProfileFilteringSettingsData copyWith({
    Object? showOnlyFavorites,
    Object? attributeIdAndFilterValueMap,
    Object? lastSeenTimeFilter = _detectDefaultValueInCopyWith,
    Object? unlimitedLikesFilter = _detectDefaultValueInCopyWith,
    Object? maxDistanceKmFilter = _detectDefaultValueInCopyWith,
    Object? profileCreatedFilter = _detectDefaultValueInCopyWith,
    Object? profileEditedFilter = _detectDefaultValueInCopyWith,
    Object? randomProfileOrder,
  }) => _$EditProfileFilteringSettingsDataImpl(
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
    attributeIdAndFilterValueMap: (attributeIdAndFilterValueMap ?? this.attributeIdAndFilterValueMap) as Map<int, ProfileAttributeFilterValueUpdate>,
    lastSeenTimeFilter: (lastSeenTimeFilter == _detectDefaultValueInCopyWith ? this.lastSeenTimeFilter : lastSeenTimeFilter) as LastSeenTimeFilter?,
    unlimitedLikesFilter: (unlimitedLikesFilter == _detectDefaultValueInCopyWith ? this.unlimitedLikesFilter : unlimitedLikesFilter) as bool?,
    maxDistanceKmFilter: (maxDistanceKmFilter == _detectDefaultValueInCopyWith ? this.maxDistanceKmFilter : maxDistanceKmFilter) as MaxDistanceKm?,
    profileCreatedFilter: (profileCreatedFilter == _detectDefaultValueInCopyWith ? this.profileCreatedFilter : profileCreatedFilter) as ProfileCreatedTimeFilter?,
    profileEditedFilter: (profileEditedFilter == _detectDefaultValueInCopyWith ? this.profileEditedFilter : profileEditedFilter) as ProfileEditedTimeFilter?,
    randomProfileOrder: (randomProfileOrder ?? this.randomProfileOrder) as bool,
  );
}
