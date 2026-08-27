import 'package:app/localizations.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:flutter/material.dart';

class AttributeInfoBox extends StatelessWidget {
  final UiAttribute attribute;
  const AttributeInfoBox({required this.attribute, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final apiAttribute = attribute.apiAttribute();
    final String? text;
    if (!apiAttribute.editable) {
      text = context.strings.attribute_deprecated_info(attribute.uiName());
    } else if (!apiAttribute.visible) {
      text = context.strings.attribute_partially_hidden_info(attribute.uiName());
    } else {
      text = null;
    }
    if (text == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.info, color: colorScheme.onPrimaryContainer),
              const Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimaryContainer),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
