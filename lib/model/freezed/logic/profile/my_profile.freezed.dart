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
  ProfileUpdateState get profileUpdateState => throw _privateConstructorErrorMyProfileData;
  ProfileEntry? get profile => throw _privateConstructorErrorMyProfileData;

  MyProfileData copyWith({
    ProfileUpdateState? profileUpdateState,
    ProfileEntry? profile,
  }) => throw _privateConstructorErrorMyProfileData;
}

/// @nodoc
abstract class _MyProfileData extends MyProfileData {
  factory _MyProfileData({
    ProfileUpdateState profileUpdateState,
    ProfileEntry? profile,
  }) = _$MyProfileDataImpl;
  _MyProfileData._() : super._();
}

/// @nodoc
class _$MyProfileDataImpl extends _MyProfileData with DiagnosticableTreeMixin {
  static const ProfileUpdateState _profileUpdateStateDefaultValue = ProfileUpdateIdle();
  
  _$MyProfileDataImpl({
    this.profileUpdateState = _profileUpdateStateDefaultValue,
    this.profile,
  }) : super._();

  @override
  final ProfileUpdateState profileUpdateState;
  @override
  final ProfileEntry? profile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyProfileData(profileUpdateState: $profileUpdateState, profile: $profile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyProfileData'))
      ..add(DiagnosticsProperty('profileUpdateState', profileUpdateState))
      ..add(DiagnosticsProperty('profile', profile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$MyProfileDataImpl &&
        (identical(other.profileUpdateState, profileUpdateState) ||
          other.profileUpdateState == profileUpdateState) &&
        (identical(other.profile, profile) ||
          other.profile == profile)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    profileUpdateState,
    profile,
  );

  @override
  MyProfileData copyWith({
    Object? profileUpdateState,
    Object? profile = _detectDefaultValueInCopyWith,
  }) => _$MyProfileDataImpl(
    profileUpdateState: (profileUpdateState ?? this.profileUpdateState) as ProfileUpdateState,
    profile: (profile == _detectDefaultValueInCopyWith ? this.profile : profile) as ProfileEntry?,
  );
}
