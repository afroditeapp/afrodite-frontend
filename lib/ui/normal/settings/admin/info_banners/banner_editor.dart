import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/profile_attributes/utils.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditInfoBannerPage extends MyScreenPageLimited<(String, InfoBanner)> {
  final String bannerKey;
  final InfoBanner banner;
  EditInfoBannerPage(this.bannerKey, this.banner)
    : super(
        builder: (closer) => InfoBannerEditorScreen(closer, bannerKey: bannerKey, banner: banner),
      );
}

class InfoBannerEditorScreen extends StatefulWidget {
  final PageCloser<(String, InfoBanner)> closer;
  final String bannerKey;
  final InfoBanner banner;

  const InfoBannerEditorScreen(
    this.closer, {
    required this.bannerKey,
    required this.banner,
    super.key,
  });

  @override
  State<InfoBannerEditorScreen> createState() => _InfoBannerEditorScreenState();
}

class _InfoBannerEditorScreenState extends State<InfoBannerEditorScreen> {
  final _formKey = GlobalKey<FormState>();

  late final InfoBanner _banner;
  late final TextInfoBanner _textBanner;

  @override
  void initState() {
    super.initState();

    _banner = widget.banner;
    _banner.mode = InfoBannerMode.text;

    _textBanner =
        _banner.text ??
        TextInfoBanner(
          body: StringResource(default_: "", translations: {}),
        );
    _banner.text = _textBanner;
  }

  Future<void> _validateAndClose() async {
    if (_formKey.currentState?.validate() != true) {
      showSnackBar("Please fix the errors in the form before saving.");
      return;
    }

    widget.closer.close(context, (widget.bannerKey, _banner));
  }

