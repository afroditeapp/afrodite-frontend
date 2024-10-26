//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAgeCounts {
  /// Returns a new [ProfileAgeCounts] instance.
  ProfileAgeCounts({
    this.man = const [],
    this.nonBinary = const [],
    required this.startAge,
    this.woman = const [],
  });

  List<int> man;

  List<int> nonBinary;

  /// Age for first count
  int startAge;

  List<int> woman;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAgeCounts &&
    _deepEquality.equals(other.man, man) &&
    _deepEquality.equals(other.nonBinary, nonBinary) &&
    other.startAge == startAge &&
    _deepEquality.equals(other.woman, woman);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (man.hashCode) +
    (nonBinary.hashCode) +
    (startAge.hashCode) +
    (woman.hashCode);

  @override
  String toString() => 'ProfileAgeCounts[man=$man, nonBinary=$nonBinary, startAge=$startAge, woman=$woman]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'man'] = this.man;
      json[r'non_binary'] = this.nonBinary;
      json[r'start_age'] = this.startAge;
      json[r'woman'] = this.woman;
    return json;
  }

  /// Returns a new [ProfileAgeCounts] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAgeCounts? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAgeCounts[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAgeCounts[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAgeCounts(
        man: json[r'man'] is Iterable
            ? (json[r'man'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        nonBinary: json[r'non_binary'] is Iterable
            ? (json[r'non_binary'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        startAge: mapValueOfType<int>(json, r'start_age')!,
        woman: json[r'woman'] is Iterable
            ? (json[r'woman'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<ProfileAgeCounts> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAgeCounts>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAgeCounts.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAgeCounts> mapFromJson(dynamic json) {
    final map = <String, ProfileAgeCounts>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAgeCounts.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAgeCounts-objects as value to a dart map
  static Map<String, List<ProfileAgeCounts>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAgeCounts>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAgeCounts.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'man',
    'non_binary',
    'start_age',
    'woman',
  };
}

