import "dart:async";
import "dart:io";
import "dart:typed_data";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/logic/media/profile_pictures_interface.dart";
import "package:app/ui_utils/crop_image_screen.dart";
import "package:app/ui_utils/profile_pictures.dart";
import "package:app/utils/age.dart";
import "package:app/utils/result.dart";
import "package:collection/collection.dart";
import "package:database/database.dart";
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
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/immutable_list.dart";

final _log = Logger("InitialSetupBloc");

sealed class InitialSetupEvent {}

// Internal event for DB value updates
class _NewProgressData extends InitialSetupEvent {
  final InitialSetupProgressEntry? data;
  _NewProgressData(this.data);
}

// Public events for UI updates (these will write to DB)
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

class SetFirstChatBackupCreated extends InitialSetupEvent {
  final bool created;
  SetFirstChatBackupCreated(this.created);
}

class UpdateAttributeValue extends InitialSetupEvent {
  final ProfileAttributeValueUpdate update;
  UpdateAttributeValue(this.update);
}

class SetCurrentPage extends InitialSetupEvent {
  final String pageName;
  SetCurrentPage(this.pageName);
}

class CompleteInitialSetup extends InitialSetupEvent {}

class ResetState extends InitialSetupEvent {}

class CreateDebugAdminAccount extends InitialSetupEvent {}

class SkipInitialSetup extends InitialSetupEvent {}

class RefreshSecuritySelfieFaceDetectedValue extends InitialSetupEvent {}

