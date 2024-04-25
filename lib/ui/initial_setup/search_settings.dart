import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/navigator_state.dart";
import "package:pihka_frontend/model/freezed/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup/location.dart";
import "package:pihka_frontend/ui_utils/consts/padding.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/ui_utils/text_field.dart";
import "package:pihka_frontend/utils/age.dart";

class AskSearchSettingsScreen extends StatelessWidget {
  const AskSearchSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<InitialSetupBloc>().state;
    final int? currentMin;
    final int? currentMax;
    if (!state.searchAgeRangeInitDone) {
      // Init age range
      final currentAge = state.profileAge;
      if (currentAge == null) {
        currentMin = MIN_AGE;
        currentMax = MAX_AGE;
      } else {
        currentMin = max(currentAge - 5, MIN_AGE);
        currentMax = min(currentAge + 5, MAX_AGE);
      }
      context.read<InitialSetupBloc>().add(InitAgeRange(currentMin, currentMax));
    } else {
      currentMin = state.searchAgeRangeMin;
      currentMax = state.searchAgeRangeMax;
    }

    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.genderSearchSetting.notEmpty() && ageRangeIsValid(state.searchAgeRangeMin, state.searchAgeRangeMax)) {
            return () {
              MyNavigator.push(context, MaterialPage<void>(child: AskLocationScreen()));
            };
          } else {
            return null;
          }
        },
        question: AskSearchSettings(
          minAgeInitialValue: currentMin?.toString() ?? "",
          maxAgeInitialValue: currentMax?.toString() ?? "",
        ),
      ),
    );
  }
}

class AskSearchSettings extends StatefulWidget {
  final String minAgeInitialValue;
  final String maxAgeInitialValue;
  const AskSearchSettings({required this.minAgeInitialValue, required this.maxAgeInitialValue, super.key});

  @override
  State<AskSearchSettings> createState() => _AskSearchSettingsState();
}

class _AskSearchSettingsState extends State<AskSearchSettings> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_search_settings_title),
        askGenderSearchQuestion(context),
        subtitle(context.strings.initial_setup_screen_search_settings_min_age_subtitle),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: INITIAL_SETUP_PADDING),
          child: minAgeField(),
        ),
        subtitle(context.strings.initial_setup_screen_search_settings_max_age_subtitle),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: INITIAL_SETUP_PADDING),
          child: maxAgeField(),
        ),
      ],
    );
  }

  Widget subtitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  Widget askGenderSearchQuestion(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        if (state.gender == Gender.nonBinary) {
          return searchingCheckboxesForNonBinary(
            context,
            state.genderSearchSetting,
            (isSelected, whatWasSelected) {
              final newValue = state.genderSearchSetting.updateWith(isSelected, whatWasSelected);
              context.read<InitialSetupBloc>().add(SetGenderSearchSetting(newValue));
            }
          );
        } else {
          return searchingRadioButtonsForMenAndWomen(
            context,
            state.genderSearchSetting.toGenderSearchSetting(),
            (selected) {
              if (selected != null) {
                context.read<InitialSetupBloc>().add(SetGenderSearchSetting(selected.toGenderSearchSettingsAll()));
              }
            },
            () => context.read<InitialSetupBloc>().state.gender,
          );
        }
      }
    );
  }

  Widget minAgeField() {
    return AgeTextField(
      getInitialValue: () => widget.minAgeInitialValue,
      onChanged: (value) {
        final min = int.tryParse(value);
        context.read<InitialSetupBloc>().add(SetAgeRangeMin(min));
      },
    );
  }

  Widget maxAgeField() {
    return AgeTextField(
      getInitialValue: () => widget.maxAgeInitialValue,
      onChanged: (value) {
        final max = int.tryParse(value);
        context.read<InitialSetupBloc>().add(SetAgeRangeMax(max));
      },
    );
  }
}

Widget searchingRadioButtonsForMenAndWomen(
  BuildContext context,
  GenderSearchSetting? selected,
  void Function(GenderSearchSetting?) onChanged,
  Gender? Function() getGender,
) {
  final men = searchSettingRadioButton(context, selected, GenderSearchSetting.men, onChanged);
  final women = searchSettingRadioButton(context, selected, GenderSearchSetting.women, onChanged);
  final Widget first;
  final Widget second;
  if (getGender() == Gender.man) {
    first = women;
    second = men;
  } else {
    first = men;
    second = women;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      first,
      second,
      searchSettingRadioButton(context, selected, GenderSearchSetting.all, onChanged),
    ],
  );
}

Widget searchSettingRadioButton(
  BuildContext context,
  GenderSearchSetting? selected,
  GenderSearchSetting gender,
  void Function(GenderSearchSetting?) onChanged,
) {
  return RadioListTile<GenderSearchSetting>(
    title: Text(gender.uiText(context)),
    value: gender,
    groupValue: selected,
    onChanged: onChanged,
  );
}


Widget searchingCheckboxesForNonBinary(
  BuildContext context,
  GenderSearchSettingsAll? selected,
  void Function(bool, Gender) onChanged,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      searchSettingCheckbox(context, selected?.nonBinary == true, Gender.nonBinary, onChanged),
      searchSettingCheckbox(context, selected?.men == true, Gender.man, onChanged),
      searchSettingCheckbox(context, selected?.women == true, Gender.woman, onChanged),
    ],
  );
}

Widget searchSettingCheckbox(
  BuildContext context,
  bool? selected,
  Gender gender,
  void Function(bool, Gender) onChanged,
) {
  return CheckboxListTile(
    title: Text(gender.uiTextPlural(context)),
    value: selected,
    onChanged: (value) {
      if (value == true) {
        onChanged(true, gender);
      } else {
        onChanged(false, gender);
      }
    },
  );
}
