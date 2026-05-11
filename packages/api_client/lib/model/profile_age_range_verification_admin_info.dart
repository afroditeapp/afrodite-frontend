//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAgeRangeVerificationAdminInfo {
  /// Returns a new [ProfileAgeRangeVerificationAdminInfo] instance.
  ProfileAgeRangeVerificationAdminInfo({
    this.profileAgeRangeVerified,
    this.profileAgeRangeVerifiedManual,
  });

  bool? profileAgeRangeVerified;

  bool? profileAgeRangeVerifiedManual;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAgeRangeVerificationAdminInfo &&
    other.profileAgeRangeVerified == profileAgeRangeVerified &&
    other.profileAgeRangeVerifiedManual == profileAgeRangeVerifiedManual;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileAgeRangeVerified == null ? 0 : profileAgeRangeVerified!.hashCode) +
    (profileAgeRangeVerifiedManual == null ? 0 : profileAgeRangeVerifiedManual!.hashCode);

  @override
  String toString() => 'ProfileAgeRangeVerificationAdminInfo[profileAgeRangeVerified=$profileAgeRangeVerified, profileAgeRangeVerifiedManual=$profileAgeRangeVerifiedManual]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.profileAgeRangeVerified != null) {
      json[r'profile_age_range_verified'] = this.profileAgeRangeVerified;
    } else {
      json[r'profile_age_range_verified'] = null;
    }
    if (this.profileAgeRangeVerifiedManual != null) {
      json[r'profile_age_range_verified_manual'] = this.profileAgeRangeVerifiedManual;
    } else {
      json[r'profile_age_range_verified_manual'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileAgeRangeVerificationAdminInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAgeRangeVerificationAdminInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAgeRangeVerificationAdminInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAgeRangeVerificationAdminInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAgeRangeVerificationAdminInfo(
        profileAgeRangeVerified: mapValueOfType<bool>(json, r'profile_age_range_verified'),
        profileAgeRangeVerifiedManual: mapValueOfType<bool>(json, r'profile_age_range_verified_manual'),
      );
    }
    return null;
  }

  static List<ProfileAgeRangeVerificationAdminInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAgeRangeVerificationAdminInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAgeRangeVerificationAdminInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAgeRangeVerificationAdminInfo> mapFromJson(dynamic json) {
    final map = <String, ProfileAgeRangeVerificationAdminInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAgeRangeVerificationAdminInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAgeRangeVerificationAdminInfo-objects as value to a dart map
  static Map<String, List<ProfileAgeRangeVerificationAdminInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAgeRangeVerificationAdminInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAgeRangeVerificationAdminInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

