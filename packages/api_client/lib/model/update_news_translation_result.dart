//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateNewsTranslationResult {
  /// Returns a new [UpdateNewsTranslationResult] instance.
  UpdateNewsTranslationResult({
    this.errorAlreadyChanged = false,
  });

  bool errorAlreadyChanged;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateNewsTranslationResult &&
    other.errorAlreadyChanged == errorAlreadyChanged;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (errorAlreadyChanged.hashCode);

  @override
  String toString() => 'UpdateNewsTranslationResult[errorAlreadyChanged=$errorAlreadyChanged]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error_already_changed'] = this.errorAlreadyChanged;
    return json;
  }

  /// Returns a new [UpdateNewsTranslationResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateNewsTranslationResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateNewsTranslationResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateNewsTranslationResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateNewsTranslationResult(
        errorAlreadyChanged: mapValueOfType<bool>(json, r'error_already_changed') ?? false,
      );
    }
    return null;
  }

  static List<UpdateNewsTranslationResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateNewsTranslationResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateNewsTranslationResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateNewsTranslationResult> mapFromJson(dynamic json) {
    final map = <String, UpdateNewsTranslationResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateNewsTranslationResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateNewsTranslationResult-objects as value to a dart map
  static Map<String, List<UpdateNewsTranslationResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateNewsTranslationResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateNewsTranslationResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

