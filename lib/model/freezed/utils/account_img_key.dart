import 'package:app/data/image_cache.dart';
import 'package:app/ui_utils/crop_image_screen.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'account_img_key.freezed.dart';

@freezed
class AccountImgKey with _$AccountImgKey {
  factory AccountImgKey({
    required AccountId accountId,
    required ContentId contentId,
    required ImageCacheSize cacheSize,
    required CropArea cropArea,
  }) = _AccountImgKey;
}
