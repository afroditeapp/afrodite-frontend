import "package:app/ui_utils/crop_image_screen.dart";
import "package:database/database.dart";
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";

part 'content.freezed.dart';

@freezed
class ContentData with _$ContentData {
  const ContentData._();

  factory ContentData({
    PrimaryProfileContent? primaryContent,
    @Default(true) bool isLoadingPrimaryContent,
    MyContent? securityContent,
    @Default(true) bool isLoadingSecurityContent,
  }) = _ContentData;

  ContentId? get primaryProfilePicture {
    return primaryContent?.content0?.id;
  }

  CropArea get primaryProfilePictureCropInfo {
    final size = primaryContent?.gridCropSize ?? 1.0;
    final x = primaryContent?.gridCropX ?? 0.0;
    final y = primaryContent?.gridCropY ?? 0.0;
    return CropArea.fromValues(size, x, y);
  }

  ContentId? get currentSecurityContent {
    return securityContent?.id;
  }
}
