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
  bool get showNonAcceptedProfileNames => throw _privateConstructorErrorUiSettingsData;
  GridSettings get gridSettings => throw _privateConstructorErrorUiSettingsData;

  UiSettingsData copyWith({
    bool? showNonAcceptedProfileNames,
    GridSettings? gridSettings,
  }) => throw _privateConstructorErrorUiSettingsData;
}

/// @nodoc
abstract class _UiSettingsData extends UiSettingsData {
  factory _UiSettingsData({
    bool showNonAcceptedProfileNames,
    GridSettings gridSettings,
  }) = _$UiSettingsDataImpl;
  _UiSettingsData._() : super._();
}

/// @nodoc
class _$UiSettingsDataImpl extends _UiSettingsData with DiagnosticableTreeMixin {
  static const bool _showNonAcceptedProfileNamesDefaultValue = false;
  static const GridSettings _gridSettingsDefaultValue = GridSettings();
  
  _$UiSettingsDataImpl({
    this.showNonAcceptedProfileNames = _showNonAcceptedProfileNamesDefaultValue,
    this.gridSettings = _gridSettingsDefaultValue,
  }) : super._();

  @override
  final bool showNonAcceptedProfileNames;
  @override
  final GridSettings gridSettings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UiSettingsData(showNonAcceptedProfileNames: $showNonAcceptedProfileNames, gridSettings: $gridSettings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UiSettingsData'))
      ..add(DiagnosticsProperty('showNonAcceptedProfileNames', showNonAcceptedProfileNames))
      ..add(DiagnosticsProperty('gridSettings', gridSettings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$UiSettingsDataImpl &&
        (identical(other.showNonAcceptedProfileNames, showNonAcceptedProfileNames) ||
          other.showNonAcceptedProfileNames == showNonAcceptedProfileNames) &&
        (identical(other.gridSettings, gridSettings) ||
          other.gridSettings == gridSettings)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showNonAcceptedProfileNames,
    gridSettings,
  );

  @override
  UiSettingsData copyWith({
    Object? showNonAcceptedProfileNames,
    Object? gridSettings,
  }) => _$UiSettingsDataImpl(
    showNonAcceptedProfileNames: (showNonAcceptedProfileNames ?? this.showNonAcceptedProfileNames) as bool,
    gridSettings: (gridSettings ?? this.gridSettings) as GridSettings,
  );
}
