


import 'package:flutter/material.dart';

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
    Key? key,
  }) : super(key: key);

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
        decoration: InputDecoration(
          icon: null,
          hintText: widget.hintText,
        ),
        onChanged: (newValue) {
          widget.onChanged(newValue);
        },
      ),
    );
  }
}
