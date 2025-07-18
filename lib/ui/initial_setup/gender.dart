import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/ui/initial_setup/search_settings.dart";
import "package:app/ui_utils/initial_setup_common.dart";

class AskGenderScreen extends StatelessWidget {
  const AskGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.gender != null) {
            return () {
              MyNavigator.push(context, const MaterialPage<void>(child: AskSearchSettingsScreen()));
            };
          } else {
            return null;
          }
        },
        question: const AskGender(),
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
    title: Text(gender.uiTextSingular(context)),
    value: gender,
    groupValue: selected,
    onChanged: onChanged,
  );
}
