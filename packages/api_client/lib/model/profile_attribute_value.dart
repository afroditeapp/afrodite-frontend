//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeValue {
  /// Returns a new [ProfileAttributeValue] instance.
  ProfileAttributeValue({
    required this.id,
    required this.valuePart1,
    this.valuePart2,
  });

  /// Attribute ID
  ///
  /// Minimum value: 0
  int id;

  /// Bitflags value or top level attribute value ID.
  ///
  /// Minimum value: 0
  int valuePart1;

  /// Sub level attribute value ID.
  ///
  /// Minimum value: 0
  int? valuePart2;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeValue &&
     other.id == id &&
     other.valuePart1 == valuePart1 &&
     other.valuePart2 == valuePart2;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (valuePart1.hashCode) +
    (valuePart2 == null ? 0 : valuePart2!.hashCode);

  @override
  String toString() => 'ProfileAttributeValue[id=$id, valuePart1=$valuePart1, valuePart2=$valuePart2]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'value_part1'] = this.valuePart1;
    if (this.valuePart2 != null) {
      json[r'value_part2'] = this.valuePart2;
    } else {
      json[r'value_part2'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileAttributeValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributeValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributeValue[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributeValue[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributeValue(
        id: mapValueOfType<int>(json, r'id')!,
        valuePart1: mapValueOfType<int>(json, r'value_part1')!,
        valuePart2: mapValueOfType<int>(json, r'value_part2'),
      );
    }
    return null;
  }

  static List<ProfileAttributeValue>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributeValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributeValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributeValue> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributeValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributeValue-objects as value to a dart map
  static Map<String, List<ProfileAttributeValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributeValue>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeValue.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'value_part1',
  };
}

