//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotContentModerationConfig {
  /// Returns a new [AdminBotContentModerationConfig] instance.
  AdminBotContentModerationConfig({
    this.addedContent = false,
    required this.defaultAction,
    this.initialContent = false,
    required this.llmPrimary,
    this.llmPrimaryEnabled = false,
    required this.llmSecondary,
    this.llmSecondaryEnabled = false,
    required this.nsfwDetection,
    this.nsfwDetectionEnabled = false,
  });

  bool addedContent;

  ModerationAction defaultAction;

  bool initialContent;

  AdminBotContentModerationLlmConfig llmPrimary;

  /// Large language model based moderation. Actions: reject (can be replaced with move_to_human or ignore) and          accept (can be replaced with move_to_human or delete).
  bool llmPrimaryEnabled;

  AdminBotContentModerationLlmConfig llmSecondary;

  /// The secondary LLM moderation will run if primary results with ignore action.
  bool llmSecondaryEnabled;

  AdminBotNsfwDetectionConfig nsfwDetection;

  /// Neural network based detection. Actions: reject, move_to_human, accept and delete.
  bool nsfwDetectionEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotContentModerationConfig &&
    other.addedContent == addedContent &&
    other.defaultAction == defaultAction &&
    other.initialContent == initialContent &&
    other.llmPrimary == llmPrimary &&
    other.llmPrimaryEnabled == llmPrimaryEnabled &&
    other.llmSecondary == llmSecondary &&
    other.llmSecondaryEnabled == llmSecondaryEnabled &&
    other.nsfwDetection == nsfwDetection &&
    other.nsfwDetectionEnabled == nsfwDetectionEnabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (addedContent.hashCode) +
    (defaultAction.hashCode) +
    (initialContent.hashCode) +
    (llmPrimary.hashCode) +
    (llmPrimaryEnabled.hashCode) +
    (llmSecondary.hashCode) +
    (llmSecondaryEnabled.hashCode) +
    (nsfwDetection.hashCode) +
    (nsfwDetectionEnabled.hashCode);

  @override
  String toString() => 'AdminBotContentModerationConfig[addedContent=$addedContent, defaultAction=$defaultAction, initialContent=$initialContent, llmPrimary=$llmPrimary, llmPrimaryEnabled=$llmPrimaryEnabled, llmSecondary=$llmSecondary, llmSecondaryEnabled=$llmSecondaryEnabled, nsfwDetection=$nsfwDetection, nsfwDetectionEnabled=$nsfwDetectionEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'added_content'] = this.addedContent;
      json[r'default_action'] = this.defaultAction;
      json[r'initial_content'] = this.initialContent;
      json[r'llm_primary'] = this.llmPrimary;
      json[r'llm_primary_enabled'] = this.llmPrimaryEnabled;
      json[r'llm_secondary'] = this.llmSecondary;
      json[r'llm_secondary_enabled'] = this.llmSecondaryEnabled;
      json[r'nsfw_detection'] = this.nsfwDetection;
      json[r'nsfw_detection_enabled'] = this.nsfwDetectionEnabled;
    return json;
  }

  /// Returns a new [AdminBotContentModerationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotContentModerationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminBotContentModerationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminBotContentModerationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminBotContentModerationConfig(
        addedContent: mapValueOfType<bool>(json, r'added_content') ?? false,
        defaultAction: ModerationAction.fromJson(json[r'default_action'])!,
        initialContent: mapValueOfType<bool>(json, r'initial_content') ?? false,
        llmPrimary: AdminBotContentModerationLlmConfig.fromJson(json[r'llm_primary'])!,
        llmPrimaryEnabled: mapValueOfType<bool>(json, r'llm_primary_enabled') ?? false,
        llmSecondary: AdminBotContentModerationLlmConfig.fromJson(json[r'llm_secondary'])!,
        llmSecondaryEnabled: mapValueOfType<bool>(json, r'llm_secondary_enabled') ?? false,
        nsfwDetection: AdminBotNsfwDetectionConfig.fromJson(json[r'nsfw_detection'])!,
        nsfwDetectionEnabled: mapValueOfType<bool>(json, r'nsfw_detection_enabled') ?? false,
      );
    }
    return null;
  }

  static List<AdminBotContentModerationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotContentModerationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotContentModerationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotContentModerationConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotContentModerationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotContentModerationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotContentModerationConfig-objects as value to a dart map
  static Map<String, List<AdminBotContentModerationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotContentModerationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotContentModerationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'default_action',
    'llm_primary',
    'llm_secondary',
    'nsfw_detection',
  };
}

