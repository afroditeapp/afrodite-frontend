import "dart:math";

import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/ui/initial_setup/navigation.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:app/ui_utils/dropdown_menu.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:app/utils/age.dart";

class AskSearchSettingsPage extends InitialSetupPageBase
    with SimpleUrlParser<AskSearchSettingsPage> {
  AskSearchSettingsPage() : super(builder: (_) => AskSearchSettingsScreen());

  @override
  String get nameForDb => 'search_settings';

  @override
  AskSearchSettingsPage create() => AskSearchSettingsPage();
}

class AskSearchSettingsScreen extends StatelessWidget {
  const AskSearchSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitialSetupLoadingGuard(child: _AskSearchSettingsScreenInternal());
  }
}

class _AskSearchSettingsScreenInternal extends StatelessWidget {
  const _AskSearchSettingsScreenInternal();

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
          if (state.genderSearchSetting.notEmpty() &&
              ageRangeIsValid(state.searchAgeRangeMin, state.searchAgeRangeMax)) {
            return () {
              navigateToNextInitialSetupPage(context);
            };
          } else {
            return null;
          }
        },
        question: AskSearchSettings(
          minAgeInitialValue: currentMin ?? MIN_AGE,
          maxAgeInitialValue: currentMax ?? MAX_AGE,
        ),
      ),
    );
  }
}

class AskSearchSettings extends StatefulWidget {
  final int minAgeInitialValue;
  final int maxAgeInitialValue;
  const AskSearchSettings({
    required this.minAgeInitialValue,
    required this.maxAgeInitialValue,
    super.key,
  });

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
          padding: const EdgeInsets.symmetric(horizontal: INITIAL_SETUP_PADDING, vertical: 8.0),
          child: minAgeField(),
        ),
        subtitle(context.strings.initial_setup_screen_search_settings_max_age_subtitle),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: INITIAL_SETUP_PADDING, vertical: 8.0),
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
        child: Text(text, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }

  Widget askGenderSearchQuestion(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        return genderSearchSettingCheckboxes(context, state.gender, state.genderSearchSetting, (
          isSelected,
          whatWasSelected,
        ) {
          final newValue = state.genderSearchSetting.updateWith(isSelected, whatWasSelected);
          context.read<InitialSetupBloc>().add(SetGenderSearchSetting(newValue));
        });
      },
    );
  }

  Widget minAgeField() {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerLeft,
          child: AgeDropdown(
            getMinValue: () => MIN_AGE,
            getMaxValue: () => MAX_AGE,
            value: state.searchAgeRangeMin ?? widget.minAgeInitialValue,
            onChanged: (value) {
              context.read<InitialSetupBloc>().add(SetAgeRangeMin(value));
            },
          ),
        );
      },
    );
  }

  Widget maxAgeField() {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerLeft,
          child: AgeDropdown(
            getMinValue: () => MIN_AGE,
            getMaxValue: () => MAX_AGE,
            value: state.searchAgeRangeMax ?? widget.maxAgeInitialValue,
            onChanged: (value) {
              context.read<InitialSetupBloc>().add(SetAgeRangeMax(value));
            },
          ),
        );
      },
    );
  }
}

List<Gender> genderSearchSettingCheckboxOrder(Gender? myProfileGender) {
  return switch (myProfileGender) {
    Gender.man => [Gender.woman, Gender.man, Gender.nonBinary],
    null || Gender.woman => [Gender.man, Gender.woman, Gender.nonBinary],
    Gender.nonBinary => [Gender.nonBinary, Gender.man, Gender.woman],
  };
}

Widget genderSearchSettingCheckboxes(
  BuildContext context,
  Gender? myProfileGender,
  GenderSearchSettingsAll? selected,
  void Function(bool, Gender) onChanged,
) {
  final checkboxOrder = genderSearchSettingCheckboxOrder(myProfileGender);
  final widgets = checkboxOrder.map((e) {
    return switch (e) {
      Gender.man => searchSettingCheckbox(context, selected?.men == true, Gender.man, onChanged),
      Gender.woman => searchSettingCheckbox(
        context,
        selected?.women == true,
        Gender.woman,
        onChanged,
      ),
      Gender.nonBinary => searchSettingCheckbox(
        context,
        selected?.nonBinary == true,
        Gender.nonBinary,
        onChanged,
      ),
    };
  }).toList();
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
}

Widget searchSettingCheckbox(
  BuildContext context,
  bool? selected,
  Gender gender,
  void Function(bool, Gender) onChanged,
) {
  return CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading,
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
