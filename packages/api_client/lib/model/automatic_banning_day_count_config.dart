//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AutomaticBanningDayCountConfig {
  /// Returns a new [AutomaticBanningDayCountConfig] instance.
  AutomaticBanningDayCountConfig({
    required this.high,
    required this.low,
    required this.medium,
  });

  /// Minimum value: 0
  int high;

  /// Minimum value: 0
  int low;

  /// Minimum value: 0
  int medium;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AutomaticBanningDayCountConfig &&
    other.high == high &&
    other.low == low &&
    other.medium == medium;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (high.hashCode) +
    (low.hashCode) +
    (medium.hashCode);

  @override
  String toString() => 'AutomaticBanningDayCountConfig[high=$high, low=$low, medium=$medium]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'high'] = this.high;
      json[r'low'] = this.low;
      json[r'medium'] = this.medium;
    return json;
  }

  /// Returns a new [AutomaticBanningDayCountConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AutomaticBanningDayCountConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AutomaticBanningDayCountConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AutomaticBanningDayCountConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AutomaticBanningDayCountConfig(
        high: mapValueOfType<int>(json, r'high')!,
        low: mapValueOfType<int>(json, r'low')!,
        medium: mapValueOfType<int>(json, r'medium')!,
      );
    }
    return null;
  }

  static List<AutomaticBanningDayCountConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AutomaticBanningDayCountConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AutomaticBanningDayCountConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AutomaticBanningDayCountConfig> mapFromJson(dynamic json) {
    final map = <String, AutomaticBanningDayCountConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AutomaticBanningDayCountConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AutomaticBanningDayCountConfig-objects as value to a dart map
  static Map<String, List<AutomaticBanningDayCountConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AutomaticBanningDayCountConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AutomaticBanningDayCountConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'high',
    'low',
    'medium',
  };
}

