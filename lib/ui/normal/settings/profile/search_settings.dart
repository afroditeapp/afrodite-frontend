

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/settings/edit_search_settings.dart';
import 'package:pihka_frontend/logic/settings/search_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/account/initial_setup.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/settings/edit_search_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/settings/search_settings.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/search_settings/edit_gender_filter.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/search_settings/edit_my_gender.dart';
import 'package:pihka_frontend/ui_utils/app_bar/menu_actions.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/padding.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/ui_utils/text_field.dart';
import 'package:pihka_frontend/utils/age.dart';
import 'package:pihka_frontend/utils/api.dart';

class SearchSettingsScreen extends StatefulWidget {
  final PageKey pageKey;
  final SearchSettingsBloc searchSettingsBloc;
  final EditSearchSettingsBloc editSearchSettingsBloc;
  const SearchSettingsScreen({
    required this.pageKey,
    required this.searchSettingsBloc,
    required this.editSearchSettingsBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchSettingsScreen> createState() => _SearchSettingsScreenState();
}

class _SearchSettingsScreenState extends State<SearchSettingsScreen> {
  String initialMinAge = "";
  String initialMaxAge = "";

  @override
  void initState() {
    super.initState();

    final minAge = widget.searchSettingsBloc.state.minAge;
    final maxAge = widget.searchSettingsBloc.state.maxAge;

    widget.editSearchSettingsBloc.add(SetInitialValues(
      minAge: minAge,
      maxAge: maxAge,
      searchGroups: widget.searchSettingsBloc.state.searchGroups,
    ));

    initialMinAge = minAge?.toString() ?? "";
    initialMaxAge = maxAge?.toString() ?? "";
  }

  void validateAndSaveData(BuildContext context) {
    final s = widget.editSearchSettingsBloc.state;

    final minAge = s.minAge;
    final maxAge = s.maxAge;
    if (minAge == null || maxAge == null || !ageRangeIsValid(minAge, maxAge)) {
      showSnackBar(context.strings.search_settings_screen_age_range_is_invalid);
      return;
    }

    final gender = s.gender;
    if (gender == null) {
      showSnackBar(context.strings.search_settings_screen_gender_is_not_selected);
      return;
    }

    final searchGroups = SearchGroupsExtensions.createFrom(gender, s.genderSearchSetting);
    if (!searchGroups.somethingIsSelected()) {
      showSnackBar(context.strings.search_settings_screen_gender_filter_is_not_selected);
      return;
    }

    // Check is setting saving needed
    final currentState = widget.searchSettingsBloc.state;
    if (minAge == currentState.minAge && maxAge == currentState.maxAge && searchGroups == currentState.searchGroups) {
      MyNavigator.pop(context);
      return;
    }

    context.read<SearchSettingsBloc>().add(SaveSearchSettings(
      minAge: minAge,
      maxAge: maxAge,
      searchGroups: searchGroups,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        validateAndSaveData(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.search_settings_screen_title),
          actions: [
            menuActions([
              MenuItemButton(
                child: Text(context.strings.search_settings_screen_change_my_gender_action_title),
                onPressed: () => MyNavigator.push(context, const MaterialPage<void>(child: EditMyGenderScreen())),
              )
            ]),
          ],
        ),
        body: updateStateHandler<SearchSettingsBloc, SearchSettingsData>(
          context: context,
          pageKey: widget.pageKey,
          child: edit(context),
        ),
      ),
    );
  }

  Widget edit(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          hPad(Text(context.strings.search_settings_screen_age_range_min_value_title)),
          hPad(minAgeField()),
          hPad(Text(context.strings.search_settings_screen_age_range_max_value_title)),
          hPad(maxAgeField()),
          hPad(Text(context.strings.search_settings_screen_change_gender_filter_action_tile)),
          const Padding(padding: EdgeInsets.all(4)),
          editGenderFilter(),
          const Padding(padding: EdgeInsets.all(4)),
          hPad(Text(context.strings.search_settings_screen_help_text)),
        ],
      ),
    );
  }

  Widget editGenderFilter() {
    return BlocBuilder<EditSearchSettingsBloc, EditSearchSettingsData>(
      builder: (context, state) {
        return EditGenderFilter(
          onStartEditor: () => MyNavigator.push(context, const MaterialPage<void>(child: EditGenderFilterScreen())),
          genderSearchSetting: state.genderSearchSetting,
          gender: state.gender,
        );
      }
    );
  }

  Widget minAgeField() {
    return AgeTextField(
      getInitialValue: () => initialMinAge,
      onChanged: (value) {
        final min = int.tryParse(value);
        context.read<EditSearchSettingsBloc>().add(UpdateMinAge(min));
      },
    );
  }

  Widget maxAgeField() {
    return AgeTextField(
      getInitialValue: () => initialMaxAge,
      onChanged: (value) {
        final max = int.tryParse(value);
        context.read<EditSearchSettingsBloc>().add(UpdateMaxAge(max));
      },
    );
  }
}


class EditGenderFilter extends StatelessWidget {
  final void Function() onStartEditor;
  final Gender? gender;
  final GenderSearchSettingsAll genderSearchSetting;
  const EditGenderFilter({
    required this.onStartEditor,
    required this.gender,
    required this.genderSearchSetting,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final attributeWidget = Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: COMMON_SCREEN_EDGE_PADDING),
            child: visibleValues(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: onStartEditor,
          ),
        ),
      ],
    );

    return InkWell(
      onTap: onStartEditor,
      child: attributeWidget,
    );
  }

  Widget visibleValues(BuildContext context) {
    final values = genderSearchSetting.toUiTexts(context, gender);
    final valueWidgets = values.map((e) => Chip(label: Text(e))).toList();
    return Wrap(
      spacing: 8,
      children: valueWidgets,
    );
  }
}
