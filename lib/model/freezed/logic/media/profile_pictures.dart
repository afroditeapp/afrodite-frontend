import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/utils/model.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:openapi/api.dart";
import "package:app/ui_utils/crop_image_screen.dart";
import 'package:collection/collection.dart';

part 'profile_pictures.freezed.dart';

@freezed
class ProfilePicturesData with _$ProfilePicturesData {
  const ProfilePicturesData._();
  const factory ProfilePicturesData({
    @Default(Hidden()) ImgState picture0,
    @Default(Hidden()) ImgState picture1,
    @Default(Hidden()) ImgState picture2,
    @Default(Hidden()) ImgState picture3,
    PageKey? pageKey,
    required EditedProfilePicturesData edited,
  }) = _ProfilePicturesData;

  List<ImgState> pictures() {
    return [picture0, picture1, picture2, picture3];
  }

  bool unsavedChanges() =>
      edited.picture0.unsavedChanges() ||
      edited.picture1.unsavedChanges() ||
      edited.picture2.unsavedChanges() ||
      edited.picture3.unsavedChanges();

  ImgState valuePicture0() => edited.picture0.editedValue(picture0) ?? picture0;
  ImgState valuePicture1() => edited.picture1.editedValue(picture1) ?? picture1;
  ImgState valuePicture2() => edited.picture2.editedValue(picture2) ?? picture2;
  ImgState valuePicture3() => edited.picture3.editedValue(picture3) ?? picture3;

  List<ImgState> valuePictures() {
    return [valuePicture0(), valuePicture1(), valuePicture2(), valuePicture3()];
  }

  int? nextAvailableSlotInInitialSetup() {
    // 0 is for security selfie
    final availableSlots = [1, 2, 3, 4];
    for (final img in valuePictures()) {
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
    final pics = valuePictures();

    final img0 = pics[0];
    if (img0 is! ImageSelected) {
      return null;
    }
    final img0Info = img0.img;
    if (img0Info is! ProfileImage) {
      return null;
    }

    final c = [
      img0Info.id.contentId,
      imgStateToContentId(pics[1]),
      imgStateToContentId(pics[2]),
      imgStateToContentId(pics[3]),
    ];

    return SetProfileContent(
      c: c.nonNulls.toList(),
      gridCropSize: img0.cropArea.gridCropSize,
      gridCropX: img0.cropArea.gridCropX,
      gridCropY: img0.cropArea.gridCropY,
    );
  }

  bool faceDetectedFromPrimaryImage() {
    final img0 = valuePictures()[0];
    return img0 is ImageSelected && img0.img.isFaceDetected();
  }
}

@freezed
class EditedProfilePicturesData with _$EditedProfilePicturesData {
  EditedProfilePicturesData._();
  factory EditedProfilePicturesData({
    @Default(NoEdit()) EditValue<ImgState> picture0,
    @Default(NoEdit()) EditValue<ImgState> picture1,
    @Default(NoEdit()) EditValue<ImgState> picture2,
    @Default(NoEdit()) EditValue<ImgState> picture3,
  }) = _EditedProfilePicturesData;
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

  @override
  bool operator ==(Object other) => identical(this, other) || other.runtimeType == runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ImageSelected extends ImgState {
  final SelectedImageInfo img;
  final CropArea cropArea;
  const ImageSelected(this.img, {this.cropArea = CropArea.full});

  ImageSelected copyWithImg(SelectedImageInfo img) {
    return ImageSelected(img, cropArea: cropArea);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageSelected && other.img == img && other.cropArea == cropArea;

  @override
  int get hashCode => Object.hash(img, cropArea);
}

sealed class SelectedImageInfo {
  bool isFaceDetected() {
    final img = this;
    return img is InitialSetupSecuritySelfie || (img is ProfileImage && img.id.faceDetected);
  }

  bool isAccepted() {
    final img = this;
    return img is InitialSetupSecuritySelfie || (img is ProfileImage && img.id.accepted);
  }
}

class InitialSetupSecuritySelfie extends SelectedImageInfo {
  @override
  bool operator ==(Object other) => identical(this, other) || other.runtimeType == runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ProfileImage extends SelectedImageInfo {
  final AccountImageId id;

  /// Slot where image is uploaded to.
  final int? slot;
  ProfileImage(this.id, this.slot);

  ProfileImage copyWithFaceDetected(bool faceDetected) {
    return ProfileImage(
      AccountImageId(id.accountId, id.contentId, faceDetected, id.accepted),
      slot,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProfileImage && other.id == id && other.slot == slot;

  @override
  int get hashCode => Object.hash(id, slot);
}

class AccountImageId {
  final AccountId accountId;
  final ContentId contentId;
  final bool faceDetected;
  final bool accepted;
  AccountImageId(this.accountId, this.contentId, this.faceDetected, this.accepted);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountImageId &&
          other.accountId == accountId &&
          other.contentId == contentId &&
          other.faceDetected == faceDetected &&
          other.accepted == accepted;

  @override
  int get hashCode => Object.hash(accountId, contentId, faceDetected, accepted);
}
