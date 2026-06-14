//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotReportProcessingConfig {
  /// Returns a new [AdminBotReportProcessingConfig] instance.
  AdminBotReportProcessingConfig({
    required this.messages,
    required this.profileContent,
    required this.profileName,
    required this.profileText,
  });

  AdminBotReportProcessingMessagesConfig messages;

  AdminBotReportProcessingProfileContentConfig profileContent;

  AdminBotReportProcessingProfileStringConfig profileName;

  AdminBotReportProcessingProfileStringConfig profileText;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotReportProcessingConfig &&
    other.messages == messages &&
    other.profileContent == profileContent &&
    other.profileName == profileName &&
    other.profileText == profileText;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (messages.hashCode) +
    (profileContent.hashCode) +
    (profileName.hashCode) +
    (profileText.hashCode);

  @override
  String toString() => 'AdminBotReportProcessingConfig[messages=$messages, profileContent=$profileContent, profileName=$profileName, profileText=$profileText]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'messages'] = this.messages;
      json[r'profile_content'] = this.profileContent;
      json[r'profile_name'] = this.profileName;
      json[r'profile_text'] = this.profileText;
    return json;
  }

  /// Returns a new [AdminBotReportProcessingConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotReportProcessingConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminBotReportProcessingConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminBotReportProcessingConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminBotReportProcessingConfig(
        messages: AdminBotReportProcessingMessagesConfig.fromJson(json[r'messages'])!,
        profileContent: AdminBotReportProcessingProfileContentConfig.fromJson(json[r'profile_content'])!,
        profileName: AdminBotReportProcessingProfileStringConfig.fromJson(json[r'profile_name'])!,
        profileText: AdminBotReportProcessingProfileStringConfig.fromJson(json[r'profile_text'])!,
      );
    }
    return null;
  }

  static List<AdminBotReportProcessingConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotReportProcessingConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotReportProcessingConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotReportProcessingConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotReportProcessingConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotReportProcessingConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotReportProcessingConfig-objects as value to a dart map
  static Map<String, List<AdminBotReportProcessingConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotReportProcessingConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotReportProcessingConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'messages',
    'profile_content',
    'profile_name',
    'profile_text',
  };
}

