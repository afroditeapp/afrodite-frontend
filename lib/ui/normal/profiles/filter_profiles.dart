
import 'dart:math';

import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/list.dart';
import 'package:app/utils/option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/logic/profile/profile_filtering_settings.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/attributes.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:app/ui/normal/profiles/edit_profile_attribute_filter.dart';
import 'package:app/ui/normal/settings/profile/edit_profile.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/padding.dart';

void openProfileFilteringSettings(BuildContext context) {
  final filteringSettingsBloc = context.read<ProfileFilteringSettingsBloc>();
  if (filteringSettingsBloc.state.updateState is! UpdateIdle) {
    showSnackBar(context.strings.profile_grid_screen_profile_filter_settings_update_ongoing);
    return;
  }
  final pageKey = PageKey();
  MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(child: ProfileFilteringSettingsPage(
      pageKey: pageKey,
      profileFilteringSettingsBloc: filteringSettingsBloc,
    )),
    pageKey,
  );
}

class ProfileFilteringSettingsPage extends StatefulWidget {
  final PageKey pageKey;
  final ProfileFilteringSettingsBloc profileFilteringSettingsBloc;
  const ProfileFilteringSettingsPage({
    required this.pageKey,
    required this.profileFilteringSettingsBloc,
    super.key,
  });

  @override
  State<ProfileFilteringSettingsPage> createState() => _ProfileFilteringSettingsPageState();
}

class _ProfileFilteringSettingsPageState extends State<ProfileFilteringSettingsPage> {

