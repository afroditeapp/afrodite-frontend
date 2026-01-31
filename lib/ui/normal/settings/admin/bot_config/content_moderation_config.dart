import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/bot_config/nsfw_detection_config.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditContentModerationConfigPage extends MyScreenPageLimited<AdminContentModerationConfig> {
  EditContentModerationConfigPage(AdminContentModerationConfig config)
    : super(builder: (closer) => EditContentModerationConfigScreen(config, closer));
}

class EditContentModerationConfigScreen extends StatefulWidget {
  final AdminContentModerationConfig initialConfig;
  final PageCloser<AdminContentModerationConfig> closer;
  const EditContentModerationConfigScreen(this.initialConfig, this.closer, {super.key});

  @override
  State<EditContentModerationConfigScreen> createState() =>
      _EditContentModerationConfigScreenState();
}

class _EditContentModerationConfigScreenState extends State<EditContentModerationConfigScreen> {
  late AdminContentModerationConfig _config;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _config = widget.initialConfig;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        widget.closer.close(context, _config);
      },
      child: _scaffold(context),
    );
  }

  Widget _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Content Moderation")),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text("Added content"),
                value: _config.addedContent,
                onChanged: (v) => setState(() => _config.addedContent = v),
              ),
              SwitchListTile(
                title: const Text("Initial content"),
                value: _config.initialContent,
                onChanged: (v) => setState(() => _config.initialContent = v),
              ),
              ListTile(
                title: const Text("Default action"),
                trailing: DropdownButton<ModerationAction>(
                  value: _config.defaultAction,
                  items: ModerationAction.values.map((a) {
                    return DropdownMenuItem(value: a, child: Text(a.value));
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _config.defaultAction = v);
                  },
                ),
              ),
              const Divider(),
              _nsfwSection(),
              const Divider(),
              _llmSection(
                "LLM Primary",
                _config.llmPrimary,
                _config.llmPrimaryEnabled,
                (v) => setState(() => _config.llmPrimaryEnabled = v),
              ),
              const Divider(),
              _llmSection(
                "LLM Secondary",
                _config.llmSecondary,
                _config.llmSecondaryEnabled,
                (v) => setState(() => _config.llmSecondaryEnabled = v),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nsfwSection() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text("NSFW Detection"),
          value: _config.nsfwDetectionEnabled,
          onChanged: (v) => setState(() => _config.nsfwDetectionEnabled = v),
        ),
        ListTile(
          title: const Text("Configure NSFW detection"),
          trailing: const Icon(Icons.chevron_right),
          enabled: _config.nsfwDetectionEnabled,
          onTap: _config.nsfwDetectionEnabled
              ? () async {
                  final result = await MyNavigator.pushLimited(
                    context,
                    EditNsfwDetectionConfigPage(_config.nsfwDetection),
                  );
                  if (result != null) {
                    setState(() => _config.nsfwDetection = result);
                  }
                }
              : null,
        ),
      ],
    );
  }

  Widget _llmSection(
    String title,
    LlmContentModerationConfig llm,
    bool enabled,
    void Function(bool) onEnabledChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Text(title, style: Theme.of(context).textTheme.titleSmall)),
        SwitchListTile(title: const Text("Enabled"), value: enabled, onChanged: onEnabledChanged),
        if (enabled) hPad(_llmEditor(llm)),
      ],
    );
  }

  Widget _llmEditor(LlmContentModerationConfig llm) {
    return Column(
      children: [
        TextFormField(
          initialValue: llm.expectedResponse,
          decoration: const InputDecoration(labelText: "Expected Response"),
          validator: _validateRequiredText,
          onChanged: (v) {
            setState(() => llm.expectedResponse = v);
            _formKey.currentState?.validate();
          },
        ),
        TextFormField(
          initialValue: llm.systemText,
          decoration: const InputDecoration(labelText: "System Text"),
          maxLines: null,
          validator: _validateRequiredText,
          onChanged: (v) {
            setState(() => llm.systemText = v);
            _formKey.currentState?.validate();
          },
        ),
        TextFormField(
          initialValue: llm.maxTokens.toString(),
          decoration: const InputDecoration(labelText: "Max Tokens"),
          keyboardType: TextInputType.number,
          onChanged: (v) => setState(() => llm.maxTokens = int.tryParse(v) ?? 0),
        ),
        SwitchListTile(
          title: const Text("Delete accepted"),
          value: llm.deleteAccepted,
          onChanged: (v) => setState(() => llm.deleteAccepted = v),
        ),
        SwitchListTile(
          title: const Text("Ignore rejected"),
          value: llm.ignoreRejected,
          onChanged: (v) => setState(() => llm.ignoreRejected = v),
        ),
        SwitchListTile(
          title: const Text("Move accepted to human"),
          value: llm.moveAcceptedToHumanModeration,
          onChanged: (v) => setState(() => llm.moveAcceptedToHumanModeration = v),
        ),
        SwitchListTile(
          title: const Text("Move rejected to human"),
          value: llm.moveRejectedToHumanModeration,
          onChanged: (v) => setState(() => llm.moveRejectedToHumanModeration = v),
        ),
        SwitchListTile(
          title: const Text("Add LLM output to rejection details"),
          value: llm.addLlmOutputToUserVisibleRejectionDetails,
          onChanged: (v) => setState(() => llm.addLlmOutputToUserVisibleRejectionDetails = v),
        ),
      ],
    );
  }

  String? _validateRequiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field is required";
    }
    return null;
  }
}
