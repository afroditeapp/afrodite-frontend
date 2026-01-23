import "dart:async";

import "package:app/data/image_cache.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/media/image_processing.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/model/freezed/logic/media/image_processing.dart";
import "package:app/ui_utils/image.dart";
import "package:app/ui_utils/loading_dialog.dart";
import "package:app/ui_utils/view_image_screen.dart";
import "package:app/ui_utils/dialog.dart";
import "package:image_picker/image_picker.dart";
import "package:logging/logging.dart";
import "package:utils/utils.dart";

final _log = Logger("ImageProcessingUtils");

/// Zero sized widgets related to image processing.
List<Widget> imageProcessingUiWidgets<B extends Bloc<ImageProcessingEvent, ImageProcessingData>>({
  required void Function(BuildContext, ProcessedAccountImage) onComplete,
}) {
  return [
    confirmDialogOpener<B>(),
    uploadImageProgressDialogListener<B>(),
    uploadErrorDialogOpener<B>(),
    uploadCompletedListener<B>(onComplete),
  ];
}

Widget confirmDialogOpener<B extends Bloc<ImageProcessingEvent, ImageProcessingData>>() {
  return BlocListener<B, ImageProcessingData>(
    listenWhen: (previous, current) => previous.processingState != current.processingState,
    listener: (context, state) async {
      final processingState = state.processingState;
      if (processingState is UnconfirmedImage) {
        final bloc = context.read<B>();
        bloc.add(ResetState());
        final accepted = await _confirmDialogForImage(context, processingState.imgBytes);
        if (accepted == true) {
          bloc.add(
            SendImageToSlot(
              processingState.imgBytes,
              processingState.slot,
              secureCapture: processingState.secureCapture,
            ),
          );
        }
      }
    },
    child: const SizedBox.shrink(),
  );
}

class ConfirmImageDialog extends MyDialogPage<bool> {
  ConfirmImageDialog({required super.builder});
}

Future<bool?> _confirmDialogForImage(BuildContext context, Uint8List imageBytes) async {
  const IMG_WIDTH = 150.0;
  const IMG_HEIGHT = 200.0;
  Widget img = InkWell(
    onTap: () => openViewImageScreenWithImageData(context, imageBytes),
    // Width seems to prevent the dialog from expanding horizontaly
    child: bytesImgWidget(
      imageBytes,
      width: IMG_WIDTH,
      height: IMG_HEIGHT,
      cacheSize: ImageCacheSize.constantWidthAndHeight(context, IMG_WIDTH, IMG_HEIGHT),
    ),
  );

  final page = ConfirmImageDialog(
    builder: (context, closer) {
      return AlertDialog(
        title: Text(context.strings.image_processing_ui_confirm_photo_dialog_title),
        content: img,
        actions: [
          TextButton(
            onPressed: () => closer.close(context, false),
            child: Text(context.strings.generic_cancel),
          ),
          TextButton(
            onPressed: () => closer.close(context, true),
            child: Text(context.strings.generic_continue),
          ),
        ],
      );
    },
  );

  return await MyNavigator.showDialog<bool>(context: context, page: page);
}

Widget
uploadImageProgressDialogListener<B extends Bloc<ImageProcessingEvent, ImageProcessingData>>() {
  return ProgressDialogOpener<B, ImageProcessingData>(
    dialogVisibilityGetter: (state) => state.processingState is SendingInProgress,
    stateInfoBuilder: (context, state) {
      final processingState = state.processingState;
      if (processingState is SendingInProgress) {
        final String s = switch (processingState.state) {
          DataUploadInProgress() =>
            context.strings.image_processing_ui_upload_in_progress_dialog_description,
          ServerDataProcessingInProgress s => s.uiText(context),
        };
        return Text(s);
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}

Widget uploadErrorDialogOpener<B extends Bloc<ImageProcessingEvent, ImageProcessingData>>() {
  return BlocListener<B, ImageProcessingData>(
    listenWhen: (previous, current) => previous.processingState != current.processingState,
    listener: (context, state) async {
      final processingState = state.processingState;
      if (processingState is SendingFailed) {
        context.read<B>().add(ResetState());
        if (processingState.nsfwDetected) {
          await showInfoDialog(
            context,
            context.strings.image_processing_ui_nsfw_detected_dialog_title,
          );
        } else {
          await showInfoDialog(
            context,
            context.strings.image_processing_ui_upload_failed_dialog_title,
          );
        }
      }
    },
    child: const SizedBox.shrink(),
  );
}

Widget uploadCompletedListener<B extends Bloc<ImageProcessingEvent, ImageProcessingData>>(
  void Function(BuildContext, ProcessedAccountImage) onComplete,
) {
  return BlocListener<B, ImageProcessingData>(
    listenWhen: (previous, current) => previous.processedImage != current.processedImage,
    listener: (context, state) async {
      final img = state.processedImage;
      if (img != null) {
        context.read<B>().add(ResetState());
        onComplete(context, img);
      }
    },
    child: const SizedBox.shrink(),
  );
}

bool _isJpeg(Uint8List bytes) {
  return bytes.length >= 3 && bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF;
}

bool validateJpeg(Uint8List bytes) {
  if (!_isJpeg(bytes)) {
    showSnackBar(R.strings.initial_setup_screen_profile_pictures_unsupported_image_error);
    return false;
  }
  return true;
}

sealed class LostImageData {}

class LostImageNoData extends LostImageData {}

class LostImageFound extends LostImageData {
  final Uint8List bytes;
  LostImageFound(this.bytes);
}

class ImagePickerLostDataHandler extends StatefulWidget {
  final void Function(BuildContext context, Uint8List imageBytes) onImage;
  const ImagePickerLostDataHandler({required this.onImage, super.key});

  @override
  State<ImagePickerLostDataHandler> createState() => _ImagePickerLostDataHandlerState();
}

class _ImagePickerLostDataHandlerState extends State<ImagePickerLostDataHandler> {
  Future<LostImageData>? _lostDataFuture;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      _lostDataFuture = _getLostData();
    } else {
      _lostDataFuture = null;
    }
  }

  Future<LostImageData> _getLostData() async {
    try {
      final response = await ImagePicker().retrieveLostData();
      if (response.isEmpty) {
        return LostImageNoData();
      }

      final file = response.file;
      if (file == null) {
        _log.error("retrieveLostData: file is null");
        return LostImageNoData();
      } else {
        return LostImageFound(await file.readAsBytes());
      }
    } catch (e) {
      _log.error("retrieveLostData: exception $e");
      return LostImageNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_lostDataFuture == null) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<LostImageData>(
      future: _lostDataFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null) {
          _lostDataFuture = null;
          if (data is LostImageFound) {
            final imageBytes = data.bytes;
            if (validateJpeg(imageBytes)) {
              widget.onImage(context, imageBytes);
            }
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
