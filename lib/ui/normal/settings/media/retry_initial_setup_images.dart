


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/initial_setup.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_pictures.dart';
import 'package:pihka_frontend/ui/initial_setup/security_selfie.dart';
import 'package:pihka_frontend/ui_utils/initial_setup_common.dart';
import 'package:pihka_frontend/utils/camera.dart';


Future<RetryInitialSetupImages?> openRetryInitialSetupImages(BuildContext context) async {
  final initialSetupBloc = context.read<InitialSetupBloc>();
  final profilePicturesBloc = context.read<ProfilePicturesBloc>();
  return await Navigator.push(
    context,
    MaterialPageRoute<RetryInitialSetupImages>(builder: (_) => RetrySecuritySelfieScreen(
      initialSetupBloc: initialSetupBloc,
      profilePicturesBloc: profilePicturesBloc,
    )),
  );
}


/// Returns [RetryInitialSetupImages?]
class RetrySecuritySelfieScreen extends StatefulWidget {
  final InitialSetupBloc initialSetupBloc;
  final ProfilePicturesBloc profilePicturesBloc;
  const RetrySecuritySelfieScreen({
    required this.initialSetupBloc,
    required this.profilePicturesBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<RetrySecuritySelfieScreen> createState() => _RetrySecuritySelfieScreenState();
}

class _RetrySecuritySelfieScreenState extends State<RetrySecuritySelfieScreen> {

  @override
  void initState() {
    super.initState();
    widget.profilePicturesBloc.add(ResetProfilePicturesBloc());
    widget.initialSetupBloc.add(ResetState());
  }

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          final selfie = state.securitySelfie;
          if (selfie != null) {
            return () async {
              CameraManager.getInstance().sendCmd(CloseCmd());
              final imgStateList = await Navigator.push(context, MaterialPageRoute<List<ImgState>>(builder: (_) => const RetryProfilePicturesScreen()));
              if (context.mounted && imgStateList != null) {
                Navigator.pop(context, RetryInitialSetupImages(imgStateList, selfie.contentId));
              }
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


/// Returns [List<ImgState>?]
class RetryProfilePicturesScreen extends StatefulWidget {

  const RetryProfilePicturesScreen({Key? key}) : super(key: key);

  @override
  State<RetryProfilePicturesScreen> createState() => _RetryProfilePicturesScreen();
}

class _RetryProfilePicturesScreen extends State<RetryProfilePicturesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        continueButtonBuilder: (context) {
          return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
            builder: (context, state) {
              void Function()? onPressed;
              final pictures = state.pictures();
              if (pictures[0] is ImageSelected) {
                onPressed = () {
                  Navigator.pop(context, pictures);
                };
              }

              return ElevatedButton(
                onPressed: onPressed,
                child: Text(context.strings.generic_continue),
              );
            }
          );
        },
        question: AskProfilePictures(),
      ),
    );
  }
}


class RetryInitialSetupImages {
  final List<ImgState> profileImgs;
  final ContentId securitySelfie;
  RetryInitialSetupImages(this.profileImgs, this.securitySelfie);
}
