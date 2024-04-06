import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import "package:pihka_frontend/data/image_cache.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/media/send_to_slot.dart";
import "package:pihka_frontend/localizations.dart";

part 'image_processing.freezed.dart';

final log = Logger("ImageProcessingBloc");

const int SECURITY_SELFIE_SLOT = 0;
const int PROFILE_IMAGE_1_SLOT = 1;
const int PROFILE_IMAGE_2_SLOT = 2;
const int PROFILE_IMAGE_3_SLOT = 3;
const int PROFILE_IMAGE_4_SLOT = 4;

@freezed
class ImageProcessingData with _$ImageProcessingData {
  factory ImageProcessingData({
    ProcessingState? processingState,
    ProcessedAccountImage? processedImage,
  }) = _ImageProcessingData;
}

sealed class ImageProcessingEvent {}



class ConfirmImage extends ImageProcessingEvent {
  final XFile img;
  final int slot;
  final bool secureCapture;
  ConfirmImage(this.img, this.slot, {this.secureCapture = false});
}
class SendImageToSlot extends ImageProcessingEvent {
  final XFile img;
  final int slot;
  final bool secureCapture;
  SendImageToSlot(this.img, this.slot, {this.secureCapture = false});
}
class ResetState extends ImageProcessingEvent {}

class ImageProcessingBloc extends Bloc<ImageProcessingEvent, ImageProcessingData> {
  final LoginRepository login = LoginRepository.getInstance();
  final AccountRepository account = AccountRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();
  final ImageCacheData imageCache = ImageCacheData.getInstance();

  ImageProcessingBloc() : super(ImageProcessingData()) {
    on<ResetState>((data, emit) {
      emit(ImageProcessingData());
    });
    on<ConfirmImage>((data, emit) {
      emit(state.copyWith(
        processingState: UnconfirmedImage(data.img, data.slot, secureCapture: data.secureCapture),
      ));
    });
    on<SendImageToSlot>((data, emit) async {
      emit(state.copyWith(
        processingState: SendingInProgress(DataUploadInProgress()),
      ));

      final accountId = await login.accountId.first;
      if (accountId == null) {
        emit(state.copyWith(
          processingState: SendingFailed(),
        ));
        return;
      }

      await for (final e in media.sendImageToSlot(data.img, data.slot, secureCapture: data.secureCapture)) {
        switch (e) {
          case Uploading(): {}
          case UploadCompleted(): {}
          case InProcessingQueue(:final queueNumber): {
            final selfieState = SendingInProgress(ServerDataProcessingInProgress(queueNumber));
            emit(state.copyWith(
              processingState: selfieState,
            ));
          }
          case Processing(): {
            final selfieState = SendingInProgress(ServerDataProcessingInProgress(null));
            emit(state.copyWith(
              processingState: selfieState,
            ));
          }
          case ProcessingCompleted(:final contentId): {
            final imgFile = await imageCache.getImage(accountId, contentId);
            if (imgFile == null) {
              emit(state.copyWith(
                processingState: SendingFailed(),
              ));
            } else {
              emit(state.copyWith(
                processingState: null,
                processedImage: ProcessedAccountImage(accountId, contentId, data.slot),
              ));
            }
          }
          case SendToSlotError(): {
            emit(state.copyWith(
              processingState: SendingFailed(),
            ));
          }
        }
      }
    });
  }
}


sealed class ProcessingState {}
class UnconfirmedImage extends ProcessingState {
  final XFile img;
  final int slot;
  final bool secureCapture;
  UnconfirmedImage(this.img, this.slot, {required this.secureCapture});
}
class SendingInProgress extends ProcessingState {
  final ContentUploadState state;
  SendingInProgress(this.state);
}
class SendingFailed extends ProcessingState {}


/// Image which server has processed.
class ProcessedAccountImage {
  const ProcessedAccountImage(this.accountId, this.contentId, this.slot);
  final AccountId accountId;
  final ContentId contentId;
  final int slot;
}

sealed class ContentUploadState {}
class DataUploadInProgress extends ContentUploadState {}
class ServerDataProcessingInProgress extends ContentUploadState {
  final int? queueNumber;
  ServerDataProcessingInProgress(this.queueNumber);

  String uiText(BuildContext context) {
    if (queueNumber == null) {
      return context.strings.image_processing_ui_upload_processing_ongoing_description;
    } else {
      return context.strings.image_processing_ui_upload_in_processing_queue_dialog_description(queueNumber.toString());
    }
  }
}

class SecuritySelfieImageProcessingBloc extends ImageProcessingBloc {}
class ProfilePicturesImageProcessingBloc extends ImageProcessingBloc {}
