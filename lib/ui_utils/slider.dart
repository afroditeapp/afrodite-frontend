import 'package:flutter/material.dart';

/// Extra padding is for reducing unwanted slider
/// value changes when gesture back navigation happens.
class SliderWithPadding extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Color thumbColor;
  final Color? activeColor;
  final void Function(double) onChanged;
  const SliderWithPadding({
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.thumbColor,
    required this.activeColor,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        thumbColor: thumbColor,
        activeColor: activeColor,
        onChanged: onChanged,
      ),
    );
  }
}

/// Extra padding is for reducing unwanted slider
/// value changes when gesture back navigation happens.
class RangeSliderWithPadding extends StatelessWidget {
  final RangeValues values;
  final double min;
  final double max;
  final int? divisions;
  final void Function(RangeValues) onChanged;
  const RangeSliderWithPadding({
    required this.values,
    required this.min,
    required this.max,
    this.divisions,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
      child: RangeSlider(
        values: values,
        min: min,
        max: max,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}
