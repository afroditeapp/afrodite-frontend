
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'sign_in_with.freezed.dart';

@freezed
class SignInWithData with _$SignInWithData {
  factory SignInWithData({
    @Default(false) bool showProgress,
  }) = _SignInWithData;
}
