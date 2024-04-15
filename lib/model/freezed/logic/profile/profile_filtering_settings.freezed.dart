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
  bool get showOnlyFavorites => throw _privateConstructorErrorProfileFilteringSettingsData;

  ProfileFilteringSettingsData copyWith({
    bool? showOnlyFavorites,
  }) => throw _privateConstructorErrorProfileFilteringSettingsData;
}

/// @nodoc
abstract class _ProfileFilteringSettingsData extends ProfileFilteringSettingsData {
  factory _ProfileFilteringSettingsData({
    bool showOnlyFavorites,
  }) = _$ProfileFilteringSettingsDataImpl;
  const _ProfileFilteringSettingsData._() : super._();
}

/// @nodoc
class _$ProfileFilteringSettingsDataImpl extends _ProfileFilteringSettingsData with DiagnosticableTreeMixin {
  static const bool _showOnlyFavoritesDefaultValue = false;
  
  _$ProfileFilteringSettingsDataImpl({
    this.showOnlyFavorites = _showOnlyFavoritesDefaultValue,
  }) : super._();

  @override
  final bool showOnlyFavorites;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileFilteringSettingsData(showOnlyFavorites: $showOnlyFavorites)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ProfileFilteringSettingsDataImpl &&
        (identical(other.showOnlyFavorites, showOnlyFavorites) ||
          other.showOnlyFavorites == showOnlyFavorites)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showOnlyFavorites,
  );

  @override
  ProfileFilteringSettingsData copyWith({
    Object? showOnlyFavorites,
  }) => _$ProfileFilteringSettingsDataImpl(
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
  );
}
