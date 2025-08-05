//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InitialProfileAge {
  /// Returns a new [InitialProfileAge] instance.
  InitialProfileAge({
    required this.initialProfileAge,
    required this.initialProfileAgeSetUnixTime,
  });

  int initialProfileAge;

  UnixTime initialProfileAgeSetUnixTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InitialProfileAge &&
    other.initialProfileAge == initialProfileAge &&
    other.initialProfileAgeSetUnixTime == initialProfileAgeSetUnixTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (initialProfileAge.hashCode) +
    (initialProfileAgeSetUnixTime.hashCode);

  @override
  String toString() => 'InitialProfileAge[initialProfileAge=$initialProfileAge, initialProfileAgeSetUnixTime=$initialProfileAgeSetUnixTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'initial_profile_age'] = this.initialProfileAge;
      json[r'initial_profile_age_set_unix_time'] = this.initialProfileAgeSetUnixTime;
    return json;
  }

  /// Returns a new [InitialProfileAge] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InitialProfileAge? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "InitialProfileAge[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "InitialProfileAge[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InitialProfileAge(
        initialProfileAge: mapValueOfType<int>(json, r'initial_profile_age')!,
        initialProfileAgeSetUnixTime: UnixTime.fromJson(json[r'initial_profile_age_set_unix_time'])!,
      );
    }
    return null;
  }

  static List<InitialProfileAge> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InitialProfileAge>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InitialProfileAge.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InitialProfileAge> mapFromJson(dynamic json) {
    final map = <String, InitialProfileAge>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InitialProfileAge.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InitialProfileAge-objects as value to a dart map
  static Map<String, List<InitialProfileAge>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InitialProfileAge>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InitialProfileAge.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'initial_profile_age',
    'initial_profile_age_set_unix_time',
  };
}

