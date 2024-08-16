//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileSearchAgeRange {
  /// Returns a new [ProfileSearchAgeRange] instance.
  ProfileSearchAgeRange({
    required this.max,
    required this.min,
  });

  /// Max value for this field is 99.
  ///
  /// Minimum value: 0
  int max;

  /// Min value for this field is 18.
  ///
  /// Minimum value: 0
  int min;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileSearchAgeRange &&
    other.max == max &&
    other.min == min;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (max.hashCode) +
    (min.hashCode);

  @override
  String toString() => 'ProfileSearchAgeRange[max=$max, min=$min]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'max'] = this.max;
      json[r'min'] = this.min;
    return json;
  }

  /// Returns a new [ProfileSearchAgeRange] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileSearchAgeRange? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileSearchAgeRange[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileSearchAgeRange[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileSearchAgeRange(
        max: mapValueOfType<int>(json, r'max')!,
        min: mapValueOfType<int>(json, r'min')!,
      );
    }
    return null;
  }

  static List<ProfileSearchAgeRange> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileSearchAgeRange>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileSearchAgeRange.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileSearchAgeRange> mapFromJson(dynamic json) {
    final map = <String, ProfileSearchAgeRange>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileSearchAgeRange.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileSearchAgeRange-objects as value to a dart map
  static Map<String, List<ProfileSearchAgeRange>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileSearchAgeRange>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileSearchAgeRange.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'max',
    'min',
  };
}

