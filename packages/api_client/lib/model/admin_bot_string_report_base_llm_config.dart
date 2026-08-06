//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotStringReportBaseLlmConfig {
  /// Returns a new [AdminBotStringReportBaseLlmConfig] instance.
  AdminBotStringReportBaseLlmConfig({
    required this.expectedResponse,
    required this.systemText,
    required this.userTextTemplate,
  });

  /// If LLM response starts with this text or the first line of the response contains this text, the content is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  String systemText;

  /// Placeholder \"{text}\" is replaced with the reported content.
  String userTextTemplate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotStringReportBaseLlmConfig &&
    other.expectedResponse == expectedResponse &&
    other.systemText == systemText &&
    other.userTextTemplate == userTextTemplate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (expectedResponse.hashCode) +
    (systemText.hashCode) +
    (userTextTemplate.hashCode);

  @override
  String toString() => 'AdminBotStringReportBaseLlmConfig[expectedResponse=$expectedResponse, systemText=$systemText, userTextTemplate=$userTextTemplate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expected_response'] = this.expectedResponse;
      json[r'system_text'] = this.systemText;
      json[r'user_text_template'] = this.userTextTemplate;
    return json;
  }

  /// Returns a new [AdminBotStringReportBaseLlmConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotStringReportBaseLlmConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'expected_response'), 'Required key "AdminBotStringReportBaseLlmConfig[expected_response]" is missing from JSON.');
        assert(json[r'expected_response'] != null, 'Required key "AdminBotStringReportBaseLlmConfig[expected_response]" has a null value in JSON.');
        assert(json.containsKey(r'system_text'), 'Required key "AdminBotStringReportBaseLlmConfig[system_text]" is missing from JSON.');
        assert(json[r'system_text'] != null, 'Required key "AdminBotStringReportBaseLlmConfig[system_text]" has a null value in JSON.');
        assert(json.containsKey(r'user_text_template'), 'Required key "AdminBotStringReportBaseLlmConfig[user_text_template]" is missing from JSON.');
        assert(json[r'user_text_template'] != null, 'Required key "AdminBotStringReportBaseLlmConfig[user_text_template]" has a null value in JSON.');
        return true;
      }());

      return AdminBotStringReportBaseLlmConfig(
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        systemText: mapValueOfType<String>(json, r'system_text')!,
        userTextTemplate: mapValueOfType<String>(json, r'user_text_template')!,
      );
    }
    return null;
  }

  static List<AdminBotStringReportBaseLlmConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotStringReportBaseLlmConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotStringReportBaseLlmConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotStringReportBaseLlmConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotStringReportBaseLlmConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotStringReportBaseLlmConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotStringReportBaseLlmConfig-objects as value to a dart map
  static Map<String, List<AdminBotStringReportBaseLlmConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotStringReportBaseLlmConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotStringReportBaseLlmConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'expected_response',
    'system_text',
    'user_text_template',
  };
}

