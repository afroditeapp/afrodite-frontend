
import 'package:app/ui_utils/profile_thumbnail_image.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/crop_image_screen.dart';

class ProfileThumbnailImageOrError extends StatefulWidget {
  final AccountId accountId;
  final ContentId? contentId;
  final CropResults cropResults;
  /// 1.0 means square image, 0.0 means original aspect ratio
  final double squareFactor;
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;
  final ImageCacheSize cacheSize;

  ProfileThumbnailImageOrError.fromProfileEntry({
    required ProfileEntry entry,
    this.width,
    this.height,
    this.child,
    this.squareFactor = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(PROFILE_PICTURE_BORDER_RADIUS)),
    this.cacheSize = ImageCacheSize.maxQuality,
    super.key,
  }) :
    accountId = entry.uuid,
    contentId = entry.acceptedPrimaryImg(),
    cropResults = CropResults.fromValues(
      entry.primaryContentGridCropSize,
      entry.primaryContentGridCropX,
      entry.primaryContentGridCropY,
    );

  @override
  State<ProfileThumbnailImageOrError> createState() => _ProfileThumbnailImageOrErrorState();
}

class _ProfileThumbnailImageOrErrorState extends State<ProfileThumbnailImageOrError> {

  @override
  Widget build(BuildContext context) {
    final content = widget.contentId;
    if (content != null) {
      return ProfileThumbnailImage(
        accountId: widget.accountId,
        contentId: content,
        width: widget.width,
        height: widget.height,
        squareFactor: widget.squareFactor,
        borderRadius: widget.borderRadius,
        cacheSize: widget.cacheSize,
        child: widget.child,
      );
    } else {
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: const Center(
            child: Icon(Icons.warning),
          ),
        ),
      );
    }
  }
}
