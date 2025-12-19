import 'dart:math';

import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/consts/icons.dart';
import 'package:app/ui_utils/consts/size.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/slider.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/age.dart';
import 'package:app/utils/list.dart';
import 'package:app/utils/option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/logic/settings/privacy_settings.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/attributes.dart';
import 'package:app/model/freezed/logic/profile/profile_filters.dart';
import 'package:app/model/freezed/logic/settings/privacy_settings.dart';
import 'package:app/ui/normal/profiles/edit_profile_attribute_filter.dart';
import 'package:app/ui/normal/settings/profile/edit_profile.dart';
import 'package:app/ui_utils/common_update_logic.dart';

const _SLIDER_DEFAULT_VALUE_ALPHA = 125;

void openProfileFilters(BuildContext context) {
  final profileFiltersBloc = context.read<ProfileFiltersBloc>();
  if (profileFiltersBloc.state.updateState is! UpdateIdle) {
    showSnackBar(context.strings.profile_grid_screen_profile_filter_settings_update_ongoing);
    return;
  }
  MyNavigator.push(context, ProfileFiltersPage());
}

class ProfileFiltersPage extends MyScreenPage<()> with SimpleUrlParser<ProfileFiltersPage> {
  ProfileFiltersPage() : super(builder: (closer) => ProfileFiltersScreenOpener(closer: closer));

  @override
  ProfileFiltersPage create() => ProfileFiltersPage();
}

class ProfileFiltersScreenOpener extends StatelessWidget {
  final PageCloser<()> closer;
  const ProfileFiltersScreenOpener({required this.closer, super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileFiltersScreen(
      closer: closer,
      profileFiltersBloc: context.read<ProfileFiltersBloc>(),
    );
  }
}

class ProfileFiltersScreen extends StatefulWidget {
  final PageCloser<()> closer;
  final ProfileFiltersBloc profileFiltersBloc;
  const ProfileFiltersScreen({required this.closer, required this.profileFiltersBloc, super.key});

  @override
  State<ProfileFiltersScreen> createState() => _ProfileFiltersScreenState();
}

class _ProfileFiltersScreenState extends State<ProfileFiltersScreen> {
  int initialMinAge = MIN_AGE;
  int initialMaxAge = MAX_AGE;

