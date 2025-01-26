//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileNameState {
  /// Returns a new [GetProfileNameState] instance.
  GetProfileNameState({
    required this.name,
    required this.state,
  });

  /// If empty, the profile name is not set.
  String name;

  ProfileNameModerationState state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileNameState &&
    other.name == name &&
    other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'GetProfileNameState[name=$name, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'state'] = this.state;
    return json;
  }

  /// Returns a new [GetProfileNameState] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetProfileNameState? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetProfileNameState[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetProfileNameState[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetProfileNameState(
        name: mapValueOfType<String>(json, r'name')!,
        state: ProfileNameModerationState.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<GetProfileNameState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetProfileNameState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetProfileNameState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetProfileNameState> mapFromJson(dynamic json) {
    final map = <String, GetProfileNameState>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileNameState.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetProfileNameState-objects as value to a dart map
  static Map<String, List<GetProfileNameState>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetProfileNameState>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetProfileNameState.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'state',
  };
}

