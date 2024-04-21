// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_filtering_settings.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorEditProfileFilteringSettingsData = UnsupportedError(
    'Private constructor EditProfileFilteringSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditProfileFilteringSettingsData {
  bool get showOnlyFavorites => throw _privateConstructorErrorEditProfileFilteringSettingsData;

  EditProfileFilteringSettingsData copyWith({
    bool? showOnlyFavorites,
  }) => throw _privateConstructorErrorEditProfileFilteringSettingsData;
}

/// @nodoc
abstract class _EditProfileFilteringSettingsData implements EditProfileFilteringSettingsData {
  factory _EditProfileFilteringSettingsData({
    bool showOnlyFavorites,
  }) = _$EditProfileFilteringSettingsDataImpl;
}

/// @nodoc
class _$EditProfileFilteringSettingsDataImpl with DiagnosticableTreeMixin implements _EditProfileFilteringSettingsData {
  static const bool _showOnlyFavoritesDefaultValue = false;
  
  _$EditProfileFilteringSettingsDataImpl({
    this.showOnlyFavorites = _showOnlyFavoritesDefaultValue,
  });

  @override
  final bool showOnlyFavorites;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditProfileFilteringSettingsData(showOnlyFavorites: $showOnlyFavorites)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditProfileFilteringSettingsData'))
      ..add(DiagnosticsProperty('showOnlyFavorites', showOnlyFavorites));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditProfileFilteringSettingsDataImpl &&
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
  EditProfileFilteringSettingsData copyWith({
    Object? showOnlyFavorites,
  }) => _$EditProfileFilteringSettingsDataImpl(
    showOnlyFavorites: (showOnlyFavorites ?? this.showOnlyFavorites) as bool,
  );
}
