
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
      contentId0: img0Info.id.contentId,
      gridCropSize: img0.cropResults.gridCropSize,
      gridCropX: img0.cropResults.gridCropX,
      gridCropY: img0.cropResults.gridCropY,

      contentId1: imgStateToContentId(picture1),
      contentId2: imgStateToContentId(picture2),
      contentId3: imgStateToContentId(picture3),
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
class InitialSetupSecuritySelfie extends SelectedImageInfo {
  final int profileImagesIndex;
  InitialSetupSecuritySelfie(this.profileImagesIndex);
}
class ProfileImage extends SelectedImageInfo {
  final AccountImageId id;
  final int profileImagesIndex;
  ProfileImage(this.id, this.profileImagesIndex);
}

class AccountImageId {
  final AccountId accountId;
  final ContentId contentId;
  AccountImageId(this.accountId, this.contentId);
}
