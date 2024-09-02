//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetAccountSetup {
  /// Returns a new [SetAccountSetup] instance.
  SetAccountSetup({
    this.birthdate,
    required this.isAdult,
  });

  /// String date with \"YYYY-MM-DD\" format.  This is not required at the moment to reduce sensitive user data.
  String? birthdate;

  bool isAdult;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetAccountSetup &&
    other.birthdate == birthdate &&
    other.isAdult == isAdult;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (birthdate == null ? 0 : birthdate!.hashCode) +
    (isAdult.hashCode);

  @override
  String toString() => 'SetAccountSetup[birthdate=$birthdate, isAdult=$isAdult]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.birthdate != null) {
      json[r'birthdate'] = this.birthdate;
    } else {
      json[r'birthdate'] = null;
    }
      json[r'is_adult'] = this.isAdult;
    return json;
  }

  /// Returns a new [SetAccountSetup] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetAccountSetup? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetAccountSetup[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetAccountSetup[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetAccountSetup(
        birthdate: mapValueOfType<String>(json, r'birthdate'),
        isAdult: mapValueOfType<bool>(json, r'is_adult')!,
      );
    }
    return null;
  }

  static List<SetAccountSetup> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetAccountSetup>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetAccountSetup.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetAccountSetup> mapFromJson(dynamic json) {
    final map = <String, SetAccountSetup>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetAccountSetup.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetAccountSetup-objects as value to a dart map
  static Map<String, List<SetAccountSetup>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetAccountSetup>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetAccountSetup.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'is_adult',
  };
}

