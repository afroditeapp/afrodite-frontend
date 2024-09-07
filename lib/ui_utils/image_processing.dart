import "dart:async";
import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/app/navigator_state.dart";
import "package:pihka_frontend/logic/media/image_processing.dart";
import "package:pihka_frontend/model/freezed/logic/main/navigator_state.dart";
import "package:pihka_frontend/model/freezed/logic/media/image_processing.dart";
import "package:pihka_frontend/ui_utils/image.dart";
import "package:pihka_frontend/ui_utils/loading_dialog.dart";
import "package:pihka_frontend/ui_utils/view_image_screen.dart";
import "package:pihka_frontend/ui_utils/dialog.dart";

/// Zero sized widgets related to image processing.
List<Widget> imageProcessingUiWidgets<B extends Bloc<ImageProcessingEvent, ImageProcessingData>>({required void Function(BuildContext, ProcessedAccountImage) onComplete}) {
  return [
    confirmDialogOpener<B>(),
    sendSecuritySelfieProgressDialogListener<B>(),
    uploadErrorDialogOpener<B>(),
    sendingCompletedListener<B>(onComplete),
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
          bloc.add(SendImageToSlot(
            processingState.imgBytes,
            processingState.slot,
            secureCapture: processingState.secureCapture,
          ));
        }
      }
    },
    child: const SizedBox.shrink(),
  );
}

Future<bool?> _confirmDialogForImage(BuildContext context, Uint8List imageBytes) async {
  Widget img = InkWell(
    onTap: () {
      MyNavigator.push(
        context,
        MaterialPage<void>(
          child: ViewImageScreen(ViewImageBytesContent(imageBytes))
        )
      );
    },
    // Width seems to prevent the dialog from expanding horizontaly
    child: bytesImgWidget(imageBytes, height: 200, width: 150),
  );

  Widget dialog = AlertDialog(
    title: Text(context.strings.image_processing_ui_confirm_photo_dialog_title),
    content: img,
    actions: [
      TextButton(
        onPressed: () {
          MyNavigator.pop(context, false);
        },
        child: Text(context.strings.generic_cancel),
      ),
      TextButton(
        onPressed: () {
          MyNavigator.pop(context, true);
        },
        child: Text(context.strings.generic_continue),
      ),
    ],
  );

  final pageKey = PageKey();
  return await MyNavigator.showDialog<bool?>(
    context: context,
    builder: (context) => dialog,
    pageKey: pageKey,
  );
}

Widget sendSecuritySelfieProgressDialogListener<B extends Bloc<ImageProcessingEvent, ImageProcessingData>>() {
  return ProgressDialogOpener<B, ImageProcessingData>(
    dialogVisibilityGetter: (state) => state.processingState is SendingInProgress,
    stateInfoBuilder: (context, state) {
      final selfieState = state.processingState;
      if (selfieState is SendingInProgress) {
        final String s = switch (selfieState.state) {
          DataUploadInProgress() => context.strings.image_processing_ui_upload_in_progress_dialog_description,
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
      final selfieState = state.processingState;
      if (selfieState is SendingFailed) {
        context.read<B>().add(ResetState());
        await showInfoDialog(context, context.strings.image_processing_ui_upload_failed_dialog_title);
      }
    },
    child: const SizedBox.shrink(),
  );
}

Widget sendingCompletedListener<B extends Bloc<ImageProcessingEvent, ImageProcessingData>>(void Function(BuildContext, ProcessedAccountImage) onComplete) {
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
