//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountVerificationScope {
  /// Returns a new [AccountVerificationScope] instance.
  AccountVerificationScope({
    this.profileAgeRange = false,
    this.profileName = false,
    this.securityContent = false,
  });

  bool profileAgeRange;

  bool profileName;

  bool securityContent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountVerificationScope &&
    other.profileAgeRange == profileAgeRange &&
    other.profileName == profileName &&
    other.securityContent == securityContent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileAgeRange.hashCode) +
    (profileName.hashCode) +
    (securityContent.hashCode);

  @override
  String toString() => 'AccountVerificationScope[profileAgeRange=$profileAgeRange, profileName=$profileName, securityContent=$securityContent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profile_age_range'] = this.profileAgeRange;
      json[r'profile_name'] = this.profileName;
      json[r'security_content'] = this.securityContent;
    return json;
  }

  /// Returns a new [AccountVerificationScope] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountVerificationScope? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountVerificationScope[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountVerificationScope[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountVerificationScope(
        profileAgeRange: mapValueOfType<bool>(json, r'profile_age_range') ?? false,
        profileName: mapValueOfType<bool>(json, r'profile_name') ?? false,
        securityContent: mapValueOfType<bool>(json, r'security_content') ?? false,
      );
    }
    return null;
  }

  static List<AccountVerificationScope> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountVerificationScope>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountVerificationScope.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountVerificationScope> mapFromJson(dynamic json) {
    final map = <String, AccountVerificationScope>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountVerificationScope.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountVerificationScope-objects as value to a dart map
  static Map<String, List<AccountVerificationScope>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountVerificationScope>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountVerificationScope.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

