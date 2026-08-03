import "package:app/ui_utils/common_update_logic.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'sign_in_with_management.freezed.dart';

@freezed
class SignInWithManagementBlocData with _$SignInWithManagementBlocData, UpdateStateProvider {
  factory SignInWithManagementBlocData({
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    @Default(false) bool apple,
    @Default(false) bool google,
    @Default(UpdateIdle()) UpdateState updateState,
  }) = _SignInWithManagementBlocData;
}
