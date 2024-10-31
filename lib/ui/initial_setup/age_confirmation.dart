import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/ui/initial_setup/security_selfie.dart";
import "package:app/ui_utils/initial_setup_common.dart";


class AgeConfirmationScreen extends StatelessWidget {
  const AgeConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          final isAdult = state.isAdult;
          if (isAdult != null && isAdult) {
            return () {
              MyNavigator.push(context, MaterialPage<void>(child: const AskSecuritySelfieScreen()));
            };
          } else {
            return null;
          }
        },
        question: const AskAgeConfirmation(),
      ),
    );
  }
}


class AskAgeConfirmation extends StatefulWidget {
  const AskAgeConfirmation({super.key});

  @override
  State<AskAgeConfirmation> createState() => _AskAgeConfirmationState();
}

class _AskAgeConfirmationState extends State<AskAgeConfirmation> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_age_confirmation_title),
        isAdultCheckbox(context),
      ],
    );
  }

  Widget isAdultCheckbox(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        return CheckboxListTile(
          value: state.isAdult ?? false,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(context.strings.initial_setup_screen_age_confirmation_checkbox),
          onChanged: (value) {
            context.read<InitialSetupBloc>().add(SetAgeConfirmation(value ?? false));
          }
        );
      }
    );
  }
}
