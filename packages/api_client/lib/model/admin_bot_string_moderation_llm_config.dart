//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotStringModerationLlmConfig {
  /// Returns a new [AdminBotStringModerationLlmConfig] instance.
  AdminBotStringModerationLlmConfig({
    this.addLlmOutputToUserVisibleRejectionDetails = false,
    required this.expectedResponse,
    this.moveRejectedToHumanModeration = false,
    required this.systemText,
    required this.userTextTemplate,
  });

  bool addLlmOutputToUserVisibleRejectionDetails;

  /// If LLM response starts with this text or the first line of the response contains this text, the content is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  bool moveRejectedToHumanModeration;

  String systemText;

  /// Placeholder \"{text}\" is replaced with text which will be moderated.
  String userTextTemplate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotStringModerationLlmConfig &&
    other.addLlmOutputToUserVisibleRejectionDetails == addLlmOutputToUserVisibleRejectionDetails &&
    other.expectedResponse == expectedResponse &&
    other.moveRejectedToHumanModeration == moveRejectedToHumanModeration &&
    other.systemText == systemText &&
    other.userTextTemplate == userTextTemplate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (addLlmOutputToUserVisibleRejectionDetails.hashCode) +
    (expectedResponse.hashCode) +
    (moveRejectedToHumanModeration.hashCode) +
    (systemText.hashCode) +
    (userTextTemplate.hashCode);

  @override
  String toString() => 'AdminBotStringModerationLlmConfig[addLlmOutputToUserVisibleRejectionDetails=$addLlmOutputToUserVisibleRejectionDetails, expectedResponse=$expectedResponse, moveRejectedToHumanModeration=$moveRejectedToHumanModeration, systemText=$systemText, userTextTemplate=$userTextTemplate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'add_llm_output_to_user_visible_rejection_details'] = this.addLlmOutputToUserVisibleRejectionDetails;
      json[r'expected_response'] = this.expectedResponse;
      json[r'move_rejected_to_human_moderation'] = this.moveRejectedToHumanModeration;
      json[r'system_text'] = this.systemText;
      json[r'user_text_template'] = this.userTextTemplate;
    return json;
  }

  /// Returns a new [AdminBotStringModerationLlmConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotStringModerationLlmConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminBotStringModerationLlmConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminBotStringModerationLlmConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminBotStringModerationLlmConfig(
        addLlmOutputToUserVisibleRejectionDetails: mapValueOfType<bool>(json, r'add_llm_output_to_user_visible_rejection_details') ?? false,
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        moveRejectedToHumanModeration: mapValueOfType<bool>(json, r'move_rejected_to_human_moderation') ?? false,
        systemText: mapValueOfType<String>(json, r'system_text')!,
        userTextTemplate: mapValueOfType<String>(json, r'user_text_template')!,
      );
    }
    return null;
  }

  static List<AdminBotStringModerationLlmConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotStringModerationLlmConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotStringModerationLlmConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotStringModerationLlmConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotStringModerationLlmConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotStringModerationLlmConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotStringModerationLlmConfig-objects as value to a dart map
  static Map<String, List<AdminBotStringModerationLlmConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotStringModerationLlmConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotStringModerationLlmConfig.listFromJson(entry.value, growable: growable,);
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

