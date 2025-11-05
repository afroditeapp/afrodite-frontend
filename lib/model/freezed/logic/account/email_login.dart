import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'email_login.freezed.dart';

enum EmailLoginError { requestTokenFailed, unsupportedClient, loginFailed }

@freezed
class EmailLoginBlocData with _$EmailLoginBlocData, UpdateStateProvider {
  factory EmailLoginBlocData({
    @Default(false) bool isLoading,
    EmailLoginError? error,
    String? email,
    int? tokenValiditySeconds,
    int? resendWaitSeconds,
    @Default(UpdateIdle()) UpdateState updateState,
  }) = _EmailLoginBlocData;
}
