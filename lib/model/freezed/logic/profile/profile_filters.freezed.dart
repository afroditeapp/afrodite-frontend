// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_filters.dart';

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
final _privateConstructorErrorProfileFiltersData = UnsupportedError(
    'Private constructor ProfileFiltersData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ProfileFiltersData {
  UpdateState get updateState => throw _privateConstructorErrorProfileFiltersData;
  bool get showAdvancedFilters => throw _privateConstructorErrorProfileFiltersData;
  bool get showOnlyFavorites => throw _privateConstructorErrorProfileFiltersData;
  GetProfileFilters? get filters => throw _privateConstructorErrorProfileFiltersData;
  Map<int, ProfileAttributeFilterValueUpdate> get attributeIdAndAttributeFilterMap => throw _privateConstructorErrorProfileFiltersData;
  EditedFiltersData get edited => throw _privateConstructorErrorProfileFiltersData;

  ProfileFiltersData copyWith({
    UpdateState? updateState,
    bool? showAdvancedFilters,
    bool? showOnlyFavorites,
    GetProfileFilters? filters,
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndAttributeFilterMap,
    EditedFiltersData? edited,
  }) => throw _privateConstructorErrorProfileFiltersData;
}

/// @nodoc
abstract class _ProfileFiltersData extends ProfileFiltersData {
  factory _ProfileFiltersData({
    UpdateState updateState,
    bool showAdvancedFilters,
    bool showOnlyFavorites,
    GetProfileFilters? filters,
    Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndAttributeFilterMap,
    required EditedFiltersData edited,
  }) = _$ProfileFiltersDataImpl;
  const _ProfileFiltersData._() : super._();
}

/// @nodoc
class _$ProfileFiltersDataImpl extends _ProfileFiltersData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _showAdvancedFiltersDefaultValue = false;
  static const bool _showOnlyFavoritesDefaultValue = false;
  static const Map<int, ProfileAttributeFilterValueUpdate> _attributeIdAndAttributeFilterMapDefaultValue = {};
  
  _$ProfileFiltersDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.showAdvancedFilters = _showAdvancedFiltersDefaultValue,
    this.showOnlyFavorites = _showOnlyFavoritesDefaultValue,
    this.filters,
    this.attributeIdAndAttributeFilterMap = _attributeIdAndAttributeFilterMapDefaultValue,
    required this.edited,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final bool showAdvancedFilters;
  @override
  final bool showOnlyFavorites;
  @override
  final GetProfileFilters? filters;
  @override
  final Map<int, ProfileAttributeFilterValueUpdate> attributeIdAndAttributeFilterMap;
  @override
  final EditedFiltersData edited;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileFiltersData(updateState: $updateState, showAdvancedFilters: $showAdvancedFilters, showOnlyFavorites: $showOnlyFavorites, filters: $filters, attributeIdAndAttributeFilterMap: $attributeIdAndAttributeFilterMap, edited: $edited)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileFiltersData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('showAdvancedFilters', showAdvancedFilters))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites))
      ..add(DiagnosticsProperty('filters', filters))
      ..add(DiagnosticsProperty('attributeIdAndAttributeFilterMap', attributeIdAndAttributeFilterMap))
      ..add(DiagnosticsProperty('edited', edited));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ProfileFiltersDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.showAdvancedFilters, showAdvancedFilters) ||
          other.showAdvancedFilters == showAdvancedFilters) &&
        (identical(other.showOnlyFavorites, showOnlyFavorites) ||
          other.showOnlyFavorites == showOnlyFavorites) &&
        (identical(other.filters, filters) ||
          other.filters == filters) &&
        (identical(other.attributeIdAndAttributeFilterMap, attributeIdAndAttributeFilterMap) ||
          other.attributeIdAndAttributeFilterMap == attributeIdAndAttributeFilterMap) &&
        (identical(other.edited, edited) ||
          other.edited == edited)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    showAdvancedFilters,
    showOnlyFavorites,
    filters,
    attributeIdAndAttributeFilterMap,
    edited,
  );

  @override
  ProfileFiltersData copyWith({
    Object? updateState,
    Object? showAdvancedFilters,
    Object? showOnlyFavorites,
    Object? filters = _detectDefaultValueInCopyWith,
    Object? attributeIdAndAttributeFilterMap,
    Object? edited,
  }) => _$ProfileFiltersDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    showAdvancedFilters: (showAdvancedFilters ?? this.showAdvancedFilters) as bool,
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
    filters: (filters == _detectDefaultValueInCopyWith ? this.filters : filters) as GetProfileFilters?,
    attributeIdAndAttributeFilterMap: (attributeIdAndAttributeFilterMap ?? this.attributeIdAndAttributeFilterMap) as Map<int, ProfileAttributeFilterValueUpdate>,
    edited: (edited ?? this.edited) as EditedFiltersData,
  );
}

