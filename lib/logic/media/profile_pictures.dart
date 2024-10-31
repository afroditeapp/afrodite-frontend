
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:app/model/freezed/logic/media/profile_pictures.dart";
import "package:app/ui_utils/crop_image_screen.dart";

final log = Logger("ProfilePicturesBloc");

sealed class ProfilePicturesEvent {}
class ResetIfModeChanges extends ProfilePicturesEvent {
  final PictureSelectionMode mode;
  ResetIfModeChanges(this.mode);
}
class AddProcessedImage extends ProfilePicturesEvent {
  final SelectedImageInfo img;
  final int profileImagesIndex;
  AddProcessedImage(this.img, this.profileImagesIndex);
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
class ResetProfilePicturesBloc extends ProfilePicturesEvent {}

class ProfilePicturesBloc extends Bloc<ProfilePicturesEvent, ProfilePicturesData> {
  ProfilePicturesBloc() : super(const ProfilePicturesData()) {
    on<ResetIfModeChanges>((data, emit) {
      if (state.mode.runtimeType != data.mode.runtimeType) {
        emit(ProfilePicturesData(
          mode: data.mode,
        ));
      }
    });
    on<ResetProfilePicturesBloc>((data, emit) {
      emit(const ProfilePicturesData());
    });
    on<AddProcessedImage>((data, emit) {
      final pictures = _pictureList();
      switch (data.img) {
       case InitialSetupSecuritySelfie(): {
          pictures[data.profileImagesIndex] = ImageSelected(data.img);
        }
        case ProfileImage(): {
          pictures[data.profileImagesIndex] = ImageSelected(data.img);
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
