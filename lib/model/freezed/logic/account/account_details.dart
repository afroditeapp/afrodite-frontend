import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/account_repository.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:pihka_frontend/utils.dart";

part 'account_details.freezed.dart';

@freezed
class AccountDetailsBlocData with _$AccountDetailsBlocData {
  factory AccountDetailsBlocData({
    String? email,
    String? birthdate,
  }) = _AccountDetailsBlocData;
}
