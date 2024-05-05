// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile.dart';

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
final _privateConstructorErrorMyProfileData = UnsupportedError(
    'Private constructor MyProfileData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$MyProfileData {
  UpdateState get updateState => throw _privateConstructorErrorMyProfileData;
  ProfileEntry? get profile => throw _privateConstructorErrorMyProfileData;
  bool get loadingMyProfile => throw _privateConstructorErrorMyProfileData;

  MyProfileData copyWith({
    UpdateState? updateState,
    ProfileEntry? profile,
    bool? loadingMyProfile,
  }) => throw _privateConstructorErrorMyProfileData;
}

/// @nodoc
abstract class _MyProfileData extends MyProfileData {
  factory _MyProfileData({
    UpdateState updateState,
    ProfileEntry? profile,
    bool loadingMyProfile,
  }) = _$MyProfileDataImpl;
  _MyProfileData._() : super._();
}

/// @nodoc
class _$MyProfileDataImpl extends _MyProfileData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _loadingMyProfileDefaultValue = false;
  
  _$MyProfileDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.profile,
    this.loadingMyProfile = _loadingMyProfileDefaultValue,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final ProfileEntry? profile;
  @override
  final bool loadingMyProfile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyProfileData(updateState: $updateState, profile: $profile, loadingMyProfile: $loadingMyProfile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyProfileData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('profile', profile))
      ..add(DiagnosticsProperty('loadingMyProfile', loadingMyProfile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$MyProfileDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.profile, profile) ||
          other.profile == profile) &&
        (identical(other.loadingMyProfile, loadingMyProfile) ||
          other.loadingMyProfile == loadingMyProfile)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    profile,
    loadingMyProfile,
  );

  @override
  MyProfileData copyWith({
    Object? updateState,
    Object? profile = _detectDefaultValueInCopyWith,
    Object? loadingMyProfile,
  }) => _$MyProfileDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    profile: (profile == _detectDefaultValueInCopyWith ? this.profile : profile) as ProfileEntry?,
    loadingMyProfile: (loadingMyProfile ?? this.loadingMyProfile) as bool,
  );
}
