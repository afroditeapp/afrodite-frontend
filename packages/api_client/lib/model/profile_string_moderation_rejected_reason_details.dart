//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileStringModerationRejectedReasonDetails {
  /// Returns a new [ProfileStringModerationRejectedReasonDetails] instance.
  ProfileStringModerationRejectedReasonDetails({
    required this.value,
  });

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileStringModerationRejectedReasonDetails &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (value.hashCode);

  @override
  String toString() => 'ProfileStringModerationRejectedReasonDetails[value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [ProfileStringModerationRejectedReasonDetails] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileStringModerationRejectedReasonDetails? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileStringModerationRejectedReasonDetails[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileStringModerationRejectedReasonDetails[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileStringModerationRejectedReasonDetails(
        value: mapValueOfType<String>(json, r'value')!,
      );
    }
    return null;
  }

  static List<ProfileStringModerationRejectedReasonDetails> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileStringModerationRejectedReasonDetails>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileStringModerationRejectedReasonDetails.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileStringModerationRejectedReasonDetails> mapFromJson(dynamic json) {
    final map = <String, ProfileStringModerationRejectedReasonDetails>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileStringModerationRejectedReasonDetails.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileStringModerationRejectedReasonDetails-objects as value to a dart map
  static Map<String, List<ProfileStringModerationRejectedReasonDetails>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileStringModerationRejectedReasonDetails>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileStringModerationRejectedReasonDetails.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'value',
  };
}

