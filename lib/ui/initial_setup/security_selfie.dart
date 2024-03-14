import "dart:io";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup/gender.dart";
import "package:pihka_frontend/ui_utils/camera_screen.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/utils/date.dart";


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
            // return () {
            //   Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen))
            // };
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          questionTitleText(context, context.strings.initial_setup_screen_security_selfie_title),
          imageArea(context),
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
      onPressed: () async {
        final bloc = context.read<InitialSetupBloc>();
        final image = await Navigator.push<XFile?>(
            context,
            MaterialPageRoute<XFile?>(builder: (_) {
              return const CameraScreen();
            }),
        );
        if (image != null) {
          bloc.add(SetSecuritySelfie(image));
        }
      }
    );

    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        List<Widget> selfieImageWidgets = [cameraButton];
        final image = state.securitySelfie;
        if (image != null) {
          selfieImageWidgets = [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.file(File(image.path), height: 200),
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
}
