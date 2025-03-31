import "dart:io";
import "dart:typed_data";

import "package:app/database/account_database_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:latlong2/latlong.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import 'package:image/image.dart' as img;
import 'package:utils/utils.dart';

import "package:app/data/account_repository.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/media/image_processing.dart";
import "package:app/model/freezed/logic/media/profile_pictures.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/api.dart";
import "package:app/utils/immutable_list.dart";


// TODO(prod): Figure out email address changing?
//  Remove it from complete initial setup?
//  Allow changeing email in AccountData only if it null?
//  That allows easy debugging.

final log = Logger("InitialSetupBloc");

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
  final int? min;
  SetAgeRangeMin(this.min);
}
class SetAgeRangeMax extends InitialSetupEvent {
  final int? max;
  SetAgeRangeMax(this.max);
}
class SetLocation extends InitialSetupEvent {
  final LatLng location;
  SetLocation(this.location);
}
class SetProfileAttributesState extends InitialSetupEvent {
  final ProfileAttributesState attributeState;
  SetProfileAttributesState(this.attributeState);
}
class ModifyProfileAttributeBitflagValue extends InitialSetupEvent {
  final int requiredAttributeCount;
  final Attribute attribute;
  final AttributeValue attributeValue;
  final bool value;
  ModifyProfileAttributeBitflagValue(this.requiredAttributeCount, this.attribute, this.attributeValue, this.value);
}
class SetUnlimitedLikes extends InitialSetupEvent {
  final bool value;
  SetUnlimitedLikes(this.value);
}
class CompleteInitialSetup extends InitialSetupEvent {}
class ResetState extends InitialSetupEvent {}
class CreateDebugAdminAccount extends InitialSetupEvent {}
class SkipInitialSetup extends InitialSetupEvent {}

class InitialSetupBloc extends Bloc<InitialSetupEvent, InitialSetupData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();
  final AccountRepository account = LoginRepository.getInstance().repositories.account;
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final AccountId currentUser = LoginRepository.getInstance().repositories.accountId;
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  InitialSetupBloc() : super(InitialSetupData()) {
    on<ResetState>((data, emit) {
      emit(InitialSetupData());
    });
    on<SetAgeConfirmation>((data, emit) {
      emit(state.copyWith(
        isAdult: data.isAdult,
      ));
    });
    on<SetEmail>((data, emit) {
      emit(state.copyWith(
        email: data.email,
      ));
    });
    on<SetProfileName>((data, emit) {
      emit(state.copyWith(
        profileName: data.value,
      ));
    });
    on<SetProfileAge>((data, emit) {
      emit(state.copyWith(
        profileAge: data.age,
      ));
    });
    on<SetSecuritySelfie>((data, emit) {
      emit(state.copyWith(
        securitySelfie: data.securitySelfie,
      ));
    });
    on<SetProfileImages>((data, emit) async {
      emit(state.copyWith(
        profileImages: ImmutableList(data.profileImages),
      ));
    });
    on<SetGender>((data, emit) async {
      emit(state.copyWith(
        gender: data.gender,
        genderSearchSetting: const GenderSearchSettingsAll(),
      ));
    });
    on<SetGenderSearchSetting>((data, emit) async {
      emit(state.copyWith(
        genderSearchSetting: data.settings,
      ));
    });
    on<InitAgeRange>((data, emit) async {
      emit(state.copyWith(
        searchAgeRangeMin: data.min,
        searchAgeRangeMax: data.max,
        searchAgeRangeInitDone: true,
      ));
    });
    on<SetAgeRangeMin>((data, emit) async {
      emit(state.copyWith(
        searchAgeRangeMin: data.min,
      ));
    });
    on<SetAgeRangeMax>((data, emit) async {
      emit(state.copyWith(
        searchAgeRangeMax: data.max,
      ));
    });
    on<SetLocation>((data, emit) async {
      emit(state.copyWith(
        profileLocation: data.location,
      ));
    });
    on<SetProfileAttributesState>((data, emit) async {
      emit(state.copyWith(
        profileAttributes: data.attributeState,
      ));
    });
    on<ModifyProfileAttributeBitflagValue>((data, emit) async {
      emit(state.copyWith(
        profileAttributes: modifyAttributes(data, state.profileAttributes),
      ));
    });
    on<SetUnlimitedLikes>((data, emit) async {
      emit(state.copyWith(
        unlimitedLikes: data.value,
      ));
    });
    on<CompleteInitialSetup>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(
          sendingInProgress: true,
        ));
        var result = await account.doInitialSetup(
          state,
        );

        if (result.isErr()) {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(
          sendingInProgress: false,
        ));
      });
    });
    on<CreateDebugAdminAccount>((data, emit) async {
      emit(state.copyWith(
        sendingInProgress: true,
      ));

      final securitySelfie = await createImage("debug_security_selfie.jpg", (pixel) {
        pixel..r = 0
             ..g = 145
             ..b = 255
             ..a = 255;
      });

      final profileImage = await createImage("debug_profile_image.jpg", (pixel) {
        pixel..r = 255
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
        log.error("Developer initial setup failed: $error");
        showSnackBar(R.strings.generic_error_occurred);
      }

      emit(state.copyWith(
        sendingInProgress: false,
      ));
    });
    on<SkipInitialSetup>((data, emit) async {
      final r = await db.accountAction((db) => db.daoInitialSetup.updateInitialSetupSkipped(true));
      if (r.isErr()) {
        showSnackBar(R.strings.generic_error_occurred);
      }
    });
  }
}

Future<Uint8List> createImage(String fileName, void Function(img.Pixel) pixelModifier) async {
  final imageBuffer = img.Image(width: 512, height: 512);

  for (var pixel in imageBuffer) {
    pixelModifier(pixel);
  }

  return img.encodeJpg(imageBuffer);
}


ProfileAttributesState modifyAttributes(
  ModifyProfileAttributeBitflagValue modifyCmd,
  ProfileAttributesState currentState
) {

  final newAnswers = currentState.answers.toList();

  bool updated = false;
  for (final value in newAnswers) {
    if (value.id == modifyCmd.attribute.id) {
      updated = true;
      if (modifyCmd.value) {
        var v = value.bitflagValue() ?? 0;
        v |= modifyCmd.attributeValue.id;
        value.setBitflagValue(v);
      } else {
        var v = value.bitflagValue() ?? 0;
        v &= ~modifyCmd.attributeValue.id;
        value.setBitflagValue(v);
      }
    }
  }

  if (!updated) {
    newAnswers.add(ProfileAttributeValueUpdate(
      id: modifyCmd.attribute.id,
      v: [modifyCmd.value ? modifyCmd.attributeValue.id : 0],
    ));
  }

  if (newAnswers.length == modifyCmd.requiredAttributeCount && newAnswers.every((v) => v.bitflagValue() != 0)) {
    return FullyAnswered(newAnswers);
  } else {
    return PartiallyAnswered(newAnswers);
  }
}
