import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

part 'account.freezed.dart';

@freezed
class AccountBlocData with _$AccountBlocData {
  factory AccountBlocData({
    AccountId? accountId,
    String? email,
    AccountState? accountState,
    required Capabilities capabilities,
    required ProfileVisibility visibility,
  }) = _AccountBlocData;
}
