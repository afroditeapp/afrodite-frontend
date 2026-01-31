//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminContentModerationConfig {
  /// Returns a new [AdminContentModerationConfig] instance.
  AdminContentModerationConfig({
    required this.addedContent,
    required this.defaultAction,
    required this.initialContent,
    this.llmPrimary,
    this.llmSecondary,
    this.nsfwDetection,
  });

  bool addedContent;

  ModerationAction defaultAction;

  bool initialContent;

  /// Large language model based moderation. Actions: reject (can be replaced with move_to_human or ignore) and          accept (can be replaced with move_to_human or delete).
  LlmContentModerationConfig? llmPrimary;

  /// The secondary LLM moderation will run if primary results with ignore action.
  LlmContentModerationConfig? llmSecondary;

  /// Neural network based detection. Actions: reject, move_to_human, accept and delete.
  AdminNsfwDetectionConfig? nsfwDetection;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminContentModerationConfig &&
    other.addedContent == addedContent &&
    other.defaultAction == defaultAction &&
    other.initialContent == initialContent &&
    other.llmPrimary == llmPrimary &&
    other.llmSecondary == llmSecondary &&
    other.nsfwDetection == nsfwDetection;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (addedContent.hashCode) +
    (defaultAction.hashCode) +
    (initialContent.hashCode) +
    (llmPrimary == null ? 0 : llmPrimary!.hashCode) +
    (llmSecondary == null ? 0 : llmSecondary!.hashCode) +
    (nsfwDetection == null ? 0 : nsfwDetection!.hashCode);

  @override
  String toString() => 'AdminContentModerationConfig[addedContent=$addedContent, defaultAction=$defaultAction, initialContent=$initialContent, llmPrimary=$llmPrimary, llmSecondary=$llmSecondary, nsfwDetection=$nsfwDetection]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'added_content'] = this.addedContent;
      json[r'default_action'] = this.defaultAction;
      json[r'initial_content'] = this.initialContent;
    if (this.llmPrimary != null) {
      json[r'llm_primary'] = this.llmPrimary;
    } else {
      json[r'llm_primary'] = null;
    }
    if (this.llmSecondary != null) {
      json[r'llm_secondary'] = this.llmSecondary;
    } else {
      json[r'llm_secondary'] = null;
    }
    if (this.nsfwDetection != null) {
      json[r'nsfw_detection'] = this.nsfwDetection;
    } else {
      json[r'nsfw_detection'] = null;
    }
    return json;
  }

  /// Returns a new [AdminContentModerationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminContentModerationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminContentModerationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminContentModerationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminContentModerationConfig(
        addedContent: mapValueOfType<bool>(json, r'added_content')!,
        defaultAction: ModerationAction.fromJson(json[r'default_action'])!,
        initialContent: mapValueOfType<bool>(json, r'initial_content')!,
        llmPrimary: LlmContentModerationConfig.fromJson(json[r'llm_primary']),
        llmSecondary: LlmContentModerationConfig.fromJson(json[r'llm_secondary']),
        nsfwDetection: AdminNsfwDetectionConfig.fromJson(json[r'nsfw_detection']),
      );
    }
    return null;
  }

  static List<AdminContentModerationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminContentModerationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminContentModerationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminContentModerationConfig> mapFromJson(dynamic json) {
    final map = <String, AdminContentModerationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminContentModerationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminContentModerationConfig-objects as value to a dart map
  static Map<String, List<AdminContentModerationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminContentModerationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminContentModerationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'added_content',
    'default_action',
    'initial_content',
  };
}

