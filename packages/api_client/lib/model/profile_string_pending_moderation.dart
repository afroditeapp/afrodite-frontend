//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileStringPendingModeration {
  /// Returns a new [ProfileStringPendingModeration] instance.
  ProfileStringPendingModeration({
    required this.id,
    required this.value,
  });

  AccountId id;

  String value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileStringPendingModeration &&
    other.id == id &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'ProfileStringPendingModeration[id=$id, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [ProfileStringPendingModeration] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileStringPendingModeration? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileStringPendingModeration[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileStringPendingModeration[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileStringPendingModeration(
        id: AccountId.fromJson(json[r'id'])!,
        value: mapValueOfType<String>(json, r'value')!,
      );
    }
    return null;
  }

  static List<ProfileStringPendingModeration> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileStringPendingModeration>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileStringPendingModeration.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileStringPendingModeration> mapFromJson(dynamic json) {
    final map = <String, ProfileStringPendingModeration>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileStringPendingModeration.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileStringPendingModeration-objects as value to a dart map
  static Map<String, List<ProfileStringPendingModeration>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileStringPendingModeration>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileStringPendingModeration.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'value',
  };
}

