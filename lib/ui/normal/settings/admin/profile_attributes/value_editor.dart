import 'dart:math';

import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/add_value.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/key_translations_editor.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/utils.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class ValueEditorResult {
  final AttributeValue value;
  final List<Language> translations;
  ValueEditorResult(this.value, this.translations);
}

class ValueEditorPage extends MyScreenPageLimited<ValueEditorResult> {
  final AttributeValue value;
  final Attribute attribute;
  final Permissions permissions;
  ValueEditorPage(this.value, this.attribute, this.permissions)
    : super(builder: (closer) => ValueEditorScreen(value, attribute, permissions, closer));
}

class ValueEditorScreen extends StatefulWidget {
  final AttributeValue value;
  final Attribute attribute;
  final Permissions permissions;
  final PageCloser<ValueEditorResult> closer;

  const ValueEditorScreen(this.value, this.attribute, this.permissions, this.closer, {super.key});

  @override
  State<ValueEditorScreen> createState() => _ValueEditorScreenState();
}

class _ValueEditorScreenState extends State<ValueEditorScreen> {
  late AttributeValue _val;
  late List<Language> _translations;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _val = widget.value;
    _translations = List.from(widget.attribute.translations);
    _nameController = TextEditingController(text: _val.name);
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
        widget.closer.close(context, ValueEditorResult(_val, _translations));
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit Value")),
        body: _body(context, canEditContent),
      ),
    );
  }

  bool _validateOrderNumbers() {
    final seen = <int>{};
    for (final groupValue in _val.groupValues) {
      if (!seen.add(groupValue.orderNumber)) {
        showSnackBar("Duplicate group value order numbers are not allowed.");
        return false;
      }
    }
    return true;
  }

  void _onReorderGroupValues(List<AttributeValue> currentOrder, int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final reordered = [...currentOrder];
      final item = reordered.removeAt(oldIndex);
      reordered.insert(newIndex, item);
      _val.groupValues = [
        for (var i = 0; i < reordered.length; i++) reordered[i]..orderNumber = i + 1,
      ];
    });
  }

  Future<void> _editGroupValue(AttributeValue groupVal) async {
    final tempAttr = Attribute(
      id: widget.attribute.id,
      key: widget.attribute.key,
      mode: widget.attribute.mode,
      name: widget.attribute.name,
      orderNumber: widget.attribute.orderNumber,
      valueOrder: widget.attribute.valueOrder,
      translations: _translations,
    );
    final updatedValue = await MyNavigator.pushLimited(
      context,
      ValueEditorPage(groupVal, tempAttr, widget.permissions),
    );
    if (updatedValue != null) {
      setState(() {
        final index = _val.groupValues.indexWhere(
          (v) => v.id == groupVal.id && v.key == groupVal.key,
        );
        if (index != -1) {
          _val.groupValues[index] = updatedValue.value;
          _translations = updatedValue.translations;
        }
      });
    }
  }

  Widget _buildGroupValueListItem(AttributeValue groupVal, {int? dragIndex}) {
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
      key: dragIndex == null ? null : ValueKey("${groupVal.id}-${groupVal.key}"),
      title: Text("${groupVal.name} (${groupVal.key})"),
      subtitle: TranslationSummary(
        translationKey: groupVal.key,
        translations: _translations,
        multilineValues: true,
      ),
      trailing: trailing,
      onTap: () => _editGroupValue(groupVal),
    );
  }

  Widget _body(BuildContext context, bool canEditContent) {
    final orderedGroupValuesForDisplay = [..._val.groupValues];
    reorderAttributeValuesByOrderMode(orderedGroupValuesForDisplay, widget.attribute.valueOrder);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ReadOnlyTextField(label: "Key", value: _val.key),
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
                  onChanged: (val) => setState(() => _val.name = val),
                  validator: (val) => val == null || val.isEmpty ? "Required" : null,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.translate),
                onPressed: () async {
                  final newTranslations = await MyNavigator.pushLimited(
                    context,
                    KeyTranslationsEditorPage(_val.key, _translations, widget.permissions),
                  );
                  if (newTranslations != null) {
                    setState(() => _translations = newTranslations);
                  }
                },
              ),
            ],
          ),
          if (_translations.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: TranslationSummary(
                translationKey: _val.key,
                translations: _translations,
                multilineValues: true,
              ),
            ),
          const SizedBox(height: 16),
          const Text("Icon"),
          const SizedBox(height: 8),
          IconSelector(
            initialIcon: _val.icon,
            enabled: canEditContent,
            onChanged: (val) => setState(() => _val.icon = val),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text("Visible"),
            value: _val.visible,
            onChanged: (val) => setState(() => _val.visible = val),
          ),
          SwitchListTile(
            title: const Text("Editable"),
            value: _val.editable,
            onChanged: (val) => setState(() => _val.editable = val),
          ),
          if (widget.attribute.mode == AttributeMode.twoLevel) ...[
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Group Values", style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    final nextId = _val.groupValues.isEmpty
                        ? 1
                        : _val.groupValues.map((e) => e.id).reduce(max) + 1;
                    final nextOrderNumber = nextAttributeValueOrderNumber(_val.groupValues);
                    final newValue = await MyNavigator.pushLimited(
                      context,
                      AddValuePage(nextId, nextOrderNumber: nextOrderNumber),
                    );
                    if (newValue != null) {
                      setState(() {
                        _val.groupValues = [..._val.groupValues, newValue];
                      });
                    }
                  },
                ),
              ],
            ),
            if (widget.attribute.valueOrder == AttributeValueOrderMode.orderNumber &&
                canEditContent)
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                itemCount: orderedGroupValuesForDisplay.length,
                onReorder: (oldIndex, newIndex) =>
                    _onReorderGroupValues(orderedGroupValuesForDisplay, oldIndex, newIndex),
                itemBuilder: (context, index) {
                  final groupVal = orderedGroupValuesForDisplay[index];
                  return _buildGroupValueListItem(groupVal, dragIndex: index);
                },
              )
            else
              ...orderedGroupValuesForDisplay.map((groupVal) {
                return _buildGroupValueListItem(groupVal);
              }),
          ],
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