class RefreshProfilePicturesFaceDetectedValues extends InitialSetupEvent {}

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

  StreamSubscription<InitialSetupProgressEntry?>? _progressSubscription;

  InitialSetupBloc(RepositoryInstances r)
    : account = r.account,
      currentUser = r.accountId,
      db = r.accountDb,
      api = r.api,
      currentAccount = r.accountId,
      super(InitialSetupData()) {
    // Internal DB update handler - single event for all progress data
    on<_NewProgressData>((data, emit) {
      if (data.data == null) {
        emit(InitialSetupData(loadingComplete: true));
        return;
      }

      final progress = data.data!;

      // Build security selfie if all parts are present (slot is always 0)
      ProcessedAccountImage? securitySelfie;
      if (progress.securitySelfieContentId != null && progress.securitySelfieFaceDetected != null) {
        securitySelfie = ProcessedAccountImage(
          currentAccount,
          ContentId(cid: progress.securitySelfieContentId!),
          0, // Security selfie slot is always 0
          progress.securitySelfieFaceDetected!,
        );
      }

      // Parse gender
      final gender = progress.gender != null ? _parseGender(progress.gender!) : null;

      // Build gender search settings
      final genderSearchSetting = GenderSearchSettingsAll(
        men: progress.searchSettingMen ?? false,
        women: progress.searchSettingWomen ?? false,
        nonBinary: progress.searchSettingNonBinary ?? false,
      );

      // Build location
      LatLng? location;
      if (progress.latitude != null && progress.longitude != null) {
        location = LatLng(progress.latitude!, progress.longitude!);
      }

      // Build profile attributes
      final profileAttributes = ProfileAttributesState(progress.profileAttributes ?? []);

      // Build profile images from DB data
      final profileImages = <ImgState>[];
      if (progress.profileImages != null) {
        for (final entry in progress.profileImages!) {
          profileImages.add(
            ImageSelected(
              AccountImageId(
                currentAccount,
                ContentId(cid: entry.contentId),
                entry.faceDetected,
                entry.accepted,
              ),
              entry.slot,
              cropArea: CropArea.fromValues(entry.cropSize, entry.cropX, entry.cropY),
            ),
          );
        }
      }
      // Fill remaining slots with Empty
      while (profileImages.length < 4) {
        profileImages.add(const Empty());
      }

      emit(
        state.copyWith(
          email: progress.email,
          isAdult: progress.isAdult,
          profileName: progress.profileName,
          profileAge: progress.profileAge,
          securitySelfie: securitySelfie,
          profileImages: ImmutableList(profileImages),
          gender: gender,
          genderSearchSetting: genderSearchSetting,
          searchAgeRangeInitDone: progress.searchAgeRangeInitDone ?? false,
          searchAgeRangeMin: progress.searchAgeRangeMin,
          searchAgeRangeMax: progress.searchAgeRangeMax,
          profileLocation: location,
          profileAttributes: profileAttributes,
          firstChatBackupCreated: progress.firstChatBackupCreated ?? false,
          loadingComplete: true,
        ),
      );
    });

    // Public event handlers that write to DB
    on<ResetState>((data, emit) async {
      await db.accountAction((db) => db.progress.clearInitialSetupProgress());
    });
    on<SetAgeConfirmation>((data, emit) async {
      await db.accountAction((db) => db.progress.updateInitialSetupIsAdult(data.isAdult));
    });
    on<SetEmail>((data, emit) async {
      await db.accountAction((db) => db.progress.updateInitialSetupEmail(data.email));
    });
    on<SetProfileName>((data, emit) async {
      await db.accountAction((db) => db.progress.updateInitialSetupProfileName(data.value));
    });
    on<SetProfileAge>((data, emit) async {
      await db.accountAction((db) => db.progress.updateInitialSetupProfileAge(data.age));
    });
    on<SetSecuritySelfie>((data, emit) async {
      await db.accountAction(
        (db) => db.progress.updateInitialSetupSecuritySelfie(
          contentId: data.securitySelfie.contentId.cid,
          faceDetected: data.securitySelfie.faceDetected,
        ),
      );
    });
    on<SetProfileImages>((data, emit) async {
      // Convert ImgState list to ProfilePictureEntry list
      final entries = <ProfilePictureEntry>[];

      for (final img in data.profileImages) {
        if (img is ImageSelected) {
          entries.add(
            ProfilePictureEntry(
              contentId: img.id.contentId.cid,
              slot: img.slot,
              faceDetected: img.id.faceDetected,
              accepted: img.id.accepted,
              cropSize: img.cropArea.gridCropSize,
              cropX: img.cropArea.gridCropX,
              cropY: img.cropArea.gridCropY,
            ),
          );
        }
      }

      await db.accountAction((db) => db.progress.updateInitialSetupProfileImages(entries));
    });
    on<SetGender>((data, emit) async {
      await db.accountAction(
        (db) => db.progress.updateInitialSetupGender(_genderToString(data.gender)),
      );
      // Reset search settings when gender changes
      await db.accountAction(
        (db) => db.progress.updateInitialSetupGenderSearchSettings(
          men: false,
          women: false,
          nonBinary: false,
        ),
      );
    });
    on<SetGenderSearchSetting>((data, emit) async {
      await db.accountAction(
        (db) => db.progress.updateInitialSetupGenderSearchSettings(
          men: data.settings.men,
          women: data.settings.women,
          nonBinary: data.settings.nonBinary,
        ),
      );
    });
    on<InitAgeRange>((data, emit) async {
      await db.accountAction(
        (db) => db.progress.updateInitialSetupSearchAgeRange(
          initDone: true,
          min: data.min,
          max: data.max,
        ),
      );
    });
    on<SetAgeRangeMin>((data, emit) async {
      var max = state.searchAgeRangeMax ?? MAX_AGE;
      if (data.min > max) {
        max = data.min;
      }
      await db.accountAction(
        (db) => db.progress.updateInitialSetupSearchAgeRange(min: data.min, max: max),
      );
    });
    on<SetAgeRangeMax>((data, emit) async {
      var min = state.searchAgeRangeMin ?? MIN_AGE;
      if (data.max < min) {
        min = data.max;
      }
      await db.accountAction(
        (db) => db.progress.updateInitialSetupSearchAgeRange(min: min, max: data.max),
      );
    });
    on<SetLocation>((data, emit) async {
      await db.accountAction(
        (db) =>
            db.progress.updateInitialSetupLocation(data.location.latitude, data.location.longitude),
      );
    });
    on<SetFirstChatBackupCreated>((data, emit) async {
      await db.accountAction(
        (db) => db.progress.updateInitialSetupFirstChatBackupCreated(data.created),
      );
    });
    on<UpdateAttributeValue>((data, emit) async {
      final updated = state.profileAttributes.addOrReplace(data.update);
      await db.accountAction(
        (db) => db.progress.updateInitialSetupProfileAttributes(updated.answers),
      );
    });
    on<SetCurrentPage>((data, emit) async {
      await db.accountAction((db) => db.progress.updateInitialSetupCurrentPage(data.pageName));
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
          // Update DB with new face detected value
          await db.accountAction(
            (db) => db.progress.updateInitialSetupSecuritySelfie(
              contentId: securitySelfie.contentId.cid,
              faceDetected: newSecuritySelfieState.fd,
            ),
          );
        }
      }

      showSnackBar(R.strings.generic_action_completed);
    });
    on<RefreshProfilePicturesFaceDetectedValues>((data, emit) async {
      final r = await api.media((api) => api.getAllAccountMediaContent(currentAccount.aid)).ok();
      if (r == null) {
        showSnackBar(R.strings.generic_error_occurred);
        return;
      }

      final profileImages = state.valuePictures();
      bool changed = false;
      for (final (i, img) in profileImages.indexed) {
        if (img is ImageSelected) {
          final newImgState = r.data.firstWhereOrNull((v) => v.cid == img.id.contentId);
          if (newImgState != null && newImgState.fd != img.id.faceDetected) {
            profileImages[i] = img.copyWithFaceDetected(newImgState.fd);
            changed = true;
          }
        }
      }

      if (changed) {
        add(SetProfileImages(profileImages));
      }

      showSnackBar(R.strings.generic_action_completed);
    });
    on<AddProcessedImageToSetup>((data, emit) {
      final newImages = state.valuePictures();
      newImages[data.index] = data.img;
      add(SetProfileImages(newImages));
    });
    on<UpdateCropAreaInSetup>((data, emit) {
      final newImages = state.valuePictures();
      final imgState = newImages[data.index];
      if (imgState is ImageSelected) {
        newImages[data.index] = ImageSelected(imgState.id, imgState.slot, cropArea: data.cropArea);
        add(SetProfileImages(newImages));
      }
    });
    on<RemoveImageFromSetup>((data, emit) {
      final newImages = state.valuePictures();
      newImages[data.index] = const Empty();
      add(SetProfileImages(newImages));
    });
    on<MoveImageInSetup>((data, emit) {
      final newImages = state.valuePictures();
      final temp = newImages[data.src];
      newImages[data.src] = newImages[data.dst];
      newImages[data.dst] = temp;
      add(SetProfileImages(newImages));
    });

    // Single subscription for all initial setup progress data
    _progressSubscription = db
        .accountStream((db) => db.progress.watchInitialSetupProgress())
        .listen((data) {
          add(_NewProgressData(data));
        });
  }

  @override
  Future<void> close() async {
    await _progressSubscription?.cancel();
    await super.close();
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

Gender? _parseGender(String value) {
  return switch (value) {
    'man' => Gender.man,
    'woman' => Gender.woman,
    'nonBinary' => Gender.nonBinary,
    _ => null,
  };
}

String _genderToString(Gender gender) {
  return switch (gender) {
    Gender.man => 'man',
    Gender.woman => 'woman',
    Gender.nonBinary => 'nonBinary',
  };
}
