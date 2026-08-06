//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotContentModerationLlmConfig {
  /// Returns a new [AdminBotContentModerationLlmConfig] instance.
  AdminBotContentModerationLlmConfig({
    required this.expectedResponse,
    required this.systemText,
    this.addLlmOutputToUserVisibleRejectionDetails = false,
    this.deleteAccepted = false,
    this.ignoreRejected = false,
    this.moveAcceptedToHumanModeration = false,
    this.moveRejectedToHumanModeration = false,
  });

  /// If LLM response starts with this text or the first line of the response contains this text, the content is moderated as accepted. The comparisons are case insensitive.
  String expectedResponse;

  String systemText;

  bool addLlmOutputToUserVisibleRejectionDetails;

  /// Overrides [Self::move_accepted_to_human_moderation]
  bool deleteAccepted;

  /// Overrides [Self::move_rejected_to_human_moderation]
  bool ignoreRejected;

  bool moveAcceptedToHumanModeration;

  bool moveRejectedToHumanModeration;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotContentModerationLlmConfig &&
    other.expectedResponse == expectedResponse &&
    other.systemText == systemText &&
    other.addLlmOutputToUserVisibleRejectionDetails == addLlmOutputToUserVisibleRejectionDetails &&
    other.deleteAccepted == deleteAccepted &&
    other.ignoreRejected == ignoreRejected &&
    other.moveAcceptedToHumanModeration == moveAcceptedToHumanModeration &&
    other.moveRejectedToHumanModeration == moveRejectedToHumanModeration;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (expectedResponse.hashCode) +
    (systemText.hashCode) +
    (addLlmOutputToUserVisibleRejectionDetails.hashCode) +
    (deleteAccepted.hashCode) +
    (ignoreRejected.hashCode) +
    (moveAcceptedToHumanModeration.hashCode) +
    (moveRejectedToHumanModeration.hashCode);

  @override
  String toString() => 'AdminBotContentModerationLlmConfig[expectedResponse=$expectedResponse, systemText=$systemText, addLlmOutputToUserVisibleRejectionDetails=$addLlmOutputToUserVisibleRejectionDetails, deleteAccepted=$deleteAccepted, ignoreRejected=$ignoreRejected, moveAcceptedToHumanModeration=$moveAcceptedToHumanModeration, moveRejectedToHumanModeration=$moveRejectedToHumanModeration]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'expected_response'] = this.expectedResponse;
      json[r'system_text'] = this.systemText;
      json[r'add_llm_output_to_user_visible_rejection_details'] = this.addLlmOutputToUserVisibleRejectionDetails;
      json[r'delete_accepted'] = this.deleteAccepted;
      json[r'ignore_rejected'] = this.ignoreRejected;
      json[r'move_accepted_to_human_moderation'] = this.moveAcceptedToHumanModeration;
      json[r'move_rejected_to_human_moderation'] = this.moveRejectedToHumanModeration;
    return json;
  }

  /// Returns a new [AdminBotContentModerationLlmConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotContentModerationLlmConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'expected_response'), 'Required key "AdminBotContentModerationLlmConfig[expected_response]" is missing from JSON.');
        assert(json[r'expected_response'] != null, 'Required key "AdminBotContentModerationLlmConfig[expected_response]" has a null value in JSON.');
        assert(json.containsKey(r'system_text'), 'Required key "AdminBotContentModerationLlmConfig[system_text]" is missing from JSON.');
        assert(json[r'system_text'] != null, 'Required key "AdminBotContentModerationLlmConfig[system_text]" has a null value in JSON.');
        return true;
      }());

      return AdminBotContentModerationLlmConfig(
        expectedResponse: mapValueOfType<String>(json, r'expected_response')!,
        systemText: mapValueOfType<String>(json, r'system_text')!,
        addLlmOutputToUserVisibleRejectionDetails: mapValueOfType<bool>(json, r'add_llm_output_to_user_visible_rejection_details') ?? false,
        deleteAccepted: mapValueOfType<bool>(json, r'delete_accepted') ?? false,
        ignoreRejected: mapValueOfType<bool>(json, r'ignore_rejected') ?? false,
        moveAcceptedToHumanModeration: mapValueOfType<bool>(json, r'move_accepted_to_human_moderation') ?? false,
        moveRejectedToHumanModeration: mapValueOfType<bool>(json, r'move_rejected_to_human_moderation') ?? false,
      );
    }
    return null;
  }

  static List<AdminBotContentModerationLlmConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotContentModerationLlmConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotContentModerationLlmConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotContentModerationLlmConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotContentModerationLlmConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotContentModerationLlmConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotContentModerationLlmConfig-objects as value to a dart map
  static Map<String, List<AdminBotContentModerationLlmConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotContentModerationLlmConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotContentModerationLlmConfig.listFromJson(entry.value, growable: growable,);
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

