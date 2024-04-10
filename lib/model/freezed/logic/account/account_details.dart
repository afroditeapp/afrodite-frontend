

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'account_details.freezed.dart';

@freezed
class AccountDetailsBlocData with _$AccountDetailsBlocData {
  factory AccountDetailsBlocData({
    String? email,
    String? birthdate,
  }) = _AccountDetailsBlocData;
}
