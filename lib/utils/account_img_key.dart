import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'account_img_key.freezed.dart';

@freezed
class AccountImgKey with _$AccountImgKey {
  factory AccountImgKey({
    required AccountId accountId,
    required ContentId contentId,
  }) = _AccountImgKey;
}
