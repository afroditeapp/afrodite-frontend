import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:app/logic/media/profile_pictures_interface.dart";
import "package:app/ui_utils/crop_image_screen.dart";
import "package:app/ui_utils/profile_pictures.dart";
import "package:app/utils/list.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/account_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/data/profile_repository.dart";
import 'package:database/database.dart';
import "package:app/database/account_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/profile/my_profile.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/model.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";

sealed class MyProfileEvent {}

class SetProfile extends MyProfileEvent {
  final ProfileUpdate profile;
  final SetProfileContent pictures;
  final bool unlimitedLikes;

  SetProfile(this.profile, this.pictures, {required this.unlimitedLikes});
}

class NewMyProfile extends MyProfileEvent {
  final MyProfileEntry? profile;
  NewMyProfile(this.profile);
}

class NewInitialAgeInfo extends MyProfileEvent {
  final InitialAgeInfo? value;
  NewInitialAgeInfo(this.value);
}

class ReloadMyProfile extends MyProfileEvent {}

class ResetEditedValues extends MyProfileEvent {}

class RestoreEditingState extends MyProfileEvent {
  final MyProfileEntry initialProfile;
  final EditProfileProgressEntry progress;
  RestoreEditingState(this.initialProfile, this.progress);
}

class ClearOpenSelectImageScreen extends MyProfileEvent {}

class NewAge extends MyProfileEvent {
  final int? value;
  NewAge(this.value);
}

class NewName extends MyProfileEvent {
  final String? value;
  NewName(this.value);
}

class NewProfileText extends MyProfileEvent {
  final String? value;
  NewProfileText(this.value);
}

class NewUnlimitedLikesValue extends MyProfileEvent {
  final bool value;
  NewUnlimitedLikesValue(this.value);
}

class NewAttributeValue extends MyProfileEvent {
  final ProfileAttributeValueUpdate value;
  NewAttributeValue(this.value);
}

class AddProcessedImage extends MyProfileEvent {
  final ImageSelected img;
  final int profileImagesIndex;
  AddProcessedImage(this.img, this.profileImagesIndex);
}

class UpdateCropArea extends MyProfileEvent {
  final CropArea cropArea;
  final int imgIndex;
  UpdateCropArea(this.cropArea, this.imgIndex);
}

class RemoveImage extends MyProfileEvent {
  final int imgIndex;
  RemoveImage(this.imgIndex);
}

