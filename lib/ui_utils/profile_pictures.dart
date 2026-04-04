import 'package:app/ui_utils/crop_image_screen.dart';
import 'package:app/utils/api.dart';
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
      AccountImageId(
        id.accountId,
        id.contentId,
        faceDetected,
        id.moderationState,
        rejectedCategory: id.rejectedCategory,
        rejectedDetails: id.rejectedDetails,
      ),
      slot,
      cropArea: cropArea,
    );
  }

  bool isFaceDetected() => id.faceDetected;

  bool isAccepted() => id.moderationState?.isAccepted() ?? false;

  bool isRejected() => id.moderationState?.isRejected() ?? false;

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

  /// Null when picture selection happens in initial setup.
  final ContentModerationState? moderationState;

  /// Null when picture selection happens in initial setup.
  final MediaContentModerationRejectedReasonCategory? rejectedCategory;

  /// Null when picture selection happens in initial setup.
  final MediaContentModerationRejectedReasonDetails? rejectedDetails;
  AccountImageId(
    this.accountId,
    this.contentId,
    this.faceDetected,
    this.moderationState, {
    this.rejectedCategory,
    this.rejectedDetails,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountImageId &&
          other.accountId == accountId &&
          other.contentId == contentId &&
          other.faceDetected == faceDetected &&
          other.moderationState == moderationState &&
          other.rejectedCategory == rejectedCategory &&
          other.rejectedDetails == rejectedDetails;

  @override
  int get hashCode => Object.hash(
    accountId,
    contentId,
    faceDetected,
    moderationState,
    rejectedCategory,
    rejectedDetails,
  );
}

List<ImgState> compactProfilePictureSlots(List<ImgState> pictures, {int slotCount = 4}) {
  final selected = pictures.whereType<ImageSelected>();
  final compacted = <ImgState>[...selected.take(slotCount)];
  while (compacted.length < slotCount) {
    compacted.add(const Empty());
  }
  return compacted;
}
