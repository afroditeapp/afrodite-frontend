import "dart:typed_data";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import "package:pihka_frontend/localizations.dart";

part 'image_processing.freezed.dart';

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

sealed class ProcessingState {}
class UnconfirmedImage extends ProcessingState {
  final Uint8List imgBytes;
  final int slot;
  final bool secureCapture;
  UnconfirmedImage(this.imgBytes, this.slot, {required this.secureCapture});
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
  /// Slot where the image was uploaded.
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
