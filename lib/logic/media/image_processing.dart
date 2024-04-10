import "package:camera/camera.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/data/account_repository.dart";

import "package:pihka_frontend/data/image_cache.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/media/send_to_slot.dart";
import "package:pihka_frontend/model/freezed/logic/media/image_processing.dart";


final log = Logger("ImageProcessingBloc");


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

class SecuritySelfieImageProcessingBloc extends ImageProcessingBloc {}
class ProfilePicturesImageProcessingBloc extends ImageProcessingBloc {}
