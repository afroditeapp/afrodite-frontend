


import 'dart:math';

import 'package:flutter/material.dart';

class AgeDropdown extends StatefulWidget {
  /// Called only once when the widget is initialized.
  final int Function() getInitialValue;
  /// Called only once when the widget is initialized.
  final int Function() getMinValue;
  /// Called only once when the widget is initialized.
  final int Function() getMaxValue;
  final void Function(int) onChanged;

  final bool enabled;

  const AgeDropdown({
    required this.getInitialValue,
    required this.getMinValue,
    required this.getMaxValue,
    required this.onChanged,
    this.enabled = true,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AgeDropdownState();
}

class _AgeDropdownState extends State<AgeDropdown> {
  late final List<int> availableValues;
  late final int initialSelection;

  @override
  void initState() {
    super.initState();

    final minValue = widget.getMinValue();
    final maxValue = widget.getMaxValue();

    availableValues = List.generate(
      max(0, maxValue - minValue + 1),
      (index) => minValue + index,
    );

    initialSelection = widget.getInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<int>(
      initialSelection: initialSelection,
      enabled: widget.enabled,
      dropdownMenuEntries: availableValues
        .map((value) {
          return DropdownMenuEntry<int>(
            value: value,
            label: value.toString(),
          );
        })
        .toList(),
      onSelected: (value) {
        if (value != null) {
          widget.onChanged(value);
        }
      },
    );
  }
}
