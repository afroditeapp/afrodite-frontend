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
  Map<int, ProfileAttributeFilterValueUpdate> get attributeIdAndFilterValueMap => throw _privateConstructorErrorProfileFilteringSettingsData;
  EditedFilteringSettingsData get edited => throw _privateConstructorErrorProfileFilteringSettingsData;

  ProfileFilteringSettingsData copyWith({
    UpdateState? updateState,
    bool? showOnlyFavorites,
    GetProfileFilteringSettings? filteringSettings,
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndFilterValueMap,
    EditedFilteringSettingsData? edited,
  }) => throw _privateConstructorErrorProfileFilteringSettingsData;
}

/// @nodoc
abstract class _ProfileFilteringSettingsData extends ProfileFilteringSettingsData {
  factory _ProfileFilteringSettingsData({
    UpdateState updateState,
    bool showOnlyFavorites,
    GetProfileFilteringSettings? filteringSettings,
    Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndFilterValueMap,
    required EditedFilteringSettingsData edited,
  }) = _$ProfileFilteringSettingsDataImpl;
  const _ProfileFilteringSettingsData._() : super._();
}

/// @nodoc
class _$ProfileFilteringSettingsDataImpl extends _ProfileFilteringSettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _showOnlyFavoritesDefaultValue = false;
  static const Map<int, ProfileAttributeFilterValueUpdate> _attributeIdAndFilterValueMapDefaultValue = {};
  
  _$ProfileFilteringSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.showOnlyFavorites = _showOnlyFavoritesDefaultValue,
    this.filteringSettings,
    this.attributeIdAndFilterValueMap = _attributeIdAndFilterValueMapDefaultValue,
    required this.edited,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final bool showOnlyFavorites;
  @override
  final GetProfileFilteringSettings? filteringSettings;
  @override
  final Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndFilterValueMap;
  @override
  final EditedFilteringSettingsData edited;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileFilteringSettingsData(updateState: $updateState, showOnlyFavorites: $showOnlyFavorites, filteringSettings: $filteringSettings, attributeIdAndFilterValueMap: $attributeIdAndFilterValueMap, edited: $edited)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites))
      ..add(DiagnosticsProperty('filteringSettings', filteringSettings))
      ..add(DiagnosticsProperty('attributeIdAndFilterValueMap', attributeIdAndFilterValueMap))
      ..add(DiagnosticsProperty('edited', edited));
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
          other.filteringSettings == filteringSettings) &&
        (identical(other.attributeIdAndFilterValueMap, attributeIdAndFilterValueMap) ||
          other.attributeIdAndFilterValueMap == attributeIdAndFilterValueMap) &&
        (identical(other.edited, edited) ||
          other.edited == edited)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    showOnlyFavorites,
    filteringSettings,
    attributeIdAndFilterValueMap,
    edited,
  );

  @override
  ProfileFilteringSettingsData copyWith({
    Object? updateState,
    Object? showOnlyFavorites,
    Object? filteringSettings = _detectDefaultValueInCopyWith,
    Object? attributeIdAndFilterValueMap,
    Object? edited,
  }) => _$ProfileFilteringSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
    filteringSettings: (filteringSettings == _detectDefaultValueInCopyWith ? this.filteringSettings : filteringSettings) as GetProfileFilteringSettings?,
    attributeIdAndFilterValueMap: (attributeIdAndFilterValueMap ?? this.attributeIdAndFilterValueMap) as Map<int, ProfileAttributeFilterValueUpdate>,
    edited: (edited ?? this.edited) as EditedFilteringSettingsData,
  );
}

