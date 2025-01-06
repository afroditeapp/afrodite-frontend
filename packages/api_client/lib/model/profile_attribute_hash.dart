//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeHash {
  /// Returns a new [ProfileAttributeHash] instance.
  ProfileAttributeHash({
    required this.h,
  });

  String h;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeHash &&
    other.h == h;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (h.hashCode);

  @override
  String toString() => 'ProfileAttributeHash[h=$h]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'h'] = this.h;
    return json;
  }

  /// Returns a new [ProfileAttributeHash] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributeHash? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributeHash[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributeHash[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributeHash(
        h: mapValueOfType<String>(json, r'h')!,
      );
    }
    return null;
  }

  static List<ProfileAttributeHash> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributeHash>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributeHash.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributeHash> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributeHash>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeHash.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributeHash-objects as value to a dart map
  static Map<String, List<ProfileAttributeHash>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributeHash>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAttributeHash.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'h',
  };
}

