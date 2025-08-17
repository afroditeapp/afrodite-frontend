
import 'package:app/localizations.dart';
import 'package:app/ui_utils/profile_thumbnail_image.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/profile_entry.dart';
import 'package:flutter/material.dart';
import 'package:app/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/crop_image_screen.dart';

class ProfileThumbnailImageOrError extends StatelessWidget {
  final ProfileEntry entry;
  final CropArea cropArea;
  /// 1.0 means square image, 0.0 means original aspect ratio
  final double squareFactor;
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;
  final ImageCacheSize cacheSize;

  ProfileThumbnailImageOrError.fromProfileEntry({
    required this.entry,
    this.width,
    this.height,
    this.child,
    this.squareFactor = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(PROFILE_PICTURE_BORDER_RADIUS)),
    required this.cacheSize,
    super.key,
  }) :
    cropArea = entry.primaryImageCropArea();

  @override
  Widget build(BuildContext context) {
    final img = entry.content.firstOrNull;
    if (img == null) {
      return error(context.strings.profile_image_error_no_image);
    } else if (!img.primary) {
      return error(context.strings.profile_image_error_no_primary_image);
    } else if (!img.accepted) {
      return error(context.strings.profile_image_error_image_not_accepted);
    } else {
      return ProfileThumbnailImage(
        accountId: entry.accountId,
        contentId: img.id,
        cropArea: cropArea,
        width: width,
        height: height,
        squareFactor: squareFactor,
        borderRadius: borderRadius,
        cacheSize: cacheSize,
        child: child,
      );
    }
  }

  Widget error(String text) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.warning),
            onPressed: () => showSnackBar(text),
          ),
        ),
      ),
    );
  }
}
