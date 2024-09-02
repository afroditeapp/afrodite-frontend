//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AcceptedProfileAges {
  /// Returns a new [AcceptedProfileAges] instance.
  AcceptedProfileAges({
    required this.profileInitialAge,
    required this.profileInitialAgeSetUnixTime,
  });

  ProfileAge profileInitialAge;

  UnixTime profileInitialAgeSetUnixTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AcceptedProfileAges &&
    other.profileInitialAge == profileInitialAge &&
    other.profileInitialAgeSetUnixTime == profileInitialAgeSetUnixTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileInitialAge.hashCode) +
    (profileInitialAgeSetUnixTime.hashCode);

  @override
  String toString() => 'AcceptedProfileAges[profileInitialAge=$profileInitialAge, profileInitialAgeSetUnixTime=$profileInitialAgeSetUnixTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profile_initial_age'] = this.profileInitialAge;
      json[r'profile_initial_age_set_unix_time'] = this.profileInitialAgeSetUnixTime;
    return json;
  }

  /// Returns a new [AcceptedProfileAges] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AcceptedProfileAges? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AcceptedProfileAges[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AcceptedProfileAges[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AcceptedProfileAges(
        profileInitialAge: ProfileAge.fromJson(json[r'profile_initial_age'])!,
        profileInitialAgeSetUnixTime: UnixTime.fromJson(json[r'profile_initial_age_set_unix_time'])!,
      );
    }
    return null;
  }

  static List<AcceptedProfileAges> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AcceptedProfileAges>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AcceptedProfileAges.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AcceptedProfileAges> mapFromJson(dynamic json) {
    final map = <String, AcceptedProfileAges>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AcceptedProfileAges.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AcceptedProfileAges-objects as value to a dart map
  static Map<String, List<AcceptedProfileAges>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AcceptedProfileAges>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AcceptedProfileAges.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile_initial_age',
    'profile_initial_age_set_unix_time',
  };
}

