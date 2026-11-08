//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileStringIterationValue {
  /// Returns a new [ProfileStringIterationValue] instance.
  ProfileStringIterationValue({
    required this.editedTime,
    required this.id,
    required this.value,
  });

  UnixTime editedTime;

  AccountId id;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileStringIterationValue &&
    other.editedTime == editedTime &&
    other.id == id &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (editedTime.hashCode) +
    (id.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'ProfileStringIterationValue[editedTime=$editedTime, id=$id, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'edited_time'] = this.editedTime;
      json[r'id'] = this.id;
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [ProfileStringIterationValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileStringIterationValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'edited_time'), 'Required key "ProfileStringIterationValue[edited_time]" is missing from JSON.');
        assert(json[r'edited_time'] != null, 'Required key "ProfileStringIterationValue[edited_time]" has a null value in JSON.');
        assert(json.containsKey(r'id'), 'Required key "ProfileStringIterationValue[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProfileStringIterationValue[id]" has a null value in JSON.');
        assert(json.containsKey(r'value'), 'Required key "ProfileStringIterationValue[value]" is missing from JSON.');
        assert(json[r'value'] != null, 'Required key "ProfileStringIterationValue[value]" has a null value in JSON.');
        return true;
      }());

      return ProfileStringIterationValue(
        editedTime: UnixTime.fromJson(json[r'edited_time'])!,
        id: AccountId.fromJson(json[r'id'])!,
        value: mapValueOfType<String>(json, r'value')!,
      );
    }
    return null;
  }

  static List<ProfileStringIterationValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileStringIterationValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileStringIterationValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileStringIterationValue> mapFromJson(dynamic json) {
    final map = <String, ProfileStringIterationValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileStringIterationValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileStringIterationValue-objects as value to a dart map
  static Map<String, List<ProfileStringIterationValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileStringIterationValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileStringIterationValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'edited_time',
    'id',
    'value',
  };
}

