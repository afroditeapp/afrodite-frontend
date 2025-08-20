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
  final controller = TextEditingController();

  final String hintText;
  final bool obscureText;
  final String Function() getInitialValue;
  final void Function(String) onChanged;

  SimpleTextField({
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
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.getInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: widget.controller,
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
  final TextEditingController? controller;

  /// Called only once when the widget is initialized.
  final String Function() getInitialValue;
  final void Function(String) onChanged;

  const AgeTextField({
    this.getInitialValue = _defaultInitialValue,
    this.onChanged = _defaultOnChanged,
    this.controller,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AgeTextFieldState();
}

class _AgeTextFieldState extends State<AgeTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    final providedController = widget.controller;
    if (providedController == null) {
      controller = TextEditingController();
    } else {
      controller = providedController;
    }

    controller.text = widget.getInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
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
