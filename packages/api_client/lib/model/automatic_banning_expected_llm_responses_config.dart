//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AutomaticBanningExpectedLlmResponsesConfig {
  /// Returns a new [AutomaticBanningExpectedLlmResponsesConfig] instance.
  AutomaticBanningExpectedLlmResponsesConfig({
    required this.high,
    required this.low,
    required this.medium,
  });

  String high;

  String low;

  String medium;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AutomaticBanningExpectedLlmResponsesConfig &&
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
  String toString() => 'AutomaticBanningExpectedLlmResponsesConfig[high=$high, low=$low, medium=$medium]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'high'] = this.high;
      json[r'low'] = this.low;
      json[r'medium'] = this.medium;
    return json;
  }

  /// Returns a new [AutomaticBanningExpectedLlmResponsesConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AutomaticBanningExpectedLlmResponsesConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'high'), 'Required key "AutomaticBanningExpectedLlmResponsesConfig[high]" is missing from JSON.');
        assert(json[r'high'] != null, 'Required key "AutomaticBanningExpectedLlmResponsesConfig[high]" has a null value in JSON.');
        assert(json.containsKey(r'low'), 'Required key "AutomaticBanningExpectedLlmResponsesConfig[low]" is missing from JSON.');
        assert(json[r'low'] != null, 'Required key "AutomaticBanningExpectedLlmResponsesConfig[low]" has a null value in JSON.');
        assert(json.containsKey(r'medium'), 'Required key "AutomaticBanningExpectedLlmResponsesConfig[medium]" is missing from JSON.');
        assert(json[r'medium'] != null, 'Required key "AutomaticBanningExpectedLlmResponsesConfig[medium]" has a null value in JSON.');
        return true;
      }());

      return AutomaticBanningExpectedLlmResponsesConfig(
        high: mapValueOfType<String>(json, r'high')!,
        low: mapValueOfType<String>(json, r'low')!,
        medium: mapValueOfType<String>(json, r'medium')!,
      );
    }
    return null;
  }

  static List<AutomaticBanningExpectedLlmResponsesConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AutomaticBanningExpectedLlmResponsesConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AutomaticBanningExpectedLlmResponsesConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AutomaticBanningExpectedLlmResponsesConfig> mapFromJson(dynamic json) {
    final map = <String, AutomaticBanningExpectedLlmResponsesConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AutomaticBanningExpectedLlmResponsesConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AutomaticBanningExpectedLlmResponsesConfig-objects as value to a dart map
  static Map<String, List<AutomaticBanningExpectedLlmResponsesConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AutomaticBanningExpectedLlmResponsesConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AutomaticBanningExpectedLlmResponsesConfig.listFromJson(entry.value, growable: growable,);
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

