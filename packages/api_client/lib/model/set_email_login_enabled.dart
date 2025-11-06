//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetEmailLoginEnabled {
  /// Returns a new [SetEmailLoginEnabled] instance.
  SetEmailLoginEnabled({
    required this.aid,
    required this.enabled,
  });

  AccountId aid;

  bool enabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetEmailLoginEnabled &&
    other.aid == aid &&
    other.enabled == enabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aid.hashCode) +
    (enabled.hashCode);

  @override
  String toString() => 'SetEmailLoginEnabled[aid=$aid, enabled=$enabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'aid'] = this.aid;
      json[r'enabled'] = this.enabled;
    return json;
  }

  /// Returns a new [SetEmailLoginEnabled] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetEmailLoginEnabled? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetEmailLoginEnabled[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetEmailLoginEnabled[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetEmailLoginEnabled(
        aid: AccountId.fromJson(json[r'aid'])!,
        enabled: mapValueOfType<bool>(json, r'enabled')!,
      );
    }
    return null;
  }

  static List<SetEmailLoginEnabled> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetEmailLoginEnabled>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetEmailLoginEnabled.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetEmailLoginEnabled> mapFromJson(dynamic json) {
    final map = <String, SetEmailLoginEnabled>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetEmailLoginEnabled.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetEmailLoginEnabled-objects as value to a dart map
  static Map<String, List<SetEmailLoginEnabled>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetEmailLoginEnabled>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetEmailLoginEnabled.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'aid',
    'enabled',
  };
}

