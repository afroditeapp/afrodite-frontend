

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/logic/settings/search_settings.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/search_settings.dart';
import 'package:app/ui/normal/settings/profile/search_settings/edit_gender_filter.dart';
import 'package:app/ui/normal/settings/profile/search_settings/edit_my_gender.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/dropdown_menu.dart';
import 'package:app/ui_utils/icon_button.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/age.dart';
import 'package:app/utils/api.dart';

class SearchSettingsScreen extends StatefulWidget {
  final PageKey pageKey;
  final SearchSettingsBloc searchSettingsBloc;
  const SearchSettingsScreen({
    required this.pageKey,
    required this.searchSettingsBloc,
    super.key,
  });

  @override
  State<SearchSettingsScreen> createState() => _SearchSettingsScreenState();
}

class _SearchSettingsScreenState extends State<SearchSettingsScreen> {
  int initialMinAge = MIN_AGE;
  int initialMaxAge = MAX_AGE;

  @override
  void initState() {
    super.initState();

    widget.searchSettingsBloc.add(ResetEditedValues());

    initialMinAge = widget.searchSettingsBloc.state.minAge;
    initialMaxAge = widget.searchSettingsBloc.state.maxAge;
  }

  void validateAndSaveData(BuildContext context) {
    final s = widget.searchSettingsBloc.state;

    final minAge = s.valueMinAge();
    final maxAge = s.valueMaxAge();
    if (!ageRangeIsValid(minAge, maxAge)) {
      showSnackBar(context.strings.search_settings_screen_age_range_is_invalid);
      return;
    }

    final gender = s.valueGender();
    if (gender == null) {
      showSnackBar(context.strings.search_settings_screen_gender_is_not_selected);
      return;
    }

    final searchGroups = SearchGroupsExtensions.createFrom(gender, s.valueGenderSearchSettingsAll());
    if (!searchGroups.somethingIsSelected()) {
      showSnackBar(context.strings.search_settings_screen_gender_filter_is_not_selected);
      return;
    }

    context.read<SearchSettingsBloc>().add(SaveSearchSettings(
      searchGroups
    ));
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<SearchSettingsBloc, SearchSettingsData>(
      context: context,
      pageKey: widget.pageKey,
      child: BlocBuilder<SearchSettingsBloc, SearchSettingsData>(
        builder: (context, data) {
          final settingsChanged = data.unsavedChanges();

          return PopScope(
            canPop: !settingsChanged,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }
              showConfirmDialog(context, context.strings.generic_save_confirmation_title, yesNoActions: true)
                .then((value) {
                  if (value == true && context.mounted) {
                    validateAndSaveData(context);
                  } else if (value == false && context.mounted) {
                    MyNavigator.pop(context);
                  }
                });
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
              body: edit(context, settingsChanged),
              floatingActionButton: settingsChanged ? FloatingActionButton(
                onPressed: () => validateAndSaveData(context),
                child: const Icon(Icons.check),
              ) : null
            ),
          );
        },
      ),
    );
  }

  Widget edit(BuildContext context, bool settingsChanged) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  hPad(Text(context.strings.search_settings_screen_age_range_min_value_title)),
                  hPad(minAgeField(context)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(context.strings.search_settings_screen_age_range_max_value_title),
                  maxAgeField(context),
                ],
              ),
            ],
          ),
          hPad(Text(context.strings.search_settings_screen_change_gender_filter_action_tile)),
          const Padding(padding: EdgeInsets.all(4)),
          editGenderFilter(),
          const Padding(padding: EdgeInsets.all(4)),
          hPad(Text(context.strings.search_settings_screen_help_text)),
          if (settingsChanged) const Padding(
            padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA),
            child: null,
          ),
        ],
      ),
    );
  }

  Widget editGenderFilter() {
    return BlocBuilder<SearchSettingsBloc, SearchSettingsData>(
      builder: (context, state) {
        return EditGenderFilter(
          onStartEditor: () => MyNavigator.push(context, const MaterialPage<void>(child: EditGenderFilterScreen())),
          genderSearchSetting: state.valueGenderSearchSettingsAll(),
          gender: state.valueGender(),
        );
      }
    );
  }

  Widget minAgeField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AgeDropdown(
        getMinValue: () => MIN_AGE,
        getMaxValue: () {
          final currentAge = context.read<MyProfileBloc>().state.profile?.age;
          if (currentAge != null) {
            return currentAge;
          } else {
            return MAX_AGE;
          }
        },
        getInitialValue: () => initialMinAge,
        onChanged: (value) {
          context.read<SearchSettingsBloc>().add(UpdateMinAge(value));
        },
      ),
    );
  }

  Widget maxAgeField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AgeDropdown(
        getMinValue: () {
          final currentAge = context.read<MyProfileBloc>().state.profile?.age;
          if (currentAge != null) {
            return currentAge;
          } else {
            return MIN_AGE;
          }
        },
        getMaxValue: () => MAX_AGE,
        getInitialValue: () => initialMaxAge,
        onChanged: (value) {
          context.read<SearchSettingsBloc>().add(UpdateMaxAge(value));
        },
      ),
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
          child: IconWithIconButtonPadding(
            Icons.edit_rounded,
            iconColor: getIconButtonEnabledColor(context)
          )
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
