import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openapi/api.dart';
import 'package:app/ui_utils/attribute/icon.dart';

String deriveKey(String name) {
  return name.trim().toLowerCase().replaceAll(' ', '_');
}

int nextAttributeValueId(AttributeMode mode, List<AttributeValue> values) {
  if (values.isEmpty) {
    return 1;
  }

  final maxId = values.map((e) => e.id).reduce((a, b) => a > b ? a : b);
  if (mode == AttributeMode.bitflag) {
    var nextBitflag = 1;
    while (nextBitflag <= maxId) {
      nextBitflag <<= 1;
    }
    return nextBitflag;
  }

  return maxId + 1;
}

int nextAttributeOrderNumber(List<Attribute> attributes) {
  if (attributes.isEmpty) {
    return 1;
  }

  final maxOrder = attributes.map((e) => e.orderNumber).reduce((a, b) => a > b ? a : b);
  return maxOrder + 1;
}

int nextAttributeValueOrderNumber(List<AttributeValue> values) {
  if (values.isEmpty) {
    return 1;
  }

  final maxOrder = values.map((e) => e.orderNumber).reduce((a, b) => a > b ? a : b);
  return maxOrder + 1;
}

void reorderAttributeValuesByOrderMode(List<AttributeValue> values, AttributeValueOrderMode order) {
  if (order == AttributeValueOrderMode.orderNumber) {
    values.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));
  } else if (order == AttributeValueOrderMode.alphabethicalKey) {
    values.sort((a, b) => a.key.compareTo(b.key));
  } else if (order == AttributeValueOrderMode.alphabethicalValue) {
    values.sort((a, b) => a.name.compareTo(b.name));
  }
}

class ReadOnlyTextField extends StatelessWidget {
  final String label;
  final String value;

  const ReadOnlyTextField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}

class IconSelector extends StatefulWidget {
  final String? initialIcon;
  final ValueChanged<String?> onChanged;
  final bool enabled;

  const IconSelector({super.key, this.initialIcon, required this.onChanged, this.enabled = true});

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  static final _materialIcons = AttributeIcons.materialIcons.keys.toList();
  static const _emptyPrefix = "empty:";
  static const _materialPrefix = "material:";
  static const _emojiPrefix = "emoji:";

  late String _prefix;
  String? _materialSelection;
  final TextEditingController _emojiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _parseInitialIcon();
  }

  void _parseInitialIcon() {
    final icon = widget.initialIcon;
    if (icon != null && icon.startsWith(_materialPrefix)) {
      _prefix = _materialPrefix;
      final val = icon.substring(_materialPrefix.length);
      if (_materialIcons.contains(val)) {
        _materialSelection = val;
      } else {
        _materialSelection = _materialIcons.first;
      }
    } else if (icon != null && icon.startsWith(_emojiPrefix)) {
      _prefix = _emojiPrefix;
      _emojiController.text = icon.substring(_emojiPrefix.length);
    } else {
      _prefix = _emptyPrefix;
    }
  }

  void _updateIcon() {
    if (_prefix == _emptyPrefix) {
      widget.onChanged(null);
    } else if (_prefix == _materialPrefix) {
      if (_materialSelection != null) {
        widget.onChanged("$_materialPrefix$_materialSelection");
      } else {
        widget.onChanged(null);
      }
    } else if (_prefix == _emojiPrefix) {
      final emoji = _emojiController.text;
      if (emoji.isNotEmpty) {
        widget.onChanged("$_emojiPrefix$emoji");
      } else {
        widget.onChanged(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: _prefix,
          items: const [
            DropdownMenuItem(value: _emptyPrefix, child: Text("Empty")),
            DropdownMenuItem(value: _materialPrefix, child: Text("Material")),
            DropdownMenuItem(value: _emojiPrefix, child: Text("Emoji")),
          ],
          onChanged: widget.enabled
              ? (val) {
                  if (val != null) {
                    setState(() {
                      _prefix = val;
                      if (_prefix == _materialPrefix && _materialSelection == null) {
                        _materialSelection = _materialIcons.first;
                      }
                      _updateIcon();
                    });
                  }
                }
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _prefix == _materialPrefix
              ? DropdownButton<String>(
                  value: _materialSelection,
                  isExpanded: true,
                  items: _materialIcons.map((e) {
                    final iconData = AttributeIcons.materialIcons[e];
                    return DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          if (iconData != null) Icon(iconData),
                          if (iconData != null) const SizedBox(width: 8),
                          Text(e),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: widget.enabled
                      ? (val) {
                          if (val != null) {
                            setState(() {
                              _materialSelection = val;
                              _updateIcon();
                            });
                          }
                        }
                      : null,
                )
              : _prefix == _emojiPrefix
              ? TextFormField(
                  controller: _emojiController,
                  enabled: widget.enabled,
                  decoration: const InputDecoration(
                    labelText: "Emoji",
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 1,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  onChanged: (_) => _updateIcon(),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emojiController.dispose();
    super.dispose();
  }
}

class TranslationSummary extends StatelessWidget {
  final String translationKey;
  final List<Language> translations;
  final bool multilineValues;

  const TranslationSummary({
    super.key,
    required this.translationKey,
    required this.translations,
    this.multilineValues = false,
  });

  @override
  Widget build(BuildContext context) {
    final translatedValues = <MapEntry<String, String>>[];
    for (final lang in translations) {
      for (final translation in lang.values) {
        if (translation.key == translationKey && translation.name.isNotEmpty) {
          translatedValues.add(MapEntry(lang.lang, translation.name));
          break;
        }
      }
    }

    if (translatedValues.isEmpty) {
      return const SizedBox.shrink();
    }

    final summaryText = multilineValues
        ? translatedValues.map((entry) => "${entry.key}: ${entry.value}").join('\n')
        : "Translations: ${translatedValues.map((entry) => entry.key).join(', ')}";

    return Text(summaryText, style: Theme.of(context).textTheme.bodySmall);
  }
}

bool canEditVisibleContent(Permissions permissions) {
  return permissions.adminEditProfileAttributesSchemaVisibleContent;
}
