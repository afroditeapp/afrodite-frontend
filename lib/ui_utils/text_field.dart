import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/localizations.dart';

String _defaultInitialValue() {
  return "";
}

void _defaultOnChanged(String value) {
  return;
}

class SimpleTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final String Function() getInitialValue;
  final void Function(String) onChanged;

  const SimpleTextField({
    this.hintText = "",
    this.obscureText = false,
    this.getInitialValue = _defaultInitialValue,
    this.onChanged = _defaultOnChanged,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  late final String initialValue;

  @override
  void initState() {
    super.initState();
    initialValue = widget.getInitialValue();
    widget.onChanged(initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        initialValue: initialValue,
        obscureText: widget.obscureText,
        decoration: InputDecoration(icon: null, hintText: widget.hintText),
        onChanged: (newValue) {
          widget.onChanged(newValue);
        },
      ),
    );
  }
}

class AgeTextField extends StatefulWidget {
  /// Called only once when the widget is initialized.
  final String Function() getInitialValue;
  final void Function(String) onChanged;

  const AgeTextField({
    this.getInitialValue = _defaultInitialValue,
    this.onChanged = _defaultOnChanged,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AgeTextFieldState();
}

class _AgeTextFieldState extends State<AgeTextField> {
  late final String initialValue;

  @override
  void initState() {
    super.initState();
    initialValue = widget.getInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(hintText: context.strings.generic_text_field_age_hint_text),
        keyboardType: TextInputType.number,
        enableSuggestions: false,
        autocorrect: false,
        maxLength: 2,
        onChanged: (newValue) {
          widget.onChanged(newValue);
        },
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
      ),
    );
  }
}
