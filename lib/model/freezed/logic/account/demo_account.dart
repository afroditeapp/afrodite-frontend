import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";

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
