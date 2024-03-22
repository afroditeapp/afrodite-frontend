import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/media/image_processing.dart";
import "package:pihka_frontend/ui/initial_setup/profile_pictures.dart";
import "package:pihka_frontend/ui_utils/image.dart";
import "package:pihka_frontend/ui_utils/image_processing.dart";
import "package:pihka_frontend/ui_utils/view_image_screen.dart";
import "package:pihka_frontend/ui_utils/camera_screen.dart";
import "package:pihka_frontend/ui_utils/dialog.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils/camera.dart";

var log = Logger("AskSecuritySelfieScreen");

// There is several CameraManager.getInstance().sendCmd(CloseCmd());
// calls in this file as the CameraController travels from screen to another
// I'm not sure does that always work, so just to make sure that camera will be
// closed there is several sending of CloseCmd to close the camera.

class AskSecuritySelfieScreen extends StatelessWidget {
  const AskSecuritySelfieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          final selfie = state.securitySelfie;
          if (selfie != null) {
            return () {
              CameraManager.getInstance().sendCmd(CloseCmd());
              Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const AskProfilePicturesScreen()));
            };
          } else {
            return null;
          }
        },
        question: const AskSecuritySelfie(),
      ),
    );
  }
}

class AskSecuritySelfie extends StatefulWidget {
  const AskSecuritySelfie({super.key});

  @override
  State<AskSecuritySelfie> createState() => _AskSecuritySelfieState();
}

class _AskSecuritySelfieState extends State<AskSecuritySelfie> {
  bool cameraOpeningInProgress = false;

  @override
  void dispose() {
    super.dispose();
    log.info("Disposing AskSecuritySelfie");
    CameraManager.getInstance().sendCmd(CloseCmd());
  }

  @override
  Widget build(BuildContext context) {
     Widget cameraButton = ElevatedButton.icon(
      label: Text(context.strings.generic_take_photo),
      icon: const Icon(Icons.camera_alt),
      onPressed: () => openCameraScreenAction(context),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [cameraButton]),
          questionTitleText(context, context.strings.initial_setup_screen_security_selfie_title),
          imageArea(context),

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
      ),
    );
  }

  Widget imageArea(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 150.0, color: Colors.black45),
            imageAndCameraButton(context),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(context.strings.initial_setup_screen_security_selfie_description),
        ),
      ],
    );
  }

  Widget imageAndCameraButton(BuildContext context) {
    Widget cameraButton = ElevatedButton.icon(
      label: Text(context.strings.generic_take_photo),
      icon: const Icon(Icons.camera_alt),
      onPressed: () => openCameraScreenAction(context),
    );

    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        List<Widget> selfieImageWidgets = [cameraButton];
        final image = state.securitySelfie;
        if (image != null) {
          selfieImageWidgets = [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AccountImage(
                accountId: image.accountId,
                contentId: image.contentId,
                imageBuilder: (file) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => ViewImageScreen(ViewImageAccountContent(image.accountId, image.contentId))
                        )
                      );
                    },
                    child: xfileImgWidget(file, height: 200),
                  );
                }
              ),
            ),
            cameraButton
          ];
        }
        return Column(
          children: selfieImageWidgets
        );
      }
    );
  }

  void openCameraScreenAction(BuildContext context) async {
    if (cameraOpeningInProgress) {
      showSnackBar(context.strings.camera_screen_camera_opening_already_in_progress_error);
      return;
    }
    cameraOpeningInProgress = true;
    final bloc = context.read<SecuritySelfieImageProcessingBloc>();

    final result = await CameraManager.getInstance().openNewControllerAndThenEvents().first;
    switch (result) {
      case Open(:final controller): {
        if (!context.mounted) {
          CameraManager.getInstance().sendCmd(CloseCmd());
          return;
        }

        final image = await Navigator.push<XFile?>(
          context,
          MaterialPageRoute<XFile?>(builder: (_) {
            return CameraScreen(controller: controller);
          }),
        );

        if (image != null) {
          bloc.add(ConfirmImage(image, SECURITY_SELFIE_SLOT));
        }

        // Assume that CameraScreens will close the camera.
      }
      case Closed(:final error): {
        if (error != null) {
          Future.delayed(Duration.zero, () {
            showInfoDialog(context, error.message);
          });
        }
        CameraManager.getInstance().sendCmd(CloseCmd());
      }
      case DisposeOngoing(): {
        CameraManager.getInstance().sendCmd(CloseCmd());
      }
    }

    cameraOpeningInProgress = false;
  }
}
