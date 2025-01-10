//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileTextState {
  /// Returns a new [GetProfileTextState] instance.
  GetProfileTextState({
    required this.moderationInfo,
    required this.text,
  });

  ProfileTextModerationInfo moderationInfo;

  /// If empty, the profile text is not set.
  String text;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileTextState &&
    other.moderationInfo == moderationInfo &&
    other.text == text;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (moderationInfo.hashCode) +
    (text.hashCode);

  @override
  String toString() => 'GetProfileTextState[moderationInfo=$moderationInfo, text=$text]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'moderation_info'] = this.moderationInfo;
      json[r'text'] = this.text;
    return json;
  }

  /// Returns a new [GetProfileTextState] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetProfileTextState? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetProfileTextState[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetProfileTextState[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetProfileTextState(
        moderationInfo: ProfileTextModerationInfo.fromJson(json[r'moderation_info'])!,
        text: mapValueOfType<String>(json, r'text')!,
      );
    }
    return null;
  }

  static List<GetProfileTextState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetProfileTextState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetProfileTextState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetProfileTextState> mapFromJson(dynamic json) {
    final map = <String, GetProfileTextState>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileTextState.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetProfileTextState-objects as value to a dart map
  static Map<String, List<GetProfileTextState>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetProfileTextState>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetProfileTextState.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'moderation_info',
    'text',
  };
}

