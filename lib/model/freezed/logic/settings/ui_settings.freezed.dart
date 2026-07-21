// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_settings.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorUiSettingsData = UnsupportedError(
    'Private constructor UiSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$UiSettingsData {
  GridSettings get gridSettings => throw _privateConstructorErrorUiSettingsData;
  UserPreferredContentQuality get userPreferredContentQuality => throw _privateConstructorErrorUiSettingsData;

  UiSettingsData copyWith({
    GridSettings? gridSettings,
    UserPreferredContentQuality? userPreferredContentQuality,
  }) => throw _privateConstructorErrorUiSettingsData;
}

/// @nodoc
abstract class _UiSettingsData extends UiSettingsData {
  factory _UiSettingsData({
    GridSettings gridSettings,
    UserPreferredContentQuality userPreferredContentQuality,
  }) = _$UiSettingsDataImpl;
  _UiSettingsData._() : super._();
}

/// @nodoc
class _$UiSettingsDataImpl extends _UiSettingsData with DiagnosticableTreeMixin {
  static const GridSettings _gridSettingsDefaultValue = GridSettings();
  static const UserPreferredContentQuality _userPreferredContentQualityDefaultValue = UserPreferredContentQuality();

  _$UiSettingsDataImpl({
    this.gridSettings = _gridSettingsDefaultValue,
    this.userPreferredContentQuality = _userPreferredContentQualityDefaultValue,
  }) : super._();

  @override
  final GridSettings gridSettings;
  @override
  final UserPreferredContentQuality userPreferredContentQuality;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UiSettingsData(gridSettings: $gridSettings, userPreferredContentQuality: $userPreferredContentQuality)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UiSettingsData'))
      ..add(DiagnosticsProperty('gridSettings', gridSettings))
      ..add(DiagnosticsProperty('userPreferredContentQuality', userPreferredContentQuality));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$UiSettingsDataImpl &&
        (identical(other.gridSettings, gridSettings) ||
          other.gridSettings == gridSettings) &&
        (identical(other.userPreferredContentQuality, userPreferredContentQuality) ||
          other.userPreferredContentQuality == userPreferredContentQuality)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    gridSettings,
    userPreferredContentQuality,
  );

  @override
  UiSettingsData copyWith({
    Object? gridSettings,
    Object? userPreferredContentQuality,
  }) => _$UiSettingsDataImpl(
    gridSettings: (gridSettings ?? this.gridSettings) as GridSettings,
    userPreferredContentQuality: (userPreferredContentQuality ?? this.userPreferredContentQuality) as UserPreferredContentQuality,
  );
}
