import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:database/database.dart';
import "package:pihka_frontend/ui_utils/crop_image_screen.dart";


part 'content.freezed.dart';


@freezed
class ContentData with _$ContentData {
  const ContentData._();

  factory ContentData({
    CurrentProfileContent? content,
    ContentId? securityContent,
    PendingProfileContentInternal? pendingContent,
    ContentId? pendingSecurityContent,
  }) = _ContentData;

  ContentId? get primaryProfilePicture {
    return content?.contentId0 ?? pendingContent?.pendingContentId0;
  }

  CropResults get primaryProfilePictureCropInfo {
    final size = content?.gridCropSize ?? pendingContent?.pendingGridCropSize ?? 1.0;
    final x = content?.gridCropX ?? pendingContent?.pendingGridCropX ?? 0.0;
    final y = content?.gridCropY ?? pendingContent?.pendingGridCropY ?? 0.0;
    return CropResults.fromValues(size, x, y);
  }
}
