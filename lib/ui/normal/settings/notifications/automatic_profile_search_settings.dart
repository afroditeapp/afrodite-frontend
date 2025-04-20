
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/app/notification_settings.dart';
import 'package:app/model/freezed/logic/settings/notification_settings.dart';

void openAutomaticProfileSearchSettings(BuildContext context) {
  MyNavigator.push(
    context,
    const MaterialPage<void>(
      child: AutomaticProfileSearchSettingsScreen(),
    ),
  );
}

class AutomaticProfileSearchSettingsScreen extends StatefulWidget {
  const AutomaticProfileSearchSettingsScreen({
    super.key,
  });

  @override
  State<AutomaticProfileSearchSettingsScreen> createState() => _AutomaticProfileSearchSettingsScreenState();
}

class _AutomaticProfileSearchSettingsScreenState extends State<AutomaticProfileSearchSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationSettingsBloc, NotificationSettingsData>(
      builder: (context, data) {
        return Scaffold(
          appBar: AppBar(title: Text(context.strings.automatic_profile_search_settings_screen_title)),
          body: content(context, data),
        );
      }
    );
  }

  Widget content(BuildContext context, NotificationSettingsData state) {
    return contentWidget(context, state);
  }

  Widget contentWidget(
    BuildContext context,
    NotificationSettingsData state,
  ) {
    final List<Widget> settingsList;
    settingsList = [
      distanceWidget(context, state),
      filtersWidget(context, state),
      newProfilesWidget(context, state),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          context.strings.automatic_profile_search_settings_screen_weekdays,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      hPad(weekdaysWidget(context, state)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: settingsList,
    );
  }

  Widget distanceWidget(BuildContext context, NotificationSettingsData state) {
    return CheckboxListTile(
      title: Text(context.strings.automatic_profile_search_settings_screen_distance),
      value: state.valueSearchDistance(),
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleSearchDistance());
      },
    );
  }

  Widget filtersWidget(BuildContext context, NotificationSettingsData state) {
    return CheckboxListTile(
      title: Text(context.strings.automatic_profile_search_settings_screen_filters),
      value: state.valueSearchFilters(),
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleSearchFilters());
      },
    );
  }

  Widget newProfilesWidget(BuildContext context, NotificationSettingsData state) {
    return CheckboxListTile(
      title: Text(context.strings.automatic_profile_search_settings_screen_new_profiles),
      value: state.valueSearchNewProfiles(),
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleSearchNewProfiles());
      },
    );
  }

  Widget weekdaysWidget(BuildContext context, NotificationSettingsData state) {
    return Wrap(
      spacing: 5,
      children: Weekday.weekdays(context).map((day) {
        return FilterChip(
          label: Text(day.text),
          selected: state.valueSearchWeekdays() & day.bitflag == day.bitflag,
          onSelected: (value) {
            if (value) {
              context.read<NotificationSettingsBloc>().add(UpdateSearchWeekday(state.valueSearchWeekdays() | day.bitflag));
            } else {
              final newValue = state.valueSearchWeekdays() & ~day.bitflag;
              if (newValue != 0) {
                context.read<NotificationSettingsBloc>().add(UpdateSearchWeekday(newValue));
              } else {
                showSnackBar(context.strings.automatic_profile_search_settings_screen_one_weekday_must_be_selected_info);
              }
            }
          },
        );
      }).toList(),
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
