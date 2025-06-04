
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/model/freezed/logic/media/profile_pictures.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/crop_image_screen.dart';

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
    this.cacheSize = ImageCacheSize.maxQuality,
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
    this.cacheSize = ImageCacheSize.maxQuality,
    super.key,
  }) :
    accountId = img.accountId,
    contentId = img.contentId;

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
    final newStream = AccountImageProvider.create(
      widget.accountId,
      widget.contentId,
      sizeSetting: widget.cacheSize,
      media: LoginRepository.getInstance().repositories.media,
    )
      .resolve(createLocalImageConfiguration(context));
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
                painter: CroppedImagePainter(
                  widget.accountId,
                  widget.contentId,
                  img,
                  widget.cropResults,
                  widget.squareFactor,
                ),
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
  // AccountId and ContentId are needed here to make sure
  // that repaint happens when a ProfileThumbnailImage is replaced
  // with another ProfileThumbnailImage.
  final AccountId accountId;
  final ContentId contentId;
  final ui.Image img;
  final CropResults cropResults;
  final double squareFactor;
  CroppedImagePainter(
    this.accountId,
    this.contentId,
    this.img,
    this.cropResults,
    this.squareFactor,
  );

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
    return old.accountId != accountId ||
      old.contentId != contentId ||
      old.cropResults != cropResults ||
      old.squareFactor != squareFactor;
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

// TODO: Images are too high resolution for cacheing as cache has decoded
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
