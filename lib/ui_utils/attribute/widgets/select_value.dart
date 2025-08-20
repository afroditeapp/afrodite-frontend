import 'package:app/localizations.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/attribute/state.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';

enum FilterMode { basic, advanced }

class SelectAttributeValueStorage {
  /// Used for saving attribute values and filter values for wanted
  /// values.
  final AttributeStateStorage selected;

  /// Used for saving filter values for unwanted values.
  final AttributeStateStorage unwanted;
  SelectAttributeValueStorage({required this.selected, required this.unwanted});
  SelectAttributeValueStorage.selected(this.selected) : unwanted = AttributeStateStorage();
}

void _emptyOnChanged(SelectAttributeValueStorage storage) => ();
SelectAttributeValueStorage? _emptyInitialStateBuilder() => null;

class SelectAttributeValue extends StatefulWidget {
  final UiAttribute attribute;
  final FilterMode? filterMode;
  final void Function(SelectAttributeValueStorage) onChanged;
  final Widget? firstListItem;
  final Widget? lastListItem;
  final SelectAttributeValueStorage? Function() initialStateBuilder;
  final String? filterText;
  const SelectAttributeValue({
    required this.attribute,
    this.filterMode,
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
  late final AttributeStateStorage storageSelected;
  late final AttributeStateStorage storageUnwanted;
  late int maxSelected;
  List<UiAttributeValue> allValues = [];
  bool showOnlySelectedFilterSetting = false;
  bool showOnlySelected = false;

  @override
  void initState() {
    super.initState();
    final s = widget.initialStateBuilder();
    storageSelected = s?.selected ?? AttributeStateStorage();
    storageUnwanted = s?.unwanted ?? AttributeStateStorage();
    if (widget.filterMode != null) {
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
          (!showOnlySelected ||
              storageSelected.isSelected(a) ||
              (a.isParentOfGroupValue() && storageSelected.groupValueSelected(a)) ||
              storageUnwanted.isSelected(a) ||
              (a.isParentOfGroupValue() && storageUnwanted.groupValueSelected(a)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = getVisibleAttributeValues();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: widget.firstListItem ?? const SizedBox.shrink()),
        if (showOnlySelectedFilterSetting)
          SliverToBoxAdapter(child: showOnlySelectedSetting(context)),
        SliverList.builder(
          itemCount: list.length,
          itemBuilder: (context, i) => selectWidget(context, list[i]),
        ),
        SliverToBoxAdapter(child: widget.lastListItem ?? const SizedBox.shrink()),
      ],
    );
  }

  Widget selectWidget(BuildContext context, UiAttributeValue v) {
    if (widget.filterMode == FilterMode.advanced ||
        (widget.filterMode == FilterMode.basic && storageUnwanted.isSelected(v))) {
      return selectWidgetAdvanced(context, v);
    } else {
      return selectWidgetBasic(context, v);
    }
  }

  Widget selectWidgetBasic(BuildContext context, UiAttributeValue v) {
    final bool? currentValue = getSelectedStatusBasic(storageSelected, v);
    final checkbox = CheckboxListTile(
      title: title(v),
      tristate: currentValue == null,
      controlAffinity: ListTileControlAffinity.leading,
      value: currentValue,
      onChanged: (newValue) {
        setState(() {
          updateSelectedStatusBasic(storageSelected, v, currentValue, newValue);
        });
        widget.onChanged(
          SelectAttributeValueStorage(selected: storageSelected, unwanted: storageUnwanted),
        );
      },
    );

    if (v.isGroupValue()) {
      return Padding(padding: const EdgeInsets.only(left: 24), child: checkbox);
    } else {
      return checkbox;
    }
  }

  Widget selectWidgetAdvanced(BuildContext context, UiAttributeValue v) {
    final bool? currentSelectedValue = getSelectedStatusBasic(storageSelected, v);
    final bool? currentUnwantedValue = getSelectedStatusBasic(storageUnwanted, v);
    final List<bool> selected;
    if (currentSelectedValue == true) {
      selected = [true, false];
    } else if (currentUnwantedValue == true) {
      selected = [false, true];
    } else {
      selected = [false, false];
    }
    final checkbox = ListTile(
      title: Row(
        children: [
          title(v),
          const Spacer(),
          ToggleButtons(
            isSelected: selected,
            onPressed: (selectedIndex) {
              setState(() {
                storageSelected.unselect(v);
                storageUnwanted.unselect(v);
                if (selectedIndex == 0 &&
                    (currentSelectedValue == false || currentSelectedValue == null)) {
                  updateSelectedStatusBasic(storageSelected, v, currentSelectedValue, true);
                } else if (selectedIndex == 1 &&
                    (currentUnwantedValue == false || currentUnwantedValue == null)) {
                  updateSelectedStatusBasic(storageUnwanted, v, currentUnwantedValue, true);
                }
              });
              widget.onChanged(
                SelectAttributeValueStorage(selected: storageSelected, unwanted: storageUnwanted),
              );
            },
            children: const [Icon(Icons.check), Icon(Icons.close)],
          ),
        ],
      ),
      onTap: () {
        setState(() {
          storageSelected.unselect(v);
          storageUnwanted.unselect(v);
          if (currentSelectedValue == true) {
            updateSelectedStatusBasic(storageUnwanted, v, currentUnwantedValue, true);
          } else if (currentUnwantedValue == true) {
            // Unselect
          } else {
            updateSelectedStatusBasic(storageSelected, v, currentSelectedValue, true);
          }
        });
        widget.onChanged(
          SelectAttributeValueStorage(selected: storageSelected, unwanted: storageUnwanted),
        );
      },
    );

    if (v.isGroupValue()) {
      return Padding(padding: const EdgeInsets.only(left: 24), child: checkbox);
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
      onChanged: storageSelected.isNotEmpty() || storageUnwanted.isNotEmpty()
          ? (value) {
              setState(() {
                showOnlySelected = value;
              });
            }
          : null,
    );
  }

  /// Null is returned for level one value when related level two value
  /// is selected.
  bool? getSelectedStatusBasic(AttributeStateStorage storage, UiAttributeValue v) {
    if (v.isParentOfGroupValue()) {
      if (storage.isSelected(v)) {
        return true;
      } else {
        if (storage.groupValueSelected(v)) {
          return null;
        } else {
          return false;
        }
      }
    } else {
      return storage.isSelected(v);
    }
  }

  void updateSelectedStatusBasic(
    AttributeStateStorage storage,
    UiAttributeValue v,
    bool? currentValue,
    bool? newValue,
  ) {
    if (maxSelected > 1) {
      if (newValue == true) {
        if (storage.length() < maxSelected) {
          storage.select(v);
        } else {
          showSnackBar(R.strings.edit_attribute_value_screen_max_selected_values_error);
        }
      } else if (newValue == false) {
        storage.unselect(v);
        if (currentValue == null) {
          storage.unselectGroupValues(v);
        }
      }
    } else {
      if (newValue == true) {
        if (storage.length() >= 1) {
          storage.clearAndSelect(v);
        } else {
          storage.select(v);
        }
      } else if (newValue == false) {
        storage.unselect(v);
        if (currentValue == null) {
          storage.unselectGroupValues(v);
        }
      }
    }
  }
}
