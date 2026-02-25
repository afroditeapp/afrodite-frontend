import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/utils.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class AddValuePage extends MyScreenPageLimited<AttributeValue> {
  final int nextId;
  final int nextOrderNumber;
  AddValuePage(this.nextId, {required this.nextOrderNumber})
    : super(
        builder: (closer) =>
            AddValueScreen(closer, nextId: nextId, nextOrderNumber: nextOrderNumber),
      );
}

class AddValueScreen extends StatefulWidget {
  final PageCloser<AttributeValue> closer;
  final int nextId;
  final int nextOrderNumber;
  const AddValueScreen(
    this.closer, {
    required this.nextId,
    required this.nextOrderNumber,
    super.key,
  });

  @override
  State<AddValueScreen> createState() => _AddValueScreenState();
}

class _AddValueScreenState extends State<AddValueScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _keyController = TextEditingController();

  String? _icon;

  Future<void> _completeAdding() async {
    if (_formKey.currentState?.validate() == true) {
      final trimmedName = _nameController.text.trim();
      final derivedKey = deriveKey(trimmedName);
      final newVal = AttributeValue(
        id: widget.nextId,
        key: derivedKey,
        name: trimmedName,
        icon: _icon,
        orderNumber: widget.nextOrderNumber,
        groupValues: [],
        editable: true,
        visible: true,
      );
      widget.closer.close(context, newVal);
    } else {
      showSnackBar("Please fix the errors in the form before saving.");
    }
  }

  Future<void> _confirmCancel() async {
    final confirmed = await showConfirmDialog(context, "Cancel?");
    if (confirmed == true && mounted) {
      MyNavigator.removePage(context, widget.closer.key, null);
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _keyController.text = deriveKey(_nameController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        await _confirmCancel();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Value"),
          actions: [IconButton(onPressed: _completeAdding, icon: const Icon(Icons.check))],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
            validator: (val) => val == null || val.trim().isEmpty ? "Required" : null,
          ),
          const SizedBox(height: 16),
          ReadOnlyTextField(label: "Key (Auto-derived)", value: _keyController.text),
          const SizedBox(height: 16),
          const Text("Icon"),
          const SizedBox(height: 8),
          IconSelector(initialIcon: _icon, onChanged: (val) => setState(() => _icon = val)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _keyController.dispose();
    super.dispose();
  }
}
