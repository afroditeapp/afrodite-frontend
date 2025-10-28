import "package:database/database.dart";
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:app/utils/api.dart";

part 'account.freezed.dart';

@freezed
class AccountBlocData with _$AccountBlocData {
  AccountBlocData._();
  factory AccountBlocData({
    String? email,

    /// Set by default to true, so that profiles screen will not
    /// try to show email not verified UI.
    @Default(true) bool emailVerified,
    required AccountState? accountState,
    required Permissions permissions,
    required ProfileVisibility visibility,
  }) = _AccountBlocData;

  bool isInitialModerationOngoing() {
    return visibility.isInitialModerationOngoing();
  }
}
