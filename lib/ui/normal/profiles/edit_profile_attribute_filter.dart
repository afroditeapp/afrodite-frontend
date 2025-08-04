

import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/model/freezed/logic/profile/profile_filters.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/attribute/filter.dart';
import 'package:app/ui_utils/attribute/widgets/select_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/ui/normal/settings/profile/edit_profile_attribute.dart';
import 'package:app/ui_utils/app_bar/search.dart';

class EditProfileAttributeFilterScreen extends StatefulWidget {
  final AttributeAndFilterState a;
  const EditProfileAttributeFilterScreen({
    required this.a,
    super.key,
  });

  @override
  State<EditProfileAttributeFilterScreen> createState() => _EditProfileAttributeFilterScreenState();
}

class _EditProfileAttributeFilterScreenState extends State<EditProfileAttributeFilterScreen> {
  bool searchPossible = false;
  late AppBarSearchController searchController;

  @override
  void initState() {
    super.initState();
    searchPossible = widget.a.attribute().apiAttribute().mode == AttributeMode.oneLevel ||
      widget.a.attribute().apiAttribute().mode == AttributeMode.twoLevel;
    searchController = AppBarSearchController(onChanged: () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearch(
        controller: searchController,
        searchPossible: searchPossible,
        title: Text(context.strings.edit_attribute_filter_value_screen_title),
        searchHintText: context.strings.edit_attribute_filter_value_screen_search_placeholder_text,
        actions: [
          menuActions([
            BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
              builder: (context, state) {
                final bloc = context.read<ProfileFiltersBloc>();
                if (state.showAdvancedFilters) {
                  return MenuItemButton(
                    child: Text(context.strings.edit_attribute_filter_value_screen_show_basic_filters_action),
                    onPressed: () => bloc.add(SetShowAdvancedFilters(false)),
                  );
                } else {
                  return MenuItemButton(
                    child: Text(context.strings.edit_attribute_filter_value_screen_show_advanced_filters_action),
                    onPressed: () => bloc.add(SetShowAdvancedFilters(true)),
                  );
                }
              }
            ),
          ]),
        ],
      ),
      body: edit(context),
    );
  }

  Widget edit(BuildContext context) {
    final String? filterValue;
    if (searchController.searchActive) {
      final processedFilter = searchController.searchController.text.trim().toLowerCase();
      if (processedFilter.isEmpty) {
        filterValue = null;
      } else {
        filterValue = processedFilter;
      }
    } else {
      filterValue = null;
    }

    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
      buildWhen: (previous, current) => previous.showAdvancedFilters != current.showAdvancedFilters,
      builder: (context, state) {
        return SelectAttributeValue(
          attribute: widget.a.attribute(),
          filterMode: state.showAdvancedFilters ? FilterMode.advanced : FilterMode.basic,
          initialStateBuilder: () => SelectAttributeValueStorage(
            selected: widget.a.wanted.copy(),
            unwanted: widget.a.unwanted.copy(),
          ),
          onChanged: (state) =>
            context.read<ProfileFiltersBloc>().add(SetAttributeFilterValueLists(widget.a.attribute(), state.selected, state.unwanted)),
          firstListItem: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditAttributeTitle(a: widget.a.attribute()),
              EditAttributeFilterSettings(
                a: widget.a,
                onChanged: (settings) =>
                  context.read<ProfileFiltersBloc>().add(SetAttributeFilterSettings(widget.a.attribute(), settings)),
                showAdvancedFilters: state.showAdvancedFilters,
              )
            ],
          ),
          filterText: filterValue,
        );
      }
    );
  }
}

class EditAttributeFilterSettings extends StatefulWidget {
  final AttributeAndFilterState a;
  final bool showAdvancedFilters;
  final void Function(FilterSettingsState settings) onChanged;
  const EditAttributeFilterSettings({
    required this.a,
    required this.onChanged,
    required this.showAdvancedFilters,
    super.key,
  });

  @override
  State<EditAttributeFilterSettings> createState() => _EditAttributeFilterSettingsState();
}

class _EditAttributeFilterSettingsState extends State<EditAttributeFilterSettings> {
  bool acceptMissingAttributeState = false;
  bool requireAllWantedValuesState = false;

  @override
  void initState() {
    super.initState();
    acceptMissingAttributeState = widget.a.settingsState.acceptMissingAttribute;
    requireAllWantedValuesState = widget.a.settingsState.requireAllWantedValues;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile(
          title: Text(context.strings.generic_empty),
          controlAffinity: ListTileControlAffinity.leading,
          value: acceptMissingAttributeState,
          onChanged: (_) {
            setState(() {
              acceptMissingAttributeState = !acceptMissingAttributeState;
            });
            widget.onChanged(FilterSettingsState(
              acceptMissingAttribute: acceptMissingAttributeState,
              requireAllWantedValues: requireAllWantedValuesState,
            ));
          },
        ),
        if (widget.showAdvancedFilters || requireAllWantedValuesState) CheckboxListTile(
          title: Text(context.strings.edit_attribute_filter_value_screen_require_all_wanted_values),
          controlAffinity: ListTileControlAffinity.leading,
          value: requireAllWantedValuesState,
          onChanged: (_) {
            setState(() {
              requireAllWantedValuesState = !requireAllWantedValuesState;
            });
            widget.onChanged(FilterSettingsState(
              acceptMissingAttribute: acceptMissingAttributeState,
              requireAllWantedValues: requireAllWantedValuesState,
            ));
          },
        ),
      ],
    );
  }
}
