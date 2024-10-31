import "dart:typed_data";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:app/data/account_repository.dart";

import "package:app/data/image_cache.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/data/media/send_to_slot.dart";
import "package:app/model/freezed/logic/media/image_processing.dart";


final log = Logger("ImageProcessingBloc");


sealed class ImageProcessingEvent {}

class ConfirmImage extends ImageProcessingEvent {
  final Uint8List imgBytes;
  final int slot;
  final bool secureCapture;
  ConfirmImage(this.imgBytes, this.slot, {this.secureCapture = false});
}
class SendImageToSlot extends ImageProcessingEvent {
  final Uint8List imgBytes;
  final int slot;
  final bool secureCapture;
  SendImageToSlot(this.imgBytes, this.slot, {this.secureCapture = false});
}
class ResetState extends ImageProcessingEvent {}

class ImageProcessingBloc extends Bloc<ImageProcessingEvent, ImageProcessingData> {
  final AccountRepository account = LoginRepository.getInstance().repositories.account;
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final ImageCacheData imageCache = ImageCacheData.getInstance();

  ImageProcessingBloc() : super(ImageProcessingData()) {
    on<ResetState>((data, emit) {
      emit(ImageProcessingData());
    });
    on<ConfirmImage>((data, emit) {
      emit(state.copyWith(
        processingState: UnconfirmedImage(data.imgBytes, data.slot, secureCapture: data.secureCapture),
      ));
    });
    on<SendImageToSlot>((data, emit) async {
      emit(state.copyWith(
        processingState: SendingInProgress(DataUploadInProgress()),
      ));

      final currentUser = media.currentUser;

      await for (final e in media.sendImageToSlot(data.imgBytes, data.slot, secureCapture: data.secureCapture)) {
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
            final imgFile = await imageCache.getImage(currentUser, contentId, media: media);
            if (imgFile == null) {
              emit(state.copyWith(
                processingState: SendingFailed(),
              ));
            } else {
              emit(state.copyWith(
                processingState: null,
                processedImage: ProcessedAccountImage(currentUser, contentId, data.slot),
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

class SecuritySelfieImageProcessingBloc extends ImageProcessingBloc {}
class ProfilePicturesImageProcessingBloc extends ImageProcessingBloc {}
