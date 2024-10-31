

import 'package:database/database.dart';
import 'package:app/ui_utils/crop_image_screen.dart';

extension ProfileEntryExtensions on ProfileEntry {
  CropResults primaryImageCropInfo() {
    return CropResults.fromValues(
      primaryContentGridCropSize,
      primaryContentGridCropX,
      primaryContentGridCropY
    );
  }
}
