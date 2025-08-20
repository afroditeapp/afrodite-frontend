import 'package:app/ui_utils/crop_image_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';

Widget bytesImgWidget(
  Uint8List imageBytes, {
  double? width,
  double? height,
  AlignmentGeometry alignment = Alignment.center,
}) {
  return Image.memory(imageBytes, width: width, height: height, alignment: alignment);
}

Widget accountImgWidget(
  AccountId accountId,
  ContentId contentId, {
  bool isMatch = false,
  double? width,
  double? height,
  AlignmentGeometry alignment = Alignment.center,
  required ImageCacheSize cacheSize,
}) {
  return Image(
    image: AccountImageProvider.create(
      accountId,
      contentId,
      isMatch: isMatch,
      cacheSize: cacheSize,
      media: LoginRepository.getInstance().repositories.media,
      cropArea: CropArea.full,
    ),
    width: width,
    height: height,
    alignment: alignment,
  );
}

/// Image with InkWell ink splash effect.
Widget accountImgWidgetInk(
  AccountId accountId,
  ContentId contentId, {
  bool isMatch = false,
  double? width,
  double? height,
  AlignmentGeometry alignment = Alignment.center,
  BoxFit? fit,
  required ImageCacheSize cacheSize,
}) {
  return Ink.image(
    image: AccountImageProvider.create(
      accountId,
      contentId,
      isMatch: isMatch,
      media: LoginRepository.getInstance().repositories.media,
      cacheSize: cacheSize,
      cropArea: CropArea.full,
    ),
    width: width,
    height: height,
    alignment: alignment,
    fit: fit,
  );
}

int calculateCachedImageSize(BuildContext context, double size) {
  return (size * MediaQuery.devicePixelRatioOf(context)).round();
}
