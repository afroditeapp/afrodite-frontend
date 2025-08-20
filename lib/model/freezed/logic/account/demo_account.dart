import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:openapi/api.dart";
import "package:app/utils/immutable_list.dart";

part 'demo_account.freezed.dart';

@freezed
class DemoAccountBlocData with _$DemoAccountBlocData {
  factory DemoAccountBlocData({
    @Default(false) bool logoutInProgress,
    @Default(UnmodifiableList<AccessibleAccount>.empty())
    UnmodifiableList<AccessibleAccount> accounts,
  }) = _DemoAccountBlocData;
}
