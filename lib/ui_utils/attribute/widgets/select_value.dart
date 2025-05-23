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
  final AttributeStateStorage? Function() initialStateBuilder;
  const SelectAttributeValue({
    required this.attribute,
    required this.isFilter,
    this.onChanged = _emptyOnChanged,
    this.firstListItem,
    this.initialStateBuilder = _emptyInitialStateBuilder,
    super.key,
  });

  @override
  State<SelectAttributeValue> createState() => _SelectAttributeValueState();
}

class _SelectAttributeValueState extends State<SelectAttributeValue> {
  late final AttributeStateStorage storage;
  late int maxSelected;

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

  @override
  Widget build(BuildContext context) {
    final list = widget.attribute.values();
    return ListView.builder(
      itemCount: list.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return widget.firstListItem ?? const SizedBox.shrink();
        }
        final attributeValue = list[i - 1];
        return selectWidget(context, attributeValue);
      }
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
              storage.clearAndSelect(v);
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
}
