import "dart:async";
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup/profile_pictures.dart";
import "package:pihka_frontend/ui_utils/image.dart";
import "package:pihka_frontend/ui_utils/loading_dialog.dart";
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
          confirmDialogOpener(),
          sendSecuritySelfieProgressDialogListener(),
          uploadErrorDialogOpener(),
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
                    child: Image.file(file, height: 200),
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
    final bloc = context.read<InitialSetupBloc>();

    final result = await CameraManager.getInstance().openNewControllerAndThenEvents().first;
    switch (result) {
      case Open(:final controller): {
        if (!context.mounted) {
          CameraManager.getInstance().sendCmd(CloseCmd());
          return;
        }

        final image = await Navigator.push<File?>(
          context,
          MaterialPageRoute<File?>(builder: (_) {
            return CameraScreen(controller: controller);
          }),
        );

        if (image != null) {
          bloc.add(SetSecuritySelfieState(InitialSetupSecuritySelfieUnconfirmedImage(image)));
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

  Widget confirmDialogOpener() {
    return BlocListener<InitialSetupBloc, InitialSetupData>(
      listenWhen: (previous, current) => previous.securitySelfieState != current.securitySelfieState,
      listener: (context, state) async {
        final selfieState = state.securitySelfieState;
        if (selfieState is InitialSetupSecuritySelfieUnconfirmedImage) {
          final bloc = context.read<InitialSetupBloc>();
          bloc.add(SetSecuritySelfieState(null));
          final accepted = await confirmDialogForImage(selfieState.image);
          if (accepted == true) {
            bloc.add(SendSecuritySelfie(selfieState.image));
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Future<bool?> confirmDialogForImage(File image) async {
    Widget img = InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => ViewImageScreen(ViewImageFileContent(image))
          )
        );
      },
      child: Image.file(image, height: 200),
    );

    Widget dialog = AlertDialog(
      title: Text(context.strings.initial_setup_screen_security_selfie_confirm_photo_dialog_title),
      content: img,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(context.strings.generic_cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(context.strings.generic_continue),
        ),
      ],
    );

    return await showDialog<bool?>(
      context: context,
      builder: (context) => dialog,
    );
  }

  Widget sendSecuritySelfieProgressDialogListener() {
    return ProgressDialogBlocListener<InitialSetupBloc, InitialSetupData>(
      child: const SizedBox.shrink(),
      dialogVisibilityGetter: (context, state) => state.securitySelfieState is InitialSetupSecuritySelfieSendingInProgress,
      stateInfoBuilder: (context, state) {
        final selfieState = state.securitySelfieState;
        if (selfieState is InitialSetupSecuritySelfieSendingInProgress) {
          final String s = switch (selfieState.state) {
            DataUploadInProgress() => context.strings.initial_setup_screen_security_selfie_upload_in_progress_dialog_description,
            ServerDataProcessingInProgress s => s.uiText(context),
          };
          return Text(s);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget uploadErrorDialogOpener() {
    return BlocListener<InitialSetupBloc, InitialSetupData>(
      listenWhen: (previous, current) => previous.securitySelfieState != current.securitySelfieState,
      listener: (context, state) async {
        final selfieState = state.securitySelfieState;
        if (selfieState is InitialSetupSecuritySelfieSendingFailed) {
          context.read<InitialSetupBloc>().add(SetSecuritySelfieState(null));
          await showInfoDialog(context, context.strings.initial_setup_screen_security_selfie_upload_failed_dialog_title);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
