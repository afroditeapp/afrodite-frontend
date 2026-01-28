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

  UiSettingsData copyWith({
    GridSettings? gridSettings,
  }) => throw _privateConstructorErrorUiSettingsData;
}

/// @nodoc
abstract class _UiSettingsData extends UiSettingsData {
  factory _UiSettingsData({
    GridSettings gridSettings,
  }) = _$UiSettingsDataImpl;
  _UiSettingsData._() : super._();
}

/// @nodoc
class _$UiSettingsDataImpl extends _UiSettingsData with DiagnosticableTreeMixin {
  static const GridSettings _gridSettingsDefaultValue = GridSettings();

  _$UiSettingsDataImpl({
    this.gridSettings = _gridSettingsDefaultValue,
  }) : super._();

  @override
  final GridSettings gridSettings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UiSettingsData(gridSettings: $gridSettings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UiSettingsData'))
      ..add(DiagnosticsProperty('gridSettings', gridSettings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$UiSettingsDataImpl &&
        (identical(other.gridSettings, gridSettings) ||
          other.gridSettings == gridSettings)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    gridSettings,
  );

  @override
  UiSettingsData copyWith({
    Object? gridSettings,
  }) => _$UiSettingsDataImpl(
    gridSettings: (gridSettings ?? this.gridSettings) as GridSettings,
  );
}
