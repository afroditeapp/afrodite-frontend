import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

/// Builds the automatic banning config editor: low/medium/high day count
/// text fields plus the two boolean options.
Widget banningConfigEditor({
  required BuildContext context,
  required AutomaticBanningConfig config,
  required GlobalKey<FormState> formKey,
  required void Function(void Function()) setState,
}) {
  final dayCounts = config.dayCounts;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Banning day counts", style: Theme.of(context).textTheme.titleSmall),
      const SizedBox(height: 8),
      TextFormField(
        initialValue: dayCounts.low.toString(),
        decoration: const InputDecoration(labelText: "Low severity days"),
        keyboardType: TextInputType.number,
        onChanged: (v) {
          setState(() {
            dayCounts.low = int.tryParse(v) ?? 0;
            formKey.currentState?.validate();
          });
        },
      ),
      TextFormField(
        initialValue: dayCounts.medium.toString(),
        decoration: const InputDecoration(labelText: "Medium severity days"),
        keyboardType: TextInputType.number,
        onChanged: (v) {
          setState(() {
            dayCounts.medium = int.tryParse(v) ?? 0;
            formKey.currentState?.validate();
          });
        },
      ),
      TextFormField(
        initialValue: dayCounts.high.toString(),
        decoration: const InputDecoration(labelText: "High severity days"),
        keyboardType: TextInputType.number,
        onChanged: (v) {
          setState(() {
            dayCounts.high = int.tryParse(v) ?? 0;
            formKey.currentState?.validate();
          });
        },
      ),
      const SizedBox(height: 8),
      SwitchListTile(
        title: const Text("Show ban reason details to user"),
        value: config.reasonDetailsVisibleToUser,
        onChanged: (v) => setState(() => config.reasonDetailsVisibleToUser = v),
      ),
      SwitchListTile(
        title: const Text("Save LLM response as ban reason details"),
        value: config.saveReasonDetails,
        onChanged: (v) => setState(() => config.saveReasonDetails = v),
      ),
    ],
  );
}

/// Builds low/medium/high expected LLM response text fields.
Widget expectedResponsesEditor({
  required BuildContext context,
  required AutomaticBanningExpectedLlmResponsesConfig cfg,
  required bool llmEnabled,
  required GlobalKey<FormState> formKey,
  required void Function(void Function()) setState,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Expected LLM responses for banning", style: Theme.of(context).textTheme.titleSmall),
      const SizedBox(height: 8),
      TextFormField(
        initialValue: cfg.low,
        decoration: const InputDecoration(labelText: "Low severity response"),
        validator: (value) => llmEnabled ? validateRequiredText(value) : null,
        onChanged: (v) {
          setState(() {
            cfg.low = v;
            formKey.currentState?.validate();
          });
        },
      ),
      TextFormField(
        initialValue: cfg.medium,
        decoration: const InputDecoration(labelText: "Medium severity response"),
        validator: (value) => llmEnabled ? validateRequiredText(value) : null,
        onChanged: (v) {
          setState(() {
            cfg.medium = v;
            formKey.currentState?.validate();
          });
        },
      ),
      TextFormField(
        initialValue: cfg.high,
        decoration: const InputDecoration(labelText: "High severity response"),
        validator: (value) => llmEnabled ? validateRequiredText(value) : null,
        onChanged: (v) {
          setState(() {
            cfg.high = v;
            formKey.currentState?.validate();
          });
        },
      ),
    ],
  );
}

/// Validates that the text field is not empty or whitespace-only.
String? validateRequiredText(String? value) {
  if (value == null || value.trim().isEmpty) return "Field is required";
  return null;
}

/// Validates that the user text template contains the {text} placeholder.
String? validateUserTextTemplate(String? value) {
  if (value == null || value.isEmpty) return "User text template is required";
  if (!value.contains("{text}")) return "Template must include {text}";
  return null;
}
