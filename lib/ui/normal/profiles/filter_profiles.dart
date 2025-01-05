
import 'dart:math';

import 'package:app/utils/option.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/profile/edit_profile_filtering_settings.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/logic/profile/profile_filtering_settings.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/attributes.dart';
import 'package:app/model/freezed/logic/profile/edit_profile_filtering_settings.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:app/ui/normal/profiles/edit_profile_attribute_filter.dart';
import 'package:app/ui/normal/settings/profile/edit_profile.dart';
import 'package:app/ui/utils/view_profile.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/utils/api.dart';

class ProfileFilteringSettingsPage extends StatefulWidget {
  final PageKey pageKey;
  final ProfileFilteringSettingsBloc profileFilteringSettingsBloc;
  final EditProfileFilteringSettingsBloc editProfileFilteringSettingsBloc;
  const ProfileFilteringSettingsPage({
    required this.pageKey,
    required this.profileFilteringSettingsBloc,
    required this.editProfileFilteringSettingsBloc,
    super.key,
  });

  @override
  State<ProfileFilteringSettingsPage> createState() => _ProfileFilteringSettingsPageState();
}

class _ProfileFilteringSettingsPageState extends State<ProfileFilteringSettingsPage> {

  late final List<ProfileAttributeFilterValueUpdate> initialFilters;

  @override
  void initState() {
    super.initState();

    initialFilters = widget.profileFilteringSettingsBloc.state.filteringSettings?.currentFiltersCopy() ?? [];

    widget.editProfileFilteringSettingsBloc.add(ResetStateWith(
      widget.profileFilteringSettingsBloc.state.showOnlyFavorites,
      initialFilters,
      widget.profileFilteringSettingsBloc.state.filteringSettings?.lastSeenTimeFilter,
      widget.profileFilteringSettingsBloc.state.filteringSettings?.unlimitedLikesFilter,
      widget.profileFilteringSettingsBloc.state.filteringSettings?.maxDistanceKmFilter,
      widget.profileFilteringSettingsBloc.state.filteringSettings?.accountCreatedFilter,
      widget.profileFilteringSettingsBloc.state.filteringSettings?.profileEditedFilter,
      widget.profileFilteringSettingsBloc.state.filteringSettings?.randomProfileOrder ?? false,
    ));
  }

  void saveData(BuildContext context) {
    widget.profileFilteringSettingsBloc.add(SaveNewFilterSettings(
      widget.editProfileFilteringSettingsBloc.state.showOnlyFavorites,
      widget.editProfileFilteringSettingsBloc.state.attributeFilters.toList(),
      widget.editProfileFilteringSettingsBloc.state.lastSeenTimeFilter,
      widget.editProfileFilteringSettingsBloc.state.unlimitedLikesFilter,
      widget.editProfileFilteringSettingsBloc.state.maxDistanceKmFilter,
      widget.editProfileFilteringSettingsBloc.state.accountCreatedFilter,
      widget.editProfileFilteringSettingsBloc.state.profileEditedFilter,
      widget.editProfileFilteringSettingsBloc.state.randomProfileOrder,
    ));
  }