/// @nodoc
final _privateConstructorErrorEditedFilteringSettingsData = UnsupportedError(
    'Private constructor EditedFilteringSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditedFilteringSettingsData {
  bool? get showOnlyFavorites => throw _privateConstructorErrorEditedFilteringSettingsData;
  Map<int, ProfileAttributeFilterValueUpdate>? get attributeIdAndFilterValueMap => throw _privateConstructorErrorEditedFilteringSettingsData;
  EditValue<LastSeenTimeFilter> get lastSeenTimeFilter => throw _privateConstructorErrorEditedFilteringSettingsData;
  EditValue<bool> get unlimitedLikesFilter => throw _privateConstructorErrorEditedFilteringSettingsData;
  EditValue<MinDistanceKm> get minDistanceKmFilter => throw _privateConstructorErrorEditedFilteringSettingsData;
  EditValue<MaxDistanceKm> get maxDistanceKmFilter => throw _privateConstructorErrorEditedFilteringSettingsData;
  EditValue<ProfileCreatedTimeFilter> get profileCreatedFilter => throw _privateConstructorErrorEditedFilteringSettingsData;
  EditValue<ProfileEditedTimeFilter> get profileEditedFilter => throw _privateConstructorErrorEditedFilteringSettingsData;
  EditValue<ProfileTextMinCharactersFilter> get profileTextMinCharactersFilter => throw _privateConstructorErrorEditedFilteringSettingsData;
  EditValue<ProfileTextMaxCharactersFilter> get profileTextMaxCharactersFilter => throw _privateConstructorErrorEditedFilteringSettingsData;
  bool? get randomProfileOrder => throw _privateConstructorErrorEditedFilteringSettingsData;

  EditedFilteringSettingsData copyWith({
    bool? showOnlyFavorites,
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndFilterValueMap,
    EditValue<LastSeenTimeFilter>? lastSeenTimeFilter,
    EditValue<bool>? unlimitedLikesFilter,
    EditValue<MinDistanceKm>? minDistanceKmFilter,
    EditValue<MaxDistanceKm>? maxDistanceKmFilter,
    EditValue<ProfileCreatedTimeFilter>? profileCreatedFilter,
    EditValue<ProfileEditedTimeFilter>? profileEditedFilter,
    EditValue<ProfileTextMinCharactersFilter>? profileTextMinCharactersFilter,
    EditValue<ProfileTextMaxCharactersFilter>? profileTextMaxCharactersFilter,
    bool? randomProfileOrder,
  }) => throw _privateConstructorErrorEditedFilteringSettingsData;
}

/// @nodoc
abstract class _EditedFilteringSettingsData implements EditedFilteringSettingsData {
  factory _EditedFilteringSettingsData({
    bool? showOnlyFavorites,
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndFilterValueMap,
    EditValue<LastSeenTimeFilter> lastSeenTimeFilter,
    EditValue<bool> unlimitedLikesFilter,
    EditValue<MinDistanceKm> minDistanceKmFilter,
    EditValue<MaxDistanceKm> maxDistanceKmFilter,
    EditValue<ProfileCreatedTimeFilter> profileCreatedFilter,
    EditValue<ProfileEditedTimeFilter> profileEditedFilter,
    EditValue<ProfileTextMinCharactersFilter> profileTextMinCharactersFilter,
    EditValue<ProfileTextMaxCharactersFilter> profileTextMaxCharactersFilter,
    bool? randomProfileOrder,
  }) = _$EditedFilteringSettingsDataImpl;
}

/// @nodoc
class _$EditedFilteringSettingsDataImpl with DiagnosticableTreeMixin implements _EditedFilteringSettingsData {
  static const EditValue<LastSeenTimeFilter> _lastSeenTimeFilterDefaultValue = NoEdit();
  static const EditValue<bool> _unlimitedLikesFilterDefaultValue = NoEdit();
  static const EditValue<MinDistanceKm> _minDistanceKmFilterDefaultValue = NoEdit();
  static const EditValue<MaxDistanceKm> _maxDistanceKmFilterDefaultValue = NoEdit();
  static const EditValue<ProfileCreatedTimeFilter> _profileCreatedFilterDefaultValue = NoEdit();
  static const EditValue<ProfileEditedTimeFilter> _profileEditedFilterDefaultValue = NoEdit();
  static const EditValue<ProfileTextMinCharactersFilter> _profileTextMinCharactersFilterDefaultValue = NoEdit();
  static const EditValue<ProfileTextMaxCharactersFilter> _profileTextMaxCharactersFilterDefaultValue = NoEdit();
  
