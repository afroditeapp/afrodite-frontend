
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/logic/media/image_processing.dart";
import "package:pihka_frontend/ui_utils/crop_image_screen.dart";

part 'profile_pictures.freezed.dart';

final log = Logger("ProfilePicturesBloc");

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
}

sealed class ProfilePicturesEvent {}
class ResetIfModeChanges extends ProfilePicturesEvent {
  final PictureSelectionMode mode;
  ResetIfModeChanges(this.mode);
}
class AddProcessedImage extends ProfilePicturesEvent {
  final SelectedImageInfo img;
  AddProcessedImage(this.img);
}
class UpdateCropResults extends ProfilePicturesEvent {
  final CropResults cropResults;
  final int imgIndex;
  UpdateCropResults(this.cropResults, this.imgIndex);
}
class RemoveImage extends ProfilePicturesEvent {
  final int imgIndex;
  RemoveImage(this.imgIndex);
}
class MoveImageTo extends ProfilePicturesEvent {
  final int src;
  final int dst;
  MoveImageTo(this.src, this.dst);
}

class ProfilePicturesBloc extends Bloc<ProfilePicturesEvent, ProfilePicturesData> {
  ProfilePicturesBloc() : super(const ProfilePicturesData()) {
    on<ResetIfModeChanges>((data, emit) {
      if (state.mode.runtimeType != data.mode.runtimeType) {
        emit(ProfilePicturesData(
          mode: data.mode,
        ));
      }
    });
    on<AddProcessedImage>((data, emit) {
      final pictures = _pictureList();
      switch (data.img) {
       case InitialSetupSecuritySelfie(:final profileImagesIndex): {
          pictures[profileImagesIndex] = ImageSelected(data.img);
        }
        case ProfileImage(:final profileImagesIndex): {
          pictures[profileImagesIndex] = ImageSelected(data.img);
        }
      }
      _modifyPicturesListToHaveCorrectStates(pictures);
      _emitPictureChanges(emit, pictures);
    });
    on<RemoveImage>((data, emit) async {
      final pictures = _pictureList();
      final img = pictures[data.imgIndex];
      if (img is ImageSelected) {
        pictures[data.imgIndex] = const Add();
      }
      _modifyPicturesListToHaveCorrectStates(pictures);
      _emitPictureChanges(emit, pictures);
    });
    on<UpdateCropResults>((data, emit) async {
      final pictures = _pictureList();
      final img = pictures[data.imgIndex];
      if (img is ImageSelected) {
        pictures[data.imgIndex] = ImageSelected(img.img, cropResults: data.cropResults);
      }
      _emitPictureChanges(emit, pictures);
    });
    on<MoveImageTo>((data, emit) async {
      final pictures = _pictureList();
      final srcImg = pictures[data.src];
      final dstImg = pictures[data.dst];
      pictures[data.src] = dstImg;
      pictures[data.dst] = srcImg;
      _modifyPicturesListToHaveCorrectStates(pictures);
      _emitPictureChanges(emit, pictures);
    });
  }

  List<ImgState> _pictureList() {
    return state.pictures();
  }

  void _modifyPicturesListToHaveCorrectStates(List<ImgState> pictures) {
    for (var i = 1; i < pictures.length; i++) {
      if (pictures[i - 1] is ImageSelected && pictures[i] is Hidden) {
        // If previous slot has image, show add button
        pictures[i] = const Add();
      } else if (pictures[i - 1] is Add && pictures[i] is ImageSelected) {
        // If previous slot image was removed, move image to previous slot
        pictures[i - 1] = pictures[i];
        pictures[i] = const Add();
      } else if (pictures[i - 1] is Add && pictures[i] is Add) {
        // Subsequent add image buttons
        pictures[i] = const Hidden();
      } else if (pictures[i - 1] is Add && pictures[i] is ImageSelected) {
        // Image was drag and dropped to empty slot.
        // This is currently prevented from UI code.
        pictures[i - 1] = pictures[i];
        pictures[i] = const Add();
      }
    }
  }

  void _emitPictureChanges(Emitter<ProfilePicturesData> emit, List<ImgState> pictures) {
    emit(state.copyWith(
      picture0: pictures[0],
      picture1: pictures[1],
      picture2: pictures[2],
      picture3: pictures[3],
    ));
  }
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


sealed class ImgState {
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
