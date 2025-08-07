

import 'package:app/ui/normal/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
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

  bool floatingActionButtonPadding = false;

  @override
  void initState() {
    super.initState();

    widget.searchSettingsBloc.add(ResetEditedValues());
  }

  void validateAndSaveData(BuildContext context) {
    final s = widget.searchSettingsBloc.state;

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
          if (settingsChanged) {
            floatingActionButtonPadding = true;
          }

          return PopScope(
            canPop: !settingsChanged,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) {
                return;
              }
              showConfirmDialog(context, context.strings.generic_save_confirmation_title, yesNoActions: true)
                .then((value) {
                  if (value == true && context.mounted) {
                    validateAndSaveData(context);
                  } else if (value == false && context.mounted) {
                    MyNavigator.pop(context);
                    widget.searchSettingsBloc.add(ResetEditedValues());
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
              body: edit(context, data),
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

  Widget edit(BuildContext context, SearchSettingsData state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          hPad(Text(context.strings.search_settings_screen_change_gender_filter_action_tile)),
          const Padding(padding: EdgeInsets.all(4)),
          editGenderFilter(state),
          const Padding(padding: EdgeInsets.all(4)),
          settingsCategoryTitle(context, context.strings.search_settings_screen_automatic_search),
          distanceWidget(context, state),
          filtersWidget(context, state),
          newProfilesWidget(context, state),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              context.strings.search_settings_screen_weekdays,
            ),
          ),
          hPad(weekdaysWidget(context, state)),
          const Padding(padding: EdgeInsets.all(4)),
          if (floatingActionButtonPadding) const Padding(
            padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA),
            child: null,
          ),
        ],
      ),
    );
  }

  Widget editGenderFilter(SearchSettingsData state) {
    return EditGenderFilter(
      onStartEditor: () => MyNavigator.push(context, const MaterialPage<void>(child: EditGenderFilterScreen())),
      genderSearchSetting: state.valueGenderSearchSettingsAll(),
      gender: state.valueGender(),
    );
  }

  Widget distanceWidget(BuildContext context, SearchSettingsData state) {
    return CheckboxListTile(
      title: Text(context.strings.search_settings_screen_distance),
      value: state.valueSearchDistanceFilters(),
      onChanged: (value) {
        context.read<SearchSettingsBloc>().add(ToggleSearchDistanceFilters());
      },
    );
  }

  Widget filtersWidget(BuildContext context, SearchSettingsData state) {
    return CheckboxListTile(
      title: Text(context.strings.search_settings_screen_filters),
      value: state.valueSearchAttributeFilters(),
      onChanged: (value) {
        context.read<SearchSettingsBloc>().add(ToggleSearchAttributeFilters());
      },
    );
  }

  Widget newProfilesWidget(BuildContext context, SearchSettingsData state) {
    return CheckboxListTile(
      title: Text(context.strings.search_settings_screen_new_profiles),
      value: state.valueSearchNewProfiles(),
      onChanged: (value) {
        context.read<SearchSettingsBloc>().add(ToggleSearchNewProfiles());
      },
    );
  }

  Widget weekdaysWidget(BuildContext context, SearchSettingsData state) {
    return Wrap(
      spacing: 5,
      children: Weekday.weekdays(context).map((day) {
        return FilterChip(
          label: Text(day.text),
          selected: state.valueSearchWeekdays() & day.bitflag == day.bitflag,
          onSelected: (value) {
            if (value) {
              context.read<SearchSettingsBloc>().add(UpdateSearchWeekday(state.valueSearchWeekdays() | day.bitflag));
            } else {
              final newValue = state.valueSearchWeekdays() & ~day.bitflag;
              context.read<SearchSettingsBloc>().add(UpdateSearchWeekday(newValue));
            }
          },
        );
      }).toList(),
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

class Weekday {
  final String text;
  final int bitflag;
  Weekday(this.text, this.bitflag);

  static List<Weekday> weekdays(BuildContext context) {
    final strings = context.strings;
    return [
      Weekday(strings.generic_weekday_mon, 0x01),
      Weekday(strings.generic_weekday_tue, 0x02),
      Weekday(strings.generic_weekday_wed, 0x04),
      Weekday(strings.generic_weekday_thu, 0x08),
      Weekday(strings.generic_weekday_fri, 0x10),
      Weekday(strings.generic_weekday_sat, 0x20),
      Weekday(strings.generic_weekday_sun, 0x40),
    ];
  }
}
