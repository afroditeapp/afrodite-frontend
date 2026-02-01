//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotConfig {
  /// Returns a new [AdminBotConfig] instance.
  AdminBotConfig({
    required this.contentModeration,
    this.contentModerationEnabled = false,
    required this.profileNameModeration,
    this.profileNameModerationEnabled = false,
    required this.profileTextModeration,
    this.profileTextModerationEnabled = false,
  });

  AdminContentModerationConfig contentModeration;

  bool contentModerationEnabled;

  AdminProfileStringModerationConfig profileNameModeration;

  bool profileNameModerationEnabled;

  AdminProfileStringModerationConfig profileTextModeration;

  bool profileTextModerationEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotConfig &&
    other.contentModeration == contentModeration &&
    other.contentModerationEnabled == contentModerationEnabled &&
    other.profileNameModeration == profileNameModeration &&
    other.profileNameModerationEnabled == profileNameModerationEnabled &&
    other.profileTextModeration == profileTextModeration &&
    other.profileTextModerationEnabled == profileTextModerationEnabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentModeration.hashCode) +
    (contentModerationEnabled.hashCode) +
    (profileNameModeration.hashCode) +
    (profileNameModerationEnabled.hashCode) +
    (profileTextModeration.hashCode) +
    (profileTextModerationEnabled.hashCode);

  @override
  String toString() => 'AdminBotConfig[contentModeration=$contentModeration, contentModerationEnabled=$contentModerationEnabled, profileNameModeration=$profileNameModeration, profileNameModerationEnabled=$profileNameModerationEnabled, profileTextModeration=$profileTextModeration, profileTextModerationEnabled=$profileTextModerationEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content_moderation'] = this.contentModeration;
      json[r'content_moderation_enabled'] = this.contentModerationEnabled;
      json[r'profile_name_moderation'] = this.profileNameModeration;
      json[r'profile_name_moderation_enabled'] = this.profileNameModerationEnabled;
      json[r'profile_text_moderation'] = this.profileTextModeration;
      json[r'profile_text_moderation_enabled'] = this.profileTextModerationEnabled;
    return json;
  }

  /// Returns a new [AdminBotConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminBotConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminBotConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminBotConfig(
        contentModeration: AdminContentModerationConfig.fromJson(json[r'content_moderation'])!,
        contentModerationEnabled: mapValueOfType<bool>(json, r'content_moderation_enabled') ?? false,
        profileNameModeration: AdminProfileStringModerationConfig.fromJson(json[r'profile_name_moderation'])!,
        profileNameModerationEnabled: mapValueOfType<bool>(json, r'profile_name_moderation_enabled') ?? false,
        profileTextModeration: AdminProfileStringModerationConfig.fromJson(json[r'profile_text_moderation'])!,
        profileTextModerationEnabled: mapValueOfType<bool>(json, r'profile_text_moderation_enabled') ?? false,
      );
    }
    return null;
  }

  static List<AdminBotConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotConfig-objects as value to a dart map
  static Map<String, List<AdminBotConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content_moderation',
    'profile_name_moderation',
    'profile_text_moderation',
  };
}

