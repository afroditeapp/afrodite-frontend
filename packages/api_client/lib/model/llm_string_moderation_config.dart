//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LlmStringModerationConfig {
  /// Returns a new [LlmStringModerationConfig] instance.
  LlmStringModerationConfig({
    this.addLlmOutputToUserVisibleRejectionDetails = false,
    required this.expectedResponse,
    required this.maxTokens,
    this.moveRejectedToHumanModeration = false,
    required this.systemText,
    required this.userTextTemplate,
  });

  bool addLlmOutputToUserVisibleRejectionDetails;

  /// If LLM response starts with this text or the first line of the response contains this text, the profile text is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  /// Minimum value: 0
  int maxTokens;

  bool moveRejectedToHumanModeration;

  String systemText;

  /// Placeholder \"{text}\" is replaced with text which will be moderated.
  String userTextTemplate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LlmStringModerationConfig &&
    other.addLlmOutputToUserVisibleRejectionDetails == addLlmOutputToUserVisibleRejectionDetails &&
    other.expectedResponse == expectedResponse &&
    other.maxTokens == maxTokens &&
    other.moveRejectedToHumanModeration == moveRejectedToHumanModeration &&
    other.systemText == systemText &&
    other.userTextTemplate == userTextTemplate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (addLlmOutputToUserVisibleRejectionDetails.hashCode) +
    (expectedResponse.hashCode) +
    (maxTokens.hashCode) +
    (moveRejectedToHumanModeration.hashCode) +
    (systemText.hashCode) +
    (userTextTemplate.hashCode);

  @override
  String toString() => 'LlmStringModerationConfig[addLlmOutputToUserVisibleRejectionDetails=$addLlmOutputToUserVisibleRejectionDetails, expectedResponse=$expectedResponse, maxTokens=$maxTokens, moveRejectedToHumanModeration=$moveRejectedToHumanModeration, systemText=$systemText, userTextTemplate=$userTextTemplate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'add_llm_output_to_user_visible_rejection_details'] = this.addLlmOutputToUserVisibleRejectionDetails;
      json[r'expected_response'] = this.expectedResponse;
      json[r'max_tokens'] = this.maxTokens;
      json[r'move_rejected_to_human_moderation'] = this.moveRejectedToHumanModeration;
      json[r'system_text'] = this.systemText;
      json[r'user_text_template'] = this.userTextTemplate;
    return json;
  }

  /// Returns a new [LlmStringModerationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LlmStringModerationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LlmStringModerationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LlmStringModerationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LlmStringModerationConfig(
        addLlmOutputToUserVisibleRejectionDetails: mapValueOfType<bool>(json, r'add_llm_output_to_user_visible_rejection_details') ?? false,
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        maxTokens: mapValueOfType<int>(json, r'max_tokens')!,
        moveRejectedToHumanModeration: mapValueOfType<bool>(json, r'move_rejected_to_human_moderation') ?? false,
        systemText: mapValueOfType<String>(json, r'system_text')!,
        userTextTemplate: mapValueOfType<String>(json, r'user_text_template')!,
      );
    }
    return null;
  }

  static List<LlmStringModerationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LlmStringModerationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LlmStringModerationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LlmStringModerationConfig> mapFromJson(dynamic json) {
    final map = <String, LlmStringModerationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LlmStringModerationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LlmStringModerationConfig-objects as value to a dart map
  static Map<String, List<LlmStringModerationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LlmStringModerationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LlmStringModerationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'expected_response',
    'max_tokens',
    'system_text',
    'user_text_template',
  };
}

