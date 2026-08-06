//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotFaceVerificationLlmConfig {
  /// Returns a new [AdminBotFaceVerificationLlmConfig] instance.
  AdminBotFaceVerificationLlmConfig({
    required this.expectedResponse,
    required this.systemText,
  });

  /// If LLM response starts with this text or the first line of the response contains this text, the content is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  String systemText;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotFaceVerificationLlmConfig &&
    other.expectedResponse == expectedResponse &&
    other.systemText == systemText;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (expectedResponse.hashCode) +
    (systemText.hashCode);

  @override
  String toString() => 'AdminBotFaceVerificationLlmConfig[expectedResponse=$expectedResponse, systemText=$systemText]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expected_response'] = this.expectedResponse;
      json[r'system_text'] = this.systemText;
    return json;
  }

  /// Returns a new [AdminBotFaceVerificationLlmConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotFaceVerificationLlmConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'expected_response'), 'Required key "AdminBotFaceVerificationLlmConfig[expected_response]" is missing from JSON.');
        assert(json[r'expected_response'] != null, 'Required key "AdminBotFaceVerificationLlmConfig[expected_response]" has a null value in JSON.');
        assert(json.containsKey(r'system_text'), 'Required key "AdminBotFaceVerificationLlmConfig[system_text]" is missing from JSON.');
        assert(json[r'system_text'] != null, 'Required key "AdminBotFaceVerificationLlmConfig[system_text]" has a null value in JSON.');
        return true;
      }());

      return AdminBotFaceVerificationLlmConfig(
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        systemText: mapValueOfType<String>(json, r'system_text')!,
      );
    }
    return null;
  }

  static List<AdminBotFaceVerificationLlmConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotFaceVerificationLlmConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotFaceVerificationLlmConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotFaceVerificationLlmConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotFaceVerificationLlmConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotFaceVerificationLlmConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotFaceVerificationLlmConfig-objects as value to a dart map
  static Map<String, List<AdminBotFaceVerificationLlmConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotFaceVerificationLlmConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotFaceVerificationLlmConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'expected_response',
    'system_text',
  };
}

