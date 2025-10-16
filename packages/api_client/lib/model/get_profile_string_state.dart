//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileStringState {
  /// Returns a new [GetProfileStringState] instance.
  GetProfileStringState({
    this.moderationInfo,
    this.value,
  });

  ProfileStringModerationInfo? moderationInfo;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileStringState &&
    other.moderationInfo == moderationInfo &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (moderationInfo == null ? 0 : moderationInfo!.hashCode) +
    (value == null ? 0 : value!.hashCode);

  @override
  String toString() => 'GetProfileStringState[moderationInfo=$moderationInfo, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.moderationInfo != null) {
      json[r'moderation_info'] = this.moderationInfo;
    } else {
      json[r'moderation_info'] = null;
    }
    if (this.value != null) {
      json[r'value'] = this.value;
    } else {
      json[r'value'] = null;
    }
    return json;
  }

  /// Returns a new [GetProfileStringState] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetProfileStringState? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetProfileStringState[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetProfileStringState[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetProfileStringState(
        moderationInfo: ProfileStringModerationInfo.fromJson(json[r'moderation_info']),
        value: mapValueOfType<String>(json, r'value'),
      );
    }
    return null;
  }

  static List<GetProfileStringState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetProfileStringState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetProfileStringState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetProfileStringState> mapFromJson(dynamic json) {
    final map = <String, GetProfileStringState>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileStringState.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetProfileStringState-objects as value to a dart map
  static Map<String, List<GetProfileStringState>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetProfileStringState>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetProfileStringState.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

