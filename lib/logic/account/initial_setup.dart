import "dart:io";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:image/image.dart' as img;
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/media/send_to_slot.dart";
import "package:pihka_frontend/localizations.dart";
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
    @Default("") String profileName,
    DateTime? birthdate,
    InitialSetupSecuritySelfieState? securitySelfieState,
    SelectedSecuritySelfie? securitySelfie,
    XFile? profileImage,
    String? sendError,
    @Default(false) bool sendingInProgress,
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
class SetProfileStep extends InitialSetupEvent {
  final String profileName;
  SetProfileStep(this.profileName);
}
class SetSecuritySelfieState extends InitialSetupEvent {
  final InitialSetupSecuritySelfieState? securitySelfieState;
  SetSecuritySelfieState(this.securitySelfieState);
}
class SetSecuritySelfie extends InitialSetupEvent {
  final SelectedSecuritySelfie securitySelfie;
  SetSecuritySelfie(this.securitySelfie);
}
class SendSecuritySelfie extends InitialSetupEvent {
  final File securitySelfie;
  SendSecuritySelfie(this.securitySelfie);
}
class SetProfileImageStep extends InitialSetupEvent {
  final XFile profileImage;
  SetProfileImageStep(this.profileImage);
}
class ResetState extends InitialSetupEvent {
  ResetState();
}
class CreateDebugAdminAccount extends InitialSetupEvent {
  CreateDebugAdminAccount();
}

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
    on<SetProfileStep>((data, emit) {
      emit(state.copyWith(
        profileName: data.profileName,
      ));
    });
    on<SetSecuritySelfieState>((data, emit) {
      emit(state.copyWith(
        securitySelfieState: data.securitySelfieState,
      ));
    });
    on<SetSecuritySelfie>((data, emit) {
      emit(state.copyWith(
        securitySelfie: data.securitySelfie,
      ));
    });
    on<SendSecuritySelfie>((data, emit) async {
      emit(state.copyWith(
        securitySelfieState: InitialSetupSecuritySelfieSendingInProgress(DataUploadInProgress()),
      ));

      final accountId = await login.accountId.first;
      if (accountId == null) {
        emit(state.copyWith(
          securitySelfieState: InitialSetupSecuritySelfieSendingFailed(),
        ));
        return;
      }

      await for (final e in media.sendImageToSlot(data.securitySelfie, 0)) {
        switch (e) {
          case Uploading(): {}
          case UploadCompleted(): {}
          case InProcessingQueue(:final queueNumber): {
            final selfieState = InitialSetupSecuritySelfieSendingInProgress(ServerDataProcessingInProgress(queueNumber));
            emit(state.copyWith(
              securitySelfieState: selfieState,
            ));
          }
          case Processing(): {
            final selfieState = InitialSetupSecuritySelfieSendingInProgress(ServerDataProcessingInProgress(null));
            emit(state.copyWith(
              securitySelfieState: selfieState,
            ));
          }
          case ProcessingCompleted(:final contentId): {
            emit(state.copyWith(
              securitySelfieState: null,
              securitySelfie: SelectedSecuritySelfie(accountId, contentId),
            ));
          }
          case SendToSlotError(): {
            emit(state.copyWith(
              securitySelfieState: InitialSetupSecuritySelfieSendingFailed(),
            ));
          }
        }
      }
    });

    on<SetProfileImageStep>((data, emit) async {
      emit(state.copyWith(
        profileImage: data.profileImage,
        sendingInProgress: true,
        sendError: null,
      ));


      final securitySelfie = state.securitySelfie;
      if (securitySelfie == null) {
        emit(state.copyWith(
          sendingInProgress: false,
          sendError: "Missing security selfie",
        ));
        return;
      }

      final profileImage = state.profileImage;
      if (profileImage == null) {
        emit(state.copyWith(
          sendingInProgress: false,
          sendError: "Missing profile image",
        ));
        return;
      }

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

sealed class InitialSetupSecuritySelfieState {}
class InitialSetupSecuritySelfieUnconfirmedImage extends InitialSetupSecuritySelfieState {
  final File image;
  InitialSetupSecuritySelfieUnconfirmedImage(this.image);
}
class InitialSetupSecuritySelfieSendingInProgress extends InitialSetupSecuritySelfieState {
  final ContentUploadState state;
  InitialSetupSecuritySelfieSendingInProgress(this.state);
}
class InitialSetupSecuritySelfieSendingFailed extends InitialSetupSecuritySelfieState {}


/// Selected security selfie which is located on server
class SelectedSecuritySelfie {
  const SelectedSecuritySelfie(this.accountId, this.contentId);
  final AccountId accountId;
  final ContentId contentId;
}

sealed class ContentUploadState {}
class DataUploadInProgress extends ContentUploadState {}
class ServerDataProcessingInProgress extends ContentUploadState {
  final int? queueNumber;
  ServerDataProcessingInProgress(this.queueNumber);

  String uiText(BuildContext context) {
    if (queueNumber == null) {
      return context.strings.initial_setup_screen_security_selfie_upload_processing_ongoing_description;
    } else {
      return "${context.strings.initial_setup_screen_security_selfie_upload_in_processing_queue_dialog_description} $queueNumber";
    }
  }
}
