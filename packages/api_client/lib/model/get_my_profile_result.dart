//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetMyProfileResult {
  /// Returns a new [GetMyProfileResult] instance.
  GetMyProfileResult({
    this.nameModerationInfo,
    required this.profile,
    this.profileAgeRangeVerified,
    this.profileAgeRangeVerifiedManual,
    this.profileNameVerified,
    this.profileNameVerifiedManual,
    required this.profileSyncVersion,
    required this.profileVersion,
    this.textModerationInfo,
  });

  ProfileStringModerationInfo? nameModerationInfo;

  Profile profile;

  bool? profileAgeRangeVerified;

  bool? profileAgeRangeVerifiedManual;

  bool? profileNameVerified;

  bool? profileNameVerifiedManual;

  ProfileSyncVersion profileSyncVersion;

  ProfileVersion profileVersion;

  ProfileStringModerationInfo? textModerationInfo;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetMyProfileResult &&
    other.nameModerationInfo == nameModerationInfo &&
    other.profile == profile &&
    other.profileAgeRangeVerified == profileAgeRangeVerified &&
    other.profileAgeRangeVerifiedManual == profileAgeRangeVerifiedManual &&
    other.profileNameVerified == profileNameVerified &&
    other.profileNameVerifiedManual == profileNameVerifiedManual &&
    other.profileSyncVersion == profileSyncVersion &&
    other.profileVersion == profileVersion &&
    other.textModerationInfo == textModerationInfo;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (nameModerationInfo == null ? 0 : nameModerationInfo!.hashCode) +
    (profile.hashCode) +
    (profileAgeRangeVerified == null ? 0 : profileAgeRangeVerified!.hashCode) +
    (profileAgeRangeVerifiedManual == null ? 0 : profileAgeRangeVerifiedManual!.hashCode) +
    (profileNameVerified == null ? 0 : profileNameVerified!.hashCode) +
    (profileNameVerifiedManual == null ? 0 : profileNameVerifiedManual!.hashCode) +
    (profileSyncVersion.hashCode) +
    (profileVersion.hashCode) +
    (textModerationInfo == null ? 0 : textModerationInfo!.hashCode);

  @override
  String toString() => 'GetMyProfileResult[nameModerationInfo=$nameModerationInfo, profile=$profile, profileAgeRangeVerified=$profileAgeRangeVerified, profileAgeRangeVerifiedManual=$profileAgeRangeVerifiedManual, profileNameVerified=$profileNameVerified, profileNameVerifiedManual=$profileNameVerifiedManual, profileSyncVersion=$profileSyncVersion, profileVersion=$profileVersion, textModerationInfo=$textModerationInfo]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.nameModerationInfo != null) {
      json[r'name_moderation_info'] = this.nameModerationInfo;
    } else {
      json[r'name_moderation_info'] = null;
    }
      json[r'profile'] = this.profile;
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
      json[r'profile_sync_version'] = this.profileSyncVersion;
      json[r'profile_version'] = this.profileVersion;
    if (this.textModerationInfo != null) {
      json[r'text_moderation_info'] = this.textModerationInfo;
    } else {
      json[r'text_moderation_info'] = null;
    }
    return json;
  }

  /// Returns a new [GetMyProfileResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetMyProfileResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetMyProfileResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetMyProfileResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetMyProfileResult(
        nameModerationInfo: ProfileStringModerationInfo.fromJson(json[r'name_moderation_info']),
        profile: Profile.fromJson(json[r'profile'])!,
        profileAgeRangeVerified: mapValueOfType<bool>(json, r'profile_age_range_verified'),
        profileAgeRangeVerifiedManual: mapValueOfType<bool>(json, r'profile_age_range_verified_manual'),
        profileNameVerified: mapValueOfType<bool>(json, r'profile_name_verified'),
        profileNameVerifiedManual: mapValueOfType<bool>(json, r'profile_name_verified_manual'),
        profileSyncVersion: ProfileSyncVersion.fromJson(json[r'profile_sync_version'])!,
        profileVersion: ProfileVersion.fromJson(json[r'profile_version'])!,
        textModerationInfo: ProfileStringModerationInfo.fromJson(json[r'text_moderation_info']),
      );
    }
    return null;
  }

  static List<GetMyProfileResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetMyProfileResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetMyProfileResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetMyProfileResult> mapFromJson(dynamic json) {
    final map = <String, GetMyProfileResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetMyProfileResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetMyProfileResult-objects as value to a dart map
  static Map<String, List<GetMyProfileResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetMyProfileResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetMyProfileResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile',
    'profile_sync_version',
    'profile_version',
  };
}

