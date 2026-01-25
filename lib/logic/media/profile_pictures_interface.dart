import "package:app/ui_utils/crop_image_screen.dart";
import "package:app/ui_utils/profile_pictures.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// Interface for profile pictures state operations.
/// Implement this to provide state data for ProfilePictureSelection widget.
abstract interface class ProfilePicturesStateInterface {
  /// Get the list of current picture states (including unsaved edits).
  List<ImgState> valuePictures();

  /// Get the next available slot index in initial setup mode.
  /// Returns null if all slots are occupied.
  int? nextAvailableSlotInInitialSetup();
}

/// Interface for profile pictures bloc operations.
/// Implement this to provide a bloc compatible with ProfilePictureSelection widget.
abstract interface class ProfilePicturesBlocInterface<State extends ProfilePicturesStateInterface>
    implements BlocBase<State> {
  /// Add a processed image at the specified index.
  void addProcessedImage(ImageSelected img, int profileImagesIndex);

  /// Update crop area for an image at the specified index.
  void updateCropArea(CropArea cropArea, int imgIndex);

  /// Remove an image at the specified index.
  void removeImage(int imgIndex);

  /// Move an image from source index to destination index.
  void moveImageTo(int src, int dst);
}
