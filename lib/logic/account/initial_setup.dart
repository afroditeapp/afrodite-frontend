import "dart:io";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
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

  String uiText(BuildContext context) {
    return switch (this) {
      man => context.strings.generic_gender_man,
      woman => context.strings.generic_gender_woman,
      nonBinary => context.strings.generic_gender_nonbinary,
    };
  }
}
