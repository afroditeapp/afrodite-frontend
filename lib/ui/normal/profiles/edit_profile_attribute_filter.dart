

import 'package:app/ui_utils/attribute/filter.dart';
import 'package:app/ui_utils/attribute/widgets/select_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/profile/edit_profile_filtering_settings.dart';
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

    return SelectAttributeValue(
      attribute: widget.a.attribute(),
      isFilter: true,
      initialStateBuilder: () => widget.a.selectedValues.copy(),
      onChanged: (state) =>
        context.read<EditProfileFilteringSettingsBloc>().add(SetAttributeFilterValueLists(widget.a.attribute(), state)),
      firstListItem: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditAttributeTitle(a: widget.a.attribute()),
          EditAttributeFilterEmptyValue(
            a: widget.a,
            onChanged: (settings) =>
              context.read<EditProfileFilteringSettingsBloc>().add(SetAttributeFilterSettings(widget.a.attribute(), settings))
          )
        ],
      ),
      filterText: filterValue,
    );
  }
}

class EditAttributeFilterEmptyValue extends StatefulWidget {
  final AttributeAndFilterState a;
  final void Function(FilterSettingsState settings) onChanged;
  const EditAttributeFilterEmptyValue({required this.a, required this.onChanged, super.key});

  @override
  State<EditAttributeFilterEmptyValue> createState() => _EditAttributeFilterEmptyValueState();
}

class _EditAttributeFilterEmptyValueState extends State<EditAttributeFilterEmptyValue> {
  bool acceptMissingAttributeState = false;

  @override
  void initState() {
    super.initState();
    acceptMissingAttributeState = widget.a.settingsState.acceptMissingAttribute;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(context.strings.generic_empty),
      controlAffinity: ListTileControlAffinity.leading,
      value: acceptMissingAttributeState,
      onChanged: (_) {
        setState(() {
          acceptMissingAttributeState = !acceptMissingAttributeState;
          widget.onChanged(FilterSettingsState(acceptMissingAttribute: acceptMissingAttributeState));
        });
      },
    );
  }
}
