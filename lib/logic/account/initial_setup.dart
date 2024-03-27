import "dart:io";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:latlong2/latlong.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:image/image.dart' as img;
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/media/image_processing.dart";
import "package:pihka_frontend/logic/media/profile_pictures.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/tmp_dir.dart";

part 'initial_setup.freezed.dart';

// TODO(prod): Figure out email address changing?
//  Remove it from complete initial setup?
//  Allow changeing email in AccountData only if it null?
//  That allows easy debugging.

final log = Logger("InitialSetupBloc");

@freezed
class InitialSetupData with _$InitialSetupData {
  factory InitialSetupData({
    String? email,
    DateTime? birthdate,
    String? profileInitial,
    int? profileAge,
    ProcessedAccountImage? securitySelfie,
    List<ImgState>? profileImages,
    Gender? gender,
    @Default(GenderSearchSettingsAll()) GenderSearchSettingsAll genderSearchSetting,
    @Default(false) bool searchAgeRangeInitDone,
    int? searchAgeRangeMin,
    int? searchAgeRangeMax,
    LatLng? profileLocation,
    @Default(PartiallyAnswered([]))ProfileAttributesState profileAttributes,
    String? sendError, // TODO: remove?
    @Default(false) bool sendingInProgress, // TODO: remove?
  }) = _InitialSetupData;
}

sealed class InitialSetupEvent {}

class SetBirthdate extends InitialSetupEvent {
  final DateTime birthdate;
  SetBirthdate(this.birthdate);
}
class SetEmail extends InitialSetupEvent {
  final String email;
  SetEmail(this.email);
}
class SetInitialLetter extends InitialSetupEvent {
  final String initial;
  SetInitialLetter(this.initial);
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
class CompleteInitialSetup extends InitialSetupEvent {}
class ResetState extends InitialSetupEvent {}
class CreateDebugAdminAccount extends InitialSetupEvent {}

class InitialSetupBloc extends Bloc<InitialSetupEvent, InitialSetupData> {
  final LoginRepository login = LoginRepository.getInstance();
  final AccountRepository account = AccountRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();

  InitialSetupBloc() : super(InitialSetupData()) {
    on<ResetState>((data, emit) {
      emit(InitialSetupData());
    });
    on<SetBirthdate>((data, emit) {
      emit(state.copyWith(
        birthdate: data.birthdate,
      ));
    });
    on<SetEmail>((data, emit) {
      emit(state.copyWith(
        email: data.email,
      ));
    });
    on<SetInitialLetter>((data, emit) {
      emit(state.copyWith(
        profileInitial: data.initial,
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
        profileImages: data.profileImages,
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
    on<CompleteInitialSetup>((data, emit) async {
      // //await Future.delayed(Duration(seconds: 5));
      // var error = await account.doInitialSetup(
      //   state.email ?? "",
      //   state.profileName,
      //   securitySelfie,
      //   profileImage
      // );

      // if (error != null) {
      //   emit(state.copyWith(
      //     sendingInProgress: false,
      //     sendError: error,
      //   ));
      // }
      log.error("TODO");
    });
    on<CreateDebugAdminAccount>((data, emit) async {
      emit(state.copyWith(
        sendingInProgress: true,
        sendError: null,
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

      var error = await account.doInitialSetup(
        "admin@example.com",
        "Admin",
        securitySelfie,
        profileImage,
      );

      if (error != null) {
        emit(state.copyWith(
          sendingInProgress: false,
          sendError: error,
        ));
      }
    });
  }
}

Future<XFile> createImage(String fileName, void Function(img.Pixel) pixelModifier) async {
  final imageBuffer = img.Image(width: 512, height: 512);

  for (var pixel in imageBuffer) {
    pixelModifier(pixel);
  }

  final jpg = img.encodeJpg(imageBuffer);
  final imgPath = await TmpDirUtils.initialSetupFilePath(fileName);
  await XFile.fromData(jpg).saveTo(imgPath);
  return XFile(imgPath);
}


enum Gender {
  man,
  woman,
  nonBinary;

  String uiTextSingular(BuildContext context) {
    return switch (this) {
      man => context.strings.generic_gender_man,
      woman => context.strings.generic_gender_woman,
      nonBinary => context.strings.generic_gender_nonbinary,
    };
  }

  String uiTextPlural(BuildContext context) {
    return switch (this) {
      man => context.strings.generic_gender_man_plural,
      woman => context.strings.generic_gender_woman_plural,
      nonBinary => context.strings.generic_gender_nonbinary_plural,
    };
  }
}

enum GenderSearchSetting {
  men,
  women,
  all;

  String uiText(BuildContext context) {
    return switch (this) {
      men => context.strings.generic_gender_man_plural,
      women => context.strings.generic_gender_woman_plural,
      all => context.strings.generic_search_settings_looking_for_all_genders_text,
    };
  }

  GenderSearchSettingsAll toGenderSearchSettingsAll() {
    return switch (this) {
      men => const GenderSearchSettingsAll(men: true),
      women => const GenderSearchSettingsAll(women: true),
      all => const GenderSearchSettingsAll(men: true, women: true, nonBinary: true),
    };
  }
}

class GenderSearchSettingsAll {
  final bool men;
  final bool women;
  final bool nonBinary;
  const GenderSearchSettingsAll({
    this.men = false,
    this.women = false,
    this.nonBinary = false,
  });

  GenderSearchSetting? toGenderSearchSetting() {
    return switch (this) {
      GenderSearchSettingsAll(men: true, women: true, nonBinary: true) => GenderSearchSetting.all,
      GenderSearchSettingsAll(men: true, women: false) => GenderSearchSetting.men,
      GenderSearchSettingsAll(women: true, men: false) => GenderSearchSetting.women,
      _ => null,
    };
  }

  GenderSearchSettingsAll updateWith(bool value, Gender whatUpdated) {
    return switch (whatUpdated) {
      Gender.man => GenderSearchSettingsAll(men: value, women: women, nonBinary: nonBinary),
      Gender.woman => GenderSearchSettingsAll(men: men, women: value, nonBinary: nonBinary),
      Gender.nonBinary => GenderSearchSettingsAll(men: men, women: women, nonBinary: value),
    };
  }

  bool notEmpty() {
    return men || women || nonBinary;
  }
}


sealed class ProfileAttributesState {
  final List<ProfileAttributeValueUpdate> answers;
  const ProfileAttributesState(this.answers);
}
class PartiallyAnswered extends ProfileAttributesState {
  const PartiallyAnswered(super.answers);
}
class FullyAnswered extends ProfileAttributesState {
  const FullyAnswered(super.answers);
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
        var v = value.valuePart1 ?? 0;
        v |= modifyCmd.attributeValue.id;
        value.valuePart1 = v;
      } else {
        var v = value.valuePart1 ?? 0;
        v &= ~modifyCmd.attributeValue.id;
        value.valuePart1 = v;
      }
    }
  }

  if (!updated) {
    newAnswers.add(ProfileAttributeValueUpdate(
      id: modifyCmd.attribute.id,
      valuePart1: modifyCmd.value ? modifyCmd.attributeValue.id : 0,
    ));
  }

  if (newAnswers.length == modifyCmd.requiredAttributeCount && newAnswers.every((v) => v.valuePart1 != 0)) {
    return FullyAnswered(newAnswers);
  } else {
    return PartiallyAnswered(newAnswers);
  }
}
