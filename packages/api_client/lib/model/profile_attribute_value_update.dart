//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeValueUpdate {
  /// Returns a new [ProfileAttributeValueUpdate] instance.
  ProfileAttributeValueUpdate({
    required this.id,
    this.values = const [],
  });

  /// Attribute ID
  ///
  /// Minimum value: 0
  int id;

  /// Empty list removes the attribute.  - First value is bitflags value or top level attribute value ID or first number list value. - Second value is sub level attribute value ID or second number list value. - Third and rest are number list values.
  List<int> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeValueUpdate &&
    other.id == id &&
    _deepEquality.equals(other.values, values);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'ProfileAttributeValueUpdate[id=$id, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [ProfileAttributeValueUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributeValueUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributeValueUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributeValueUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributeValueUpdate(
        id: mapValueOfType<int>(json, r'id')!,
        values: json[r'values'] is Iterable
            ? (json[r'values'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<ProfileAttributeValueUpdate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributeValueUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributeValueUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributeValueUpdate> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributeValueUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeValueUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributeValueUpdate-objects as value to a dart map
  static Map<String, List<ProfileAttributeValueUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributeValueUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAttributeValueUpdate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'values',
  };
}

