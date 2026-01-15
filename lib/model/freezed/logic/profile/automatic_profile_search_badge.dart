import 'package:database/database.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'automatic_profile_search_badge.freezed.dart';

@freezed
class AutomaticProfileSearchBadgeData with _$AutomaticProfileSearchBadgeData {
  const AutomaticProfileSearchBadgeData._();

  factory AutomaticProfileSearchBadgeData({
    @Default(AutomaticProfileSearchBadgeState.defaultValue)
    AutomaticProfileSearchBadgeState badgeState,
  }) = _AutomaticProfileSearchBadgeData;

  int profileCount() => badgeState.showBadge ? badgeState.profileCount : 0;
}
