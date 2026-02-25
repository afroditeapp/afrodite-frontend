import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/utils.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class AddAttributePage extends MyScreenPageLimited<Attribute> {
  final int nextId;
  final int nextOrderNumber;
  AddAttributePage(this.nextId, {required this.nextOrderNumber})
    : super(
        builder: (closer) =>
            AddAttributeScreen(closer, nextId: nextId, nextOrderNumber: nextOrderNumber),
      );
}

class AddAttributeScreen extends StatefulWidget {
  final PageCloser<Attribute> closer;
  final int nextId;
  final int nextOrderNumber;
  const AddAttributeScreen(
    this.closer, {
    required this.nextId,
    required this.nextOrderNumber,
    super.key,
  });

  @override
  State<AddAttributeScreen> createState() => _AddAttributeScreenState();
}

class _AddAttributeScreenState extends State<AddAttributeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _keyController = TextEditingController();

  AttributeMode _mode = AttributeMode.bitflag;
  String? _icon;

  Future<void> _completeAdding() async {
    if (_formKey.currentState?.validate() == true) {
      final trimmedName = _nameController.text.trim();
      final derivedKey = deriveKey(trimmedName);
      final newAttr = Attribute(
        id: widget.nextId,
        key: derivedKey,
        name: trimmedName,
        icon: _icon,
        mode: _mode,
        valueOrder: AttributeValueOrderMode.orderNumber,
        values: [],
        orderNumber: widget.nextOrderNumber,
        maxFilters: 1,
        maxSelected: 1,
        editable: true,
        visible: true,
        required_: false,
        translations: [],
      );
      widget.closer.close(context, newAttr);
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
          title: const Text("Add Attribute"),
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
          DropdownButtonFormField<AttributeMode>(
            initialValue: _mode,
            decoration: const InputDecoration(labelText: "Mode", border: OutlineInputBorder()),
            items: AttributeMode.values
                .map((e) => DropdownMenuItem(value: e, child: Text(e.value)))
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _mode = val);
            },
          ),
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
