
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/logic/media/image_processing.dart';
import 'package:pihka_frontend/ui_utils/consts/corners.dart';
import 'package:pihka_frontend/ui_utils/crop_image_screen.dart';
import 'package:pihka_frontend/utils/account_img_key.dart';


class ProfileThumbnailImage extends StatefulWidget {
  final ProcessedAccountImage img;
  final CropResults cropResults;
  final double size;
  final Widget? child;
  const ProfileThumbnailImage({
    required this.img,
    required this.cropResults,
    required this.size,
    this.child,
    super.key,
  });

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
    if (oldWidget.img != widget.img) {
      loadImage();
    }
  }

  void loadImage() {
    final k = AccountImgKey(accountId: widget.img.accountId, contentId: widget.img.contentId);
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
      return Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PROFILE_PICTURE_BORDER_RADIUS),
        ),
        clipBehavior: Clip.hardEdge,
        child: CustomPaint(
          painter: CroppedImagePainter(img, widget.cropResults),
          child: widget.child,
        ),
      );
    } else {
      return Container(
        width: widget.size,
        height: widget.size,
        color: Colors.transparent,
      );
    }
  }
}


class CroppedImagePainter extends CustomPainter {
  final ui.Image img;
  final CropResults cropResults;
  CroppedImagePainter(this.img, this.cropResults);

  @override
  void paint(Canvas canvas, Size size) {
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
    return old.cropResults != cropResults;
  }
}
