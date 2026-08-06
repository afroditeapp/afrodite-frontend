//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotReportProcessingMessagesLlmConfig {
  /// Returns a new [AdminBotReportProcessingMessagesLlmConfig] instance.
  AdminBotReportProcessingMessagesLlmConfig({
    required this.expectedResponse,
    required this.systemText,
    required this.userTextTemplate,
    required this.automaticBanningExpectedResponses,
    required this.reportCreatorMessageTemplate,
    required this.reportTargetMessageTemplate,
  });

  /// If LLM response starts with this text or the first line of the response contains this text, the content is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  String systemText;

  /// Placeholder \"{text}\" is replaced with the reported content.
  String userTextTemplate;

  AutomaticBanningExpectedLlmResponsesConfig automaticBanningExpectedResponses;

  /// Required placeholder \"{text}\" is replaced with the report creator's message. Optional placeholder \"{message_number}\" is replaced with the message number.
  String reportCreatorMessageTemplate;

  /// Required placeholder \"{text}\" is replaced with the report target's message. Optional placeholder \"{message_number}\" is replaced with the message number.
  String reportTargetMessageTemplate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotReportProcessingMessagesLlmConfig &&
    other.expectedResponse == expectedResponse &&
    other.systemText == systemText &&
    other.userTextTemplate == userTextTemplate &&
    other.automaticBanningExpectedResponses == automaticBanningExpectedResponses &&
    other.reportCreatorMessageTemplate == reportCreatorMessageTemplate &&
    other.reportTargetMessageTemplate == reportTargetMessageTemplate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (expectedResponse.hashCode) +
    (systemText.hashCode) +
    (userTextTemplate.hashCode) +
    (automaticBanningExpectedResponses.hashCode) +
    (reportCreatorMessageTemplate.hashCode) +
    (reportTargetMessageTemplate.hashCode);

  @override
  String toString() => 'AdminBotReportProcessingMessagesLlmConfig[expectedResponse=$expectedResponse, systemText=$systemText, userTextTemplate=$userTextTemplate, automaticBanningExpectedResponses=$automaticBanningExpectedResponses, reportCreatorMessageTemplate=$reportCreatorMessageTemplate, reportTargetMessageTemplate=$reportTargetMessageTemplate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expected_response'] = this.expectedResponse;
      json[r'system_text'] = this.systemText;
      json[r'user_text_template'] = this.userTextTemplate;
      json[r'automatic_banning_expected_responses'] = this.automaticBanningExpectedResponses;
      json[r'report_creator_message_template'] = this.reportCreatorMessageTemplate;
      json[r'report_target_message_template'] = this.reportTargetMessageTemplate;
    return json;
  }

  /// Returns a new [AdminBotReportProcessingMessagesLlmConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotReportProcessingMessagesLlmConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'expected_response'), 'Required key "AdminBotReportProcessingMessagesLlmConfig[expected_response]" is missing from JSON.');
        assert(json[r'expected_response'] != null, 'Required key "AdminBotReportProcessingMessagesLlmConfig[expected_response]" has a null value in JSON.');
        assert(json.containsKey(r'system_text'), 'Required key "AdminBotReportProcessingMessagesLlmConfig[system_text]" is missing from JSON.');
        assert(json[r'system_text'] != null, 'Required key "AdminBotReportProcessingMessagesLlmConfig[system_text]" has a null value in JSON.');
        assert(json.containsKey(r'user_text_template'), 'Required key "AdminBotReportProcessingMessagesLlmConfig[user_text_template]" is missing from JSON.');
        assert(json[r'user_text_template'] != null, 'Required key "AdminBotReportProcessingMessagesLlmConfig[user_text_template]" has a null value in JSON.');
        assert(json.containsKey(r'automatic_banning_expected_responses'), 'Required key "AdminBotReportProcessingMessagesLlmConfig[automatic_banning_expected_responses]" is missing from JSON.');
        assert(json[r'automatic_banning_expected_responses'] != null, 'Required key "AdminBotReportProcessingMessagesLlmConfig[automatic_banning_expected_responses]" has a null value in JSON.');
        assert(json.containsKey(r'report_creator_message_template'), 'Required key "AdminBotReportProcessingMessagesLlmConfig[report_creator_message_template]" is missing from JSON.');
        assert(json[r'report_creator_message_template'] != null, 'Required key "AdminBotReportProcessingMessagesLlmConfig[report_creator_message_template]" has a null value in JSON.');
        assert(json.containsKey(r'report_target_message_template'), 'Required key "AdminBotReportProcessingMessagesLlmConfig[report_target_message_template]" is missing from JSON.');
        assert(json[r'report_target_message_template'] != null, 'Required key "AdminBotReportProcessingMessagesLlmConfig[report_target_message_template]" has a null value in JSON.');
        return true;
      }());

      return AdminBotReportProcessingMessagesLlmConfig(
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        systemText: mapValueOfType<String>(json, r'system_text')!,
        userTextTemplate: mapValueOfType<String>(json, r'user_text_template')!,
        automaticBanningExpectedResponses: AutomaticBanningExpectedLlmResponsesConfig.fromJson(json[r'automatic_banning_expected_responses'])!,
        reportCreatorMessageTemplate: mapValueOfType<String>(json, r'report_creator_message_template')!,
        reportTargetMessageTemplate: mapValueOfType<String>(json, r'report_target_message_template')!,
      );
    }
    return null;
  }

  static List<AdminBotReportProcessingMessagesLlmConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotReportProcessingMessagesLlmConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotReportProcessingMessagesLlmConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotReportProcessingMessagesLlmConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotReportProcessingMessagesLlmConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotReportProcessingMessagesLlmConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotReportProcessingMessagesLlmConfig-objects as value to a dart map
  static Map<String, List<AdminBotReportProcessingMessagesLlmConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotReportProcessingMessagesLlmConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotReportProcessingMessagesLlmConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'expected_response',
    'system_text',
    'user_text_template',
    'automatic_banning_expected_responses',
    'report_creator_message_template',
    'report_target_message_template',
  };
}