  @override
  void initState() {
    super.initState();
    widget.profileFilteringSettingsBloc.add(ResetEditedValues());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileData>(
      builder: (context, myProfileState) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) {
              if (widget.profileFilteringSettingsBloc.state.unsavedChanges()) {
                widget.profileFilteringSettingsBloc.add(SaveNewFilterSettings());
              }
              return;
            }
          },
          child: Scaffold(
            appBar: AppBar(title: Text(context.strings.profile_filtering_settings_screen_title)),
            body: filteringSettingsWidget(context, myProfileState.profile?.unlimitedLikes ?? false),
          ),
        );
      }
    );
  }

  Widget filteringSettingsWidget(BuildContext context, bool myProfileUnlimitedLikesValue) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getShowFavoritesSelection(context),
          const Divider(),
          const EditAttributeFilters(),
          const Divider(),
          maxDistanceFilter(context),
          const Divider(),
          lastSeenTimeFilter(context),
          const Divider(),
          profileCreatedOrEditedFilter(
            context,
            context.strings.profile_filtering_settings_screen_profile_created_filter,
            (state) => state.valueProfileCreatedTime()?.value,
            (bloc, value) {
              if (value == null) {
                bloc.add(SetProfileCreatedFilter(null));
              } else {
                bloc.add(SetProfileCreatedFilter(ProfileCreatedTimeFilter(value: value)));
              }
            }
          ),
          const Divider(),
          profileCreatedOrEditedFilter(
            context,
            context.strings.profile_filtering_settings_screen_profile_edited_filter,
            (state) => state.valueProfileEditedTime()?.value,
            (bloc, value) {
              if (value == null) {
                bloc.add(SetProfileEditedFilter(null));
              } else {
                bloc.add(SetProfileEditedFilter(ProfileEditedTimeFilter(value: value)));
              }
            }
          ),
          const Divider(),
          profileTextFilter(context),
          const Divider(),
          unlimitedLikesSetting(context, myProfileUnlimitedLikesValue),
          const Divider(),
          randomProfileOrderSetting(context),
          const Padding(
            padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA),
            child: null,
          ),
        ],
      ),
    );
  }

  Widget getShowFavoritesSelection(BuildContext context) {
    return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      builder: (context, state) {
        return SwitchListTile(
          title: Text(context.strings.profile_filtering_settings_screen_favorite_profile_filter),
          secondary: const Icon(Icons.star_rounded),
          value: state.valueShowOnlyFavorites(),
          onChanged: (bool value) =>
              context.read<ProfileFilteringSettingsBloc>().add(SetFavoriteProfilesFilter(value)),
        );
      }
    );
  }

  Widget lastSeenTimeFilter(BuildContext context) {
    return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      builder: (context, state) {
        /// Selection for min, max and day counts for one week, 2 weeks
        /// and some months.
        const VALUE_COUNT = 2 + 7 + 1 + 6;
        const DIVISIONS = VALUE_COUNT - 1;

        /// Only online
        const VALUE_MIN = 0.0;
        /// All
        const VALUE_MAX = 15.0;

        double intDaysToDouble(int days) {
          if (days <= 7) {
            return days.toDouble();
          } else if (days == 14) {
            return 8.0;
          } else {
            final selectedMonth = days ~/ 30;
            return 8 + selectedMonth.toDouble();
          }
        }

        int? doubleToIntDays(double value) {
          if (value <= VALUE_MIN) {
            return -1;
          } else if (value >= VALUE_MAX) {
            return null;
          } else if (value <= 7) {
            return value.toInt();
          } else if (value == 8) {
            return 14;
          } else {
            return (value.toInt() - 8) * 30;
          }
        }

        final valueInt = state.valueLastSeenTimeFilter()?.value;
        final String stateText;
        final double days;
        if (valueInt == null) {
          stateText = context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter_all;
          days = VALUE_MAX;
        } else if (valueInt == -1) {
          stateText = context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter_online;
          days = VALUE_MIN;
        } else if (valueInt >= 0) {
          final daysInt = valueInt ~/ 60 ~/ 60 ~/ 24;
          if (daysInt <= 1) {
            stateText = context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter_day(1.toString());
          } else {
            stateText = context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter_days(daysInt.toString());
          }
          days = intDaysToDouble(daysInt);
        } else {
          stateText = context.strings.generic_error;
          days = VALUE_MAX;
        }

        final TextStyle? valueTextStyle;
        if (state.valueShowOnlyFavorites()) {
          final disabledTextColor = Theme.of(context).disabledColor;
          valueTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: disabledTextColor);
        } else {
          valueTextStyle = null;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter, isEnabled: !state.valueShowOnlyFavorites()),
            const Padding(padding: EdgeInsets.all(4)),
            Slider(
              value: days,
              min: VALUE_MIN,
              max: VALUE_MAX,
              divisions: DIVISIONS,
              onChanged: !state.valueShowOnlyFavorites() ? (double value) {
                final intDays = doubleToIntDays(value);
                final int? seconds;
                if (intDays == -1) {
                  seconds = -1;
                } else if (intDays != null) {
                  seconds = intDays * 60 * 60 * 24;
                } else {
                  seconds = null;
                }
                context.read<ProfileFilteringSettingsBloc>().add(SetLastSeenTimeFilter(seconds));
              } : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: COMMON_SCREEN_EDGE_PADDING),
                child: Text(
                  stateText,
                  style: valueTextStyle,
                ),
              ),
            )
          ],
        );
      }
    );
  }

  Widget profileCreatedOrEditedFilter(
    BuildContext context,
    String title,
    int? Function(ProfileFilteringSettingsData) valueGetter,
    void Function(ProfileFilteringSettingsBloc, int?) valueSetter,
  ) {
    return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      builder: (context, state) {
        /// Selection for 1-7 days, 14 days, some months
        /// and disabled value.
        const VALUE_COUNT = 7 + 1 + 6 + 1;
        const DIVISIONS = VALUE_COUNT - 1;

        /// 1 day
        const VALUE_MIN = 1.0;
        /// All
        const VALUE_MAX = 15.0;

        double intDaysToDouble(int days) {
          if (days <= 7) {
            return max(VALUE_MIN, days.toDouble());
          } else if (days == 14) {
            return 8.0;
          } else {
            final selectedMonth = days ~/ 30;
            return 8 + selectedMonth.toDouble();
          }
        }

        int? doubleToIntDays(double value) {
          if (value <= VALUE_MIN) {
            return 1;
          } else if (value >= VALUE_MAX) {
            return null;
          } else if (value <= 7) {
            return value.toInt();
          } else if (value == 8) {
            return 14;
          } else {
            return (value.toInt() - 8) * 30;
          }
        }

        final valueInt = valueGetter(state);
        final String stateText;
        final double days;
        if (valueInt == null) {
          stateText = context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter_all;
          days = VALUE_MAX;
        } else if (valueInt >= 0) {
          final daysInt = valueInt ~/ 60 ~/ 60 ~/ 24;
          if (daysInt <= 1) {
            stateText = context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter_day(1.toString());
          } else {
            stateText = context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter_days(daysInt.toString());
          }
          days = intDaysToDouble(daysInt);
        } else {
          stateText = context.strings.generic_error;
          days = VALUE_MAX;
        }

        final TextStyle? valueTextStyle;
        if (state.valueShowOnlyFavorites()) {
          final disabledTextColor = Theme.of(context).disabledColor;
          valueTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: disabledTextColor);
        } else {
          valueTextStyle = null;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(title, isEnabled: !state.valueShowOnlyFavorites()),
            const Padding(padding: EdgeInsets.all(4)),
            Slider(
              value: days,
              min: VALUE_MIN,
              max: VALUE_MAX,
              divisions: DIVISIONS,
              onChanged: !state.valueShowOnlyFavorites() ? (double value) {
                final intDays = doubleToIntDays(value);
                final int? seconds;
                if (intDays != null) {
                  seconds = intDays * 60 * 60 * 24;
                } else {
                  seconds = null;
                }
                valueSetter(context.read<ProfileFilteringSettingsBloc>(), seconds);
              } : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: COMMON_SCREEN_EDGE_PADDING),
                child: Text(
                  stateText,
                  style: valueTextStyle,
                ),
              ),
            )
          ],
        );
      }
    );
  }

  Widget maxDistanceFilter(BuildContext context) {
    return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      builder: (context, state) {
        /// Selection for numbers 1-9, 10-90 (where number % 10 == 0),
        /// 100-900 (where number % 100 == 0), 1000 and unlimited.
        const VALUE_COUNT = 9 + 9 + 9 + 2;
        const DIVISIONS = VALUE_COUNT - 1;

        /// 1 kilometers
        const VALUE_MIN = 1.0;
        /// Unlimited
        const VALUE_MAX = 29.0;

        double intKilometersToDouble(int kilometers) {
          if (kilometers <= 9) {
            return max(1, kilometers.toDouble());
          } else if (kilometers >= 10 && kilometers <= 90) {
            final selected = kilometers ~/ 10;
            return (9 + selected).toDouble();
          } else if (kilometers > 90 && kilometers <= 900) {
            final selected = kilometers ~/ 100;
            return (9 + 9 + selected).toDouble();
          } else {
            return (9 + 9 + 9 + 1).toDouble();
          }
        }

        int? doubleToIntKilometers(double value) {
          if (value <= VALUE_MIN) {
            return 1;
          } else if (value >= VALUE_MAX) {
            return null;
          } else if (value <= 9) {
            return value.toInt();
          } else if (value <= 9 + 9) {
            return (value.toInt() - 9) * 10;
          } else if (value <= 9 + 9 + 9) {
            return (value.toInt() - 9 - 9) * 100;
          } else {
            return 1000;
          }
        }

        final valueInt = state.valueMaxDistanceKmFilter()?.value;
        final String stateText;
        final double sliderValue;
        if (valueInt == null) {
          stateText = context.strings.generic_unlimited;
          sliderValue = VALUE_MAX;
        } else {
          stateText = context.strings.profile_filtering_settings_screen_max_distance_kilometers(valueInt.toString());
          sliderValue = intKilometersToDouble(valueInt);
        }

        final TextStyle? valueTextStyle;
        if (state.valueShowOnlyFavorites()) {
          final disabledTextColor = Theme.of(context).disabledColor;
          valueTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: disabledTextColor);
        } else {
          valueTextStyle = null;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(context.strings.profile_filtering_settings_screen_max_distance, isEnabled: !state.valueShowOnlyFavorites()),
            const Padding(padding: EdgeInsets.all(4)),
            Slider(
              value: sliderValue,
              min: VALUE_MIN,
              max: VALUE_MAX,
              divisions: DIVISIONS,
              onChanged: !state.valueShowOnlyFavorites() ? (double value) {
                final maxDistance = doubleToIntKilometers(value)
                  .map((v) => MaxDistanceKm(value: v));
                context.read<ProfileFilteringSettingsBloc>().add(SetMaxDistanceFilter(maxDistance));
              } : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: COMMON_SCREEN_EDGE_PADDING),
                child: Text(
                  stateText,
                  style: valueTextStyle,
                ),
              ),
            )
          ],
        );
      }
    );
  }

  Widget profileTextFilter(BuildContext context) {
    return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      builder: (context, state) {
        const AVAILABLE_VALUES = [0, 1, 5, 10, 50, 100, 200, 300, 400];
        const LIMIT_MIN = 0.0;
        final limitMax = (AVAILABLE_VALUES.length - 1).toDouble();

        int findNearestIndex(int value) {
          for (final (i, v) in AVAILABLE_VALUES.indexed) {
            if (v >= value) {
              return i;
            }
          }
          return 0;
        }

        final valueMin = state.valueProfileTextMinCharacters()?.value;
        final valueMax = state.valueProfileTextMaxCharacters()?.value;
        final String stateText;
        final double min;
        final double max;
        if (valueMin != null && valueMax != null) {
          final currentMin = valueMin.clamp(AVAILABLE_VALUES.first, AVAILABLE_VALUES.last);
          min = findNearestIndex(currentMin).toDouble();
          final currentMax = valueMax.clamp(AVAILABLE_VALUES.first, AVAILABLE_VALUES.last);
          max = findNearestIndex(currentMax).toDouble();
          stateText = context.strings.profile_filtering_settings_screen_profile_text_filter_min_and_max_value(valueMin.toString(), valueMax.toString());
        } else if (valueMax != null) {
          min = LIMIT_MIN;
          final currentMax = valueMax.clamp(AVAILABLE_VALUES.first, AVAILABLE_VALUES.last);
          max = findNearestIndex(currentMax).toDouble();
          stateText = context.strings.profile_filtering_settings_screen_profile_text_filter_max_value(valueMax.toString());
        } else if (valueMin != null) {
          max = limitMax;
          final currentMin = valueMin.clamp(AVAILABLE_VALUES.first, AVAILABLE_VALUES.last);
          min = findNearestIndex(currentMin).toDouble();
          stateText = context.strings.profile_filtering_settings_screen_profile_text_filter_min_value(valueMin.toString());
        } else {
          stateText = context.strings.generic_unlimited;
          min = LIMIT_MIN;
          max = limitMax;
        }

        final TextStyle? valueTextStyle;
        if (state.valueShowOnlyFavorites()) {
          final disabledTextColor = Theme.of(context).disabledColor;
          valueTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: disabledTextColor);
        } else {
          valueTextStyle = null;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(context.strings.profile_filtering_settings_screen_profile_text_filter, isEnabled: !state.valueShowOnlyFavorites()),
            const Padding(padding: EdgeInsets.all(4)),
            RangeSlider(
              values: RangeValues(min, max),
              min: LIMIT_MIN,
              max: limitMax,
              divisions: AVAILABLE_VALUES.length - 1,
              onChanged: !state.valueShowOnlyFavorites() ? (RangeValues values) {
                final currentMin = AVAILABLE_VALUES.getAtOrNull(values.start.round().toInt()) ?? AVAILABLE_VALUES.first;
                final currentMax = AVAILABLE_VALUES.getAtOrNull(values.end.round().toInt()) ?? AVAILABLE_VALUES.last;
                context.read<ProfileFilteringSettingsBloc>().add(SetProfileTextFilter(
                  currentMin == AVAILABLE_VALUES.first ? null : ProfileTextMinCharactersFilter(value: currentMin),
                  currentMax == AVAILABLE_VALUES.last ? null : ProfileTextMaxCharactersFilter(value: currentMax),
                ));
              } : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: COMMON_SCREEN_EDGE_PADDING),
                child: Text(
                  stateText,
                  style: valueTextStyle,
                ),
              ),
            )
          ],
        );
      }
    );
  }

  Widget unlimitedLikesSetting(BuildContext context, bool myProfileUnlimitedLikesValue) {
    return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      builder: (context, state) {
        final bool value;
        if (state.valueShowOnlyFavorites()) {
          value = false;
        } else {
          value = state.valueUnlimitedLikesFilter() ?? false;
        }
        return SwitchListTile(
          title: Text(context.strings.profile_filtering_settings_screen_unlimited_likes_filter),
          subtitle: !myProfileUnlimitedLikesValue ?
            Text(context.strings.profile_filtering_settings_screen_unlimited_likes_filter_not_available) :
            null,
          secondary: const Icon(Icons.all_inclusive),
          value: value,
          onChanged: !state.valueShowOnlyFavorites() && myProfileUnlimitedLikesValue == true ? (bool value) {
            final filterValue = value ? true : null;
            context.read<ProfileFilteringSettingsBloc>().add(SetUnlimitedLikesFilter(filterValue));
          } : null,
        );
      }
    );
  }

  Widget randomProfileOrderSetting(BuildContext context) {
    return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      builder: (context, state) {
        final bool value;
        if (state.valueShowOnlyFavorites()) {
          value = false;
        } else {
          value = state.valueRandomProfileOrder();
        }
        return SwitchListTile(
          title: Text(context.strings.profile_filtering_settings_screen_random_profile_order),
          subtitle: value ?
            Text(context.strings.profile_filtering_settings_screen_random_profile_order_description_enabled) :
            Text(context.strings.profile_filtering_settings_screen_random_profile_order_description_disabled),
          secondary: const Icon(Icons.shuffle),
          value: value,
          onChanged: !state.valueShowOnlyFavorites() ? (bool value) {
            context.read<ProfileFilteringSettingsBloc>().add(SetRandomProfileOrder(value));
          } : null,
        );
      }
    );
  }
}

class EditAttributeFilters extends StatelessWidget {
  const EditAttributeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileAttributesBloc, AttributesData>(
      builder: (context, data) {
        final manager = data.manager;
        if (manager == null) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(builder: (context, eState) {
          return Column(
            children: attributeTiles(
              context,
              !eState.valueShowOnlyFavorites(),
              manager,
              eState.valueAttributes(),
            )
          );
        });
      },
    );
  }

  List<Widget> attributeTiles(
    BuildContext context,
    bool isEnabled,
    AttributeManager manager,
    Map<int, ProfileAttributeFilterValueUpdate> myFilters,
  ) {
    final List<Widget> attributeWidgets = <Widget>[];
    final l = manager.parseFilterStates(myFilters);

    for (final a in l) {
      attributeWidgets.add(
        EditAttributeRow(
          a: a,
          isEnabled: isEnabled,
          onStartEditor: () {
            MyNavigator.push(
              context,
              MaterialPage<void>(child: EditProfileAttributeFilterScreen(a: a)),
            );
          }
        )
      );
      attributeWidgets.add(const Divider());
    }

    if (attributeWidgets.isNotEmpty) {
      attributeWidgets.removeLast();
    }

    return attributeWidgets;
  }
}
