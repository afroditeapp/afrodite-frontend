//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileContentModerationRejectedReasonCategory {
  /// Returns a new [ProfileContentModerationRejectedReasonCategory] instance.
  ProfileContentModerationRejectedReasonCategory({
    required this.value,
  });

  int value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileContentModerationRejectedReasonCategory &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (value.hashCode);

  @override
  String toString() => 'ProfileContentModerationRejectedReasonCategory[value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [ProfileContentModerationRejectedReasonCategory] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileContentModerationRejectedReasonCategory? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileContentModerationRejectedReasonCategory[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileContentModerationRejectedReasonCategory[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileContentModerationRejectedReasonCategory(
        value: mapValueOfType<int>(json, r'value')!,
      );
    }
    return null;
  }

  static List<ProfileContentModerationRejectedReasonCategory> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileContentModerationRejectedReasonCategory>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileContentModerationRejectedReasonCategory.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileContentModerationRejectedReasonCategory> mapFromJson(dynamic json) {
    final map = <String, ProfileContentModerationRejectedReasonCategory>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileContentModerationRejectedReasonCategory.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileContentModerationRejectedReasonCategory-objects as value to a dart map
  static Map<String, List<ProfileContentModerationRejectedReasonCategory>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileContentModerationRejectedReasonCategory>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileContentModerationRejectedReasonCategory.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'value',
  };
}

