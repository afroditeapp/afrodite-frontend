import 'package:app/localizations.dart';
import 'package:flutter/material.dart';

class AttributeInfoBox extends StatelessWidget {
  final String attributeName;
  const AttributeInfoBox({required this.attributeName, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                  context.strings.attribute_partially_hidden_info(attributeName),
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
