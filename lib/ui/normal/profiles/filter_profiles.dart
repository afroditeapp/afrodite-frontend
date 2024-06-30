
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/profile/attributes.dart';
import 'package:pihka_frontend/logic/profile/edit_profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/attributes.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/edit_profile_filtering_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/ui/normal/profiles/edit_profile_attribute_filter.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';

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

    initialFilters = widget.profileFilteringSettingsBloc.state.attributeFilters?.filters.map((e) => ProfileAttributeFilterValueUpdate(
      acceptMissingAttribute: e.acceptMissingAttribute,
      filterValues: [...e.filterValues],
      id: e.id,
    )).toList() ?? [];

    widget.editProfileFilteringSettingsBloc.add(ResetStateWith(
      widget.profileFilteringSettingsBloc.state.showOnlyFavorites,
      initialFilters,
    ));
  }

  void saveData(BuildContext context) {
    widget.profileFilteringSettingsBloc.add(SaveNewFilterSettings(
      widget.editProfileFilteringSettingsBloc.state.showOnlyFavorites,
      widget.editProfileFilteringSettingsBloc.state.attributeFilters.toList(),
    ));
  }

  bool areSettingsChanged(EditProfileFilteringSettingsData editedSettings) {
    if (widget.profileFilteringSettingsBloc.state.showOnlyFavorites != editedSettings.showOnlyFavorites) {
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
      child: BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
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
              body: filteringSettingsWidget(context, settingsChanged),
              floatingActionButton: settingsChanged ? FloatingActionButton(
                onPressed: () => saveData(context),
                child: const Icon(Icons.check),
              ) : null
            ),
          );
        }
      ),
    );
  }

  Widget filteringSettingsWidget(BuildContext context, bool settingsChanged) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getShowFavoritesSelection(context),
          const Divider(),
          const EditAttributeFilters(),
          if (settingsChanged) const Padding(
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
}

class EditAttributeFilters extends StatelessWidget {
  const EditAttributeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileAttributesBloc, AttributesData>(
      builder: (context, data) {
        final availableAttributes = data.attributes?.info;
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
          values: e.filterValues,
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
