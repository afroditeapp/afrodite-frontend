

import 'package:database/database.dart';
import 'package:app/ui_utils/crop_image_screen.dart';

extension ProfileEntryExtensions on ProfileEntry {
  CropArea primaryImageCropArea() {
    return CropArea.fromValues(
      primaryContentGridCropSize,
      primaryContentGridCropX,
      primaryContentGridCropY
    );
  }
}