  _$EditedFilteringSettingsDataImpl({
    this.showOnlyFavorites,
    this.attributeIdAndFilterValueMap,
    this.lastSeenTimeFilter = _lastSeenTimeFilterDefaultValue,
    this.unlimitedLikesFilter = _unlimitedLikesFilterDefaultValue,
    this.minDistanceKmFilter = _minDistanceKmFilterDefaultValue,
    this.maxDistanceKmFilter = _maxDistanceKmFilterDefaultValue,
    this.profileCreatedFilter = _profileCreatedFilterDefaultValue,
    this.profileEditedFilter = _profileEditedFilterDefaultValue,
    this.profileTextMinCharactersFilter = _profileTextMinCharactersFilterDefaultValue,
    this.profileTextMaxCharactersFilter = _profileTextMaxCharactersFilterDefaultValue,
    this.randomProfileOrder,
  });

  @override
  final bool? showOnlyFavorites;
  @override
  final Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndFilterValueMap;
  @override
  final EditValue<LastSeenTimeFilter> lastSeenTimeFilter;
  @override
  final EditValue<bool> unlimitedLikesFilter;
  @override
  final EditValue<MinDistanceKm> minDistanceKmFilter;
  @override
  final EditValue<MaxDistanceKm> maxDistanceKmFilter;
  @override
  final EditValue<ProfileCreatedTimeFilter> profileCreatedFilter;
  @override
  final EditValue<ProfileEditedTimeFilter> profileEditedFilter;
  @override
  final EditValue<ProfileTextMinCharactersFilter> profileTextMinCharactersFilter;
  @override
  final EditValue<ProfileTextMaxCharactersFilter> profileTextMaxCharactersFilter;
  @override
  final bool? randomProfileOrder;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditedFilteringSettingsData(showOnlyFavorites: $showOnlyFavorites, attributeIdAndFilterValueMap: $attributeIdAndFilterValueMap, lastSeenTimeFilter: $lastSeenTimeFilter, unlimitedLikesFilter: $unlimitedLikesFilter, minDistanceKmFilter: $minDistanceKmFilter, maxDistanceKmFilter: $maxDistanceKmFilter, profileCreatedFilter: $profileCreatedFilter, profileEditedFilter: $profileEditedFilter, profileTextMinCharactersFilter: $profileTextMinCharactersFilter, profileTextMaxCharactersFilter: $profileTextMaxCharactersFilter, randomProfileOrder: $randomProfileOrder)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditedFilteringSettingsData'))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites))
      ..add(DiagnosticsProperty('attributeIdAndFilterValueMap', attributeIdAndFilterValueMap))
      ..add(DiagnosticsProperty('lastSeenTimeFilter', lastSeenTimeFilter))
      ..add(DiagnosticsProperty('unlimitedLikesFilter', unlimitedLikesFilter))
      ..add(DiagnosticsProperty('minDistanceKmFilter', minDistanceKmFilter))
      ..add(DiagnosticsProperty('maxDistanceKmFilter', maxDistanceKmFilter))
      ..add(DiagnosticsProperty('profileCreatedFilter', profileCreatedFilter))
      ..add(DiagnosticsProperty('profileEditedFilter', profileEditedFilter))
      ..add(DiagnosticsProperty('profileTextMinCharactersFilter', profileTextMinCharactersFilter))
      ..add(DiagnosticsProperty('profileTextMaxCharactersFilter', profileTextMaxCharactersFilter))
      ..add(DiagnosticsProperty('randomProfileOrder', randomProfileOrder));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditedFilteringSettingsDataImpl &&
        (identical(other.showOnlyFavorites, showOnlyFavorites) ||
          other.showOnlyFavorites == showOnlyFavorites) &&
        (identical(other.attributeIdAndFilterValueMap, attributeIdAndFilterValueMap) ||
          other.attributeIdAndFilterValueMap == attributeIdAndFilterValueMap) &&
        (identical(other.lastSeenTimeFilter, lastSeenTimeFilter) ||
          other.lastSeenTimeFilter == lastSeenTimeFilter) &&
        (identical(other.unlimitedLikesFilter, unlimitedLikesFilter) ||
          other.unlimitedLikesFilter == unlimitedLikesFilter) &&
        (identical(other.minDistanceKmFilter, minDistanceKmFilter) ||
          other.minDistanceKmFilter == minDistanceKmFilter) &&
        (identical(other.maxDistanceKmFilter, maxDistanceKmFilter) ||
          other.maxDistanceKmFilter == maxDistanceKmFilter) &&
        (identical(other.profileCreatedFilter, profileCreatedFilter) ||
          other.profileCreatedFilter == profileCreatedFilter) &&
        (identical(other.profileEditedFilter, profileEditedFilter) ||
          other.profileEditedFilter == profileEditedFilter) &&
        (identical(other.profileTextMinCharactersFilter, profileTextMinCharactersFilter) ||
          other.profileTextMinCharactersFilter == profileTextMinCharactersFilter) &&
        (identical(other.profileTextMaxCharactersFilter, profileTextMaxCharactersFilter) ||
          other.profileTextMaxCharactersFilter == profileTextMaxCharactersFilter) &&
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
    minDistanceKmFilter,
    maxDistanceKmFilter,
    profileCreatedFilter,
    profileEditedFilter,
    profileTextMinCharactersFilter,
    profileTextMaxCharactersFilter,
    randomProfileOrder,
  );

  @override
  EditedFilteringSettingsData copyWith({
    Object? showOnlyFavorites = _detectDefaultValueInCopyWith,
    Object? attributeIdAndFilterValueMap = _detectDefaultValueInCopyWith,
    Object? lastSeenTimeFilter,
    Object? unlimitedLikesFilter,
    Object? minDistanceKmFilter,
    Object? maxDistanceKmFilter,
    Object? profileCreatedFilter,
    Object? profileEditedFilter,
    Object? profileTextMinCharactersFilter,
    Object? profileTextMaxCharactersFilter,
    Object? randomProfileOrder = _detectDefaultValueInCopyWith,
  }) => _$EditedFilteringSettingsDataImpl(
    showOnlyFavorites: (showOnlyFavorites == _detectDefaultValueInCopyWith ? this.showOnlyFavorites : showOnlyFavorites) as bool?,
    attributeIdAndFilterValueMap: (attributeIdAndFilterValueMap == _detectDefaultValueInCopyWith ? this.attributeIdAndFilterValueMap : attributeIdAndFilterValueMap) as Map<int, ProfileAttributeFilterValueUpdate>?,
    lastSeenTimeFilter: (lastSeenTimeFilter ?? this.lastSeenTimeFilter) as EditValue<LastSeenTimeFilter>,
    unlimitedLikesFilter: (unlimitedLikesFilter ?? this.unlimitedLikesFilter) as EditValue<bool>,
    minDistanceKmFilter: (minDistanceKmFilter ?? this.minDistanceKmFilter) as EditValue<MinDistanceKm>,
    maxDistanceKmFilter: (maxDistanceKmFilter ?? this.maxDistanceKmFilter) as EditValue<MaxDistanceKm>,
    profileCreatedFilter: (profileCreatedFilter ?? this.profileCreatedFilter) as EditValue<ProfileCreatedTimeFilter>,
    profileEditedFilter: (profileEditedFilter ?? this.profileEditedFilter) as EditValue<ProfileEditedTimeFilter>,
    profileTextMinCharactersFilter: (profileTextMinCharactersFilter ?? this.profileTextMinCharactersFilter) as EditValue<ProfileTextMinCharactersFilter>,
    profileTextMaxCharactersFilter: (profileTextMaxCharactersFilter ?? this.profileTextMaxCharactersFilter) as EditValue<ProfileTextMaxCharactersFilter>,
    randomProfileOrder: (randomProfileOrder == _detectDefaultValueInCopyWith ? this.randomProfileOrder : randomProfileOrder) as bool?,
  );
}
