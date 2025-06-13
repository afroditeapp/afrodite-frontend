// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_settings.dart';

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
final _privateConstructorErrorPrivacySettingsData = UnsupportedError(
    'Private constructor PrivacySettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$PrivacySettingsData {
  UpdateState get updateState => throw _privateConstructorErrorPrivacySettingsData;
  ProfileVisibility get visiblity => throw _privateConstructorErrorPrivacySettingsData;
  ProfileVisibility? get editedVisibility => throw _privateConstructorErrorPrivacySettingsData;

  PrivacySettingsData copyWith({
    UpdateState? updateState,
    ProfileVisibility? visiblity,
    ProfileVisibility? editedVisibility,
  }) => throw _privateConstructorErrorPrivacySettingsData;
}

/// @nodoc
abstract class _PrivacySettingsData extends PrivacySettingsData {
  factory _PrivacySettingsData({
    UpdateState updateState,
    ProfileVisibility visiblity,
    ProfileVisibility? editedVisibility,
  }) = _$PrivacySettingsDataImpl;
  _PrivacySettingsData._() : super._();
}

/// @nodoc
class _$PrivacySettingsDataImpl extends _PrivacySettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const ProfileVisibility _visiblityDefaultValue = ProfileVisibility.pendingPrivate;
  
  _$PrivacySettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.visiblity = _visiblityDefaultValue,
    this.editedVisibility,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final ProfileVisibility visiblity;
  @override
  final ProfileVisibility? editedVisibility;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PrivacySettingsData(updateState: $updateState, visiblity: $visiblity, editedVisibility: $editedVisibility)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PrivacySettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('visiblity', visiblity))
      ..add(DiagnosticsProperty('editedVisibility', editedVisibility));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$PrivacySettingsDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.visiblity, visiblity) ||
          other.visiblity == visiblity) &&
        (identical(other.editedVisibility, editedVisibility) ||
          other.editedVisibility == editedVisibility)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    visiblity,
    editedVisibility,
  );

  @override
  PrivacySettingsData copyWith({
    Object? updateState,
    Object? visiblity,
    Object? editedVisibility = _detectDefaultValueInCopyWith,
  }) => _$PrivacySettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    visiblity: (visiblity ?? this.visiblity) as ProfileVisibility,
    editedVisibility: (editedVisibility == _detectDefaultValueInCopyWith ? this.editedVisibility : editedVisibility) as ProfileVisibility?,
  );
}