  @override
  void initState() {
    super.initState();
    widget.profileFiltersBloc.add(ResetEditedValues());

    initialMinAge = widget.profileFiltersBloc.state.minAge;
    initialMaxAge = widget.profileFiltersBloc.state.maxAge;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          if (widget.profileFiltersBloc.state.unsavedChanges()) {
            widget.profileFiltersBloc.add(SaveNewFilterSettings());
          }
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.profile_filters_screen_title),
          actions: [
            BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
              builder: (context, state) {
                if (state.isSomeFilterEnabled()) {
                  return IconButton(
                    onPressed: () => openConfirmDisableAllDialog(context),
                    tooltip: context.strings.profile_filters_screen_disable_filters_action,
                    icon: const Icon(Icons.filter_alt_off),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
        body: profileFiltersWidget(context),
      ),
    );
  }

  void openConfirmDisableAllDialog(BuildContext context) async {
    final r = await showConfirmDialog(
      context,
      context.strings.profile_filters_screen_disable_filters_action_dialog_title,
      yesNoActions: true,
    );
    if (r == true && context.mounted) {
      widget.profileFiltersBloc.add(DisableAllFilterSettings());
    }
  }

  Widget profileFiltersWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ageRangeSlider(context),
          const Divider(),
          maxDistanceFilter(context),
          const Divider(),
          BlocBuilder<PrivacySettingsBloc, PrivacySettingsData>(
            builder: (context, state) {
              return lastSeenTimeFilter(context, state);
            },
          ),
          const Divider(),
          profileCreatedOrEditedFilter(
            context,
            context.strings.profile_filters_screen_profile_created_filter,
            Icons.auto_awesome_rounded,
            (state) => state.valueProfileCreatedTime()?.value,
            (bloc, value) {
              if (value == null) {
                bloc.add(SetProfileCreatedFilter(null));
              } else {
                bloc.add(SetProfileCreatedFilter(ProfileCreatedTimeFilter(value: value)));
              }
            },
          ),
          const Divider(),
          profileCreatedOrEditedFilter(
            context,
            context.strings.profile_filters_screen_profile_edited_filter,
            Icons.edit,
            (state) => state.valueProfileEditedTime()?.value,
            (bloc, value) {
              if (value == null) {
                bloc.add(SetProfileEditedFilter(null));
              } else {
                bloc.add(SetProfileEditedFilter(ProfileEditedTimeFilter(value: value)));
              }
            },
          ),
          const Divider(),
          profileTextFilter(context),
          const Divider(),
          unlimitedLikesSetting(context),
          const Divider(),
          const EditAttributeFilters(),
        ],
      ),
    );
  }

  Widget ageRangeSlider(BuildContext context) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
      builder: (context, state) {
        final min = state.valueMinAge();
        final max = state.valueMaxAge();
        final String stateText = min == max ? "$min" : "$min-$max";
        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(
              context.strings.generic_age,
              icon: Icons.eighteen_up_rating_outlined,
              valueText: stateText,
            ),
            const Padding(padding: EdgeInsets.all(4)),
            RangeSliderWithPadding(
              values: RangeValues(min.toDouble(), max.toDouble()),
              min: MIN_AGE.toDouble(),
              max: MAX_AGE.toDouble(),
              divisions: MAX_AGE - MIN_AGE - 1,
              onChanged: (values) {
                context.read<ProfileFiltersBloc>().add(
                  UpdateAgeRange(values.start.toInt(), values.end.toInt()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget lastSeenTimeFilter(BuildContext context, PrivacySettingsData privacySettings) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
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
          stateText = context.strings.profile_filters_screen_profile_last_seen_time_filter_all;
          days = VALUE_MAX;
        } else if (valueInt == -1) {
          if (privacySettings.onlineStatus) {
            stateText = context.strings.profile_filters_screen_profile_last_seen_time_filter_online;
          } else {
            stateText = context
                .strings
                .profile_filters_screen_profile_last_seen_time_filter_disabled_from_privacy;
          }
          days = VALUE_MIN;
        } else if (valueInt >= 0) {
          final daysInt = valueInt ~/ 60 ~/ 60 ~/ 24;
          if (!privacySettings.lastSeenTime) {
            stateText = context
                .strings
                .profile_filters_screen_profile_last_seen_time_filter_disabled_from_privacy;
          } else if (daysInt <= 1) {
            stateText = context.strings.profile_filters_screen_profile_last_seen_time_filter_day(
              1.toString(),
            );
          } else {
            stateText = context.strings.profile_filters_screen_profile_last_seen_time_filter_days(
              daysInt.toString(),
            );
          }
          days = intDaysToDouble(daysInt);
        } else {
          stateText = context.strings.generic_error;
          days = VALUE_MAX;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(
              context.strings.profile_filters_screen_profile_last_seen_time_filter,
              iconWidgetBuilder: (disabledColor) => Container(
                width: PROFILE_CURRENTLY_ONLINE_SIZE,
                height: PROFILE_CURRENTLY_ONLINE_SIZE,
                decoration: BoxDecoration(
                  color: disabledColor ?? PROFILE_CURRENTLY_ONLINE_COLOR,
                  borderRadius: BorderRadius.circular(PROFILE_CURRENTLY_ONLINE_RADIUS),
                ),
              ),
              valueText: stateText,
            ),
            const Padding(padding: EdgeInsets.all(4)),
            SliderWithPadding(
              value: days,
              min: VALUE_MIN,
              max: VALUE_MAX,
              divisions: DIVISIONS,
              thumbColor: Theme.of(context).colorScheme.primary,
              activeColor: valueInt == null
                  ? Theme.of(context).colorScheme.primary.withAlpha(_SLIDER_DEFAULT_VALUE_ALPHA)
                  : null,
              onChanged: (double value) {
                final intDays = doubleToIntDays(value);
                final int? seconds;
                if (intDays == -1) {
                  seconds = -1;
                } else if (intDays != null) {
                  seconds = intDays * 60 * 60 * 24;
                } else {
                  seconds = null;
                }
                context.read<ProfileFiltersBloc>().add(SetLastSeenTimeFilter(seconds));
              },
            ),
          ],
        );
      },
    );
  }

  Widget profileCreatedOrEditedFilter(
    BuildContext context,
    String title,
    IconData? icon,
    int? Function(ProfileFiltersData) valueGetter,
    void Function(ProfileFiltersBloc, int?) valueSetter,
  ) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
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
          stateText = context.strings.profile_filters_screen_profile_last_seen_time_filter_all;
          days = VALUE_MAX;
        } else if (valueInt >= 0) {
          final daysInt = valueInt ~/ 60 ~/ 60 ~/ 24;
          if (daysInt <= 1) {
            stateText = context.strings.profile_filters_screen_profile_last_seen_time_filter_day(
              1.toString(),
            );
          } else {
            stateText = context.strings.profile_filters_screen_profile_last_seen_time_filter_days(
              daysInt.toString(),
            );
          }
          days = intDaysToDouble(daysInt);
        } else {
          stateText = context.strings.generic_error;
          days = VALUE_MAX;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(title, icon: icon, valueText: stateText),
            const Padding(padding: EdgeInsets.all(4)),
            SliderWithPadding(
              value: days,
              min: VALUE_MIN,
              max: VALUE_MAX,
              divisions: DIVISIONS,
              thumbColor: Theme.of(context).colorScheme.primary,
              activeColor: valueInt == null
                  ? Theme.of(context).colorScheme.primary.withAlpha(_SLIDER_DEFAULT_VALUE_ALPHA)
                  : null,
              onChanged: (double value) {
                final intDays = doubleToIntDays(value);
                final int? seconds;
                if (intDays != null) {
                  seconds = intDays * 60 * 60 * 24;
                } else {
                  seconds = null;
                }
                valueSetter(context.read<ProfileFiltersBloc>(), seconds);
              },
            ),
          ],
        );
      },
    );
  }

  Widget maxDistanceFilter(BuildContext context) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
      builder: (context, state) {
        /// Min: Unlimited, Max: 1 kilometers
        const VALUE_MIN = 0;

        /// Min: 1000 kilometers, Max: Unlimited
        final valueMax = DistanceValues.availableValues.length - 1;

        final min = state.valueMinDistanceKmFilter()?.value;
        final max = state.valueMaxDistanceKmFilter()?.value;
        final String stateText;
        final double minValue;
        final double maxValue;
        if (min != null && max != null) {
          stateText = context.strings.profile_filters_screen_distance_filter_min_and_max_value(
            min.toString(),
            max.toString(),
          );
          minValue = (DistanceValues.valueToIndex[min] ?? VALUE_MIN).toDouble();
          maxValue = (DistanceValues.valueToIndex[max] ?? valueMax).toDouble();
        } else if (min != null) {
          stateText = context.strings.profile_filters_screen_distance_filter_min_value(
            min.toString(),
          );
          maxValue = valueMax.toDouble();
          minValue = (DistanceValues.valueToIndex[min] ?? VALUE_MIN).toDouble();
        } else if (max != null) {
          stateText = context.strings.profile_filters_screen_distance_filter_max_value(
            max.toString(),
          );
          minValue = VALUE_MIN.toDouble();
          maxValue = (DistanceValues.valueToIndex[max] ?? valueMax).toDouble();
        } else {
          stateText = context.strings.generic_unlimited;
          minValue = VALUE_MIN.toDouble();
          maxValue = valueMax.toDouble();
        }

        final column = Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(
              context.strings.profile_filters_screen_distance_filter,
              icon: Icons.social_distance_rounded,
              valueText: stateText,
            ),
            const Padding(padding: EdgeInsets.all(4)),
            RangeSliderWithPadding(
              values: RangeValues(minValue, maxValue),
              min: VALUE_MIN.toDouble(),
              max: valueMax.toDouble(),
              divisions: DistanceValues.availableValues.length - 1,
              onChanged: (values) {
                final minDistanceInt = values.start.round().toInt();
                final minDistance = switch (minDistanceInt) {
                  0 => null,
                  _ => DistanceValues.availableValues.getAtOrNull(minDistanceInt),
                }.map((v) => MinDistanceKm(value: v));
                final maxDistanceInt = values.end.round().toInt();
                final int? maxDistanceIntOrNull;
                if (maxDistanceInt == valueMax) {
                  maxDistanceIntOrNull = null;
                } else {
                  maxDistanceIntOrNull = DistanceValues.availableValues.getAtOrNull(maxDistanceInt);
                }
                final maxDistance = maxDistanceIntOrNull.map((v) => MaxDistanceKm(value: v));
                context.read<ProfileFiltersBloc>().add(SetDistanceFilter(minDistance, maxDistance));
              },
            ),
          ],
        );

        return SliderTheme(
          data: SliderThemeData(
            thumbColor: Theme.of(context).colorScheme.primary,
            activeTrackColor: min == null && max == null
                ? Theme.of(context).colorScheme.primary.withAlpha(_SLIDER_DEFAULT_VALUE_ALPHA)
                : null,
          ),
          child: column,
        );
      },
    );
  }

  Widget profileTextFilter(BuildContext context) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
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
          stateText = context.strings.profile_filters_screen_profile_text_filter_min_and_max_value(
            valueMin.toString(),
            valueMax.toString(),
          );
        } else if (valueMax != null) {
          min = LIMIT_MIN;
          final currentMax = valueMax.clamp(AVAILABLE_VALUES.first, AVAILABLE_VALUES.last);
          max = findNearestIndex(currentMax).toDouble();
          stateText = context.strings.profile_filters_screen_profile_text_filter_max_value(
            valueMax.toString(),
          );
        } else if (valueMin != null) {
          max = limitMax;
          final currentMin = valueMin.clamp(AVAILABLE_VALUES.first, AVAILABLE_VALUES.last);
          min = findNearestIndex(currentMin).toDouble();
          stateText = context.strings.profile_filters_screen_profile_text_filter_min_value(
            valueMin.toString(),
          );
        } else {
          stateText = context.strings.generic_unlimited;
          min = LIMIT_MIN;
          max = limitMax;
        }

        final column = Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(
              context.strings.profile_filters_screen_profile_text_filter,
              icon: Icons.notes,
              valueText: stateText,
            ),
            const Padding(padding: EdgeInsets.all(4)),
            RangeSliderWithPadding(
              values: RangeValues(min, max),
              min: LIMIT_MIN,
              max: limitMax,
              divisions: AVAILABLE_VALUES.length - 1,
              onChanged: (RangeValues values) {
                final currentMin =
                    AVAILABLE_VALUES.getAtOrNull(values.start.round().toInt()) ??
                    AVAILABLE_VALUES.first;
                final currentMax =
                    AVAILABLE_VALUES.getAtOrNull(values.end.round().toInt()) ??
                    AVAILABLE_VALUES.last;
                context.read<ProfileFiltersBloc>().add(
                  SetProfileTextFilter(
                    currentMin == AVAILABLE_VALUES.first
                        ? null
                        : ProfileTextMinCharactersFilter(value: currentMin),
                    currentMax == AVAILABLE_VALUES.last
                        ? null
                        : ProfileTextMaxCharactersFilter(value: currentMax),
                  ),
                );
              },
            ),
          ],
        );

        return SliderTheme(
          data: SliderThemeData(
            thumbColor: Theme.of(context).colorScheme.primary,
            activeTrackColor: valueMin == null && valueMax == null
                ? Theme.of(context).colorScheme.primary.withAlpha(_SLIDER_DEFAULT_VALUE_ALPHA)
                : null,
          ),
          child: column,
        );
      },
    );
  }

  Widget unlimitedLikesSetting(BuildContext context) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
      builder: (context, state) {
        return SwitchListTile(
          title: Text(context.strings.profile_filters_screen_unlimited_likes_filter),
          secondary: Icon(UNLIMITED_LIKES_ICON, color: getUnlimitedLikesColor(context)),
          value: state.valueUnlimitedLikesFilter() ?? false,
          onChanged: (bool value) {
            final filterValue = value ? true : null;
            context.read<ProfileFiltersBloc>().add(SetUnlimitedLikesFilter(filterValue));
          },
        );
      },
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

        return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
          builder: (context, eState) {
            return Column(
              children: attributeTiles(context, true, manager, eState.valueAttributeFilters()),
            );
          },
        );
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
            MyNavigator.pushLimited(context, EditProfileAttributeFilterPage(a));
          },
        ),
      );
      attributeWidgets.add(const Divider());
    }

    if (attributeWidgets.isNotEmpty) {
      attributeWidgets.removeLast();
    }

    return attributeWidgets;
  }
}

class DistanceValues {
  static final DistanceValues _getInstance = DistanceValues._();
  static final List<int> availableValues = _getInstance._availableValues;
  static final Map<int, int> valueToIndex = _getInstance._valueToIndex;

  final List<int> _availableValues;
  final Map<int, int> _valueToIndex;
  DistanceValues.__(this._availableValues, this._valueToIndex);
  factory DistanceValues._() {
    const AVAILABLE_VALUES = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      20,
      30,
      40,
      50,
      60,
      70,
      80,
      90,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      900,
      1000,
    ];

    final Map<int, int> valueToIndex = {for (final (i, v) in AVAILABLE_VALUES.indexed) v: i};

    return DistanceValues.__(AVAILABLE_VALUES, valueToIndex);
  }
}
