//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotAccountVerificationConfig {
  /// Returns a new [AdminBotAccountVerificationConfig] instance.
  AdminBotAccountVerificationConfig({
    this.profileAgeRangeEnabled = false,
    this.profileNameEnabled = false,
    required this.securityContent,
    this.securityContentEnabled = false,
  });

  bool profileAgeRangeEnabled;

  bool profileNameEnabled;

  AdminBotSecurityContentVerificationConfig securityContent;

  bool securityContentEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotAccountVerificationConfig &&
    other.profileAgeRangeEnabled == profileAgeRangeEnabled &&
    other.profileNameEnabled == profileNameEnabled &&
    other.securityContent == securityContent &&
    other.securityContentEnabled == securityContentEnabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileAgeRangeEnabled.hashCode) +
    (profileNameEnabled.hashCode) +
    (securityContent.hashCode) +
    (securityContentEnabled.hashCode);

  @override
  String toString() => 'AdminBotAccountVerificationConfig[profileAgeRangeEnabled=$profileAgeRangeEnabled, profileNameEnabled=$profileNameEnabled, securityContent=$securityContent, securityContentEnabled=$securityContentEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profile_age_range_enabled'] = this.profileAgeRangeEnabled;
      json[r'profile_name_enabled'] = this.profileNameEnabled;
      json[r'security_content'] = this.securityContent;
      json[r'security_content_enabled'] = this.securityContentEnabled;
    return json;
  }

  /// Returns a new [AdminBotAccountVerificationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotAccountVerificationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminBotAccountVerificationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminBotAccountVerificationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminBotAccountVerificationConfig(
        profileAgeRangeEnabled: mapValueOfType<bool>(json, r'profile_age_range_enabled') ?? false,
        profileNameEnabled: mapValueOfType<bool>(json, r'profile_name_enabled') ?? false,
        securityContent: AdminBotSecurityContentVerificationConfig.fromJson(json[r'security_content'])!,
        securityContentEnabled: mapValueOfType<bool>(json, r'security_content_enabled') ?? false,
      );
    }
    return null;
  }

  static List<AdminBotAccountVerificationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotAccountVerificationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotAccountVerificationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotAccountVerificationConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotAccountVerificationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotAccountVerificationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotAccountVerificationConfig-objects as value to a dart map
  static Map<String, List<AdminBotAccountVerificationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotAccountVerificationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotAccountVerificationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'security_content',
  };
}

