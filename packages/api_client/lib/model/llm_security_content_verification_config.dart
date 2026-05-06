//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LlmSecurityContentVerificationConfig {
  /// Returns a new [LlmSecurityContentVerificationConfig] instance.
  LlmSecurityContentVerificationConfig({
    required this.expectedResponse,
    required this.maxTokens,
    required this.systemText,
  });

  /// If LLM response starts with this text or the first line of the response contains this text, the verification is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  /// Minimum value: 0
  int maxTokens;

  String systemText;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LlmSecurityContentVerificationConfig &&
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
  String toString() => 'LlmSecurityContentVerificationConfig[expectedResponse=$expectedResponse, maxTokens=$maxTokens, systemText=$systemText]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expected_response'] = this.expectedResponse;
      json[r'max_tokens'] = this.maxTokens;
      json[r'system_text'] = this.systemText;
    return json;
  }

  /// Returns a new [LlmSecurityContentVerificationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LlmSecurityContentVerificationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LlmSecurityContentVerificationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LlmSecurityContentVerificationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LlmSecurityContentVerificationConfig(
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        maxTokens: mapValueOfType<int>(json, r'max_tokens')!,
        systemText: mapValueOfType<String>(json, r'system_text')!,
      );
    }
    return null;
  }

  static List<LlmSecurityContentVerificationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LlmSecurityContentVerificationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LlmSecurityContentVerificationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LlmSecurityContentVerificationConfig> mapFromJson(dynamic json) {
    final map = <String, LlmSecurityContentVerificationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LlmSecurityContentVerificationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LlmSecurityContentVerificationConfig-objects as value to a dart map
  static Map<String, List<LlmSecurityContentVerificationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LlmSecurityContentVerificationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LlmSecurityContentVerificationConfig.listFromJson(entry.value, growable: growable,);
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

