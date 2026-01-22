import "package:app/logic/media/profile_pictures_interface.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/utils/model.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:openapi/api.dart";
import "package:app/ui_utils/crop_image_screen.dart";

part 'profile_pictures.freezed.dart';

@freezed
class ProfilePicturesData with _$ProfilePicturesData implements ProfilePicturesStateInterface {
  const ProfilePicturesData._();
  const factory ProfilePicturesData({
    @Default(Empty()) ImgState picture0,
    @Default(Empty()) ImgState picture1,
    @Default(Empty()) ImgState picture2,
    @Default(Empty()) ImgState picture3,
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

  @override
  List<ImgState> valuePictures() {
    return [valuePicture0(), valuePicture1(), valuePicture2(), valuePicture3()];
  }

  @override
  int? nextAvailableSlotInInitialSetup() {
    throw Exception("ProfilePicturesData is not used in initial setup");
  }

  SetProfileContent? toSetProfileContent() {
    final pics = valuePictures();

    final img0 = pics[0];
    if (img0 is! ImageSelected) {
      return null;
    }

    final c = [img0.contentId(), pics[1].contentId(), pics[2].contentId(), pics[3].contentId()];

    return SetProfileContent(
      c: c.nonNulls.toList(),
      gridCropSize: img0.cropArea.gridCropSize,
      gridCropX: img0.cropArea.gridCropX,
      gridCropY: img0.cropArea.gridCropY,
    );
  }

  bool faceDetectedFromPrimaryImage() {
    final img0 = valuePictures()[0];
    return img0 is ImageSelected && img0.isFaceDetected();
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

  ContentId? contentId();
}

class Empty extends ImgState {
  const Empty();

  @override
  ContentId? contentId() => null;

  @override
  bool operator ==(Object other) => identical(this, other) || other.runtimeType == runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ImageSelected extends ImgState {
  final AccountImageId id;
  final int? slot;
  final CropArea cropArea;
  const ImageSelected(this.id, this.slot, {this.cropArea = CropArea.full});

  ImageSelected copyWithId(AccountImageId id) {
    return ImageSelected(id, slot, cropArea: cropArea);
  }

  ImageSelected copyWithFaceDetected(bool faceDetected) {
    return ImageSelected(
      AccountImageId(id.accountId, id.contentId, faceDetected, id.accepted),
      slot,
      cropArea: cropArea,
    );
  }

  bool isFaceDetected() => id.faceDetected;

  bool isAccepted() => id.accepted;

  @override
  ContentId? contentId() => id.contentId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageSelected && other.id == id && other.slot == slot && other.cropArea == cropArea;

  @override
  int get hashCode => Object.hash(id, slot, cropArea);
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
