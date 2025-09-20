import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/result.dart";
import "package:collection/collection.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/model/freezed/logic/media/profile_pictures.dart";
import "package:app/ui_utils/crop_image_screen.dart";
import "package:openapi/api.dart";

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

class UpdateCropArea extends ProfilePicturesEvent {
  final CropArea cropArea;
  final int imgIndex;
  UpdateCropArea(this.cropArea, this.imgIndex);
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

class RefreshProfilePicturesFaceDetectedValues extends ProfilePicturesEvent {}

class NewPageKeyForProfilePicturesBloc extends ProfilePicturesEvent {
  final PageKey value;
  NewPageKeyForProfilePicturesBloc(this.value);
}

class ProfilePicturesBloc extends Bloc<ProfilePicturesEvent, ProfilePicturesData> {
  final ApiManager api;
  final AccountId currentAccount;

  ProfilePicturesBloc(RepositoryInstances r)
    : api = r.api,
      currentAccount = r.accountId,
      super(const ProfilePicturesData()) {
    on<ResetIfModeChanges>((data, emit) {
      if (state.mode.runtimeType != data.mode.runtimeType) {
        emit(ProfilePicturesData(mode: data.mode));
      }
    });
    on<ResetProfilePicturesBloc>((data, emit) {
      emit(const ProfilePicturesData());
    });
    on<AddProcessedImage>((data, emit) {
      final pictures = _pictureList();
      switch (data.img) {
        case InitialSetupSecuritySelfie():
          {
            pictures[data.profileImagesIndex] = ImageSelected(data.img);
          }
        case ProfileImage():
          {
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
    on<UpdateCropArea>((data, emit) async {
      final pictures = _pictureList();
      final img = pictures[data.imgIndex];
      if (img is ImageSelected) {
        pictures[data.imgIndex] = ImageSelected(img.img, cropArea: data.cropArea);
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
    on<RefreshProfilePicturesFaceDetectedValues>((data, emit) async {
      final r = await api.media((api) => api.getAllAccountMediaContent(currentAccount.aid)).ok();
      if (r == null) {
        showSnackBar(R.strings.generic_error_occurred);
        return;
      }

      final imgs = state.pictures();
      for (final (i, img) in imgs.indexed) {
        if (img is ImageSelected) {
          final imgInfo = img.img;
          if (imgInfo is ProfileImage) {
            final newImgState = r.data.firstWhereOrNull((v) => v.cid == imgInfo.id.contentId);
            if (newImgState != null) {
              imgs[i] = img.copyWithImg(imgInfo.copyWithFaceDetected(newImgState.fd));
            }
          }
        }
      }
      emit(
        state.copyWith(picture0: imgs[0], picture1: imgs[1], picture2: imgs[2], picture3: imgs[3]),
      );

      showSnackBar(R.strings.generic_action_completed);
    });
    on<NewPageKeyForProfilePicturesBloc>((data, emit) async {
      emit(state.copyWith(pageKey: data.value));
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
    emit(
      state.copyWith(
        picture0: pictures[0],
        picture1: pictures[1],
        picture2: pictures[2],
        picture3: pictures[3],
      ),
    );
  }
}
