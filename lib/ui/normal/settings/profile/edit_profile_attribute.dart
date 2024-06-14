

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_attributes.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';
import 'package:pihka_frontend/ui_utils/app_bar/search.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';

class EditProfileAttributeScreen extends StatefulWidget {
  final AttributeAndValue a;
  const EditProfileAttributeScreen({
    required this.a,
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileAttributeScreen> createState() => _EditProfileAttributeScreenState();
}

class _EditProfileAttributeScreenState extends State<EditProfileAttributeScreen> {
  bool searchPossible = false;
  late AppBarSearchController searchController;

  @override
  void initState() {
    super.initState();
    searchPossible = widget.a.attribute.mode == AttributeMode.selectSingleFilterSingle;
    searchController = AppBarSearchController(onChanged: () => setState(() {}));
  }

  bool invalidSelection(EditMyProfileData data) {
    for (final a in data.attributes) {
      if (a.id == widget.a.attribute.id && widget.a.attribute.required_ && (a.valuePart1 == 0 || a.valuePart1 == null)) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyProfileBloc, EditMyProfileData>(
      builder: (context, state) {
        final currentSelectionIsInvalid = invalidSelection(state);

        return PopScope(
          canPop: !currentSelectionIsInvalid,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
            showSnackBar(context.strings.edit_attribute_value_screen_one_value_must_be_selected);
          },
          child: Scaffold(
            appBar: AppBarWithSearch(
              controller: searchController,
              searchPossible: searchPossible,
              title: Text(context.strings.edit_profile_screen_title),
              searchHintText: context.strings.edit_attribute_value_screen_search_placeholder_text,
            ),
            body: edit(context, currentSelectionIsInvalid),
          ),
        );
      },
    );
  }

  Widget edit(BuildContext context, bool invalidSelection) {
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
          EditSingleAttribute(
            a: widget.a,
            valueFilter: filterValue,
            onNewAttributeValue: (value) {
              context.read<EditMyProfileBloc>().add(NewAttributeValue(value));
            },
          ),
          if (invalidSelection) Padding(
            padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
            child: Text(context.strings.edit_attribute_value_screen_one_value_must_be_selected),
          ),
        ],
      ),
    );
  }
}

class EditSingleAttribute extends StatefulWidget {
  final AttributeInfoProvider a;
  final String? valueFilter;
  final void Function(ProfileAttributeValueUpdate) onNewAttributeValue;

  const EditSingleAttribute({
    required this.a,
    required this.valueFilter,
    required this.onNewAttributeValue,
    super.key,
  });

  @override
  State<EditSingleAttribute> createState() => _EditSingleAttributeState();
}

class _EditSingleAttributeState extends State<EditSingleAttribute> {
  int? valuePart1;
  int? valuePart2;

  @override
  void initState() {
    super.initState();

    valuePart1 = widget.a.value?.valuePart1;
    valuePart2 = widget.a.value?.valuePart2;
  }

  bool attributeValueStateForBitflagAttributes(
    AttributeValue attributeValue
  ) {
    final currentValue = valuePart1 ?? 0;
    return currentValue & attributeValue.id != 0;
  }

  void updateBitflagValue(
    bool newValue,
    AttributeValue attributeValue,
  ) {
    final int currentNumberValue = valuePart1 ?? 0;
    final int newNumberValue;
    if (newValue) {
      var v = valuePart1 ?? 0;
      v |= attributeValue.id;
      newNumberValue = v;
    } else {
      var v = valuePart1 ?? 0;
      v &= ~attributeValue.id;
      newNumberValue = v;
    }

    if (currentNumberValue != newNumberValue) {
      valuePart1 = newNumberValue;
      widget.onNewAttributeValue(
        ProfileAttributeValueUpdate(
          id: widget.a.attribute.id,
          valuePart1: valuePart1,
          valuePart2: valuePart2,
        )
      );
    }
  }

  bool? firstLevelButtonValue(
    AttributeValue attributeValue
  ) {
    if (valuePart1 == attributeValue.id) {
      if (valuePart2 == null) {
        return true;
      } else {
        return null; // Indeterminate
      }
    } else {
      return false;
    }
  }

  bool secondLevelButtonValue(
    AttributeValue parentAttributeValue,
    AttributeValue attributeValue,
  ) {
    return valuePart1 == parentAttributeValue.id && valuePart2 == attributeValue.id;
  }

  void updateFirstLevelButtonValue(
    int? newPart1Value,
  ) {
    if (valuePart1 != newPart1Value) {
      valuePart1 = newPart1Value;
      valuePart2 = null;
      widget.onNewAttributeValue(
        ProfileAttributeValueUpdate(
          id: widget.a.attribute.id,
          valuePart1: valuePart1,
          valuePart2: valuePart2,
        )
      );
    }
  }

