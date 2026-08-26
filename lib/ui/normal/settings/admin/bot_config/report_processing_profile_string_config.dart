import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/bot_config/utils.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditReportProcessingProfileStringConfigPage
    extends MyScreenPageLimited<AdminBotReportProcessingProfileStringConfig> {
  EditReportProcessingProfileStringConfigPage(AdminBotReportProcessingProfileStringConfig config)
    : super(builder: (closer) => EditReportProcessingProfileStringConfigScreen(config, closer));
}

class EditReportProcessingProfileStringConfigScreen extends StatefulWidget {
  final AdminBotReportProcessingProfileStringConfig initialConfig;
  final PageCloser<AdminBotReportProcessingProfileStringConfig> closer;
  const EditReportProcessingProfileStringConfigScreen(this.initialConfig, this.closer, {super.key});

  @override
  State<EditReportProcessingProfileStringConfigScreen> createState() =>
      _EditReportProcessingProfileStringConfigScreenState();
}

class _EditReportProcessingProfileStringConfigScreenState
    extends State<EditReportProcessingProfileStringConfigScreen> {
  late AdminBotReportProcessingProfileStringConfig _config;
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
      appBar: AppBar(title: const Text("Report Profile String Config")),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text("Default action"),
                trailing: DropdownButton<AcceptOrReject>(
                  value: _config.defaultAction,
                  items: AcceptOrReject.values
                      .where((a) => a != AcceptOrReject.unknownDefaultOpenApi)
                      .map((a) => DropdownMenuItem(value: a, child: Text(a.toString())))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _config.defaultAction = v);
                  },
                ),
              ),
              const Divider(),
              _automaticBanningSection(),
              const Divider(),
              _llmSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _automaticBanningSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text("Automatic banning"),
          value: _config.automaticBanningEnabled,
          onChanged: (v) => setState(() => _config.automaticBanningEnabled = v),
        ),
        if (_config.automaticBanningEnabled) hPad(_dayCountEditor()),
      ],
    );
  }

  Widget _dayCountEditor() {
    return dayCountEditor(
      context: context,
      dayCounts: _config.automaticBanningDayCounts,
      formKey: _formKey,
      setState: setState,
    );
  }

  Widget _llmSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Text("LLM", style: Theme.of(context).textTheme.titleSmall)),
        SwitchListTile(
          title: const Text("Enable LLM"),
          value: _config.llmEnabled,
          onChanged: (v) {
            setState(() => _config.llmEnabled = v);
            _formKey.currentState?.validate();
          },
        ),
        if (_config.llmEnabled) hPad(_llmEditor()),
      ],
    );
  }

  Widget _llmEditor() {
    return Column(
      children: [
        TextFormField(
          initialValue: _config.llm.expectedResponse,
          decoration: const InputDecoration(labelText: "Expected Response"),
          validator: (value) => _config.llmEnabled ? _validateRequiredText(value) : null,
          onChanged: (v) {
            setState(() => _config.llm.expectedResponse = v);
            _formKey.currentState?.validate();
          },
        ),
        TextFormField(
          initialValue: _config.llm.systemText,
          decoration: const InputDecoration(labelText: "System Text"),
          maxLines: null,
          validator: (value) => _config.llmEnabled ? _validateRequiredText(value) : null,
          onChanged: (v) {
            setState(() => _config.llm.systemText = v);
            _formKey.currentState?.validate();
          },
        ),
        TextFormField(
          initialValue: _config.llm.userTextTemplate,
          decoration: const InputDecoration(labelText: "User Text Template"),
          maxLines: null,
          validator: (value) => _config.llmEnabled ? _validateUserTextTemplate(value) : null,
          onChanged: (v) {
            setState(() => _config.llm.userTextTemplate = v);
            _formKey.currentState?.validate();
          },
        ),
        const Divider(),
        _expectedResponsesEditor(_config.llm.automaticBanningExpectedResponses),
      ],
    );
  }

  Widget _expectedResponsesEditor(AutomaticBanningExpectedLlmResponsesConfig cfg) {
    return expectedResponsesEditor(
      context: context,
      cfg: cfg,
      llmEnabled: _config.llmEnabled,
      formKey: _formKey,
      setState: setState,
    );
  }

  String? _validateUserTextTemplate(String? value) {
    return validateUserTextTemplate(value);
  }

  String? _validateRequiredText(String? value) {
    return validateRequiredText(value);
  }
}
