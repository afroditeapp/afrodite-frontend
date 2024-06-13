

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/profile/edit_profile_filtering_settings.dart';
import 'package:pihka_frontend/ui/normal/profiles/filter_profiles.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile_attribute.dart';
import 'package:pihka_frontend/ui_utils/app_bar/search.dart';

class EditProfileAttributeFilterScreen extends StatefulWidget {
  final AttributeFilterInfo a;
  const EditProfileAttributeFilterScreen({
    required this.a,
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileAttributeFilterScreen> createState() => _EditProfileAttributeFilterScreenState();
}

class _EditProfileAttributeFilterScreenState extends State<EditProfileAttributeFilterScreen> {
  bool searchPossible = false;
  late AppBarSearchController searchController;

  @override
  void initState() {
    super.initState();
    searchPossible = widget.a.attribute.mode == AttributeMode.selectSingleFilterSingle;
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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditAttributeTitle(a: widget.a.attribute),
          EditAttributeFilterEmptyValue(
            a: widget.a,
            onEmpty: (a, value) =>
              context.read<EditProfileFilteringSettingsBloc>().add(SetMatchWithEmpty(a, value))
          ),
          EditSingleAttribute(
            a: widget.a,
            valueFilter: filterValue,
            onNewAttributeValue: (value) =>
              context.read<EditProfileFilteringSettingsBloc>().add(SetAttributeFilterValue(widget.a.attribute, value))
          ),
        ],
      ),
    );
  }
}

class EditAttributeFilterEmptyValue extends StatefulWidget {
  final AttributeFilterInfo a;
  final void Function(Attribute a, bool value) onEmpty;
  const EditAttributeFilterEmptyValue({required this.a, required this.onEmpty, super.key});

  @override
  State<EditAttributeFilterEmptyValue> createState() => _EditAttributeFilterEmptyValueState();
}

class _EditAttributeFilterEmptyValueState extends State<EditAttributeFilterEmptyValue> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.a.update?.acceptMissingAttribute ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(context.strings.generic_empty),
      controlAffinity: ListTileControlAffinity.leading,
      value: isSelected,
      onChanged: (newValue) {
        setState(() {
          isSelected = !isSelected;
          widget.onEmpty(widget.a.attribute, isSelected);
        });
      },
    );
  }
}
