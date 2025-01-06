//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PerfMetricValues {
  /// Returns a new [PerfMetricValues] instance.
  PerfMetricValues({
    required this.name,
    this.values = const [],
  });

  String name;

  List<PerfMetricValueArea> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PerfMetricValues &&
    other.name == name &&
    _deepEquality.equals(other.values, values);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'PerfMetricValues[name=$name, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [PerfMetricValues] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PerfMetricValues? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PerfMetricValues[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PerfMetricValues[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PerfMetricValues(
        name: mapValueOfType<String>(json, r'name')!,
        values: PerfMetricValueArea.listFromJson(json[r'values']),
      );
    }
    return null;
  }

  static List<PerfMetricValues> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PerfMetricValues>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PerfMetricValues.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PerfMetricValues> mapFromJson(dynamic json) {
    final map = <String, PerfMetricValues>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PerfMetricValues.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PerfMetricValues-objects as value to a dart map
  static Map<String, List<PerfMetricValues>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PerfMetricValues>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PerfMetricValues.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'values',
  };
}

