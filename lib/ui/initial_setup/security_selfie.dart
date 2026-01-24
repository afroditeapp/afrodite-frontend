import "dart:async";
import "dart:typed_data";

import "package:app/data/image_cache.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/utils/result.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/media/image_processing.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/media/image_processing.dart";
import "package:app/ui/initial_setup/navigation.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:app/ui_utils/image.dart";
import "package:app/ui_utils/image_processing.dart";
import "package:app/ui_utils/view_image_screen.dart";
import "package:app/ui_utils/camera_screen.dart";
import "package:app/ui_utils/dialog.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/camera.dart";

final _log = Logger("AskSecuritySelfieScreen");

class AskSecuritySelfiePage extends InitialSetupPageBase
    with SimpleUrlParser<AskSecuritySelfiePage> {
  AskSecuritySelfiePage() : super(builder: (_) => AskSecuritySelfieScreen());

  @override
  String get nameForDb => 'security_selfie';

  @override
  AskSecuritySelfiePage create() => AskSecuritySelfiePage();
}

// There is several CameraManager.getInstance().sendCmd(CloseCmd());
// calls in this file as the CameraController travels from screen to another
// I'm not sure does that always work, so just to make sure that camera will be
// closed there is several sending of CloseCmd to close the camera.

class AskSecuritySelfieScreen extends StatelessWidget {
  const AskSecuritySelfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitialSetupLoadingGuard(child: _AskSecuritySelfieScreenInternal());
  }
}

class _AskSecuritySelfieScreenInternal extends StatelessWidget {
  const _AskSecuritySelfieScreenInternal();

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          final selfie = state.securitySelfie;
          if (selfie != null && selfie.faceDetected) {
            return () {
              CameraManager.getInstance().sendCmd(CloseCmd());
              navigateToNextInitialSetupPage(context);
            };
          } else {
            return null;
          }
        },
        question: const AskSecuritySelfie(),
      ),
      showRefreshSecuritySelfieFaceDetectedValuesAction: true,
    );
  }
}

const IMAGE_AREA_HEIGHT = 200.0;

class AskSecuritySelfie extends StatefulWidget {
  const AskSecuritySelfie({super.key});

  @override
  State<AskSecuritySelfie> createState() => _AskSecuritySelfieState();
}

class _AskSecuritySelfieState extends State<AskSecuritySelfie> {
  final cameraScreenOpener = CameraScreenOpener();

  @override
  void dispose() {
    super.dispose();
    _log.info("Disposing AskSecuritySelfie");
    CameraManager.getInstance().sendCmd(CloseCmd());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_security_selfie_title),
        imageArea(context),
        const Padding(padding: EdgeInsets.all(8.0)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: INITIAL_SETUP_PADDING),
          child: Text(context.strings.initial_setup_screen_security_selfie_description),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        noFaceDetectedError(context),

        // Zero sized widgets
        ...imageProcessingUiWidgets<SecuritySelfieImageProcessingBloc>(
          onComplete: (context, processedImg) {
            if (processedImg.slot == 0) {
              final bloc = context.read<InitialSetupBloc>();
              bloc.add(SetSecuritySelfie(processedImg));
            }
          },
        ),
      ],
    );
  }

  Widget imageArea(BuildContext context) {
    return SizedBox(
      height: IMAGE_AREA_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.person, size: 150.0, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Expanded(child: imageAndCameraButton(context)),
        ],
      ),
    );
  }

  Widget normalCameraButton() {
    return ElevatedButton.icon(
      label: Text(context.strings.generic_take_photo),
      icon: const Icon(Icons.camera_alt),
      onPressed: () => cameraScreenOpener.openCameraScreenAction(context),
    );
  }

  Widget imageAndCameraButton(BuildContext context) {
    Widget cameraButton = Align(alignment: Alignment.centerLeft, child: normalCameraButton());

    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        Widget w = cameraButton;
        final image = state.securitySelfie;
        if (image != null) {
          const IMG_WIDTH = 120.0;
          w = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                child: InkWell(
                  onTap: () =>
                      openViewImageScreenForAccountImage(context, image.accountId, image.contentId),
                  child: accountImgWidgetInk(
                    context,
                    image.accountId,
                    image.contentId,
                    width: IMG_WIDTH,
                    height: IMAGE_AREA_HEIGHT,
                    cacheSize: ImageCacheSize.constantWidthAndHeight(
                      context,
                      IMG_WIDTH,
                      IMAGE_AREA_HEIGHT,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => cameraScreenOpener.openCameraScreenAction(context),
                icon: const Icon(Icons.camera_alt),
              ),
            ],
          );
        }
        return w;
      },
    );
  }

  Widget noFaceDetectedError(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        final image = state.securitySelfie;
        if (image != null && !image.faceDetected) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.close, color: Colors.red, size: 32),
                    const Padding(padding: EdgeInsets.only(right: 8.0)),
                    Flexible(
                      child: Text(
                        context.strings.initial_setup_screen_security_selfie_face_not_detected,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              normalCameraButton(),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class CameraScreenOpener {
  bool cameraOpeningInProgress = false;

  void openCameraScreenAction(BuildContext context) async {
    if (cameraOpeningInProgress) {
      showSnackBar(context.strings.camera_screen_camera_opening_already_in_progress_error);
      return;
    }
    cameraOpeningInProgress = true;
    final bloc = context.read<SecuritySelfieImageProcessingBloc>();

    final result = await CameraManager.getInstance().openNewControllerAndThenEvents().first;
    switch (result) {
      case Open(:final controller):
        {
          if (!context.mounted) {
            CameraManager.getInstance().sendCmd(CloseCmd());
            return;
          }

          final image = await MyNavigator.showFullScreenDialog<Result<Uint8List, ()>>(
            context: context,
            page: CameraPage(controller: controller),
          );

          if (image case Ok()) {
            bloc.add(ConfirmImage(image.v, SECURITY_SELFIE_SLOT, secureCapture: true));
          }

          // Assume that CameraScreen will close the camera.
        }
      case Closed(:final error):
        {
          if (error != null) {
            Future.delayed(Duration.zero, () {
              if (!context.mounted) {
                return;
              }
              showInfoDialog(context, error.message);
            });
          }
          CameraManager.getInstance().sendCmd(CloseCmd());
        }
      case DisposeOngoing():
        {
          CameraManager.getInstance().sendCmd(CloseCmd());
        }
    }

    cameraOpeningInProgress = false;
  }
}
