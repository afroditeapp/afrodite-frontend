//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfilePrivacySettings {
  /// Returns a new [ProfilePrivacySettings] instance.
  ProfilePrivacySettings({
    required this.lastSeenTime,
    required this.onlineStatus,
  });

  bool lastSeenTime;

  bool onlineStatus;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfilePrivacySettings &&
    other.lastSeenTime == lastSeenTime &&
    other.onlineStatus == onlineStatus;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (lastSeenTime.hashCode) +
    (onlineStatus.hashCode);

  @override
  String toString() => 'ProfilePrivacySettings[lastSeenTime=$lastSeenTime, onlineStatus=$onlineStatus]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'last_seen_time'] = this.lastSeenTime;
      json[r'online_status'] = this.onlineStatus;
    return json;
  }

  /// Returns a new [ProfilePrivacySettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfilePrivacySettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfilePrivacySettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfilePrivacySettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfilePrivacySettings(
        lastSeenTime: mapValueOfType<bool>(json, r'last_seen_time')!,
        onlineStatus: mapValueOfType<bool>(json, r'online_status')!,
      );
    }
    return null;
  }

  static List<ProfilePrivacySettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfilePrivacySettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfilePrivacySettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfilePrivacySettings> mapFromJson(dynamic json) {
    final map = <String, ProfilePrivacySettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfilePrivacySettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfilePrivacySettings-objects as value to a dart map
  static Map<String, List<ProfilePrivacySettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfilePrivacySettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfilePrivacySettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'last_seen_time',
    'online_status',
  };
}

