//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotReportProcessingProfileStringLlmConfig {
  /// Returns a new [AdminBotReportProcessingProfileStringLlmConfig] instance.
  AdminBotReportProcessingProfileStringLlmConfig({
    required this.expectedResponse,
    required this.systemText,
    required this.userTextTemplate,
    required this.automaticBanningExpectedResponses,
  });

  /// If LLM response starts with this text or the first line of the response contains this text, the content is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  String systemText;

  /// Placeholder \"{text}\" is replaced with the reported content.
  String userTextTemplate;

  AutomaticBanningExpectedLlmResponsesConfig automaticBanningExpectedResponses;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotReportProcessingProfileStringLlmConfig &&
    other.expectedResponse == expectedResponse &&
    other.systemText == systemText &&
    other.userTextTemplate == userTextTemplate &&
    other.automaticBanningExpectedResponses == automaticBanningExpectedResponses;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (expectedResponse.hashCode) +
    (systemText.hashCode) +
    (userTextTemplate.hashCode) +
    (automaticBanningExpectedResponses.hashCode);

  @override
  String toString() => 'AdminBotReportProcessingProfileStringLlmConfig[expectedResponse=$expectedResponse, systemText=$systemText, userTextTemplate=$userTextTemplate, automaticBanningExpectedResponses=$automaticBanningExpectedResponses]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expected_response'] = this.expectedResponse;
      json[r'system_text'] = this.systemText;
      json[r'user_text_template'] = this.userTextTemplate;
      json[r'automatic_banning_expected_responses'] = this.automaticBanningExpectedResponses;
    return json;
  }

  /// Returns a new [AdminBotReportProcessingProfileStringLlmConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotReportProcessingProfileStringLlmConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'expected_response'), 'Required key "AdminBotReportProcessingProfileStringLlmConfig[expected_response]" is missing from JSON.');
        assert(json[r'expected_response'] != null, 'Required key "AdminBotReportProcessingProfileStringLlmConfig[expected_response]" has a null value in JSON.');
        assert(json.containsKey(r'system_text'), 'Required key "AdminBotReportProcessingProfileStringLlmConfig[system_text]" is missing from JSON.');
        assert(json[r'system_text'] != null, 'Required key "AdminBotReportProcessingProfileStringLlmConfig[system_text]" has a null value in JSON.');
        assert(json.containsKey(r'user_text_template'), 'Required key "AdminBotReportProcessingProfileStringLlmConfig[user_text_template]" is missing from JSON.');
        assert(json[r'user_text_template'] != null, 'Required key "AdminBotReportProcessingProfileStringLlmConfig[user_text_template]" has a null value in JSON.');
        assert(json.containsKey(r'automatic_banning_expected_responses'), 'Required key "AdminBotReportProcessingProfileStringLlmConfig[automatic_banning_expected_responses]" is missing from JSON.');
        assert(json[r'automatic_banning_expected_responses'] != null, 'Required key "AdminBotReportProcessingProfileStringLlmConfig[automatic_banning_expected_responses]" has a null value in JSON.');
        return true;
      }());

      return AdminBotReportProcessingProfileStringLlmConfig(
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        systemText: mapValueOfType<String>(json, r'system_text')!,
        userTextTemplate: mapValueOfType<String>(json, r'user_text_template')!,
        automaticBanningExpectedResponses: AutomaticBanningExpectedLlmResponsesConfig.fromJson(json[r'automatic_banning_expected_responses'])!,
      );
    }
    return null;
  }

  static List<AdminBotReportProcessingProfileStringLlmConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotReportProcessingProfileStringLlmConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotReportProcessingProfileStringLlmConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotReportProcessingProfileStringLlmConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotReportProcessingProfileStringLlmConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotReportProcessingProfileStringLlmConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotReportProcessingProfileStringLlmConfig-objects as value to a dart map
  static Map<String, List<AdminBotReportProcessingProfileStringLlmConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotReportProcessingProfileStringLlmConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotReportProcessingProfileStringLlmConfig.listFromJson(entry.value, growable: growable,);
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
  };
}

