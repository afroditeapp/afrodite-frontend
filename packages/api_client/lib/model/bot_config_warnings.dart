//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BotConfigWarnings {
  /// Returns a new [BotConfigWarnings] instance.
  BotConfigWarnings({
    this.contentModerationFileConfigMissing = false,
    this.error = false,
    this.errorAdminBotOffline = false,
    this.profileNameModerationFileConfigMissing = false,
    this.profileTextModerationFileConfigMissing = false,
  });

  bool contentModerationFileConfigMissing;

  bool error;

  /// True, when getting warnings fails because admin bot is offline
  bool errorAdminBotOffline;

  bool profileNameModerationFileConfigMissing;

  bool profileTextModerationFileConfigMissing;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BotConfigWarnings &&
    other.contentModerationFileConfigMissing == contentModerationFileConfigMissing &&
    other.error == error &&
    other.errorAdminBotOffline == errorAdminBotOffline &&
    other.profileNameModerationFileConfigMissing == profileNameModerationFileConfigMissing &&
    other.profileTextModerationFileConfigMissing == profileTextModerationFileConfigMissing;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentModerationFileConfigMissing.hashCode) +
    (error.hashCode) +
    (errorAdminBotOffline.hashCode) +
    (profileNameModerationFileConfigMissing.hashCode) +
    (profileTextModerationFileConfigMissing.hashCode);

  @override
  String toString() => 'BotConfigWarnings[contentModerationFileConfigMissing=$contentModerationFileConfigMissing, error=$error, errorAdminBotOffline=$errorAdminBotOffline, profileNameModerationFileConfigMissing=$profileNameModerationFileConfigMissing, profileTextModerationFileConfigMissing=$profileTextModerationFileConfigMissing]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content_moderation_file_config_missing'] = this.contentModerationFileConfigMissing;
      json[r'error'] = this.error;
      json[r'error_admin_bot_offline'] = this.errorAdminBotOffline;
      json[r'profile_name_moderation_file_config_missing'] = this.profileNameModerationFileConfigMissing;
      json[r'profile_text_moderation_file_config_missing'] = this.profileTextModerationFileConfigMissing;
    return json;
  }

  /// Returns a new [BotConfigWarnings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BotConfigWarnings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BotConfigWarnings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BotConfigWarnings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BotConfigWarnings(
        contentModerationFileConfigMissing: mapValueOfType<bool>(json, r'content_moderation_file_config_missing') ?? false,
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorAdminBotOffline: mapValueOfType<bool>(json, r'error_admin_bot_offline') ?? false,
        profileNameModerationFileConfigMissing: mapValueOfType<bool>(json, r'profile_name_moderation_file_config_missing') ?? false,
        profileTextModerationFileConfigMissing: mapValueOfType<bool>(json, r'profile_text_moderation_file_config_missing') ?? false,
      );
    }
    return null;
  }

  static List<BotConfigWarnings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BotConfigWarnings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BotConfigWarnings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BotConfigWarnings> mapFromJson(dynamic json) {
    final map = <String, BotConfigWarnings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BotConfigWarnings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BotConfigWarnings-objects as value to a dart map
  static Map<String, List<BotConfigWarnings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BotConfigWarnings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BotConfigWarnings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

