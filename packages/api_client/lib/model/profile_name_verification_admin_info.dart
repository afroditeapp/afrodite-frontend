//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileNameVerificationAdminInfo {
  /// Returns a new [ProfileNameVerificationAdminInfo] instance.
  ProfileNameVerificationAdminInfo({
    this.profileNameVerified,
    this.profileNameVerifiedManual,
  });

  bool? profileNameVerified;

  bool? profileNameVerifiedManual;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileNameVerificationAdminInfo &&
    other.profileNameVerified == profileNameVerified &&
    other.profileNameVerifiedManual == profileNameVerifiedManual;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileNameVerified == null ? 0 : profileNameVerified!.hashCode) +
    (profileNameVerifiedManual == null ? 0 : profileNameVerifiedManual!.hashCode);

  @override
  String toString() => 'ProfileNameVerificationAdminInfo[profileNameVerified=$profileNameVerified, profileNameVerifiedManual=$profileNameVerifiedManual]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.profileNameVerified != null) {
      json[r'profile_name_verified'] = this.profileNameVerified;
    } else {
      json[r'profile_name_verified'] = null;
    }
    if (this.profileNameVerifiedManual != null) {
      json[r'profile_name_verified_manual'] = this.profileNameVerifiedManual;
    } else {
      json[r'profile_name_verified_manual'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileNameVerificationAdminInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileNameVerificationAdminInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileNameVerificationAdminInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileNameVerificationAdminInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileNameVerificationAdminInfo(
        profileNameVerified: mapValueOfType<bool>(json, r'profile_name_verified'),
        profileNameVerifiedManual: mapValueOfType<bool>(json, r'profile_name_verified_manual'),
      );
    }
    return null;
  }

  static List<ProfileNameVerificationAdminInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileNameVerificationAdminInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileNameVerificationAdminInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileNameVerificationAdminInfo> mapFromJson(dynamic json) {
    final map = <String, ProfileNameVerificationAdminInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileNameVerificationAdminInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileNameVerificationAdminInfo-objects as value to a dart map
  static Map<String, List<ProfileNameVerificationAdminInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileNameVerificationAdminInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileNameVerificationAdminInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

