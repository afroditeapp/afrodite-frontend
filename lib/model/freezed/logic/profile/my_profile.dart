import 'package:database/database.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';

part 'my_profile.freezed.dart';

@freezed
class MyProfileData with _$MyProfileData, UpdateStateProvider {
  MyProfileData._();
  factory MyProfileData({
    @Default(UpdateIdle()) UpdateState updateState,
    ProfileEntry? profile,
  }) = _MyProfileData;
}
