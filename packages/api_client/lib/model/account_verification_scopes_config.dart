//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountVerificationScopesConfig {
  /// Returns a new [AccountVerificationScopesConfig] instance.
  AccountVerificationScopesConfig({
    this.profileAgeRange,
    this.profileName,
    this.securityContent,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountVerificationPlatforms? profileAgeRange;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountVerificationPlatforms? profileName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountVerificationPlatforms? securityContent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountVerificationScopesConfig &&
    other.profileAgeRange == profileAgeRange &&
    other.profileName == profileName &&
    other.securityContent == securityContent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileAgeRange == null ? 0 : profileAgeRange!.hashCode) +
    (profileName == null ? 0 : profileName!.hashCode) +
    (securityContent == null ? 0 : securityContent!.hashCode);

  @override
  String toString() => 'AccountVerificationScopesConfig[profileAgeRange=$profileAgeRange, profileName=$profileName, securityContent=$securityContent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.profileAgeRange != null) {
      json[r'profile_age_range'] = this.profileAgeRange;
    } else {
      json[r'profile_age_range'] = null;
    }
    if (this.profileName != null) {
      json[r'profile_name'] = this.profileName;
    } else {
      json[r'profile_name'] = null;
    }
    if (this.securityContent != null) {
      json[r'security_content'] = this.securityContent;
    } else {
      json[r'security_content'] = null;
    }
    return json;
  }

  /// Returns a new [AccountVerificationScopesConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountVerificationScopesConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountVerificationScopesConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountVerificationScopesConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountVerificationScopesConfig(
        profileAgeRange: AccountVerificationPlatforms.fromJson(json[r'profile_age_range']),
        profileName: AccountVerificationPlatforms.fromJson(json[r'profile_name']),
        securityContent: AccountVerificationPlatforms.fromJson(json[r'security_content']),
      );
    }
    return null;
  }

  static List<AccountVerificationScopesConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountVerificationScopesConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountVerificationScopesConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountVerificationScopesConfig> mapFromJson(dynamic json) {
    final map = <String, AccountVerificationScopesConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountVerificationScopesConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountVerificationScopesConfig-objects as value to a dart map
  static Map<String, List<AccountVerificationScopesConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountVerificationScopesConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountVerificationScopesConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

