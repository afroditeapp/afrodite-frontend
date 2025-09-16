import "package:app/logic/account/client_features_config.dart";
import "package:app/model/freezed/logic/account/client_features_config.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/ui/initial_setup/gender.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:app/ui_utils/text_field.dart";
import "package:app/utils/age.dart";
import "package:intl/intl.dart";

class AskProfileBasicInfoPage extends MyScreenPage<()> {
  AskProfileBasicInfoPage() : super(builder: (_) => AskProfileBasicInfoScreen());
}

class AskProfileBasicInfoScreen extends StatelessWidget {
  const AskProfileBasicInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileName = context.read<InitialSetupBloc>().state.profileName ?? "";
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
          final name = state.profileName;
          if (ageIsValid(age) && nameIsValid(context, name)) {
            return () {
              MyNavigator.push(context, AskGenderPage());
            };
          } else {
            return null;
          }
        },
        question: Column(
          children: [
            questionTitleText(
              context,
              context.strings.initial_setup_screen_profile_basic_info_title,
            ),
            AskProfileBasicInfo(
              profileNameInitialValue: profileName,
              setterProfileName: (value) {
                context.read<InitialSetupBloc>().add(SetProfileName(value));
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

bool nameIsValid(BuildContext context, String? name) {
  final profileNameRegex = context.read<ClientFeaturesConfigBloc>().state.profileNameRegex;
  return name != null &&
      name.isNotEmpty &&
      (profileNameRegex == null || profileNameRegex.hasMatch(name));
}

class AskProfileBasicInfo extends StatefulWidget {
  final String profileNameInitialValue;
  final String ageInitialValue;
  final void Function(String) setterProfileName;
  final void Function(int?) setterProfileAge;
  const AskProfileBasicInfo({
    required this.profileNameInitialValue,
    required this.ageInitialValue,
    required this.setterProfileName,
    required this.setterProfileAge,
    super.key,
  });

  @override
  State<AskProfileBasicInfo> createState() => _AskProfileBasicInfoState();
}

class _AskProfileBasicInfoState extends State<AskProfileBasicInfo> {
  final nameTextController = TextEditingController();
  final ageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameTextController.text = widget.profileNameInitialValue;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.initial_setup_screen_profile_basic_info_profile_name_title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        profileNameTextField(
          context,
          controller: nameTextController,
          onChanged: (value) {
            widget.setterProfileName(value);
          },
        ),
        Text(context.strings.generic_age, style: Theme.of(context).textTheme.bodyLarge),
        AgeTextField(
          getInitialValue: () => widget.ageInitialValue,
          onChanged: (value) {
            final age = int.tryParse(value);
            widget.setterProfileAge(age);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameTextController.dispose();
    ageTextController.dispose();
    super.dispose();
  }
}

Widget profileNameTextField(
  BuildContext context, {
  required TextEditingController controller,
  required void Function(String) onChanged,
}) {
  return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
    builder: (context, state) {
      return TextField(
        decoration: InputDecoration(
          hintText: context.strings.initial_setup_screen_profile_basic_info_profile_name_hint_text,
        ),
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        enableSuggestions: false,
        autocorrect: false,
        maxLength: 25,
        onChanged: onChanged,
        inputFormatters: [
          TextInputFormatter.withFunction((_, newText) {
            return newText.copyWith(text: toBeginningOfSentenceCase(newText.text));
          }),
          TextInputFormatter.withFunction((currentText, newText) {
            final regex = state.profileNameRegex;
            if (regex == null || regex.hasMatch(newText.text) || newText.text.isEmpty) {
              return newText;
            } else {
              return currentText;
            }
          }),
        ],
      );
    },
  );
}
