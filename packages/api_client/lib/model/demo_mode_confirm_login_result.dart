//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DemoModeConfirmLoginResult {
  /// Returns a new [DemoModeConfirmLoginResult] instance.
  DemoModeConfirmLoginResult({
    required this.locked,
    this.token,
  });

  /// This password is locked.
  bool locked;

  DemoModeToken? token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DemoModeConfirmLoginResult &&
    other.locked == locked &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (locked.hashCode) +
    (token == null ? 0 : token!.hashCode);

  @override
  String toString() => 'DemoModeConfirmLoginResult[locked=$locked, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'locked'] = this.locked;
    if (this.token != null) {
      json[r'token'] = this.token;
    } else {
      json[r'token'] = null;
    }
    return json;
  }

  /// Returns a new [DemoModeConfirmLoginResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DemoModeConfirmLoginResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DemoModeConfirmLoginResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DemoModeConfirmLoginResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DemoModeConfirmLoginResult(
        locked: mapValueOfType<bool>(json, r'locked')!,
        token: DemoModeToken.fromJson(json[r'token']),
      );
    }
    return null;
  }

  static List<DemoModeConfirmLoginResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DemoModeConfirmLoginResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DemoModeConfirmLoginResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DemoModeConfirmLoginResult> mapFromJson(dynamic json) {
    final map = <String, DemoModeConfirmLoginResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DemoModeConfirmLoginResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DemoModeConfirmLoginResult-objects as value to a dart map
  static Map<String, List<DemoModeConfirmLoginResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DemoModeConfirmLoginResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DemoModeConfirmLoginResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'locked',
  };
}

