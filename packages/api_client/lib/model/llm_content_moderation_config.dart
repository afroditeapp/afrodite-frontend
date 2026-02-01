//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LlmContentModerationConfig {
  /// Returns a new [LlmContentModerationConfig] instance.
  LlmContentModerationConfig({
    this.addLlmOutputToUserVisibleRejectionDetails = false,
    this.deleteAccepted = false,
    required this.expectedResponse,
    this.ignoreRejected = false,
    required this.maxTokens,
    this.moveAcceptedToHumanModeration = false,
    this.moveRejectedToHumanModeration = false,
    required this.systemText,
  });

  bool addLlmOutputToUserVisibleRejectionDetails;

  /// Overrides [Self::move_accepted_to_human_moderation]
  bool deleteAccepted;

  /// If LLM response starts with this text or the first line of the response contains this text, the content is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  /// Overrides [Self::move_rejected_to_human_moderation]
  bool ignoreRejected;

  /// Minimum value: 0
  int maxTokens;

  bool moveAcceptedToHumanModeration;

  bool moveRejectedToHumanModeration;

  String systemText;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LlmContentModerationConfig &&
    other.addLlmOutputToUserVisibleRejectionDetails == addLlmOutputToUserVisibleRejectionDetails &&
    other.deleteAccepted == deleteAccepted &&
    other.expectedResponse == expectedResponse &&
    other.ignoreRejected == ignoreRejected &&
    other.maxTokens == maxTokens &&
    other.moveAcceptedToHumanModeration == moveAcceptedToHumanModeration &&
    other.moveRejectedToHumanModeration == moveRejectedToHumanModeration &&
    other.systemText == systemText;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (addLlmOutputToUserVisibleRejectionDetails.hashCode) +
    (deleteAccepted.hashCode) +
    (expectedResponse.hashCode) +
    (ignoreRejected.hashCode) +
    (maxTokens.hashCode) +
    (moveAcceptedToHumanModeration.hashCode) +
    (moveRejectedToHumanModeration.hashCode) +
    (systemText.hashCode);

  @override
  String toString() => 'LlmContentModerationConfig[addLlmOutputToUserVisibleRejectionDetails=$addLlmOutputToUserVisibleRejectionDetails, deleteAccepted=$deleteAccepted, expectedResponse=$expectedResponse, ignoreRejected=$ignoreRejected, maxTokens=$maxTokens, moveAcceptedToHumanModeration=$moveAcceptedToHumanModeration, moveRejectedToHumanModeration=$moveRejectedToHumanModeration, systemText=$systemText]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'add_llm_output_to_user_visible_rejection_details'] = this.addLlmOutputToUserVisibleRejectionDetails;
      json[r'delete_accepted'] = this.deleteAccepted;
      json[r'expected_response'] = this.expectedResponse;
      json[r'ignore_rejected'] = this.ignoreRejected;
      json[r'max_tokens'] = this.maxTokens;
      json[r'move_accepted_to_human_moderation'] = this.moveAcceptedToHumanModeration;
      json[r'move_rejected_to_human_moderation'] = this.moveRejectedToHumanModeration;
      json[r'system_text'] = this.systemText;
    return json;
  }

  /// Returns a new [LlmContentModerationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LlmContentModerationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LlmContentModerationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LlmContentModerationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LlmContentModerationConfig(
        addLlmOutputToUserVisibleRejectionDetails: mapValueOfType<bool>(json, r'add_llm_output_to_user_visible_rejection_details') ?? false,
        deleteAccepted: mapValueOfType<bool>(json, r'delete_accepted') ?? false,
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        ignoreRejected: mapValueOfType<bool>(json, r'ignore_rejected') ?? false,
        maxTokens: mapValueOfType<int>(json, r'max_tokens')!,
        moveAcceptedToHumanModeration: mapValueOfType<bool>(json, r'move_accepted_to_human_moderation') ?? false,
        moveRejectedToHumanModeration: mapValueOfType<bool>(json, r'move_rejected_to_human_moderation') ?? false,
        systemText: mapValueOfType<String>(json, r'system_text')!,
      );
    }
    return null;
  }

  static List<LlmContentModerationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LlmContentModerationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LlmContentModerationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LlmContentModerationConfig> mapFromJson(dynamic json) {
    final map = <String, LlmContentModerationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LlmContentModerationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LlmContentModerationConfig-objects as value to a dart map
  static Map<String, List<LlmContentModerationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LlmContentModerationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LlmContentModerationConfig.listFromJson(entry.value, growable: growable,);
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

