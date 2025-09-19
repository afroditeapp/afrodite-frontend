import 'package:app/data/utils/repository_instances.dart';
import 'package:app/ui_utils/profile_thumbnail_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';

Widget bytesImgWidget(
  Uint8List imageBytes, {
  double? width,
  double? height,
  required ImageCacheSize cacheSize,
  AlignmentGeometry alignment = Alignment.center,
}) {
  return Image.memory(
    imageBytes,
    width: width,
    height: height,
    alignment: alignment,
    // Don't specify cacheWidth so that image aspect ratio
    // doesn't change (at least on web).
    cacheHeight: cacheSize.height,
  );
}

Widget accountImgWidget(
  BuildContext context,
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
      media: context.read<RepositoryInstances>().media,
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
  BuildContext context,
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
      context,
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
