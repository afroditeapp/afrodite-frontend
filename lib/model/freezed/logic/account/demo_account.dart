import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:openapi/api.dart";

part 'demo_account.freezed.dart';

@freezed
class DemoAccountBlocData with _$DemoAccountBlocData {
  factory DemoAccountBlocData({
    String? userId,
    String? password,
    @Default(false) bool loginProgressVisible,
    @Default([]) List<AccessibleAccount> accounts,
  }) = _DemoAccountBlocData;
}
