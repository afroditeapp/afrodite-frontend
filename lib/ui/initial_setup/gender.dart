import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";

class AskGenderScreen extends StatelessWidget {
  const AskGenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.gender != null) {
            return () {
              // Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen))
            };
          } else {
            return null;
          }
        },
        question: AskGender(),
      ),
    );
  }
}

class AskGender extends StatefulWidget {
  const AskGender({super.key});

  @override
  State<AskGender> createState() => _AskGenderState();
}

class _AskGenderState extends State<AskGender> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_gender_title),
        askInfo(context),
      ],
    );
  }

  Widget askInfo(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        return genderRadioButtons(
          context,
          state.gender,
          (selected) {
            if (selected != null) {
              context.read<InitialSetupBloc>().add(SetGender(selected));
            }
          }
        );
      }
    );
  }
}

Widget genderRadioButtons(BuildContext context, Gender? selected, void Function(Gender?) onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      genderListTile(context, selected, Gender.man, onChanged),
      genderListTile(context, selected, Gender.woman, onChanged),
      genderListTile(context, selected, Gender.nonBinary, onChanged),
    ],
  );
}

Widget genderListTile(BuildContext context, Gender? selected, Gender gender, void Function(Gender?) onChanged) {
  return RadioListTile<Gender>(
    title: Text(gender.uiText(context)),
    value: gender,
    groupValue: selected,
    onChanged: onChanged,
  );
}
