import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/add_value.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/key_translations_editor.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/utils.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/value_editor.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class AttributeEditorPage extends MyScreenPageLimited<Attribute> {
  final Attribute attribute;
  final Permissions permissions;
  AttributeEditorPage(this.attribute, this.permissions)
    : super(builder: (closer) => AttributeEditorScreen(attribute, permissions, closer));
}

class AttributeEditorScreen extends StatefulWidget {
  final Attribute attribute;
  final Permissions permissions;
  final PageCloser<Attribute> closer;

  const AttributeEditorScreen(this.attribute, this.permissions, this.closer, {super.key});

  @override
  State<AttributeEditorScreen> createState() => _AttributeEditorScreenState();
}

class _AttributeEditorScreenState extends State<AttributeEditorScreen> {
  late Attribute _attr;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _attr = widget.attribute;
    _nameController = TextEditingController(text: _attr.name);
  }

  @override
  Widget build(BuildContext context) {
    final canEditContent = canEditVisibleContent(widget.permissions);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_formKey.currentState?.validate() != true) {
          showSnackBar("Please fix the errors in the form before saving.");
          return;
        }
        if (!_validateOrderNumbers()) {
          return;
        }
        widget.closer.close(context, _attr);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit Attribute")),
        body: _body(context, canEditContent),
      ),
    );
  }

  bool _validateOrderNumbers() {
    final seen = <int>{};
    for (final value in _attr.values) {
      if (!seen.add(value.orderNumber)) {
        showSnackBar("Duplicate value order numbers are not allowed.");
        return false;
      }
    }
    return true;
  }

  void _onReorderValues(List<AttributeValue> currentOrder, int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final reordered = [...currentOrder];
      final item = reordered.removeAt(oldIndex);
      reordered.insert(newIndex, item);
      _attr.values = [for (var i = 0; i < reordered.length; i++) reordered[i]..orderNumber = i + 1];
    });
  }

  Future<void> _editValue(AttributeValue val) async {
    final updatedValue = await MyNavigator.pushLimited(
      context,
      ValueEditorPage(val, _attr, widget.permissions),
    );
    if (updatedValue != null) {
      setState(() {
        final index = _attr.values.indexWhere((v) => v.id == val.id && v.key == val.key);
        if (index != -1) {
          _attr.values[index] = updatedValue.value;
          _attr.translations = updatedValue.translations;
        }
      });
    }
  }

  Widget _buildValueListItem(AttributeValue val, {int? dragIndex}) {
    final trailing = dragIndex == null
        ? const Icon(Icons.chevron_right)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.chevron_right),
              const SizedBox(width: 8),
              ReorderableDragStartListener(index: dragIndex, child: const Icon(Icons.drag_handle)),
            ],
          );

    return ListTile(
      key: dragIndex == null ? null : ValueKey("${val.id}-${val.key}"),
      title: Text("${val.name} (${val.key})"),
      subtitle: TranslationSummary(
        translationKey: val.key,
        translations: _attr.translations,
        multilineValues: true,
      ),
      trailing: trailing,
      onTap: () => _editValue(val),
    );
  }

  Widget _body(BuildContext context, bool canEditContent) {
    final hideAddValueButton = _attr.mode.value == 'bitflag' && _attr.values.length >= 16;
    final orderedValuesForDisplay = [..._attr.values];
    reorderAttributeValuesByOrderMode(orderedValuesForDisplay, _attr.valueOrder);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ReadOnlyTextField(label: "Key", value: _attr.key),
          const SizedBox(height: 16),
          ReadOnlyTextField(label: "Mode", value: _attr.mode.value),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: canEditContent
                        ? const OutlineInputBorder()
                        : const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  enabled: canEditContent,
                  onChanged: (val) => setState(() => _attr.name = val),
                  validator: (val) => val == null || val.isEmpty ? "Required" : null,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.translate),
                onPressed: () async {
                  final newTranslations = await MyNavigator.pushLimited(
                    context,
                    KeyTranslationsEditorPage(_attr.key, _attr.translations, widget.permissions),
                  );
                  if (newTranslations != null) {
                    setState(() => _attr.translations = newTranslations);
                  }
                },
              ),
            ],
          ),
          if (_attr.translations.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: TranslationSummary(
                translationKey: _attr.key,
                translations: _attr.translations,
                multilineValues: true,
              ),
            ),
          const SizedBox(height: 16),
          const Text("Icon"),
          const SizedBox(height: 8),
          IconSelector(
            initialIcon: _attr.icon,
            enabled: canEditContent,
            onChanged: (val) => setState(() => _attr.icon = val),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<AttributeValueOrderMode>(
            initialValue: _attr.valueOrder,
            decoration: const InputDecoration(
              labelText: "Value Order",
              border: OutlineInputBorder(),
            ),
            items: AttributeValueOrderMode.values
                .map((e) => DropdownMenuItem(value: e, child: Text(e.value)))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _attr.valueOrder = val;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text("Required"),
            value: _attr.required_,
            onChanged: (val) => setState(() => _attr.required_ = val),
          ),
          SwitchListTile(
            title: const Text("Visible"),
            value: _attr.visible,
            onChanged: (val) => setState(() => _attr.visible = val),
          ),
          SwitchListTile(
            title: const Text("Editable"),
            value: _attr.editable,
            onChanged: (val) => setState(() => _attr.editable = val),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: _attr.maxFilters.toString(),
            decoration: const InputDecoration(
              labelText: "Max Filters",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) => setState(() => _attr.maxFilters = int.tryParse(val) ?? 1),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: _attr.maxSelected.toString(),
            decoration: const InputDecoration(
              labelText: "Max Selected",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) => setState(() => _attr.maxSelected = int.tryParse(val) ?? 1),
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Values", style: Theme.of(context).textTheme.titleLarge),
              if (!hideAddValueButton)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    final nextId = nextAttributeValueId(_attr.mode, _attr.values);
                    final nextOrderNumber = nextAttributeValueOrderNumber(_attr.values);
                    final newValue = await MyNavigator.pushLimited(
                      context,
                      AddValuePage(nextId, nextOrderNumber: nextOrderNumber),
                    );
                    if (newValue != null) {
                      setState(() {
                        _attr.values = [..._attr.values, newValue];
                      });
                    }
                  },
                ),
            ],
          ),
          if (_attr.valueOrder == AttributeValueOrderMode.orderNumber && canEditContent)
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: orderedValuesForDisplay.length,
              onReorder: (oldIndex, newIndex) =>
                  _onReorderValues(orderedValuesForDisplay, oldIndex, newIndex),
              itemBuilder: (context, index) {
                final val = orderedValuesForDisplay[index];
                return _buildValueListItem(val, dragIndex: index);
              },
            )
          else
            ...orderedValuesForDisplay.map((val) {
              return _buildValueListItem(val);
            }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
