import 'package:app/ui_utils/profile_thumbnail_image.dart';
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
      cropArea: null,
    ),
    width: width,
    height: height,
    alignment: alignment,
    frameBuilder: (context, image, frame, wasSynchronouslyLoaded) {
      if (frame == null && wasSynchronouslyLoaded) {
        return image;
      } else if (frame == null) {
        return AnimatedOpacity(opacity: 0, duration: IMAGE_FADE_IN, child: image);
      } else {
        return AnimatedOpacity(opacity: 1, duration: IMAGE_FADE_IN, child: image);
      }
    },
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
  required ImageCacheSize cacheSize,
}) {
  return Ink(
    width: width,
    height: height,
    child: accountImgWidget(
      accountId,
      contentId,
      isMatch: isMatch,
      width: width,
      height: height,
      alignment: alignment,
      cacheSize: cacheSize,
    ),
  );
}

int calculateCachedImageSize(BuildContext context, double size) {
  return (size * MediaQuery.devicePixelRatioOf(context)).round();
}
