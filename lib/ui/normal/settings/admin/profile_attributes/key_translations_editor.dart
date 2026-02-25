import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/utils.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class KeyTranslationsEditorPage extends MyScreenPageLimited<List<Language>> {
  final String translationKey;
  final List<Language> translations;
  final Permissions permissions;

  KeyTranslationsEditorPage(this.translationKey, this.translations, this.permissions)
    : super(
        builder: (closer) =>
            KeyTranslationsEditorScreen(translationKey, translations, permissions, closer),
      );
}

class KeyTranslationsEditorScreen extends StatefulWidget {
  final String translationKey;
  final List<Language> translations;
  final Permissions permissions;
  final PageCloser<List<Language>> closer;

  const KeyTranslationsEditorScreen(
    this.translationKey,
    this.translations,
    this.permissions,
    this.closer, {
    super.key,
  });

  @override
  State<KeyTranslationsEditorScreen> createState() => _KeyTranslationsEditorScreenState();
}

class _KeyTranslationsEditorScreenState extends State<KeyTranslationsEditorScreen> {
  late List<Language> _translations;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Deep copy translations to avoid modifying the original list directly
    _translations = widget.translations.map((l) {
      return Language(
        lang: l.lang,
        values: List.from(l.values.map((t) => Translation(key: t.key, name: t.name))),
      );
    }).toList();
  }

  void _addLanguage() {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Language"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "2-letter code (e.g., en, fi)"),
            maxLength: 2,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                final code = controller.text.trim().toLowerCase();
                if (code.length == 2 && !_translations.any((l) => l.lang == code)) {
                  setState(() {
                    _translations.add(Language(lang: code, values: []));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final canEditContent = canEditVisibleContent(widget.permissions);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_formKey.currentState?.validate() == true) {
          widget.closer.close(context, _translations);
        } else {
          showSnackBar("Please fix the errors in the form before saving.");
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Translations for ${widget.translationKey}")),
        body: _body(context, canEditContent),
      ),
    );
  }

  Widget _body(BuildContext context, bool canEditContent) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton.icon(
            onPressed: _addLanguage,
            icon: const Icon(Icons.add),
            label: const Text("Add Language"),
          ),
          const SizedBox(height: 16),
          ..._translations.map((lang) {
            final existingTranslationIndex = lang.values.indexWhere(
              (t) => t.key == widget.translationKey,
            );
            final existingTranslation = existingTranslationIndex != -1
                ? lang.values[existingTranslationIndex]
                : null;

            // If translation exists, it's protected by visible_content permission.
            // If it doesn't exist, anyone can add it.
            final isEditable = existingTranslation == null || canEditContent;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                initialValue: existingTranslation?.name ?? "",
                decoration: InputDecoration(
                  labelText: "Language: ${lang.lang}",
                  border: isEditable
                      ? const OutlineInputBorder()
                      : const OutlineInputBorder(borderSide: BorderSide.none),
                ),
                enabled: isEditable,
                onChanged: (val) {
                  setState(() {
                    if (existingTranslationIndex != -1) {
                      lang.values[existingTranslationIndex].name = val;
                    } else {
                      lang.values.add(Translation(key: widget.translationKey, name: val));
                    }
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
