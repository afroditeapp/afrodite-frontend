import "dart:io";
import "dart:typed_data";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/logic/media/profile_pictures_interface.dart";
import "package:app/ui_utils/crop_image_screen.dart";
import "package:app/utils/age.dart";
import "package:app/utils/result.dart";
import "package:collection/collection.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:latlong2/latlong.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import 'package:image/image.dart' as img;
import 'package:utils/utils.dart';

import "package:app/data/account_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/media/image_processing.dart";
import "package:app/model/freezed/logic/media/profile_pictures.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/immutable_list.dart";

final _log = Logger("InitialSetupBloc");

sealed class InitialSetupEvent {}

class SetAgeConfirmation extends InitialSetupEvent {
  final bool isAdult;
  SetAgeConfirmation(this.isAdult);
}

class SetEmail extends InitialSetupEvent {
  final String email;
  SetEmail(this.email);
}

class SetProfileName extends InitialSetupEvent {
  final String value;
  SetProfileName(this.value);
}

class SetProfileAge extends InitialSetupEvent {
  final int? age;
  SetProfileAge(this.age);
}

class SetSecuritySelfie extends InitialSetupEvent {
  final ProcessedAccountImage securitySelfie;
  SetSecuritySelfie(this.securitySelfie);
}

class SendSecuritySelfie extends InitialSetupEvent {
  final File securitySelfie;
  SendSecuritySelfie(this.securitySelfie);
}

class SetProfileImages extends InitialSetupEvent {
  final List<ImgState> profileImages;
  SetProfileImages(this.profileImages);
}

class SetGender extends InitialSetupEvent {
  final Gender gender;
  SetGender(this.gender);
}

class SetGenderSearchSetting extends InitialSetupEvent {
  final GenderSearchSettingsAll settings;
  SetGenderSearchSetting(this.settings);
}

class InitAgeRange extends InitialSetupEvent {
  final int min;
  final int max;
  InitAgeRange(this.min, this.max);
}

class SetAgeRangeMin extends InitialSetupEvent {
  final int min;
  SetAgeRangeMin(this.min);
}

class SetAgeRangeMax extends InitialSetupEvent {
  final int max;
  SetAgeRangeMax(this.max);
}

class SetLocation extends InitialSetupEvent {
  final LatLng location;
  SetLocation(this.location);
}

class SetChatInfoUnderstood extends InitialSetupEvent {
  final bool understood;
  SetChatInfoUnderstood(this.understood);
}

class UpdateAttributeValue extends InitialSetupEvent {
  final ProfileAttributeValueUpdate update;
  UpdateAttributeValue(this.update);
}

class CompleteInitialSetup extends InitialSetupEvent {}

class ResetState extends InitialSetupEvent {}

class CreateDebugAdminAccount extends InitialSetupEvent {}

class SkipInitialSetup extends InitialSetupEvent {}

class RefreshSecuritySelfieFaceDetectedValue extends InitialSetupEvent {}

class AddProcessedImageToSetup extends InitialSetupEvent {
  final ImageSelected img;
  final int index;
  AddProcessedImageToSetup(this.img, this.index);
}

class UpdateCropAreaInSetup extends InitialSetupEvent {
  final CropArea cropArea;
  final int index;
  UpdateCropAreaInSetup(this.cropArea, this.index);
}

class RemoveImageFromSetup extends InitialSetupEvent {
  final int index;
  RemoveImageFromSetup(this.index);
}

class MoveImageInSetup extends InitialSetupEvent {
  final int src;
  final int dst;
  MoveImageInSetup(this.src, this.dst);
}