  Widget _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ReadOnlyTextField(label: "Key", value: widget.bannerKey),
          const SizedBox(height: 16),
          const ReadOnlyTextField(label: "Mode", value: "Text"),
          const SizedBox(height: 16),
          TextInfoBannerEditor(textBanner: _textBanner),
          const Divider(height: 32),
          Text("Platforms", style: Theme.of(context).textTheme.titleMedium),
          SwitchListTile(
            title: const Text("Android"),
            value: _banner.platform.android,
            onChanged: (value) => setState(() => _banner.platform.android = value),
          ),
          SwitchListTile(
            title: const Text("iOS"),
            value: _banner.platform.ios,
            onChanged: (value) => setState(() => _banner.platform.ios = value),
          ),
          SwitchListTile(
            title: const Text("Web"),
            value: _banner.platform.web,
            onChanged: (value) => setState(() => _banner.platform.web = value),
          ),
          const Divider(height: 32),
          Text("Visibility", style: Theme.of(context).textTheme.titleMedium),
          SwitchListTile(
            title: const Text("Profiles"),
            value: _banner.visibility.profiles,
            onChanged: (value) => setState(() => _banner.visibility.profiles = value),
          ),
          SwitchListTile(
            title: const Text("Likes"),
            value: _banner.visibility.likes,
            onChanged: (value) => setState(() => _banner.visibility.likes = value),
          ),
          SwitchListTile(
            title: const Text("Chats"),
            value: _banner.visibility.chats,
            onChanged: (value) => setState(() => _banner.visibility.chats = value),
          ),
          SwitchListTile(
            title: const Text("Menu"),
            value: _banner.visibility.menu,
            onChanged: (value) => setState(() => _banner.visibility.menu = value),
          ),
          SwitchListTile(
            title: const Text("Conversation"),
            value: _banner.visibility.conversation,
            onChanged: (value) => setState(() => _banner.visibility.conversation = value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          return;
        }
        await _validateAndClose();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit info banner")),
        body: _body(context),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TextInfoBannerEditor extends StatefulWidget {
  final TextInfoBanner textBanner;

  const TextInfoBannerEditor({required this.textBanner, super.key});

  @override
  State<TextInfoBannerEditor> createState() => _TextInfoBannerEditorState();
}

class _TextInfoBannerEditorState extends State<TextInfoBannerEditor> {
  late final TextEditingController _bodyController;
  late final TextEditingController _buttonTextController;
  late final TextEditingController _buttonUrlController;

  bool _hasUrlButton = false;
  late Map<String, String> _bodyTranslations;
  late Map<String, String> _buttonTranslations;

  TextInfoBanner get _textBanner => widget.textBanner;

  @override
  void initState() {
    super.initState();

    final initialButton = _textBanner.urlButton;

    _bodyController = TextEditingController(text: _textBanner.body.default_);
    _buttonTextController = TextEditingController(text: initialButton?.text.default_ ?? "");
    _buttonUrlController = TextEditingController(text: initialButton?.url ?? "");

    _hasUrlButton = initialButton != null;
    _bodyTranslations = _normalizeTranslationMapKeys(_textBanner.body.translations);
    _buttonTranslations = _normalizeTranslationMapKeys(
      initialButton?.text.translations ?? const {},
    );

    _syncBodyTranslations();
    _syncButtonTranslations();
  }

  @override
  void dispose() {
    _bodyController.dispose();
    _buttonTextController.dispose();
    _buttonUrlController.dispose();
    super.dispose();
  }

  Map<String, String> _normalizeTranslationMapKeys(Map<String, String> source) {
    final normalized = <String, String>{};
    for (final entry in source.entries) {
      final locale = entry.key.trim().toLowerCase();
      if (locale.isEmpty) {
        continue;
      }
      normalized[locale] = entry.value;
    }
    return normalized;
  }

  void _syncBodyTranslations() {
    _textBanner.body.translations = _normalizeTranslationMapKeys(_bodyTranslations);
  }

  void _syncButtonTranslations() {
    final urlButton = _textBanner.urlButton;
    if (urlButton == null) {
      return;
    }
    urlButton.text.translations = _normalizeTranslationMapKeys(_buttonTranslations);
  }

  InfoBannerUrlButton _ensureUrlButton() {
    final existing = _textBanner.urlButton;
    if (existing != null) {
      return existing;
    }

    final created = InfoBannerUrlButton(
      text: StringResource(default_: _buttonTextController.text, translations: {}),
      url: _buttonUrlController.text,
    );
    _textBanner.urlButton = created;
    _syncButtonTranslations();
    return created;
  }

  void _setHasUrlButton(bool value) {
    _hasUrlButton = value;
    if (value) {
      _ensureUrlButton();
      return;
    }
    _textBanner.urlButton = null;
  }

  Future<void> _addTranslation(Map<String, String> target, String title) async {
    final localeController = TextEditingController();
    final valueController = TextEditingController();

    final shouldAdd = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add $title translation"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: localeController,
                decoration: const InputDecoration(
                  labelText: "2-letter code (e.g., en, fi)",
                  border: OutlineInputBorder(),
                ),
                maxLength: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: valueController,
                decoration: const InputDecoration(labelText: "Text", border: OutlineInputBorder()),
                minLines: 1,
                maxLines: 4,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Add")),
          ],
          scrollable: true,
        );
      },
    );

    if (shouldAdd != true) {
      return;
    }

    final locale = localeController.text.trim().toLowerCase();
    final value = valueController.text.trim();

    if (locale.isEmpty) {
      showSnackBar("Locale is required.");
      return;
    }
    if (target.containsKey(locale)) {
      showSnackBar("Locale already exists.");
      return;
    }

    setState(() {
      target[locale] = value;
      if (identical(target, _bodyTranslations)) {
        _syncBodyTranslations();
      } else {
        _syncButtonTranslations();
      }
    });
  }

  Widget _translationEditor({required String title, required Map<String, String> target}) {
    final entries = target.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            TextButton.icon(
              onPressed: () => _addTranslation(target, title),
              icon: const Icon(Icons.add),
              label: const Text("Add"),
            ),
          ],
        ),
        if (entries.isEmpty)
          Text("No translations", style: Theme.of(context).textTheme.bodySmall)
        else
          ...entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 56, child: Text(entry.key.toLowerCase())),
                  Expanded(
                    child: TextFormField(
                      initialValue: entry.value,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      minLines: 1,
                      maxLines: 3,
                      onChanged: (value) {
                        target[entry.key] = value;
                        if (identical(target, _bodyTranslations)) {
                          _syncBodyTranslations();
                        } else {
                          _syncButtonTranslations();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        target.remove(entry.key);
                        if (identical(target, _bodyTranslations)) {
                          _syncBodyTranslations();
                        } else {
                          _syncButtonTranslations();
                        }
                      });
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _bodyController,
          decoration: const InputDecoration(
            labelText: "Body (default)",
            border: OutlineInputBorder(),
          ),
          minLines: 2,
          maxLines: 5,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Required";
            }
            return null;
          },
          onChanged: (value) {
            _textBanner.body.default_ = value;
          },
        ),
        const SizedBox(height: 12),
        _translationEditor(title: "Body translations", target: _bodyTranslations),
        const SizedBox(height: 16),
        const Text("Icon"),
        const SizedBox(height: 8),
        IconSelector(
          initialIcon: _textBanner.icon,
          onChanged: (value) => setState(() => _textBanner.icon = value),
        ),
        const Divider(height: 32),
        SwitchListTile(
          title: const Text("Dismissible"),
          value: _textBanner.dismissible,
          onChanged: (value) => setState(() => _textBanner.dismissible = value),
        ),
        SwitchListTile(
          title: const Text("Enable URL button"),
          value: _hasUrlButton,
          onChanged: (value) => setState(() => _setHasUrlButton(value)),
        ),
        if (_hasUrlButton) ...[
          const SizedBox(height: 8),
          TextFormField(
            controller: _buttonTextController,
            decoration: const InputDecoration(
              labelText: "Button text (default)",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (!_hasUrlButton) {
                return null;
              }
              if (value == null || value.trim().isEmpty) {
                return "Required";
              }
              return null;
            },
            onChanged: (value) {
              if (!_hasUrlButton) {
                return;
              }
              _ensureUrlButton().text.default_ = value;
            },
          ),
          const SizedBox(height: 12),
          _translationEditor(title: "Button translations", target: _buttonTranslations),
          const SizedBox(height: 12),
          TextFormField(
            controller: _buttonUrlController,
            decoration: const InputDecoration(
              labelText: "Button URL",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (!_hasUrlButton) {
                return null;
              }
              final url = value?.trim() ?? "";
              if (url.isEmpty) {
                return "Required";
              }
              final parsed = Uri.tryParse(url);
              if (parsed == null || !parsed.hasScheme) {
                return "Invalid URL";
              }
              return null;
            },
            onChanged: (value) {
              if (!_hasUrlButton) {
                return;
              }
              _ensureUrlButton().url = value;
            },
          ),
        ],
      ],
    );
  }
}
