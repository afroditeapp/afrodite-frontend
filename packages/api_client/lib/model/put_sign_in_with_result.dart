//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PutSignInWithResult {
  /// Returns a new [PutSignInWithResult] instance.
  PutSignInWithResult({
    this.error = false,
    this.errorHistoryLimitReached = false,
  });

  bool error;

  bool errorHistoryLimitReached;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PutSignInWithResult &&
    other.error == error &&
    other.errorHistoryLimitReached == errorHistoryLimitReached;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (error.hashCode) +
    (errorHistoryLimitReached.hashCode);

  @override
  String toString() => 'PutSignInWithResult[error=$error, errorHistoryLimitReached=$errorHistoryLimitReached]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error'] = this.error;
      json[r'error_history_limit_reached'] = this.errorHistoryLimitReached;
    return json;
  }

  /// Returns a new [PutSignInWithResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PutSignInWithResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return PutSignInWithResult(
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorHistoryLimitReached: mapValueOfType<bool>(json, r'error_history_limit_reached') ?? false,
      );
    }
    return null;
  }

  static List<PutSignInWithResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PutSignInWithResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PutSignInWithResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PutSignInWithResult> mapFromJson(dynamic json) {
    final map = <String, PutSignInWithResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PutSignInWithResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PutSignInWithResult-objects as value to a dart map
  static Map<String, List<PutSignInWithResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PutSignInWithResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PutSignInWithResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