  bool areSettingsChanged(EditProfileFilteringSettingsData editedSettings) {
    final currentSettings = widget.profileFilteringSettingsBloc.state;
    if (
      currentSettings.showOnlyFavorites != editedSettings.showOnlyFavorites ||
      currentSettings.filteringSettings?.lastSeenTimeFilter != editedSettings.lastSeenTimeFilter ||
      currentSettings.filteringSettings?.unlimitedLikesFilter != editedSettings.unlimitedLikesFilter ||
      currentSettings.filteringSettings?.maxDistanceKmFilter != editedSettings.maxDistanceKmFilter ||
      currentSettings.filteringSettings?.accountCreatedFilter != editedSettings.accountCreatedFilter ||
      currentSettings.filteringSettings?.profileEditedFilter != editedSettings.profileEditedFilter ||
      currentSettings.filteringSettings?.randomProfileOrder != editedSettings.randomProfileOrder
    ) {
      return true;
    }

    for (final editedFilter in editedSettings.attributeFilters) {
      final currentFilterOrNull = initialFilters.where((e) => e.id == editedFilter.id).firstOrNull;
      final ProfileAttributeFilterValueUpdate currentFilter;
      if (currentFilterOrNull == null) {
        currentFilter = ProfileAttributeFilterValueUpdate(
          acceptMissingAttribute: null,
          filterValues: [],
          id: editedFilter.id,
        );
      } else {
        currentFilter = currentFilterOrNull;
      }
      if (
        (currentFilter.acceptMissingAttribute ?? false) != (editedFilter.acceptMissingAttribute ?? false) ||
        !listEquals(currentFilter.filterValues, editedFilter.filterValues)
      ) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      listenWhen: (previous, current) => previous.updateState != current.updateState,
      listener: (context, state) {
        if (state.updateState is UpdateStarted) {
          MyNavigator.pop(context);
        }
      },
      child: BlocBuilder<MyProfileBloc, MyProfileData>(
        builder: (context, myProfileState) {
          return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
            builder: (context, data) {
              final settingsChanged = areSettingsChanged(data);

              return PopScope(
                canPop: !settingsChanged,
                onPopInvoked: (didPop) {
                  if (didPop) {
                    return;
                  }
                  showConfirmDialog(context, context.strings.generic_save_confirmation_title, yesNoActions: true)
                    .then((value) {
                      if (value == true) {
                        saveData(context);
                      } else if (value == false) {
                        MyNavigator.pop(context);
                      }
                    });
                },
                child: Scaffold(
                  appBar: AppBar(title: Text(context.strings.profile_filtering_settings_screen_title)),
                  body: filteringSettingsWidget(context, myProfileState.profile?.unlimitedLikes ?? false),
                  floatingActionButton: settingsChanged ? FloatingActionButton(
                    onPressed: () => saveData(context),
                    child: const Icon(Icons.check),
                  ) : null
                ),
              );
            }
          );
        }
      ),
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
          accountCreatedOrProfileEditedFilter(
            context,
            context.strings.profile_filtering_settings_screen_account_created_filter,
            (state) => state.accountCreatedFilter?.value,
            (bloc, value) {
              if (value == null) {
                bloc.add(SetAccountCreatedFilter(null));
              } else {
                bloc.add(SetAccountCreatedFilter(AccountCreatedTimeFilter(value: value)));
              }
            }
          ),
          const Divider(),
          accountCreatedOrProfileEditedFilter(
            context,
            context.strings.profile_filtering_settings_screen_profile_edited_filter,
            (state) => state.profileEditedFilter?.value,
            (bloc, value) {
              if (value == null) {
                bloc.add(SetProfileEditedFilter(null));
              } else {
                bloc.add(SetProfileEditedFilter(ProfileEditedTimeFilter(value: value)));
              }
            }
          ),
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
    return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
      builder: (context, state) {
        return SwitchListTile(
          title: Text(context.strings.profile_filtering_settings_screen_favorite_profile_filter),
          secondary: const Icon(Icons.star_rounded),
          value: state.showOnlyFavorites,
          onChanged: (bool value) =>
              context.read<EditProfileFilteringSettingsBloc>().add(SetFavoriteProfilesFilter(value)),
        );
      }
    );
  }

  Widget lastSeenTimeFilter(BuildContext context) {
    return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
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

        final valueInt = state.lastSeenTimeFilter?.value;
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
        if (state.showOnlyFavorites) {
          final disabledTextColor = Theme.of(context).disabledColor;
          valueTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: disabledTextColor);
        } else {
          valueTextStyle = null;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(context.strings.profile_filtering_settings_screen_profile_last_seen_time_filter, isEnabled: !state.showOnlyFavorites),
            const Padding(padding: EdgeInsets.all(4)),
            Slider(
              value: days,
              min: VALUE_MIN,
              max: VALUE_MAX,
              divisions: DIVISIONS,
              onChanged: !state.showOnlyFavorites ? (double value) {
                final intDays = doubleToIntDays(value);
                final int? seconds;
                if (intDays == -1) {
                  seconds = -1;
                } else if (intDays != null) {
                  seconds = intDays * 60 * 60 * 24;
                } else {
                  seconds = null;
                }
                context.read<EditProfileFilteringSettingsBloc>().add(SetLastSeenTimeFilter(seconds));
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

    Widget accountCreatedOrProfileEditedFilter(
      BuildContext context,
      String title,
      int? Function(EditProfileFilteringSettingsData) valueGetter,
      void Function(EditProfileFilteringSettingsBloc, int?) valueSetter,
    ) {
    return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
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
        if (state.showOnlyFavorites) {
          final disabledTextColor = Theme.of(context).disabledColor;
          valueTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: disabledTextColor);
        } else {
          valueTextStyle = null;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(title, isEnabled: !state.showOnlyFavorites),
            const Padding(padding: EdgeInsets.all(4)),
            Slider(
              value: days,
              min: VALUE_MIN,
              max: VALUE_MAX,
              divisions: DIVISIONS,
              onChanged: !state.showOnlyFavorites ? (double value) {
                final intDays = doubleToIntDays(value);
                final int? seconds;
                if (intDays != null) {
                  seconds = intDays * 60 * 60 * 24;
                } else {
                  seconds = null;
                }
                valueSetter(context.read<EditProfileFilteringSettingsBloc>(), seconds);
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
    return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
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

        final valueInt = state.maxDistanceKmFilter?.value;
        final String stateText;
        final double sliderValue;
        if (valueInt == null) {
          stateText = context.strings.profile_filtering_settings_screen_max_distance_unlimited;
          sliderValue = VALUE_MAX;
        } else {
          stateText = context.strings.profile_filtering_settings_screen_max_distance_kilometers(valueInt.toString());
          sliderValue = intKilometersToDouble(valueInt);
        }

        final TextStyle? valueTextStyle;
        if (state.showOnlyFavorites) {
          final disabledTextColor = Theme.of(context).disabledColor;
          valueTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: disabledTextColor);
        } else {
          valueTextStyle = null;
        }

        return Column(
          children: [
            const Padding(padding: EdgeInsets.all(4)),
            ViewAttributeTitle(context.strings.profile_filtering_settings_screen_max_distance, isEnabled: !state.showOnlyFavorites),
            const Padding(padding: EdgeInsets.all(4)),
            Slider(
              value: sliderValue,
              min: VALUE_MIN,
              max: VALUE_MAX,
              divisions: DIVISIONS,
              onChanged: !state.showOnlyFavorites ? (double value) {
                final maxDistance = doubleToIntKilometers(value)
                  .map((v) => MaxDistanceKm(value: v));
                context.read<EditProfileFilteringSettingsBloc>().add(SetMaxDistanceFilter(maxDistance));
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
    return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
      builder: (context, state) {
        final bool value;
        if (state.showOnlyFavorites) {
          value = false;
        } else {
          value = state.unlimitedLikesFilter ?? false;
        }
        return SwitchListTile(
          title: Text(context.strings.profile_filtering_settings_screen_unlimited_likes_filter),
          subtitle: !myProfileUnlimitedLikesValue ?
            Text(context.strings.profile_filtering_settings_screen_unlimited_likes_filter_not_available) :
            null,
          secondary: const Icon(Icons.all_inclusive),
          value: value,
          onChanged: !state.showOnlyFavorites && myProfileUnlimitedLikesValue == true ? (bool value) {
            final filterValue = value ? true : null;
            context.read<EditProfileFilteringSettingsBloc>().add(SetUnlimitedLikesFilter(filterValue));
          } : null,
        );
      }
    );
  }

  Widget randomProfileOrderSetting(BuildContext context) {
    return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
      builder: (context, state) {
        final bool value;
        if (state.showOnlyFavorites) {
          value = false;
        } else {
          value = state.randomProfileOrder;
        }
        return SwitchListTile(
          title: Text(context.strings.profile_filtering_settings_screen_random_profile_order),
          subtitle: value ?
            Text(context.strings.profile_filtering_settings_screen_random_profile_order_description_enabled) :
            Text(context.strings.profile_filtering_settings_screen_random_profile_order_description_disabled),
          secondary: const Icon(Icons.shuffle),
          value: value,
          onChanged: !state.showOnlyFavorites ? (bool value) {
            context.read<EditProfileFilteringSettingsBloc>().add(SetRandomProfileOrder(value));
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
        final availableAttributes = data.attributes;
        if (availableAttributes == null) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(builder: (context, eState) {
          return Column(
            children: attributeTiles(
              context,
              !eState.showOnlyFavorites,
              availableAttributes,
              eState.attributeFilters,
            )
          );
        });
      },
    );
  }

  List<Widget> attributeTiles(
    BuildContext context,
    bool isEnabled,
    ProfileAttributes availableAttributes,
    Iterable<ProfileAttributeFilterValueUpdate> myFilters,
  ) {
    final List<Widget> attributeWidgets = <Widget>[];
    final convertedAttributes = myFilters.map((e) {
      final value = e.filterValues.firstOrNull;
      if (value == null) {
        return null;
      } else {
        return ProfileAttributeValue(
          id: e.id,
          v: e.filterValues,
        );
      }
    }).nonNulls;

    final l = AttributeAndValue.sortedListFrom(
      availableAttributes,
      convertedAttributes,
      includeNullAttributes: true,
    ).map((e) {
      final filter = myFilters.where((element) => element.id == e.attribute.id).firstOrNull;
      return AttributeFilterInfo(e, filter);
    });

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

class AttributeFilterInfo implements AttributeInfoProvider {
  final AttributeAndValue attributeAndValue;
  final ProfileAttributeFilterValueUpdate? update;
  AttributeFilterInfo(this.attributeAndValue, this.update);

  @override
  ProfileAttributeValue? get value => attributeAndValue.value;

  @override
  Attribute get attribute => attributeAndValue.attribute;

  @override
  String title(BuildContext context) {
    return attributeAndValue.title(context);
  }

  @override
  List<AttributeValue> sortedSelectedValues() {
    return attributeAndValue.sortedSelectedValuesWithSettings(filterValues: true);
  }

  @override
  List<String> extraValues(BuildContext context) {
    final acceptMissing = update?.acceptMissingAttribute ?? false;
    if (acceptMissing) {
      return [context.strings.generic_empty];
    } else {
      return [];
    }
  }

  @override
  bool get isFilter => true;
}
