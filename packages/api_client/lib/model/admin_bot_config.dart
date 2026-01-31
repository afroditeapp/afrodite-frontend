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
    this.contentModeration,
    this.profileNameModeration,
    this.profileTextModeration,
  });

  AdminContentModerationConfig? contentModeration;

  AdminProfileStringModerationConfig? profileNameModeration;

  AdminProfileStringModerationConfig? profileTextModeration;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotConfig &&
    other.contentModeration == contentModeration &&
    other.profileNameModeration == profileNameModeration &&
    other.profileTextModeration == profileTextModeration;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentModeration == null ? 0 : contentModeration!.hashCode) +
    (profileNameModeration == null ? 0 : profileNameModeration!.hashCode) +
    (profileTextModeration == null ? 0 : profileTextModeration!.hashCode);

  @override
  String toString() => 'AdminBotConfig[contentModeration=$contentModeration, profileNameModeration=$profileNameModeration, profileTextModeration=$profileTextModeration]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.contentModeration != null) {
      json[r'content_moderation'] = this.contentModeration;
    } else {
      json[r'content_moderation'] = null;
    }
    if (this.profileNameModeration != null) {
      json[r'profile_name_moderation'] = this.profileNameModeration;
    } else {
      json[r'profile_name_moderation'] = null;
    }
    if (this.profileTextModeration != null) {
      json[r'profile_text_moderation'] = this.profileTextModeration;
    } else {
      json[r'profile_text_moderation'] = null;
    }
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
        contentModeration: AdminContentModerationConfig.fromJson(json[r'content_moderation']),
        profileNameModeration: AdminProfileStringModerationConfig.fromJson(json[r'profile_name_moderation']),
        profileTextModeration: AdminProfileStringModerationConfig.fromJson(json[r'profile_text_moderation']),
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
  };
}

