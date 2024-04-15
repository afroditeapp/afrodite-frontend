import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:openapi/api.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

part 'demo_account.freezed.dart';

@freezed
class DemoAccountBlocData with _$DemoAccountBlocData {
  factory DemoAccountBlocData({
    String? userId,
    String? password,
    @Default(false) bool loginProgressVisible,
    @Default(UnmodifiableList<AccessibleAccount>.empty()) UnmodifiableList<AccessibleAccount> accounts,
  }) = _DemoAccountBlocData;
}