class InitialSetupBloc extends Bloc<InitialSetupEvent, InitialSetupData>
    with ActionRunner
    implements ProfilePicturesBlocInterface<InitialSetupData> {
  final AccountRepository account;
  final AccountId currentUser;
  final AccountDatabaseManager db;
  final ApiManager api;
  final AccountId currentAccount;

  InitialSetupBloc(RepositoryInstances r)
    : account = r.account,
      currentUser = r.accountId,
      db = r.accountDb,
      api = r.api,
      currentAccount = r.accountId,
      super(InitialSetupData()) {
    on<ResetState>((data, emit) {
      emit(InitialSetupData());
    });
    on<SetAgeConfirmation>((data, emit) {
      emit(state.copyWith(isAdult: data.isAdult));
    });
    on<SetEmail>((data, emit) {
      emit(state.copyWith(email: data.email));
    });
    on<SetProfileName>((data, emit) {
      emit(state.copyWith(profileName: data.value));
    });
    on<SetProfileAge>((data, emit) {
      emit(state.copyWith(profileAge: data.age));
    });
    on<SetSecuritySelfie>((data, emit) {
      emit(state.copyWith(securitySelfie: data.securitySelfie));
    });
    on<SetProfileImages>((data, emit) async {
      emit(state.copyWith(profileImages: ImmutableList(data.profileImages)));
    });
    on<SetGender>((data, emit) async {
      emit(
        state.copyWith(gender: data.gender, genderSearchSetting: const GenderSearchSettingsAll()),
      );
    });
    on<SetGenderSearchSetting>((data, emit) async {
      emit(state.copyWith(genderSearchSetting: data.settings));
    });
    on<InitAgeRange>((data, emit) async {
      emit(
        state.copyWith(
          searchAgeRangeMin: data.min,
          searchAgeRangeMax: data.max,
          searchAgeRangeInitDone: true,
        ),
      );
    });
    on<SetAgeRangeMin>((data, emit) async {
      var max = state.searchAgeRangeMax ?? MAX_AGE;

      if (data.min > max) {
        max = data.min;
      }

      emit(state.copyWith(searchAgeRangeMin: data.min, searchAgeRangeMax: max));
    });
    on<SetAgeRangeMax>((data, emit) async {
      var min = state.searchAgeRangeMin ?? MIN_AGE;

      if (data.max < min) {
        min = data.max;
      }

      emit(state.copyWith(searchAgeRangeMin: min, searchAgeRangeMax: data.max));
    });
    on<SetLocation>((data, emit) async {
      emit(state.copyWith(profileLocation: data.location));
    });
    on<SetChatInfoUnderstood>((data, emit) async {
      emit(state.copyWith(chatInfoUnderstood: data.understood));
    });
    on<UpdateAttributeValue>((data, emit) async {
      emit(state.copyWith(profileAttributes: state.profileAttributes.addOrReplace(data.update)));
    });
    on<CompleteInitialSetup>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(sendingInProgress: true));
        var result = await account.doInitialSetup(state);

        if (result.isErr()) {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(sendingInProgress: false));
      });
    });
    on<CreateDebugAdminAccount>((data, emit) async {
      emit(state.copyWith(sendingInProgress: true));

      final securitySelfie = await createImage("debug_security_selfie.jpg", (pixel) {
        pixel
          ..r = 0
          ..g = 145
          ..b = 255
          ..a = 255;
      });

      final profileImage = await createImage("debug_profile_image.jpg", (pixel) {
        pixel
          ..r = 255
          ..g = 150
          ..b = 0
          ..a = 255;
      });

      var error = await account.doDeveloperInitialSetup(
        "${currentUser.aid}@example.com",
        "Admin",
        securitySelfie,
        profileImage,
      );

      if (error != null) {
        _log.error("Developer initial setup failed: $error");
        showSnackBar(R.strings.generic_error_occurred);
      }

      emit(state.copyWith(sendingInProgress: false));
    });
    on<SkipInitialSetup>((data, emit) async {
      final r = await db.accountAction((db) => db.app.updateInitialSetupSkipped(true));
      if (r.isErr()) {
        showSnackBar(R.strings.generic_error_occurred);
      }
    });
    on<RefreshSecuritySelfieFaceDetectedValue>((data, emit) async {
      final r = await api.media((api) => api.getAllAccountMediaContent(currentAccount.aid)).ok();
      if (r == null) {
        showSnackBar(R.strings.generic_error_occurred);
        return;
      }

      final securitySelfie = state.securitySelfie;
      if (securitySelfie != null) {
        final newSecuritySelfieState = r.data.firstWhereOrNull(
          (v) => v.cid == securitySelfie.contentId,
        );
        if (newSecuritySelfieState != null) {
          emit(
            state.copyWith(
              securitySelfie: securitySelfie.copyWithFaceDetectedValue(newSecuritySelfieState.fd),
            ),
          );
        }
      }

      showSnackBar(R.strings.generic_action_completed);
    });
    on<AddProcessedImageToSetup>((data, emit) {
      final newImages = state.valuePictures();
      newImages[data.index] = data.img;
      emit(state.copyWith(profileImages: ImmutableList(newImages)));
    });
    on<UpdateCropAreaInSetup>((data, emit) {
      final newImages = state.valuePictures();
      final imgState = newImages[data.index];
      if (imgState is ImageSelected) {
        newImages[data.index] = ImageSelected(imgState.id, imgState.slot, cropArea: data.cropArea);
        emit(state.copyWith(profileImages: ImmutableList(newImages)));
      }
    });
    on<RemoveImageFromSetup>((data, emit) {
      final newImages = state.valuePictures();
      newImages[data.index] = const Empty();
      emit(state.copyWith(profileImages: ImmutableList(newImages)));
    });
    on<MoveImageInSetup>((data, emit) {
      final newImages = state.valuePictures();
      final temp = newImages[data.src];
      newImages[data.src] = newImages[data.dst];
      newImages[data.dst] = temp;
      emit(state.copyWith(profileImages: ImmutableList(newImages)));
    });
  }

  // ProfilePicturesBlocInterface implementation
  @override
  void addProcessedImage(ImageSelected img, int profileImagesIndex) {
    add(AddProcessedImageToSetup(img, profileImagesIndex));
  }

  @override
  void updateCropArea(CropArea cropArea, int imgIndex) {
    add(UpdateCropAreaInSetup(cropArea, imgIndex));
  }

  @override
  void removeImage(int imgIndex) {
    add(RemoveImageFromSetup(imgIndex));
  }

  @override
  void moveImageTo(int src, int dst) {
    add(MoveImageInSetup(src, dst));
  }
}

Future<Uint8List> createImage(String fileName, void Function(img.Pixel) pixelModifier) async {
  final imageBuffer = img.Image(width: 512, height: 512);

  for (var pixel in imageBuffer) {
    pixelModifier(pixel);
  }

  return img.encodeJpg(imageBuffer);
}
