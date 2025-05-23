import 'package:app/localizations.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/attribute/state.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';

void _emptyOnChanged(AttributeStateStorage storage) => ();
AttributeStateStorage? _emptyInitialStateBuilder() => null;

class SelectAttributeValue extends StatefulWidget {
  final UiAttribute attribute;
  final bool isFilter;
  final void Function(AttributeStateStorage) onChanged;
  final Widget? firstListItem;
  final Widget? lastListItem;
  final AttributeStateStorage? Function() initialStateBuilder;
  final String? filterText;
  const SelectAttributeValue({
    required this.attribute,
    required this.isFilter,
    this.onChanged = _emptyOnChanged,
    this.firstListItem,
    this.lastListItem,
    this.initialStateBuilder = _emptyInitialStateBuilder,
    this.filterText,
    super.key,
  });

  @override
  State<SelectAttributeValue> createState() => _SelectAttributeValueState();
}

class _SelectAttributeValueState extends State<SelectAttributeValue> {
  late final AttributeStateStorage storage;
  late int maxSelected;
  List<UiAttributeValue> allValues = [];
  bool showOnlySelectedFilterSetting = false;
  bool showOnlySelected = false;

  @override
  void initState() {
    super.initState();
    storage = widget.initialStateBuilder() ?? AttributeStateStorage();
    if (widget.isFilter) {
      maxSelected = widget.attribute.apiAttribute().maxFilters;
    } else {
      maxSelected = widget.attribute.apiAttribute().maxSelected;
    }
  }

  List<UiAttributeValue> getVisibleAttributeValues() {
    allValues = widget.attribute.values();
    showOnlySelectedFilterSetting = allValues.length > 10;
    var visible = filterVisible();
    if (visible.isEmpty && showOnlySelected) {
      showOnlySelected = false;
      visible = filterVisible();
    }
    return visible;
  }

  List<UiAttributeValue> filterVisible() {
    return allValues.where((a) {
      final filter = widget.filterText;
      final bool matchesFilter;
      if (filter != null) {
        matchesFilter = a.uiName().toLowerCase().contains(filter);
      } else {
        matchesFilter = true;
      }
      return matchesFilter &&
        (
          !showOnlySelected ||
          storage.isSelected(a) ||
          (a.isParentOfGroupValue() && storage.groupValueSelected(a))
        );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = getVisibleAttributeValues();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: widget.firstListItem ?? const SizedBox.shrink()),
        if (showOnlySelectedFilterSetting) SliverToBoxAdapter(child: showOnlySelectedSetting(context)),
        SliverList.builder(
          itemCount: list.length,
          itemBuilder: (context, i) => selectWidget(context, list[i]),
        ),
        SliverToBoxAdapter(child: widget.lastListItem ?? const SizedBox.shrink()),
      ],
    );
  }

  Widget selectWidget(BuildContext context, UiAttributeValue v) {
    final bool? value;
    if (v.isParentOfGroupValue()) {
      if (storage.isSelected(v)) {
        value = true;
      } else {
        if (storage.groupValueSelected(v)) {
          value = null;
        } else {
          value = false;
        }
      }
    } else {
      value = storage.isSelected(v);
    }

    final checkbox = CheckboxListTile(
      title: title(v),
      tristate: value == null,
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: (selected) {
        setState(() {
          if (maxSelected > 1) {
            if (selected == true) {
              if (storage.length() < maxSelected) {
                storage.select(v);
              } else {
                showSnackBar(R.strings.edit_attribute_value_screen_max_selected_values_error);
              }
            } else if (selected == false) {
              storage.unselect(v);
              if (value == null) {
                storage.unselectGroupValues(v);
              }
            }
          } else {
            if (selected == true) {
              if (storage.length() >= 1) {
                storage.clearAndSelect(v);
              } else {
                storage.select(v);
              }
            } else if (selected == false) {
              storage.unselect(v);
              if (value == null) {
                storage.unselectGroupValues(v);
              }
            }
          }
        });
        widget.onChanged(storage);
      },
    );

    if (v.isGroupValue()) {
      return Padding(
        padding: const EdgeInsets.only(left: 24),
        child: checkbox,
      );
    } else {
      return checkbox;
    }
  }

  Widget title(UiAttributeValue v) {
    final icon = v.uiIcon();
    final text = v.uiName();

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
    return title;
  }

  Widget showOnlySelectedSetting(BuildContext context) {
    return SwitchListTile(
      title: Text(context.strings.generic_show_only_selected),
      value: showOnlySelected,
      onChanged: storage.isNotEmpty() ? (value) {
        setState(() {
          showOnlySelected = value;
        });
      } : null,
    );
  }
}
