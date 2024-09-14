
import "package:freezed_annotation/freezed_annotation.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/ui_utils/crop_image_screen.dart";

part 'profile_pictures.freezed.dart';

@freezed
class ProfilePicturesData with _$ProfilePicturesData {
  const ProfilePicturesData._();
  const factory ProfilePicturesData({
    @Default(InitialSetupProfilePictures()) PictureSelectionMode mode,
    @Default(Add()) ImgState picture0,
    @Default(Hidden()) ImgState picture1,
    @Default(Hidden()) ImgState picture2,
    @Default(Hidden()) ImgState picture3,
  }) = _ProfilePicturesData;

  List<ImgState> pictures() {
    return [
      picture0,
      picture1,
      picture2,
      picture3,
    ];
  }

  int? nextAvailableSlotInInitialSetup() {
    // 0 is for security selfie
    final availableSlots = [1, 2, 3, 4];
    for (final img in pictures()) {
      if (img is ImageSelected) {
        final info = img.img;
        if (info is ProfileImage) {
          final slot = info.slot;
          if (slot != null) {
            availableSlots.remove(slot);
          }
        }
      }
    }

    return availableSlots.firstOrNull;
  }

  SetProfileContent? toSetProfileContent() {
    final img0 = picture0;
    if (img0 is! ImageSelected) {
      return null;
    }
    final img0Info = img0.img;
    if (img0Info is! ProfileImage) {
      return null;
    }

    return SetProfileContent(
      c0: img0Info.id.contentId,
      gridCropSize: img0.cropResults.gridCropSize,
      gridCropX: img0.cropResults.gridCropX,
      gridCropY: img0.cropResults.gridCropY,

      c1: imgStateToContentId(picture1),
      c2: imgStateToContentId(picture2),
      c3: imgStateToContentId(picture3),
    );
  }
}

ContentId? imgStateToContentId(ImgState state) {
  if (state is ImageSelected) {
    final info = state.img;
    if (info is ProfileImage) {
      return info.id.contentId;
    }
  }
  return null;
}

sealed class PictureSelectionMode {
  const PictureSelectionMode();
}
class InitialSetupProfilePictures extends PictureSelectionMode {
  const InitialSetupProfilePictures();
}
class NormalProfilePictures extends PictureSelectionMode {
  const NormalProfilePictures();
}

@immutable
sealed class ImgState extends Immutable {
  const ImgState();
}
class Hidden extends ImgState {
  const Hidden();
}
class Add extends ImgState {
  const Add();
}
class ImageSelected extends ImgState {
  final SelectedImageInfo img;
  final CropResults cropResults;
  const ImageSelected(this.img, {this.cropResults = CropResults.full});
}

sealed class SelectedImageInfo {}
class InitialSetupSecuritySelfie extends SelectedImageInfo {}
class ProfileImage extends SelectedImageInfo {
  final AccountImageId id;
  /// Slot where image is uploaded to.
  final int? slot;
  ProfileImage(this.id, this.slot);
}

class AccountImageId {
  final AccountId accountId;
  final ContentId contentId;
  AccountImageId(this.accountId, this.contentId);
}