  void updateSecondLevelButtonValue(
    int? newPart1Value,
    int? newPart2Value,
  ) {
    if (valuePart2 != newPart2Value || valuePart1 != newPart1Value) {
      valuePart1 = newPart1Value;
      valuePart2 = newPart2Value;
      widget.onNewAttributeValue(
        ProfileAttributeValueUpdate(
          id: widget.a.attribute.id,
          valuePart1: valuePart1,
          valuePart2: valuePart2,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: attributeToWidget(context),
    );
  }

  List<Widget> attributeToWidget(BuildContext context) {
    final attribute = widget.a.attribute;

    final valueList = attribute.values.toList();
    reorderValues(valueList, attribute.valueOrder);

    bool showSingleSelect = attribute.mode == AttributeMode.selectSingleFilterSingle ||
      (!widget.a.isFilter && attribute.mode == AttributeMode.selectSingleFilterMultiple);

    bool showMultipleSelect = attribute.mode == AttributeMode.selectMultipleFilterMultiple ||
      (widget.a.isFilter && attribute.mode == AttributeMode.selectSingleFilterMultiple);

    if (showSingleSelect) {
      return widgetsForSelectSingleAttribute(
        context,
        attribute,
        valueList,
      );
    } else if (showMultipleSelect) {
      return widgetsForSelectMultipleAttribute(
        context,
        valueList,
        attribute.translations,
      );
    } else {
      return [];
    }
  }

  List<Widget> widgetsForSelectSingleAttribute(
    BuildContext context,
    Attribute attribute,
    List<AttributeValue> attributeValues,
  ) {
    final widgets = <Widget>[];
    for (final value in attributeValues) {
      final isSelected = firstLevelButtonValue(value);
      final text = attributeValueName(context, value, attribute.translations);

      final checkbox = CheckboxListTile(
        title: singleSelectTitle(value, text),
        tristate: true,
        controlAffinity: ListTileControlAffinity.leading,
        value: isSelected,
        onChanged: (newValue) {
          setState(() {
            if (valuePart1 == value.id) {
              updateFirstLevelButtonValue(null);
            } else {
              updateFirstLevelButtonValue(value.id);
            }
          });
        },
      );

      final groupValues = value.groupValues?.values.toList();
      final List<Widget> groupWidgets;
      if (groupValues != null) {
        reorderValues(groupValues, attribute.valueOrder);
        groupWidgets = widgetsForSelectSingleAttributeSecondLevel(
          context,
          attribute,
          value,
          groupValues,
        );
      } else {
        groupWidgets = [];
      }

      final filter = widget.valueFilter;
      if (filter != null && (text.toLowerCase().contains(filter.trim().toLowerCase()))) {
        widgets.add(checkbox);
      } else if (groupWidgets.isNotEmpty) {
        widgets.add(checkbox);
      } else if (filter == null) {
        widgets.add(checkbox);
      }

      widgets.addAll(groupWidgets);
    }
    return widgets;
  }

  List<Widget> widgetsForSelectSingleAttributeSecondLevel(
    BuildContext context,
    Attribute attribute,
    AttributeValue parentValue,
    List<AttributeValue> attributeValues,
  ) {
    final widgets = <Widget>[];
    for (final value in attributeValues) {
      final isSelected = secondLevelButtonValue(parentValue, value);
      final text = attributeValueName(context, value, attribute.translations);
      final filter = widget.valueFilter;
      if (filter != null && !(text.toLowerCase().contains(filter.trim().toLowerCase()))) {
        continue;
      }

      final checkbox = CheckboxListTile(
        title: singleSelectTitle(value, text),
        tristate: true,
        controlAffinity: ListTileControlAffinity.leading,
        value: isSelected,
        onChanged: (newValue) {
          setState(() {
            if (valuePart1 == parentValue.id && valuePart2 == value.id) {
              updateSecondLevelButtonValue(null, null);
            } else {
              updateSecondLevelButtonValue(parentValue.id, value.id);
            }
          });
        },
      );

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: checkbox
        )
      );
    }
    return widgets;
  }

  Widget singleSelectTitle(
    AttributeValue value,
    String text,
  ) {
      final icon = iconResourceToMaterialIcon(value.icon);
      if (icon != null) {
        return Row(
          children: [
            Icon(icon),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(text),
          ],
        );
      } else {
        return Text(text);
      }
  }

  List<Widget> widgetsForSelectMultipleAttribute(
    BuildContext context,
    List<AttributeValue> attributeValues,
    List<Language> translations,
  ) {
    // Group values are not supported in select multiple attributes.
    final widgets = <Widget>[];
    for (final value in attributeValues) {
      final icon = iconResourceToMaterialIcon(value.icon);
      final text = attributeValueName(context, value, translations);

      final Widget title;
      if (icon != null) {
        title = Row(
          children: [
            Icon(icon),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(text),
          ],
        );
      } else {
        title = Text(text);
      }

      final checkbox = CheckboxListTile(
        title: title,
        controlAffinity: ListTileControlAffinity.leading,
        value: attributeValueStateForBitflagAttributes(value),
        onChanged: (bitflagValue) {
          setState(() {
            updateBitflagValue(bitflagValue == true, value);
          });
        },
      );

      widgets.add(checkbox);
    }
    return widgets;
  }
}


class EditAttributeTitle extends StatelessWidget {
  final Attribute a;
  const EditAttributeTitle({required this.a, super.key});

  @override
  Widget build(BuildContext context) {
    return questionTitle(context, a);
  }

  Widget questionTitle(BuildContext context, Attribute attribute) {
    final text = Text(
      attributeName(context, attribute),
      style: Theme.of(context).textTheme.bodyLarge,
    );
    // Title icon is disabled
    // final IconData? icon = iconResourceToMaterialIcon(attribute.icon);
    const IconData? icon = null;

    final Widget title;
    if (icon != null) {
      title = Row(
        children: [
          Icon(icon),
          const Padding(padding: EdgeInsets.all(8.0)),
          text,
        ],
      );
    } else {
      title = text;
    }

    return Padding(
      padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
      child: title
    );
  }
}
