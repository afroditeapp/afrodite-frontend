//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LlmFaceVerificationConfig {
  /// Returns a new [LlmFaceVerificationConfig] instance.
  LlmFaceVerificationConfig({
    required this.expectedResponse,
    required this.maxTokens,
    required this.systemText,
  });

  /// If LLM response starts with this text or the first line of the response contains this text, the face pair is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  /// Minimum value: 0
  int maxTokens;

  String systemText;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LlmFaceVerificationConfig &&
    other.expectedResponse == expectedResponse &&
    other.maxTokens == maxTokens &&
    other.systemText == systemText;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (expectedResponse.hashCode) +
    (maxTokens.hashCode) +
    (systemText.hashCode);

  @override
  String toString() => 'LlmFaceVerificationConfig[expectedResponse=$expectedResponse, maxTokens=$maxTokens, systemText=$systemText]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expected_response'] = this.expectedResponse;
      json[r'max_tokens'] = this.maxTokens;
      json[r'system_text'] = this.systemText;
    return json;
  }

  /// Returns a new [LlmFaceVerificationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LlmFaceVerificationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LlmFaceVerificationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LlmFaceVerificationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LlmFaceVerificationConfig(
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        maxTokens: mapValueOfType<int>(json, r'max_tokens')!,
        systemText: mapValueOfType<String>(json, r'system_text')!,
      );
    }
    return null;
  }

  static List<LlmFaceVerificationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LlmFaceVerificationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LlmFaceVerificationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LlmFaceVerificationConfig> mapFromJson(dynamic json) {
    final map = <String, LlmFaceVerificationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LlmFaceVerificationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LlmFaceVerificationConfig-objects as value to a dart map
  static Map<String, List<LlmFaceVerificationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LlmFaceVerificationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LlmFaceVerificationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'expected_response',
    'max_tokens',
    'system_text',
  };
}

