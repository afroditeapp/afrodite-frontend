import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditAccountVerificationConfigPage
    extends MyScreenPageLimited<AdminAccountVerificationConfig> {
  EditAccountVerificationConfigPage(AdminAccountVerificationConfig config)
    : super(builder: (closer) => EditAccountVerificationConfigScreen(config, closer));
}

class EditAccountVerificationConfigScreen extends StatefulWidget {
  final AdminAccountVerificationConfig initialConfig;
  final PageCloser<AdminAccountVerificationConfig> closer;
  const EditAccountVerificationConfigScreen(this.initialConfig, this.closer, {super.key});

  @override
  State<EditAccountVerificationConfigScreen> createState() =>
      _EditAccountVerificationConfigScreenState();
}

class _EditAccountVerificationConfigScreenState extends State<EditAccountVerificationConfigScreen> {
  late AdminAccountVerificationConfig _config;
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
      appBar: AppBar(title: const Text("Account Verification")),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text("Profile age range"),
                value: _config.profileAgeRangeEnabled,
                onChanged: (v) {
                  setState(() => _config.profileAgeRangeEnabled = v);
                  _formKey.currentState?.validate();
                },
              ),
              SwitchListTile(
                title: const Text("Profile name verification status"),
                value: _config.profileNameEnabled,
                onChanged: (v) {
                  setState(() => _config.profileNameEnabled = v);
                  _formKey.currentState?.validate();
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text("Security content"),
                value: _config.securityContentEnabled,
                onChanged: (v) {
                  setState(() => _config.securityContentEnabled = v);
                  _formKey.currentState?.validate();
                },
              ),
              if (_config.securityContentEnabled) ...[
                const Divider(),
                hPad(Text("Security Content", style: Theme.of(context).textTheme.titleSmall)),
                _securityContentEditor(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _securityContentEditor() {
    final securityContent = _config.securityContent;
    final llm = securityContent.llm;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text("Default action"),
          trailing: DropdownButton<VerificationAction>(
            value: securityContent.defaultAction,
            items: VerificationAction.values.map((a) {
              return DropdownMenuItem(value: a, child: Text(a.value));
            }).toList(),
            onChanged: (v) {
              if (v != null) {
                setState(() => securityContent.defaultAction = v);
              }
            },
          ),
        ),
        const Divider(),
        hPad(Text("LLM", style: Theme.of(context).textTheme.titleSmall)),
        SwitchListTile(
          title: const Text("Enable LLM"),
          value: securityContent.llmEnabled,
          onChanged: (v) {
            setState(() => securityContent.llmEnabled = v);
            _formKey.currentState?.validate();
          },
        ),
        if (securityContent.llmEnabled) ...[
          hPad(
            Column(
              children: [
                TextFormField(
                  initialValue: llm.expectedResponse,
                  decoration: const InputDecoration(labelText: "Expected Response"),
                  validator: (value) =>
                      securityContent.llmEnabled ? _validateRequiredText(value) : null,
                  onChanged: (v) {
                    setState(() => llm.expectedResponse = v);
                    _formKey.currentState?.validate();
                  },
                ),
                TextFormField(
                  initialValue: llm.systemText,
                  decoration: const InputDecoration(labelText: "System Text"),
                  maxLines: null,
                  validator: (value) =>
                      securityContent.llmEnabled ? _validateRequiredText(value) : null,
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
              ],
            ),
          ),
        ],
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
