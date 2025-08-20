import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'account_details.freezed.dart';

@freezed
class AccountDetailsBlocData with _$AccountDetailsBlocData {
  factory AccountDetailsBlocData({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    String? email,
  }) = _AccountDetailsBlocData;
}
