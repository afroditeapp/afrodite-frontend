import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

/// Builds low/medium/high day count text fields.
Widget dayCountEditor({
  required BuildContext context,
  required AutomaticBanningDayCountConfig dayCounts,
  required GlobalKey<FormState> formKey,
  required void Function(void Function()) setState,
}) {
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