/// @nodoc
final _privateConstructorErrorEditedFiltersData = UnsupportedError(
    'Private constructor EditedFiltersData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditedFiltersData {
  Map<int, ProfileAttributeFilterValueUpdate>? get attributeIdAndAttributeFilterMap => throw _privateConstructorErrorEditedFiltersData;
  EditValue<LastSeenTimeFilter> get lastSeenTimeFilter => throw _privateConstructorErrorEditedFiltersData;
  EditValue<bool> get unlimitedLikesFilter => throw _privateConstructorErrorEditedFiltersData;
  EditValue<MinDistanceKm> get minDistanceKmFilter => throw _privateConstructorErrorEditedFiltersData;
  EditValue<MaxDistanceKm> get maxDistanceKmFilter => throw _privateConstructorErrorEditedFiltersData;
  EditValue<ProfileCreatedTimeFilter> get profileCreatedFilter => throw _privateConstructorErrorEditedFiltersData;
  EditValue<ProfileEditedTimeFilter> get profileEditedFilter => throw _privateConstructorErrorEditedFiltersData;
  EditValue<ProfileTextMinCharactersFilter> get profileTextMinCharactersFilter => throw _privateConstructorErrorEditedFiltersData;
  EditValue<ProfileTextMaxCharactersFilter> get profileTextMaxCharactersFilter => throw _privateConstructorErrorEditedFiltersData;
  bool? get randomProfileOrder => throw _privateConstructorErrorEditedFiltersData;

  EditedFiltersData copyWith({
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndAttributeFilterMap,
    EditValue<LastSeenTimeFilter>? lastSeenTimeFilter,
    EditValue<bool>? unlimitedLikesFilter,
    EditValue<MinDistanceKm>? minDistanceKmFilter,
    EditValue<MaxDistanceKm>? maxDistanceKmFilter,
    EditValue<ProfileCreatedTimeFilter>? profileCreatedFilter,
    EditValue<ProfileEditedTimeFilter>? profileEditedFilter,
    EditValue<ProfileTextMinCharactersFilter>? profileTextMinCharactersFilter,
    EditValue<ProfileTextMaxCharactersFilter>? profileTextMaxCharactersFilter,
    bool? randomProfileOrder,
  }) => throw _privateConstructorErrorEditedFiltersData;
}

/// @nodoc
abstract class _EditedFiltersData implements EditedFiltersData {
  factory _EditedFiltersData({
    Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndAttributeFilterMap,
    EditValue<LastSeenTimeFilter> lastSeenTimeFilter,
    EditValue<bool> unlimitedLikesFilter,
    EditValue<MinDistanceKm> minDistanceKmFilter,
    EditValue<MaxDistanceKm> maxDistanceKmFilter,
    EditValue<ProfileCreatedTimeFilter> profileCreatedFilter,
    EditValue<ProfileEditedTimeFilter> profileEditedFilter,
    EditValue<ProfileTextMinCharactersFilter> profileTextMinCharactersFilter,
    EditValue<ProfileTextMaxCharactersFilter> profileTextMaxCharactersFilter,
    bool? randomProfileOrder,
  }) = _$EditedFiltersDataImpl;
}

/// @nodoc
class _$EditedFiltersDataImpl with DiagnosticableTreeMixin implements _EditedFiltersData {
  static const EditValue<LastSeenTimeFilter> _lastSeenTimeFilterDefaultValue = NoEdit();
  static const EditValue<bool> _unlimitedLikesFilterDefaultValue = NoEdit();
  static const EditValue<MinDistanceKm> _minDistanceKmFilterDefaultValue = NoEdit();
  static const EditValue<MaxDistanceKm> _maxDistanceKmFilterDefaultValue = NoEdit();
  static const EditValue<ProfileCreatedTimeFilter> _profileCreatedFilterDefaultValue = NoEdit();
  static const EditValue<ProfileEditedTimeFilter> _profileEditedFilterDefaultValue = NoEdit();
  static const EditValue<ProfileTextMinCharactersFilter> _profileTextMinCharactersFilterDefaultValue = NoEdit();
  static const EditValue<ProfileTextMaxCharactersFilter> _profileTextMaxCharactersFilterDefaultValue = NoEdit();
  
  _$EditedFiltersDataImpl({
    this.attributeIdAndAttributeFilterMap,
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
  final Map<int, ProfileAttributeFilterValueUpdate>? attributeIdAndAttributeFilterMap;
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
    return 'EditedFiltersData(attributeIdAndAttributeFilterMap: $attributeIdAndAttributeFilterMap, lastSeenTimeFilter: $lastSeenTimeFilter, unlimitedLikesFilter: $unlimitedLikesFilter, minDistanceKmFilter: $minDistanceKmFilter, maxDistanceKmFilter: $maxDistanceKmFilter, profileCreatedFilter: $profileCreatedFilter, profileEditedFilter: $profileEditedFilter, profileTextMinCharactersFilter: $profileTextMinCharactersFilter, profileTextMaxCharactersFilter: $profileTextMaxCharactersFilter, randomProfileOrder: $randomProfileOrder)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditedFiltersData'))
      ..add(DiagnosticsProperty('attributeIdAndAttributeFilterMap', attributeIdAndAttributeFilterMap))
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
        other is _$EditedFiltersDataImpl &&
        (identical(other.attributeIdAndAttributeFilterMap, attributeIdAndAttributeFilterMap) ||
          other.attributeIdAndAttributeFilterMap == attributeIdAndAttributeFilterMap) &&
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
    attributeIdAndAttributeFilterMap,
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
  EditedFiltersData copyWith({
    Object? attributeIdAndAttributeFilterMap = _detectDefaultValueInCopyWith,
    Object? lastSeenTimeFilter,
    Object? unlimitedLikesFilter,
    Object? minDistanceKmFilter,
    Object? maxDistanceKmFilter,
    Object? profileCreatedFilter,
    Object? profileEditedFilter,
    Object? profileTextMinCharactersFilter,
    Object? profileTextMaxCharactersFilter,
    Object? randomProfileOrder = _detectDefaultValueInCopyWith,
  }) => _$EditedFiltersDataImpl(
    attributeIdAndAttributeFilterMap: (attributeIdAndAttributeFilterMap == _detectDefaultValueInCopyWith ? this.attributeIdAndAttributeFilterMap : attributeIdAndAttributeFilterMap) as Map<int, ProfileAttributeFilterValueUpdate>?,
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
