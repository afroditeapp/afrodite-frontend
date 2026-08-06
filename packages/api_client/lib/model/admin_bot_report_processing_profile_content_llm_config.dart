//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotReportProcessingProfileContentLlmConfig {
  /// Returns a new [AdminBotReportProcessingProfileContentLlmConfig] instance.
  AdminBotReportProcessingProfileContentLlmConfig({
    required this.expectedResponse,
    required this.systemText,
    required this.automaticBanningExpectedResponses,
  });

  /// If LLM response starts with this text or the first line of the response contains this text, the content is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  String systemText;

  AutomaticBanningExpectedLlmResponsesConfig automaticBanningExpectedResponses;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotReportProcessingProfileContentLlmConfig &&
    other.expectedResponse == expectedResponse &&
    other.systemText == systemText &&
    other.automaticBanningExpectedResponses == automaticBanningExpectedResponses;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (expectedResponse.hashCode) +
    (systemText.hashCode) +
    (automaticBanningExpectedResponses.hashCode);

  @override
  String toString() => 'AdminBotReportProcessingProfileContentLlmConfig[expectedResponse=$expectedResponse, systemText=$systemText, automaticBanningExpectedResponses=$automaticBanningExpectedResponses]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expected_response'] = this.expectedResponse;
      json[r'system_text'] = this.systemText;
      json[r'automatic_banning_expected_responses'] = this.automaticBanningExpectedResponses;
    return json;
  }

  /// Returns a new [AdminBotReportProcessingProfileContentLlmConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotReportProcessingProfileContentLlmConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'expected_response'), 'Required key "AdminBotReportProcessingProfileContentLlmConfig[expected_response]" is missing from JSON.');
        assert(json[r'expected_response'] != null, 'Required key "AdminBotReportProcessingProfileContentLlmConfig[expected_response]" has a null value in JSON.');
        assert(json.containsKey(r'system_text'), 'Required key "AdminBotReportProcessingProfileContentLlmConfig[system_text]" is missing from JSON.');
        assert(json[r'system_text'] != null, 'Required key "AdminBotReportProcessingProfileContentLlmConfig[system_text]" has a null value in JSON.');
        assert(json.containsKey(r'automatic_banning_expected_responses'), 'Required key "AdminBotReportProcessingProfileContentLlmConfig[automatic_banning_expected_responses]" is missing from JSON.');
        assert(json[r'automatic_banning_expected_responses'] != null, 'Required key "AdminBotReportProcessingProfileContentLlmConfig[automatic_banning_expected_responses]" has a null value in JSON.');
        return true;
      }());

      return AdminBotReportProcessingProfileContentLlmConfig(
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        systemText: mapValueOfType<String>(json, r'system_text')!,
        automaticBanningExpectedResponses: AutomaticBanningExpectedLlmResponsesConfig.fromJson(json[r'automatic_banning_expected_responses'])!,
      );
    }
    return null;
  }

  static List<AdminBotReportProcessingProfileContentLlmConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotReportProcessingProfileContentLlmConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotReportProcessingProfileContentLlmConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotReportProcessingProfileContentLlmConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotReportProcessingProfileContentLlmConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotReportProcessingProfileContentLlmConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotReportProcessingProfileContentLlmConfig-objects as value to a dart map
  static Map<String, List<AdminBotReportProcessingProfileContentLlmConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotReportProcessingProfileContentLlmConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotReportProcessingProfileContentLlmConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'expected_response',
    'system_text',
    'automatic_banning_expected_responses',
  };
}

