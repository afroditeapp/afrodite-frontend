import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/navigator_state.dart";
import "package:pihka_frontend/ui/initial_setup/gender.dart";
import "package:pihka_frontend/ui_utils/consts/padding.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/ui_utils/text_field.dart";
import "package:pihka_frontend/utils/age.dart";

final initialLetterRegexp = RegExp("[a-zA-ZåäöÅÄÖ]");

// TODO(prod): Set initial age value based on birthdate

class AskProfileBasicInfoScreen extends StatelessWidget {
  const AskProfileBasicInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileInitial = context.read<InitialSetupBloc>().state.profileInitial ?? "";
    final age = context.read<InitialSetupBloc>().state.profileAge;
    final String ageString;
    if (age != null) {
      ageString = age.toString();
    } else {
      ageString = "";
    }

    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          final age = state.profileAge;
          final initial = state.profileInitial;
          if (ageIsValid(age) && initialIsValid(initial)) {
            return () {
              MyNavigator.push(context, MaterialPage<void>(child: const AskGenderScreen()));
            };
          } else {
            return null;
          }
        },
        question: Column(
          children: [
            questionTitleText(context, context.strings.initial_setup_screen_profile_basic_info_title),
            AskProfileBasicInfo(
              profileInitialInitialValue: profileInitial,
              setterProfileInitial: (value) {
                context.read<InitialSetupBloc>().add(SetInitialLetter(value));
              },
              ageInitialValue: ageString,
              setterProfileAge: (value) {
                context.read<InitialSetupBloc>().add(SetProfileAge(value));
              },
            ),
          ],
        ),
      ),
    );
  }
}

bool initialIsValid(String? initial) {
  return initial != null && initialLetterRegexp.hasMatch(initial);
}

class AskProfileBasicInfo extends StatefulWidget {
  final String profileInitialInitialValue;
  final String ageInitialValue;
  final void Function(String) setterProfileInitial;
  final void Function(int?) setterProfileAge;
  const AskProfileBasicInfo({
    required this.profileInitialInitialValue,
    required this.ageInitialValue,
    required this.setterProfileInitial,
    required this.setterProfileAge,
    super.key,
  });

  @override
  State<AskProfileBasicInfo> createState() => _AskProfileBasicInfoState();
}

class _AskProfileBasicInfoState extends State<AskProfileBasicInfo> {
  final initialTextController = TextEditingController();
  final ageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialTextController.text = widget.profileInitialInitialValue;
    ageTextController.text = widget.ageInitialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: INITIAL_SETUP_PADDING),
          child: askInfo(context),
        ),
      ],
    );
  }

  Widget askInfo(BuildContext context) {
    final initialField = TextField(
      decoration: InputDecoration(
        hintText: context.strings.initial_setup_screen_profile_basic_info_initial_hint_text,
      ),
      controller: initialTextController,
      textCapitalization: TextCapitalization.characters,
      enableSuggestions: false,
      autocorrect: false,
      maxLength: 1,
      onChanged: (value) {
        final inUppercase = value.toUpperCase();
        if (value != inUppercase) {
          initialTextController.text = inUppercase;
        }
        widget.setterProfileInitial(inUppercase);
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(initialLetterRegexp),
      ],
    );

    final ageField = AgeTextField(
      getInitialValue: () => widget.ageInitialValue,
      onChanged: (value) {
        final age = int.tryParse(value);
        widget.setterProfileAge(age);
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.initial_setup_screen_profile_basic_info_initial_title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        initialField,
        Text(
          context.strings.initial_setup_screen_profile_basic_info_age_title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ageField,
      ],
    );
  }
}
