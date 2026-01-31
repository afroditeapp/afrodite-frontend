import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditProfileStringModerationConfigPage
    extends MyScreenPageLimited<AdminProfileStringModerationConfig> {
  EditProfileStringModerationConfigPage(AdminProfileStringModerationConfig config)
    : super(builder: (closer) => EditProfileStringModerationConfigScreen(config, closer));
}

class EditProfileStringModerationConfigScreen extends StatefulWidget {
  final AdminProfileStringModerationConfig initialConfig;
  final PageCloser<AdminProfileStringModerationConfig> closer;
  const EditProfileStringModerationConfigScreen(this.initialConfig, this.closer, {super.key});

  @override
  State<EditProfileStringModerationConfigScreen> createState() =>
      _EditProfileStringModerationConfigScreenState();
}

class _EditProfileStringModerationConfigScreenState
    extends State<EditProfileStringModerationConfigScreen> {
  late bool _acceptSingleVisibleCharacter;
  late ModerationAction _defaultAction;
  late LlmStringModerationConfig _llm;
  late bool _llmEnabled;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _acceptSingleVisibleCharacter = widget.initialConfig.acceptSingleVisibleCharacter;
    _defaultAction = widget.initialConfig.defaultAction;
    _llm = widget.initialConfig.llm;
    _llmEnabled = widget.initialConfig.llmEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        widget.closer.close(
          context,
          AdminProfileStringModerationConfig(
            acceptSingleVisibleCharacter: _acceptSingleVisibleCharacter,
            defaultAction: _defaultAction,
            llm: _llm,
            llmEnabled: _llmEnabled,
          ),
        );
      },
      child: _scaffold(context),
    );
  }

  Widget _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("String Moderation")),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text("Accept single visible character"),
                value: _acceptSingleVisibleCharacter,
                onChanged: (v) => setState(() => _acceptSingleVisibleCharacter = v),
              ),
              ListTile(
                title: const Text("Default action"),
                trailing: DropdownButton<ModerationAction>(
                  value: _defaultAction,
                  items: ModerationAction.values.map((a) {
                    return DropdownMenuItem(value: a, child: Text(a.value));
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _defaultAction = v);
                  },
                ),
              ),
              const Divider(),
              hPad(Text("LLM Moderation", style: Theme.of(context).textTheme.titleSmall)),
              SwitchListTile(
                title: const Text("Enable LLM"),
                value: _llmEnabled,
                onChanged: (v) {
                  setState(() => _llmEnabled = v);
                },
              ),
              if (_llmEnabled) ...[hPad(_llmEditor())],
            ],
          ),
        ),
      ),
    );
  }

  Widget _llmEditor() {
    return Column(
      children: [
        TextFormField(
          initialValue: _llm.expectedResponse,
          decoration: const InputDecoration(labelText: "Expected Response"),
          validator: (value) => _llmEnabled ? _validateRequiredText(value) : null,
          onChanged: (v) {
            setState(() => _llm.expectedResponse = v);
            _formKey.currentState?.validate();
          },
        ),
        TextFormField(
          initialValue: _llm.systemText,
          decoration: const InputDecoration(labelText: "System Text"),
          maxLines: null,
          validator: (value) => _llmEnabled ? _validateRequiredText(value) : null,
          onChanged: (v) {
            setState(() => _llm.systemText = v);
            _formKey.currentState?.validate();
          },
        ),
        TextFormField(
          initialValue: _llm.userTextTemplate,
          decoration: const InputDecoration(labelText: "User Text Template"),
          maxLines: null,
          validator: (value) {
            if (!_llmEnabled) return null;
            return _validateUserTextTemplate(value);
          },
          onChanged: (v) {
            setState(() => _llm.userTextTemplate = v);
            _formKey.currentState?.validate();
          },
        ),
        TextFormField(
          initialValue: _llm.maxTokens.toString(),
          decoration: const InputDecoration(labelText: "Max Tokens"),
          keyboardType: TextInputType.number,
          onChanged: (v) => setState(() => _llm.maxTokens = int.tryParse(v) ?? 0),
        ),
        SwitchListTile(
          title: const Text("Move rejected to human"),
          value: _llm.moveRejectedToHumanModeration,
          onChanged: (v) => setState(() => _llm.moveRejectedToHumanModeration = v),
        ),
        SwitchListTile(
          title: const Text("Add LLM output to rejection details"),
          value: _llm.addLlmOutputToUserVisibleRejectionDetails,
          onChanged: (v) => setState(() => _llm.addLlmOutputToUserVisibleRejectionDetails = v),
        ),
      ],
    );
  }

  String? _validateUserTextTemplate(String? value) {
    if (value == null || value.isEmpty) {
      return "User text template is required";
    }
    if (!value.contains("{text}")) {
      return "Template must include {text}";
    }
    return null;
  }

  String? _validateRequiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field is required";
    }
    return null;
  }
}
