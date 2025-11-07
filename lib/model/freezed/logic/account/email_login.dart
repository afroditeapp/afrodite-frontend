import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'email_login.freezed.dart';

sealed class EmailLoginError {
  const EmailLoginError();
}

class RequestTokenFailed extends EmailLoginError {
  const RequestTokenFailed();
}

class LoginFailed extends EmailLoginError {
  final String error;
  const LoginFailed(this.error);
}

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
