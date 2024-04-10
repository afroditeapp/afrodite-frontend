
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/logic/media/image_processing.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/ui_utils/consts/corners.dart';
import 'package:pihka_frontend/ui_utils/crop_image_screen.dart';
import 'package:pihka_frontend/utils/account_img_key.dart';


class ProfileThumbnailImage extends StatefulWidget {
  final AccountId accountId;
  final ContentId contentId;
  final CropResults cropResults;
  /// 1.0 means square image, 0.0 means original aspect ratio
  final double squareFactor;
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;
  const ProfileThumbnailImage({
    required this.accountId,
    required this.contentId,
    this.cropResults = CropResults.full,
    this.width,
    this.height,
    this.child,
    this.squareFactor = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(PROFILE_PICTURE_BORDER_RADIUS)),
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
    super.key,
  }) :
    accountId = img.accountId,
    contentId = img.contentId;

  ProfileThumbnailImage.fromProfileEntry({
    required ProfileEntry entry,
    this.width,
    this.height,
    this.child,
    this.squareFactor = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(PROFILE_PICTURE_BORDER_RADIUS)),
    super.key,
  }) :
    accountId = entry.uuid,
    contentId = entry.imageUuid,
    cropResults = CropResults.fromValues(
      entry.primaryContentGridCropSize,
      entry.primaryContentGridCropX,
      entry.primaryContentGridCropY,
    );

  @override
  State<ProfileThumbnailImage> createState() => _ProfileThumbnailImageState();
}

class _ProfileThumbnailImageState extends State<ProfileThumbnailImage> {

  ImageStream? imgStream;
  ImageStreamListener? imgListener;
  ImageInfo? info;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadImage();
  }

  @override
  void didUpdateWidget(ProfileThumbnailImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.accountId, widget.contentId) != (oldWidget.accountId, oldWidget.contentId)) {
      loadImage();
    }
  }

  void loadImage() {
    final k = AccountImgKey(accountId: widget.accountId, contentId: widget.contentId);
    final newStream = AccountImageProvider(k).resolve(createLocalImageConfiguration(context));
    if (newStream.key != imgStream?.key) {
      // Remove listener from old stream
      final currentListener = imgListener;
      if (currentListener != null) {
        imgStream?.removeListener(currentListener);
      }

      // Add listener to new stream
      final newListener = ImageStreamListener(imageListenerCallback);
      newStream.addListener(newListener);
      imgListener = newListener;
      imgStream = newStream;
    }
  }

  void imageListenerCallback(ImageInfo newInfo, bool synchronousCall) {
    setState(() {
      info?.dispose();
      info = newInfo;
    });
  }

  @override
  void dispose() {
    final listener = imgListener;
    if (listener != null) {
      imgStream?.removeListener(listener);
    }
    imgListener = null;
    imgStream = null;
    info?.dispose();
    info = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final img = info?.image;
    if (img != null) {
      final imgAspect = img.width.toDouble() / img.height.toDouble();
      final aspect = ui.lerpDouble(imgAspect, 1.0, widget.squareFactor) ?? imgAspect;
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: AspectRatio(
            aspectRatio: aspect,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
              ),
              clipBehavior: Clip.hardEdge,
              child: CustomPaint(
                painter: CroppedImagePainter(img, widget.cropResults, widget.squareFactor),
                child: widget.child,
              ),
            ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.center,
        child: Container(
          width: widget.width,
          height: widget.height,
          color: Colors.transparent,
        ),
      );
    }
  }
}

class CroppedImagePainter extends CustomPainter {
  final ui.Image img;
  final CropResults cropResults;
  final double squareFactor;
  CroppedImagePainter(this.img, this.cropResults, this.squareFactor);

  @override
  void paint(Canvas canvas, Size size) {
    final squareRect = calculateSquareSrcRect(img, cropResults);
    final fullImgRect = Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble());

    final animatedSrc = RectTween(begin: fullImgRect, end: squareRect).lerp(squareFactor);
    final src = animatedSrc ?? fullImgRect;

    final dst = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );
    canvas.drawImageRect(img, src, dst, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    final old = oldDelegate as CroppedImagePainter;
    return old.cropResults != cropResults || old.squareFactor != squareFactor;
  }
}

Rect calculateSquareSrcRect(ui.Image img, CropResults cropResults) {
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
