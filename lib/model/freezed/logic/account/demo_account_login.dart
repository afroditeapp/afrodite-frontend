import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'demo_account_login.freezed.dart';

@freezed
class DemoAccountLoginData with _$DemoAccountLoginData {
  factory DemoAccountLoginData({
    String? userId,
    String? password,
    @Default(false) bool loginProgressVisible,
  }) = _DemoAccountLoginData;
}
