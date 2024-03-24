import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";

const MIN_AGE = 18;
const MAX_AGE = 99;
final initialLetterRegexp = RegExp("[a-zA-ZåäöÅÄÖ]");

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
              // Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen))
            };
          } else {
            return null;
          }
        },
        question: AskProfileBasicInfo(
          profileInitialInitialValue: profileInitial,
          ageInitialValue: ageString
        ),
      ),
    );
  }

  bool ageIsValid(int? age) {
    return age != null && age >= MIN_AGE && age <= MAX_AGE;
  }

  bool initialIsValid(String? initial) {
    return initial != null && initialLetterRegexp.hasMatch(initial);
  }
}

class AskProfileBasicInfo extends StatefulWidget {
  final String profileInitialInitialValue;
  final String ageInitialValue;
  const AskProfileBasicInfo({required this.profileInitialInitialValue, required this.ageInitialValue, super.key});

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
        questionTitleText(context, context.strings.initial_setup_screen_profile_basic_info_title),
        Padding(
          padding: const EdgeInsets.all(18.0),
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
        context.read<InitialSetupBloc>().add(SetInitialLetter(inUppercase));
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(initialLetterRegexp),
      ],
    );

    final ageField = TextField(
      decoration: InputDecoration(
          hintText: context.strings.initial_setup_screen_profile_basic_info_age_hint_text,
      ),
      controller: ageTextController,
      keyboardType: TextInputType.number,
      enableSuggestions: false,
      autocorrect: false,
      maxLength: 2,
      onChanged: (value) {
        final age = int.tryParse(value);
        context.read<InitialSetupBloc>().add(SetProfileAge(age));
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
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
