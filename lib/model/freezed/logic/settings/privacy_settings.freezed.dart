// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_settings.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorPrivacySettingsData = UnsupportedError(
    'Private constructor PrivacySettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$PrivacySettingsData {
  UpdateState get updateState => throw _privateConstructorErrorPrivacySettingsData;
  ProfileVisibility get initialVisibility => throw _privateConstructorErrorPrivacySettingsData;
  ProfileVisibility get currentVisibility => throw _privateConstructorErrorPrivacySettingsData;

  PrivacySettingsData copyWith({
    UpdateState? updateState,
    ProfileVisibility? initialVisibility,
    ProfileVisibility? currentVisibility,
  }) => throw _privateConstructorErrorPrivacySettingsData;
}

/// @nodoc
abstract class _PrivacySettingsData extends PrivacySettingsData {
  factory _PrivacySettingsData({
    UpdateState updateState,
    ProfileVisibility initialVisibility,
    ProfileVisibility currentVisibility,
  }) = _$PrivacySettingsDataImpl;
  _PrivacySettingsData._() : super._();
}

/// @nodoc
class _$PrivacySettingsDataImpl extends _PrivacySettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const ProfileVisibility _initialVisibilityDefaultValue = ProfileVisibility.pendingPrivate;
  static const ProfileVisibility _currentVisibilityDefaultValue = ProfileVisibility.pendingPrivate;
  
  _$PrivacySettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.initialVisibility = _initialVisibilityDefaultValue,
    this.currentVisibility = _currentVisibilityDefaultValue,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final ProfileVisibility initialVisibility;
  @override
  final ProfileVisibility currentVisibility;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrivacySettingsData(updateState: $updateState, initialVisibility: $initialVisibility, currentVisibility: $currentVisibility)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrivacySettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('initialVisibility', initialVisibility))
      ..add(DiagnosticsProperty('currentVisibility', currentVisibility));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$PrivacySettingsDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.initialVisibility, initialVisibility) ||
          other.initialVisibility == initialVisibility) &&
        (identical(other.currentVisibility, currentVisibility) ||
          other.currentVisibility == currentVisibility)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    initialVisibility,
    currentVisibility,
  );

  @override
  PrivacySettingsData copyWith({
    Object? updateState,
    Object? initialVisibility,
    Object? currentVisibility,
  }) => _$PrivacySettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    initialVisibility: (initialVisibility ?? this.initialVisibility) as ProfileVisibility,
    currentVisibility: (currentVisibility ?? this.currentVisibility) as ProfileVisibility,
  );
}
