
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/model/freezed/logic/media/profile_pictures.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/crop_image_screen.dart';

class ProfileThumbnailImage extends StatelessWidget {
  final AccountId accountId;
  final ContentId contentId;
  final CropResults cropResults;
  /// 1.0 means square image, 0.0 means original aspect ratio
  final double squareFactor;
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;
  final ImageCacheSize cacheSize;
  const ProfileThumbnailImage({
    required this.accountId,
    required this.contentId,
    this.cropResults = CropResults.full,
    this.width,
    this.height,
    this.child,
    this.squareFactor = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(PROFILE_PICTURE_BORDER_RADIUS)),
    required this.cacheSize,
    super.key,
  });

  ProfileThumbnailImage.fromAccountImageId({
    required AccountImageId img,
    required this.cropResults,
    this.width,
    this.height,
    this.child,
    this.squareFactor = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(PROFILE_PICTURE_BORDER_RADIUS)),
    required this.cacheSize,
    super.key,
  }) :
    accountId = img.accountId,
    contentId = img.contentId;

  @override
  Widget build(BuildContext context) {
    final imageProvider = AccountImageProvider.create(
      accountId,
      contentId,
      cacheSize: cacheSize,
      media: LoginRepository.getInstance().repositories.media,
      cropArea: cropResults,
    );
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image(image: imageProvider),
              ?child,
            ],
          )
        ),
      ),
    );
  }
}

class CroppedImagePainter {
  final ui.Image img;
  final CropResults cropResults;
  final double squareFactor;
  CroppedImagePainter(
    this.img,
    this.cropResults,
    this.squareFactor,
  );

  Rect calculateSrcRect() {
    final squareRect = _calculateSquareSrcRect(img, cropResults);
    final fullImgRect = Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble());

    final animatedSrc = RectTween(begin: fullImgRect, end: squareRect).lerp(squareFactor);
    final src = animatedSrc ?? fullImgRect;

    return src;
  }
}

Rect _calculateSquareSrcRect(ui.Image img, CropResults cropResults) {
  final imgSize = Size(img.width.toDouble(), img.height.toDouble());
  final areaWidth = imgSize.shortestSide * cropResults.gridCropSize;
  final xOffset = img.width.toDouble() * cropResults.gridCropX;
  final yOffset = img.height.toDouble() * cropResults.gridCropY;

  final src = Rect.fromLTWH(
    xOffset,
    yOffset,
    areaWidth,
    areaWidth,
  );

  return src;
}

// TODO(quality): Images are too high resolution for cacheing as cache has decoded
// data. Cache needs smaller img data if the image is small on UI.
// Perhaps use full HD max width 1920 as max dimension for image and scale
// that down depending on UI img size. The small profile img on top left
// corner could be 4x downscaled and perhaps 2x or 3x for profile img
// thumbnails. The profile view could display the original img size?
// Perhaps the downscaling could be controlled from settings at least for
// thumbnails.

/*

  @override
  void initState() {
    debugInvertOversizedImages = true;
    cacheDebug();
  }

  void cacheDebug() async {
    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));
      final c = imageCache;
      log.fine("max: ${c.maximumSize}, current: ${c.currentSize}, live: ${c.liveImageCount}, pending: ${c.pendingImageCount}");
    }
  }

  final newStream = ResizeImage(AccountImageProvider(k), width: 64, policy: ResizeImagePolicy.fit).resolve(createLocalImageConfiguration(context));
*/
