import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditFaceVerificationConfigPage extends MyScreenPageLimited<AdminFaceVerificationConfig> {
  EditFaceVerificationConfigPage(AdminFaceVerificationConfig config)
    : super(builder: (closer) => EditFaceVerificationConfigScreen(config, closer));
}

class EditFaceVerificationConfigScreen extends StatefulWidget {
  final AdminFaceVerificationConfig initialConfig;
  final PageCloser<AdminFaceVerificationConfig> closer;
  const EditFaceVerificationConfigScreen(this.initialConfig, this.closer, {super.key});

  @override
  State<EditFaceVerificationConfigScreen> createState() => _EditFaceVerificationConfigScreenState();
}

class _EditFaceVerificationConfigScreenState extends State<EditFaceVerificationConfigScreen> {
  late VerificationAction _defaultAction;
  late LlmFaceVerificationConfig _llm;
  late bool _llmEnabled;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
          AdminFaceVerificationConfig(
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
      appBar: AppBar(title: const Text("Face Verification")),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text("Default action"),
                trailing: DropdownButton<VerificationAction>(
                  value: _defaultAction,
                  items: VerificationAction.values.map((a) {
                    return DropdownMenuItem(value: a, child: Text(a.value));
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _defaultAction = v);
                  },
                ),
              ),
              const Divider(),
              hPad(Text("LLM", style: Theme.of(context).textTheme.titleSmall)),
              SwitchListTile(
                title: const Text("Enable LLM"),
                value: _llmEnabled,
                onChanged: (v) {
                  setState(() => _llmEnabled = v);
                  _formKey.currentState?.validate();
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
          initialValue: _llm.maxTokens.toString(),
          decoration: const InputDecoration(labelText: "Max Tokens"),
          keyboardType: TextInputType.number,
          onChanged: (v) => setState(() => _llm.maxTokens = int.tryParse(v) ?? 0),
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
