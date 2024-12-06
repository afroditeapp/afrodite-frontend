import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:database/database.dart';
import "package:app/ui_utils/crop_image_screen.dart";


part 'content.freezed.dart';


@freezed
class ContentData with _$ContentData {
  const ContentData._();

  factory ContentData({
    CurrentProfileContent? content,
    ContentId? securityContent,
    @Default(false) bool primaryImageDataAvailable,
  }) = _ContentData;

  ContentId? get primaryProfilePicture {
    return content?.contentId0;
  }

  CropResults get primaryProfilePictureCropInfo {
    final size = content?.gridCropSize ?? 1.0;
    final x = content?.gridCropX ?? 0.0;
    final y = content?.gridCropY ?? 0.0;
    return CropResults.fromValues(size, x, y);
  }

  ContentId? get currentSecurityContent {
    return securityContent;
  }
}
