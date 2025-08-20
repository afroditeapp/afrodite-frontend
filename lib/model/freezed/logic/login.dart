import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'login.freezed.dart';

@freezed
class LoginBlocData with _$LoginBlocData {
  LoginBlocData._();
  factory LoginBlocData({@Default(false) bool logoutInProgress}) = _LoginBlocData;
}
