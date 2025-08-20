import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'blocked_profiles.freezed.dart';

@freezed
class BlockedProfilesData with _$BlockedProfilesData {
  BlockedProfilesData._();
  factory BlockedProfilesData({@Default(false) bool unblockOngoing}) = _BlockedProfilesData;
}
