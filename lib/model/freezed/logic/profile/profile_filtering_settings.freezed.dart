// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_filtering_settings.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorProfileFilteringSettingsData = UnsupportedError(
    'Private constructor ProfileFilteringSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ProfileFilteringSettingsData {
  UpdateState get updateState => throw _privateConstructorErrorProfileFilteringSettingsData;
  bool get showOnlyFavorites => throw _privateConstructorErrorProfileFilteringSettingsData;
  bool get showOnlyFavorites2 => throw _privateConstructorErrorProfileFilteringSettingsData;

  ProfileFilteringSettingsData copyWith({
    UpdateState? updateState,
    bool? showOnlyFavorites,
    bool? showOnlyFavorites2,
  }) => throw _privateConstructorErrorProfileFilteringSettingsData;
}

/// @nodoc
abstract class _ProfileFilteringSettingsData extends ProfileFilteringSettingsData {
  factory _ProfileFilteringSettingsData({
    UpdateState updateState,
    bool showOnlyFavorites,
    bool showOnlyFavorites2,
  }) = _$ProfileFilteringSettingsDataImpl;
  const _ProfileFilteringSettingsData._() : super._();
}

/// @nodoc
class _$ProfileFilteringSettingsDataImpl extends _ProfileFilteringSettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _showOnlyFavoritesDefaultValue = false;
  static const bool _showOnlyFavorites2DefaultValue = false;
  
  _$ProfileFilteringSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.showOnlyFavorites = _showOnlyFavoritesDefaultValue,
    this.showOnlyFavorites2 = _showOnlyFavorites2DefaultValue,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final bool showOnlyFavorites;
  @override
  final bool showOnlyFavorites2;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileFilteringSettingsData(updateState: $updateState, showOnlyFavorites: $showOnlyFavorites, showOnlyFavorites2: $showOnlyFavorites2)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites))
      ..add(DiagnosticsProperty('showOnlyFavorites2', showOnlyFavorites2));
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
        (identical(other.showOnlyFavorites2, showOnlyFavorites2) ||
          other.showOnlyFavorites2 == showOnlyFavorites2)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    showOnlyFavorites,
    showOnlyFavorites2,
  );

  @override
  ProfileFilteringSettingsData copyWith({
    Object? updateState,
    Object? showOnlyFavorites,
    Object? showOnlyFavorites2,
  }) => _$ProfileFilteringSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
    showOnlyFavorites2: (showOnlyFavorites2 ?? this.showOnlyFavorites2) as bool,
  );
}
