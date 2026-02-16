import 'package:app/ui_utils/crop_image_screen.dart';
import 'package:meta/meta.dart';
import 'package:openapi/api.dart';

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

List<ImgState> compactProfilePictureSlots(List<ImgState> pictures, {int slotCount = 4}) {
  final selected = pictures.whereType<ImageSelected>();
  final compacted = <ImgState>[...selected.take(slotCount)];
  while (compacted.length < slotCount) {
    compacted.add(const Empty());
  }
  return compacted;
}
