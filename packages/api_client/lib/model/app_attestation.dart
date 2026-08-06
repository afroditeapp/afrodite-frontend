//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AppAttestation {
  /// Returns a new [AppAttestation] instance.
  AppAttestation({
    this.debug,
  });

  DebugAppAttestation? debug;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppAttestation &&
    other.debug == debug;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (debug == null ? 0 : debug!.hashCode);

  @override
  String toString() => 'AppAttestation[debug=$debug]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.debug != null) {
      json[r'debug'] = this.debug;
    } else {
      json[r'debug'] = null;
    }
    return json;
  }

  /// Returns a new [AppAttestation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppAttestation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AppAttestation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AppAttestation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AppAttestation(
        debug: DebugAppAttestation.fromJson(json[r'debug']),
      );
    }
    return null;
  }

  static List<AppAttestation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AppAttestation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppAttestation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppAttestation> mapFromJson(dynamic json) {
    final map = <String, AppAttestation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppAttestation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppAttestation-objects as value to a dart map
  static Map<String, List<AppAttestation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AppAttestation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppAttestation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

