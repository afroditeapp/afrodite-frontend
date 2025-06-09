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
    this.men = const [],
    this.nonbinaries = const [],
    required this.startAge,
    this.women = const [],
  });

  List<int> men;

  List<int> nonbinaries;

  /// Age for first count
  int startAge;

  List<int> women;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAgeCounts &&
    _deepEquality.equals(other.men, men) &&
    _deepEquality.equals(other.nonbinaries, nonbinaries) &&
    other.startAge == startAge &&
    _deepEquality.equals(other.women, women);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (men.hashCode) +
    (nonbinaries.hashCode) +
    (startAge.hashCode) +
    (women.hashCode);

  @override
  String toString() => 'ProfileAgeCounts[men=$men, nonbinaries=$nonbinaries, startAge=$startAge, women=$women]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'men'] = this.men;
      json[r'nonbinaries'] = this.nonbinaries;
      json[r'start_age'] = this.startAge;
      json[r'women'] = this.women;
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
        men: json[r'men'] is Iterable
            ? (json[r'men'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        nonbinaries: json[r'nonbinaries'] is Iterable
            ? (json[r'nonbinaries'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        startAge: mapValueOfType<int>(json, r'start_age')!,
        women: json[r'women'] is Iterable
            ? (json[r'women'] as Iterable).cast<int>().toList(growable: false)
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
    'men',
    'nonbinaries',
    'start_age',
    'women',
  };
}

