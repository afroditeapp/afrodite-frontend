import 'package:app/api/server_connection_manager.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class CustomEmailEditorPage extends MyScreenPageLimited<()> {
  CustomEmailEditorPage(ApiManager api, CustomEmail email)
    : super(builder: (closer) => CustomEmailEditorScreen(api, email, closer: closer));
}

class CustomEmailEditorScreen extends StatefulWidget {
  final ApiManager api;
  final CustomEmail email;
  final PageCloser<()> closer;

  const CustomEmailEditorScreen(this.api, this.email, {required this.closer, super.key});

  @override
  State<CustomEmailEditorScreen> createState() => _CustomEmailEditorScreenState();
}

class _CustomEmailEditorScreenState extends State<CustomEmailEditorScreen> {
  late List<_TranslationEntry> _translations;
  List<_TranslationEntry> _originalTranslations = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _initTranslations();
  }

  void _initTranslations() {
    _translations = widget.email.translations
        .map(
          (t) => _TranslationEntry(
            locale: t.locale,
            subjectController: TextEditingController(text: t.subject),
            bodyController: TextEditingController(text: t.body),
          ),
        )
        .toList();

    // Sort: default first
    _translations.sort((a, b) {
      if (a.locale == "default") return -1;
      if (b.locale == "default") return 1;
      return 0;
    });

    if (!_translations.any((t) => t.locale == "default")) {
      _translations.insert(
        0,
        _TranslationEntry(
          locale: "default",
          subjectController: TextEditingController(text: ""),
          bodyController: TextEditingController(text: ""),
        ),
      );
    }

    _originalTranslations = _translations
        .map(
          (t) => _TranslationEntry(
            locale: t.locale,
            subjectController: TextEditingController(text: t.subjectController.text),
            bodyController: TextEditingController(text: t.bodyController.text),
          ),
        )
        .toList();
  }

  bool get _unsavedChanges {
    if (_translations.length != _originalTranslations.length) return true;
    for (int i = 0; i < _translations.length; i++) {
      if (_translations[i].locale != _originalTranslations[i].locale) return true;
      if (_translations[i].subjectController.text !=
          _originalTranslations[i].subjectController.text) {
        return true;
      }
      if (_translations[i].bodyController.text != _originalTranslations[i].bodyController.text) {
        return true;
      }
    }
    return false;
  }

  bool get _canSave => _unsavedChanges && !_saving;

  bool get _canSendDraft => !_saving;

  List<CustomEmailTranslation> _buildTranslations() {
    return _translations
        .where((t) => t.subjectController.text.isNotEmpty && t.bodyController.text.isNotEmpty)
        .map(
          (t) => CustomEmailTranslation(
            locale: t.locale,
            subject: t.subjectController.text,
            body: t.bodyController.text,
          ),
        )
        .toList();
  }

  Future<bool> _save() async {
    setState(() => _saving = true);

    final defaultTranslation = _translations.firstWhere((t) => t.locale == "default");
    if (defaultTranslation.subjectController.text.isEmpty ||
        defaultTranslation.bodyController.text.isEmpty) {
      showSnackBar("Default translation must have non-empty subject and body");
      setState(() => _saving = false);
      return false;
    }

    final update = UpdateCustomEmail(id: widget.email.id, translations: _buildTranslations());

    final result = await widget.api
        .accountAdminAction((api) => api.postUpdateCustomEmail(update))
        .ok();

    setState(() => _saving = false);

    if (result == null) {
      showSnackBar("Failed to save custom email");
      return false;
    }

    _originalTranslations = _translations
        .map(
          (t) => _TranslationEntry(
            locale: t.localeController.text,
            subjectController: TextEditingController(text: t.subjectController.text),
            bodyController: TextEditingController(text: t.bodyController.text),
          ),
        )
        .toList();

    showSnackBar("Custom email saved");
    return true;
  }

  Future<void> _saveAndSendToAll() async {
    if (!await _save()) return;

    final send = SendCustomEmail(
      emailId: widget.email.id,
      targetGroup: CustomEmailTargetGroup.allAccounts,
    );
    final result = await widget.api
        .accountAdminAction((api) => api.postSendCustomEmailToAllAccounts(send))
        .ok();

    if (result == null) {
      showSnackBar("Failed to send custom email to all accounts");
      return;
    }

    showSnackBar("Custom email sending initiated");
    if (mounted) {
      widget.closer.close(context, ());
    }
  }

  Future<void> _saveAndSendDraft() async {
    if (!await _save()) return;

    final send = SendCustomEmail(
      emailId: widget.email.id,
      targetGroup: CustomEmailTargetGroup.allAccounts,
    );
    final result = await widget.api
        .accountAdminAction((api) => api.postSendCustomEmailDraftToMyEmailAddress(send))
        .ok();

    if (result == null) {
      showSnackBar("Failed to send draft to your email");
      return;
    }

    showSnackBar("Draft sent to your email");
  }

  void _addTranslation() {
    setState(() {
      _translations.add(
        _TranslationEntry(
          locale: "",
          subjectController: TextEditingController(text: ""),
          bodyController: TextEditingController(text: ""),
        ),
      );
    });
  }

  void _removeTranslation(int index) {
    if (_translations[index].locale == "default") return;
    setState(() {
      _translations[index].subjectController.dispose();
      _translations[index].bodyController.dispose();
      _translations.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (!_unsavedChanges) return widget.closer.close(context, ());
        if (await showConfirmDialog(context, "Discard unsaved changes?") == true) {
          if (context.mounted) {
            widget.closer.close(context, ());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit custom email"),
          actions: [
            if (widget.email.sendingInitiatedUnixTime == null)
              IconButton(
                icon: const Icon(Icons.send),
                tooltip: "Send email to all users",
                onPressed: () => _showConfirmThen("Send email to all users?", _saveAndSendToAll),
              ),
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: "Save email",
              onPressed: _canSave ? () => _save() : null,
            ),
            menuActions([
              MenuItemButton(
                onPressed: _canSendDraft
                    ? () => _showConfirmThen("Send draft to your email?", _saveAndSendDraft)
                    : null,
                child: const Text("Send draft to my email"),
              ),
            ]),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final email = widget.email;
    final statusText = email.sendingCompletedUnixTime != null
        ? "Sent"
        : email.sendingInitiatedUnixTime != null
        ? "Sending initiated"
        : "Draft";

    final isSending = email.sendingInitiatedUnixTime != null;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text("Status: $statusText", style: Theme.of(context).textTheme.titleMedium),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _translations.length + 1,
            itemBuilder: (context, index) {
              if (index == _translations.length) {
                if (isSending) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton.icon(
                    onPressed: _addTranslation,
                    icon: const Icon(Icons.add),
                    label: const Text("Add translation"),
                  ),
                );
              }
              return _buildTranslationCard(index);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showConfirmThen(String title, Future<void> Function() action) async {
    final confirmed = await showConfirmDialog(context, title);
    if (confirmed == true) {
      await action();
    }
  }

  Widget _buildTranslationCard(int index) {
    final entry = _translations[index];
    final isDefault = entry.locale == "default";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    isDefault ? "Default translation" : "Translation: ${entry.locale}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                if (!isDefault)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _removeTranslation(index),
                    tooltip: "Remove translation",
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (!isDefault)
              TextField(
                controller: entry.localeController,
                decoration: const InputDecoration(
                  labelText: "Locale (e.g. fi, sv)",
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
            if (!isDefault) const SizedBox(height: 8),
            TextField(
              controller: entry.subjectController,
              decoration: const InputDecoration(labelText: "Subject", border: OutlineInputBorder()),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: entry.bodyController,
              decoration: const InputDecoration(
                labelText: "Body",
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final t in _translations) {
      t.dispose();
    }
    super.dispose();
  }
}

class _TranslationEntry {
  final TextEditingController subjectController;
  final TextEditingController bodyController;
  final TextEditingController localeController;

  _TranslationEntry({
    required String locale,
    required this.subjectController,
    required this.bodyController,
  }) : localeController = TextEditingController(text: locale);

  String get locale => localeController.text;

  void dispose() {
    subjectController.dispose();
    bodyController.dispose();
    localeController.dispose();
  }
}
