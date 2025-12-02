// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_visibility.dart';

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
final _privateConstructorErrorProfileVisibilityData = UnsupportedError(
    'Private constructor ProfileVisibilityData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ProfileVisibilityData {
  UpdateState get updateState => throw _privateConstructorErrorProfileVisibilityData;
  ProfileVisibility get visiblity => throw _privateConstructorErrorProfileVisibilityData;
  ProfileVisibility? get editedVisibility => throw _privateConstructorErrorProfileVisibilityData;

  ProfileVisibilityData copyWith({
    UpdateState? updateState,
    ProfileVisibility? visiblity,
    ProfileVisibility? editedVisibility,
  }) => throw _privateConstructorErrorProfileVisibilityData;
}

/// @nodoc
abstract class _ProfileVisibilityData extends ProfileVisibilityData {
  factory _ProfileVisibilityData({
    UpdateState updateState,
    ProfileVisibility visiblity,
    ProfileVisibility? editedVisibility,
  }) = _$ProfileVisibilityDataImpl;
  _ProfileVisibilityData._() : super._();
}

/// @nodoc
class _$ProfileVisibilityDataImpl extends _ProfileVisibilityData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const ProfileVisibility _visiblityDefaultValue = ProfileVisibility.pendingPrivate;
  
  _$ProfileVisibilityDataImpl({
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
    return 'ProfileVisibilityData(updateState: $updateState, visiblity: $visiblity, editedVisibility: $editedVisibility)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileVisibilityData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('visiblity', visiblity))
      ..add(DiagnosticsProperty('editedVisibility', editedVisibility));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ProfileVisibilityDataImpl &&
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
  ProfileVisibilityData copyWith({
    Object? updateState,
    Object? visiblity,
    Object? editedVisibility = _detectDefaultValueInCopyWith,
  }) => _$ProfileVisibilityDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    visiblity: (visiblity ?? this.visiblity) as ProfileVisibility,
    editedVisibility: (editedVisibility == _detectDefaultValueInCopyWith ? this.editedVisibility : editedVisibility) as ProfileVisibility?,
  );
}
