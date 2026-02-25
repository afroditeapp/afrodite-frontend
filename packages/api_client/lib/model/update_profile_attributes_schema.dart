//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateProfileAttributesSchema {
  /// Returns a new [UpdateProfileAttributesSchema] instance.
  UpdateProfileAttributesSchema({
    required this.currentState,
    required this.newState,
  });

  ProfileAttributesSchemaExport currentState;

  ProfileAttributesSchemaExport newState;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateProfileAttributesSchema &&
    other.currentState == currentState &&
    other.newState == newState;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (currentState.hashCode) +
    (newState.hashCode);

  @override
  String toString() => 'UpdateProfileAttributesSchema[currentState=$currentState, newState=$newState]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'current_state'] = this.currentState;
      json[r'new_state'] = this.newState;
    return json;
  }

  /// Returns a new [UpdateProfileAttributesSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateProfileAttributesSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateProfileAttributesSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateProfileAttributesSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateProfileAttributesSchema(
        currentState: ProfileAttributesSchemaExport.fromJson(json[r'current_state'])!,
        newState: ProfileAttributesSchemaExport.fromJson(json[r'new_state'])!,
      );
    }
    return null;
  }

  static List<UpdateProfileAttributesSchema> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProfileAttributesSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProfileAttributesSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateProfileAttributesSchema> mapFromJson(dynamic json) {
    final map = <String, UpdateProfileAttributesSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateProfileAttributesSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateProfileAttributesSchema-objects as value to a dart map
  static Map<String, List<UpdateProfileAttributesSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateProfileAttributesSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateProfileAttributesSchema.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'current_state',
    'new_state',
  };
}