class MoveImageTo extends MyProfileEvent {
  final int src;
  final int dst;
  MoveImageTo(this.src, this.dst);
}

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileData>
    with ActionRunner
    implements ProfilePicturesBlocInterface<MyProfileData> {
  final AccountRepository account;
  final ProfileRepository profile;
  final MediaRepository media;
  final AccountDatabaseManager db;

  StreamSubscription<ProfileEntry?>? _profileSubscription;
  StreamSubscription<InitialAgeInfo?>? _initialAgeInfoSubscription;

  MyProfileBloc(RepositoryInstances r)
    : account = r.account,
      profile = r.profile,
      media = r.media,
      db = r.accountDb,
      super(MyProfileData(edited: EditedMyProfileData())) {
    on<SetProfile>((data, emit) async {
      await runOnce(() async {
        final current = state.profile;
        if (current == null) {
          return;
        }

        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(updateState: const UpdateInProgress()));

        // Do this first as updateProfile reloads the profile
        if (!await account.updateUnlimitedLikesWithoutReloadingProfile(data.unlimitedLikes)) {
          failureDetected = true;
        }

        if (!await profile.updateProfile(data.profile)) {
          failureDetected = true;
        }

        if (await media.setProfileContent(data.pictures).isErr()) {
          failureDetected = true;
        }

        if (failureDetected) {
          showSnackBar(R.strings.view_profile_screen_profile_edit_failed);
        }

        await waitTime.waitIfNeeded();

        emit(state.copyWith(updateState: const UpdateIdle()));

        resetEditedValues(emit);
      });
    });
    on<NewMyProfile>((data, emit) async {
      emit(state.copyWith(profile: data.profile));
    });
    on<AddProcessedImage>((data, emit) {
      final pictures = state.valuePictures();
      pictures[data.profileImagesIndex] = data.img;
      _emitPictureChangesToEdited(emit, pictures);
    });
    on<RemoveImage>((data, emit) async {
      final pictures = state.valuePictures();
      final img = pictures[data.imgIndex];
      if (img is ImageSelected) {
        pictures[data.imgIndex] = const Empty();
      }
      _emitPictureChangesToEdited(emit, pictures);
    });
    on<UpdateCropArea>((data, emit) async {
      final pictures = state.valuePictures();
      final img = pictures[data.imgIndex];
      if (img is ImageSelected) {
        pictures[data.imgIndex] = ImageSelected(img.id, img.slot, cropArea: data.cropArea);
        _emitPictureChangesToEdited(emit, pictures);
      }
    });
    on<MoveImageTo>((data, emit) async {
      final pictures = state.valuePictures();
      final srcImg = pictures[data.src];
      final dstImg = pictures[data.dst];
      pictures[data.src] = dstImg;
      pictures[data.dst] = srcImg;
      _emitPictureChangesToEdited(emit, pictures);
    });
    on<NewInitialAgeInfo>((data, emit) async {
      emit(state.copyWith(initialAgeInfo: data.value));
    });
    on<ReloadMyProfile>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(loadingMyProfile: true));

        final waitTime = WantedWaitingTimeManager();

        bool failureDetected = false;
        if (await profile.reloadMyProfile().isErr()) {
          failureDetected = true;
        }

        if (await media.reloadMyMediaContent().isErr()) {
          failureDetected = true;
        }

        await waitTime.waitIfNeeded();

        if (failureDetected) {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(loadingMyProfile: false));
      });
    });
    on<ResetEditedValues>((data, emit) async {
      resetEditedValues(emit);
    });
    on<RestoreEditingState>((data, emit) async {
      if (state.profile == null) {
        emit(state.copyWith(profile: data.initialProfile));
      }

      final progress = data.progress;

      final age = progress.age;
      if (age != null) add(NewAge(age));

      final name = progress.name;
      if (name != null) add(NewName(name));

      final profileText = progress.profileText;
      if (profileText != null) add(NewProfileText(profileText));

      final unlimitedLikes = progress.unlimitedLikes;
      if (unlimitedLikes != null) add(NewUnlimitedLikesValue(unlimitedLikes));

      final attributes = progress.profileAttributes;
      if (attributes != null) {
        for (final a in attributes) {
          add(NewAttributeValue(a));
        }
      }

      final images = progress.profileImages;
      if (images != null) {
        for (int i = 0; i < 4; i++) {
          final imgEntry = images.getAtOrNull(i);
          if (imgEntry != null) {
            final imgId = AccountImageId(
              data.initialProfile.accountId,
              ContentId(cid: imgEntry.contentId),
              imgEntry.faceDetected,
              imgEntry.accepted,
            );
            final cropArea = CropArea.fromValues(imgEntry.cropSize, imgEntry.cropX, imgEntry.cropY);
            add(AddProcessedImage(ImageSelected(imgId, null, cropArea: cropArea), i));
          } else {
            add(RemoveImage(i));
          }
        }
      }

      final selectingImage = await db.db.daoReadProgress.isEditProfileSelectingImage();
      emit(state.copyWith(openSelectImageScreen: selectingImage));
    });
    on<ClearOpenSelectImageScreen>((data, emit) {
      emit(state.copyWith(openSelectImageScreen: false));
    });
    on<NewAge>((data, emit) async {
      modifyEdited(
        emit,
        (e) =>
            state.profile?.age == data.value ? e.copyWith(age: null) : e.copyWith(age: data.value),
      );
    });
    on<NewName>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.profile?.name == data.value
            ? e.copyWith(name: null)
            : e.copyWith(name: data.value),
      );
    });
    on<NewProfileText>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.profile?.profileText == data.value
            ? e.copyWith(profileText: const NoEdit())
            : e.copyWith(profileText: editValue(data.value)),
      );
    });
    on<NewUnlimitedLikesValue>((data, emit) async {
      modifyEdited(
        emit,
        (e) => state.profile?.unlimitedLikes == data.value
            ? e.copyWith(unlimitedLikes: null)
            : e.copyWith(unlimitedLikes: data.value),
      );
    });
    on<NewAttributeValue>((data, emit) async {
      final newAttributes = <int, ProfileAttributeValueUpdate>{};
      var found = false;
      for (final a in state.valueAttributeIdAndStateMap().values) {
        if (a.id == data.value.id) {
          newAttributes[data.value.id] = data.value;
          found = true;
        } else {
          newAttributes[a.id] = a;
        }
      }
      if (!found) {
        newAttributes[data.value.id] = data.value;
      }

      final originalAttributes = state.profile?.attributeIdAndStateMap ?? {};
      final modifiedAttributes = {...newAttributes};

      bool attributesChanged = false;
      for (final a in originalAttributes.values) {
        final removed = modifiedAttributes.remove(a.id);
        if (removed == null) {
          // The modified attributes should contain all attributes
          // from original as those are needed when removing an attribute.
          // ProfileAttributeValueUpdate with empty list removes the attribute.
          continue;
        }
        if (!listEquals(a.v, removed.v)) {
          attributesChanged = true;
          break;
        }
      }
      if (!attributesChanged) {
        for (final a in modifiedAttributes.values) {
          if (a.v.isNotEmpty) {
            attributesChanged = true;
            break;
          }
        }
      }

      modifyEdited(
        emit,
        (e) => attributesChanged
            ? e.copyWith(attributeIdAndStateMap: newAttributes)
            : e.copyWith(attributeIdAndStateMap: null),
      );
    });

    _profileSubscription = db
        .accountStream((db) => db.myProfile.getProfileEntryForMyProfile())
        .listen((event) {
          add(NewMyProfile(event));
        });
    _initialAgeInfoSubscription = db
        .accountStream((db) => db.myProfile.watchInitialAgeInfo())
        .listen((event) {
          add(NewInitialAgeInfo(event));
        });
  }

  // ProfilePicturesBlocInterface implementation
  @override
  void addProcessedImage(ImageSelected img, int profileImagesIndex) {
    add(AddProcessedImage(img, profileImagesIndex));
  }

  @override
  void updateCropArea(CropArea cropArea, int imgIndex) {
    add(UpdateCropArea(cropArea, imgIndex));
  }

  @override
  void removeImage(int imgIndex) {
    add(RemoveImage(imgIndex));
  }

  @override
  void moveImageTo(int src, int dst) {
    add(MoveImageTo(src, dst));
  }

  void _emitPictureChangesToEdited(Emitter<MyProfileData> emit, List<ImgState> pictures) {
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

  void resetEditedValues(Emitter<MyProfileData> emit) {
    emit(state.copyWith(edited: EditedMyProfileData()));
  }

  void modifyEdited(
    Emitter<MyProfileData> emit,
    EditedMyProfileData Function(EditedMyProfileData) modify,
  ) {
    emit(state.copyWith(edited: modify(state.edited)));
  }

  @override
  Future<void> close() async {
    await _profileSubscription?.cancel();
    await _initialAgeInfoSubscription?.cancel();
    await super.close();
  }
}
