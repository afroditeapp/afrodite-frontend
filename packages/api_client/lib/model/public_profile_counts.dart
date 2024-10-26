//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicProfileCounts {
  /// Returns a new [PublicProfileCounts] instance.
  PublicProfileCounts({
    required this.man,
    required this.nonBinary,
    required this.woman,
  });

  int man;

  int nonBinary;

  int woman;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicProfileCounts &&
    other.man == man &&
    other.nonBinary == nonBinary &&
    other.woman == woman;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (man.hashCode) +
    (nonBinary.hashCode) +
    (woman.hashCode);

  @override
  String toString() => 'PublicProfileCounts[man=$man, nonBinary=$nonBinary, woman=$woman]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'man'] = this.man;
      json[r'non_binary'] = this.nonBinary;
      json[r'woman'] = this.woman;
    return json;
  }

  /// Returns a new [PublicProfileCounts] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicProfileCounts? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PublicProfileCounts[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PublicProfileCounts[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PublicProfileCounts(
        man: mapValueOfType<int>(json, r'man')!,
        nonBinary: mapValueOfType<int>(json, r'non_binary')!,
        woman: mapValueOfType<int>(json, r'woman')!,
      );
    }
    return null;
  }

  static List<PublicProfileCounts> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicProfileCounts>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicProfileCounts.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicProfileCounts> mapFromJson(dynamic json) {
    final map = <String, PublicProfileCounts>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicProfileCounts.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicProfileCounts-objects as value to a dart map
  static Map<String, List<PublicProfileCounts>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicProfileCounts>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicProfileCounts.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'man',
    'non_binary',
    'woman',
  };
}

