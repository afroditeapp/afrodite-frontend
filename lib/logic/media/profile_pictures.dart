import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/model.dart";
import "package:app/utils/result.dart";
import "package:collection/collection.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/model/freezed/logic/media/profile_pictures.dart";
import "package:app/ui_utils/crop_image_screen.dart";
import "package:openapi/api.dart";

sealed class ProfilePicturesEvent {}

class ResetEditedValues extends ProfilePicturesEvent {}

class SetInitialState extends ProfilePicturesEvent {
  final List<ImgState> pictures;
  final List<CropArea> cropAreas;
  SetInitialState(this.pictures, this.cropAreas);
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
      super(ProfilePicturesData(edited: EditedProfilePicturesData())) {
    on<ResetEditedValues>((data, emit) {
      resetEditedValues(emit);
    });
    on<SetInitialState>((data, emit) {
      final pictures = List<ImgState>.from(data.pictures);
      _modifyPicturesListToHaveCorrectStates(pictures);
      emit(
        state.copyWith(
          picture0: pictures[0],
          picture1: pictures[1],
          picture2: pictures[2],
          picture3: pictures[3],
          edited: EditedProfilePicturesData(),
        ),
      );
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
      _emitPictureChangesToEdited(emit, pictures);
    });
    on<RemoveImage>((data, emit) async {
      final pictures = _pictureList();
      final img = pictures[data.imgIndex];
      if (img is ImageSelected) {
        pictures[data.imgIndex] = const Hidden();
      }
      _modifyPicturesListToHaveCorrectStates(pictures);
      _emitPictureChangesToEdited(emit, pictures);
    });
    on<UpdateCropArea>((data, emit) async {
      final pictures = _pictureList();
      final img = pictures[data.imgIndex];
      if (img is ImageSelected) {
        pictures[data.imgIndex] = ImageSelected(img.img, cropArea: data.cropArea);
        _emitPictureChangesToEdited(emit, pictures);
      }
    });
    on<MoveImageTo>((data, emit) async {
      final pictures = _pictureList();
      final srcImg = pictures[data.src];
      final dstImg = pictures[data.dst];
      pictures[data.src] = dstImg;
      pictures[data.dst] = srcImg;
      _modifyPicturesListToHaveCorrectStates(pictures);
      _emitPictureChangesToEdited(emit, pictures);
    });
    on<RefreshProfilePicturesFaceDetectedValues>((data, emit) async {
      final r = await api.media((api) => api.getAllAccountMediaContent(currentAccount.aid)).ok();
      if (r == null) {
        showSnackBar(R.strings.generic_error_occurred);
        return;
      }

      final imgs = state.valuePictures();
      for (final (i, img) in imgs.indexed) {
        if (img is ImageSelected) {
          final imgInfo = img.img;
          if (imgInfo is ProfileImage) {
            final newImgState = r.data.firstWhereOrNull((v) => v.cid == imgInfo.id.contentId);
            if (newImgState != null) {
              imgs[i] = ImageSelected(imgInfo.copyWithFaceDetected(newImgState.fd));
            }
          }
        }
      }
      _emitPictureChangesToEdited(emit, imgs);

      showSnackBar(R.strings.generic_action_completed);
    });
    on<NewPageKeyForProfilePicturesBloc>((data, emit) async {
      emit(state.copyWith(pageKey: data.value));
    });
  }

  List<ImgState> _pictureList() {
    return state.valuePictures();
  }

  void _modifyPicturesListToHaveCorrectStates(List<ImgState> pictures) {
    for (var i = 1; i < pictures.length; i++) {
      if (pictures[i - 1] is Hidden && pictures[i] is ImageSelected) {
        // Keep images packed from the start by shifting left into empty slots.
        pictures[i - 1] = pictures[i];
        pictures[i] = const Hidden();
      }
    }
  }

  void _emitPictureChangesToEdited(Emitter<ProfilePicturesData> emit, List<ImgState> pictures) {
    modifyEdited(
      emit,
      (e) => e.copyWith(
        picture0: state.picture0 == pictures[0] ? const NoEdit() : editValue(pictures[0]),
        picture1: state.picture1 == pictures[1] ? const NoEdit() : editValue(pictures[1]),
        picture2: state.picture2 == pictures[2] ? const NoEdit() : editValue(pictures[2]),
        picture3: state.picture3 == pictures[3] ? const NoEdit() : editValue(pictures[3]),
      ),
    );
  }

  void resetEditedValues(Emitter<ProfilePicturesData> emit) {
    emit(state.copyWith(edited: EditedProfilePicturesData()));
  }

  void modifyEdited(
    Emitter<ProfilePicturesData> emit,
    EditedProfilePicturesData Function(EditedProfilePicturesData) modify,
  ) {
    emit(state.copyWith(edited: modify(state.edited)));
  }
}
