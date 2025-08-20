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
  final CropArea cropArea;

  /// 1.0 means square image, 0.0 means original aspect ratio
  final double squareFactor;
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;
  final ImageCacheSize cacheSize;
  final ImageProvider<Object> _imageProvider;
  ProfileThumbnailImage({
    required this.accountId,
    required this.contentId,
    this.cropArea = CropArea.full,
    this.width,
    this.height,
    this.child,
    this.squareFactor = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(PROFILE_PICTURE_BORDER_RADIUS)),
    required this.cacheSize,
    super.key,
  }) : _imageProvider = AccountImageProvider.create(
         accountId,
         contentId,
         cacheSize: cacheSize,
         media: LoginRepository.getInstance().repositories.media,
         cropArea: cropArea,
       );

  ProfileThumbnailImage.fromAccountImageId({
    required AccountImageId img,
    required CropArea cropArea,
    double? width,
    double? height,
    Widget? child,
    double squareFactor = 1.0,
    BorderRadius borderRadius = const BorderRadius.all(
      Radius.circular(PROFILE_PICTURE_BORDER_RADIUS),
    ),
    required ImageCacheSize cacheSize,
    Key? key,
  }) : this(
         accountId: img.accountId,
         contentId: img.contentId,
         width: width,
         height: height,
         child: child,
         squareFactor: squareFactor,
         borderRadius: borderRadius,
         cacheSize: cacheSize,
         key: key,
       );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          clipBehavior: Clip.hardEdge,
          child: Image(
            image: _imageProvider,
            frameBuilder: (context, image, frame, wasSynchronouslyLoaded) {
              final loadingReady = Center(
                child: Stack(alignment: AlignmentDirectional.center, children: [image, ?child]),
              );
              if (frame == null && wasSynchronouslyLoaded) {
                return loadingReady;
              } else if (frame == null) {
                return AnimatedOpacity(
                  opacity: 0,
                  duration: Duration(milliseconds: 200),
                  child: image,
                );
              } else {
                return AnimatedOpacity(
                  opacity: 1,
                  duration: Duration(milliseconds: 200),
                  child: loadingReady,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class CroppedImagePainter {
  final ui.Image img;
  final CropArea cropArea;
  final double squareFactor;
  CroppedImagePainter(this.img, this.cropArea, this.squareFactor);

  Rect calculateSrcRect() {
    final squareRect = _calculateSquareSrcRect(img, cropArea);
    final fullImgRect = Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble());

    final animatedSrc = RectTween(begin: fullImgRect, end: squareRect).lerp(squareFactor);
    final src = animatedSrc ?? fullImgRect;

    return src;
  }
}

Rect _calculateSquareSrcRect(ui.Image img, CropArea cropArea) {
  final imgSize = Size(img.width.toDouble(), img.height.toDouble());
  final areaWidth = imgSize.shortestSide * cropArea.gridCropSize;
  final xOffset = img.width.toDouble() * cropArea.gridCropX;
  final yOffset = img.height.toDouble() * cropArea.gridCropY;

  final src = Rect.fromLTWH(xOffset, yOffset, areaWidth, areaWidth);

  return src;
}
