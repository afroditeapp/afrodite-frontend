

import 'package:database/database.dart';
import 'package:pihka_frontend/ui_utils/crop_image_screen.dart';

extension ProfileEntryExtensions on ProfileEntry {
  CropResults primaryImageCropInfo() {
    return CropResults.fromValues(
      primaryContentGridCropSize,
      primaryContentGridCropX,
      primaryContentGridCropY
    );
  }
}
