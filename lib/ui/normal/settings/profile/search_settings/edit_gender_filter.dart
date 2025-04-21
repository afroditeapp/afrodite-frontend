import 'package:app/logic/settings/search_settings.dart';
import 'package:app/model/freezed/logic/settings/search_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/ui/initial_setup/search_settings.dart';

class EditGenderFilterScreen extends StatelessWidget {
  const EditGenderFilterScreen({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.strings.search_settings_screen_change_gender_filter_action_tile)),
        body: edit(context),
      );
  }

  Widget edit(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(4)),
          askGenderSearchQuestionForSearchSettings(context),
        ],
      ),
    );
  }
}

Widget askGenderSearchQuestionForSearchSettings(BuildContext context) {
  return BlocBuilder<SearchSettingsBloc, SearchSettingsData>(
    builder: (context, state) {
      if (state.valueGender() == Gender.nonBinary) {
        return searchingCheckboxesForNonBinary(
          context,
          state.valueGenderSearchSettingsAll(),
          (isSelected, whatWasSelected) {
            final newValue = state.valueGenderSearchSettingsAll().updateWith(isSelected, whatWasSelected);
            context.read<SearchSettingsBloc>().add(UpdateGenderSearchSettingsAll(newValue));
          }
        );
      } else {
        return searchingRadioButtonsForMenAndWomen(
          context,
          state.valueGenderSearchSettingsAll().toGenderSearchSetting(),
          (selected) {
            if (selected != null) {
              context.read<SearchSettingsBloc>().add(UpdateGenderSearchSettingsAll(selected.toGenderSearchSettingsAll()));
            }
          },
          () => context.read<SearchSettingsBloc>().state.valueGender(),
        );
      }
    }
  );
}
