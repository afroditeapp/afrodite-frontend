import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/settings/edit_search_settings.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/model/freezed/logic/settings/edit_search_settings.dart';
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
  return BlocBuilder<EditSearchSettingsBloc, EditSearchSettingsData>(
    builder: (context, state) {
      if (state.gender == Gender.nonBinary) {
        return searchingCheckboxesForNonBinary(
          context,
          state.genderSearchSetting,
          (isSelected, whatWasSelected) {
            final newValue = state.genderSearchSetting.updateWith(isSelected, whatWasSelected);
            context.read<EditSearchSettingsBloc>().add(UpdateGenderSearchSettingAll(newValue));
          }
        );
      } else {
        return searchingRadioButtonsForMenAndWomen(
          context,
          state.genderSearchSetting.toGenderSearchSetting(),
          (selected) {
            if (selected != null) {
              context.read<EditSearchSettingsBloc>().add(UpdateGenderSearchSettingAll(selected.toGenderSearchSettingsAll()));
            }
          },
          () => context.read<EditSearchSettingsBloc>().state.gender,
        );
      }
    }
  );
}
