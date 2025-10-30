import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:app/ui_utils/common_update_logic.dart';

part 'account_details.freezed.dart';

@freezed
class AccountDetailsBlocData with _$AccountDetailsBlocData, UpdateStateProvider {
  factory AccountDetailsBlocData({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    String? email,
    @Default(UpdateIdle()) UpdateState updateState,
  }) = _AccountDetailsBlocData;
}
