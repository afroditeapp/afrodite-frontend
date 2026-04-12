//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateProfileContentResult {
  /// Returns a new [UpdateProfileContentResult] instance.
  UpdateProfileContentResult({
    this.error = false,
    this.errorContentAtIndexDoesNotExist,
  });

  bool error;

  int? errorContentAtIndexDoesNotExist;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateProfileContentResult &&
    other.error == error &&
    other.errorContentAtIndexDoesNotExist == errorContentAtIndexDoesNotExist;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (error.hashCode) +
    (errorContentAtIndexDoesNotExist == null ? 0 : errorContentAtIndexDoesNotExist!.hashCode);

  @override
  String toString() => 'UpdateProfileContentResult[error=$error, errorContentAtIndexDoesNotExist=$errorContentAtIndexDoesNotExist]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error'] = this.error;
    if (this.errorContentAtIndexDoesNotExist != null) {
      json[r'error_content_at_index_does_not_exist'] = this.errorContentAtIndexDoesNotExist;
    } else {
      json[r'error_content_at_index_does_not_exist'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateProfileContentResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateProfileContentResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateProfileContentResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateProfileContentResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateProfileContentResult(
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorContentAtIndexDoesNotExist: mapValueOfType<int>(json, r'error_content_at_index_does_not_exist'),
      );
    }
    return null;
  }

  static List<UpdateProfileContentResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProfileContentResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProfileContentResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateProfileContentResult> mapFromJson(dynamic json) {
    final map = <String, UpdateProfileContentResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateProfileContentResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateProfileContentResult-objects as value to a dart map
  static Map<String, List<UpdateProfileContentResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateProfileContentResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateProfileContentResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

