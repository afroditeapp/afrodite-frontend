import 'package:database/database.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'my_profile.freezed.dart';

@freezed
class MyProfileData with _$MyProfileData {
  MyProfileData._();
  factory MyProfileData({
    @Default(ProfileUpdateIdle()) ProfileUpdateState profileUpdateState,
    ProfileEntry? profile,
  }) = _MyProfileData;
}

sealed class ProfileUpdateState {
  const ProfileUpdateState();
}
class ProfileUpdateIdle extends ProfileUpdateState {
  const ProfileUpdateIdle();
}
class ProfileUpdateStarted extends ProfileUpdateState {
  const ProfileUpdateStarted();
}
class ProfileUpdateInProgress extends ProfileUpdateState {
  const ProfileUpdateInProgress();
}
