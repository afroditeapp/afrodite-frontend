
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/login_repository.dart';

Widget bytesImgWidget(Uint8List imageBytes, {double? width, double? height, AlignmentGeometry alignment = Alignment.center}) {
  return Image.memory(
    imageBytes,
    width: width,
    height: height,
    alignment: alignment,
  );
}

Widget accountImgWidget(
  AccountId accountId,
  ContentId contentId,
  {
    bool isMatch = false,
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    ImageCacheSize cacheSize = ImageCacheSize.maxQuality,
  }
) {
  return Image(
    image: AccountImageProvider.create(
      accountId,
      contentId,
      isMatch: isMatch,
      sizeSetting: cacheSize,
      media: LoginRepository.getInstance().repositories.media,
    ),
    width: width,
    height: height,
    alignment: alignment
  );
}

/// Image with InkWell ink splash effect.
Widget accountImgWidgetInk(
  AccountId accountId,
  ContentId contentId,
  {
    bool isMatch = false,
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    BoxFit? fit,
  }
) {
  return Ink.image(
    image: AccountImageProvider.create(
      accountId,
      contentId,
      isMatch: isMatch,
      media: LoginRepository.getInstance().repositories.media,
    ),
    width: width,
    height: height,
    alignment: alignment,
    fit: fit,
  );
}
