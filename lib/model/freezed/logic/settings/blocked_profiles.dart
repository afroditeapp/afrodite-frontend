import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'blocked_profiles.freezed.dart';

@freezed
class BlockedProfilesData with _$BlockedProfilesData {
  BlockedProfilesData._();
  factory BlockedProfilesData({@Default(false) bool unblockOngoing, AccountId? lastUnblocked}) =
      _BlockedProfilesData;
}
