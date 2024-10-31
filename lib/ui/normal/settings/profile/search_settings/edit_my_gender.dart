import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/settings/edit_search_settings.dart';
import 'package:app/model/freezed/logic/settings/edit_search_settings.dart';
import 'package:app/ui/initial_setup/gender.dart';
import 'package:app/ui/normal/settings/profile/search_settings/edit_gender_filter.dart';
import 'package:app/ui_utils/padding.dart';

class EditMyGenderScreen extends StatelessWidget {
  const EditMyGenderScreen({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.search_settings_screen_change_my_gender_action_title)),
      body: edit(context),
    );
  }

  Widget edit(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          hPad(Text(context.strings.edit_my_gender_screen_gender_setting_title)),
          const Padding(padding: EdgeInsets.all(4)),
          askGender(),
          const Padding(padding: EdgeInsets.all(4)),
          hPad(Text(context.strings.search_settings_screen_change_gender_filter_action_tile)),
          const Padding(padding: EdgeInsets.all(4)),
          askGenderSearchQuestionForSearchSettings(context),
        ],
      ),
    );
  }

  Widget askGender() {
    return BlocBuilder<EditSearchSettingsBloc, EditSearchSettingsData>(
      builder: (context, state) {
        return genderRadioButtons(
          context,
          state.gender,
          (selected) {
            if (selected != null) {
              context.read<EditSearchSettingsBloc>().add(UpdateGender(selected));
            }
          }
        );
      }
    );
  }
}
