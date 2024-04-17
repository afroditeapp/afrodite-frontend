import "package:openapi/api.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'account.freezed.dart';

@freezed
class AccountBlocData with _$AccountBlocData {
  AccountBlocData._();
  factory AccountBlocData({
    AccountId? accountId,
    String? email,
    AccountState? accountState,
    required Capabilities capabilities,
    required ProfileVisibility visibility,
  }) = _AccountBlocData;

  bool isInitialModerationOngoing() {
    return visibility == ProfileVisibility.pendingPrivate ||
      visibility == ProfileVisibility.pendingPublic;
  }
}
