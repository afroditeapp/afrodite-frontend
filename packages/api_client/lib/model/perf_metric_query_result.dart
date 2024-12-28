//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PerfMetricQueryResult {
  /// Returns a new [PerfMetricQueryResult] instance.
  PerfMetricQueryResult({
    this.metrics = const [],
  });

  List<PerfMetricValues> metrics;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PerfMetricQueryResult &&
    _deepEquality.equals(other.metrics, metrics);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (metrics.hashCode);

  @override
  String toString() => 'PerfMetricQueryResult[metrics=$metrics]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'metrics'] = this.metrics;
    return json;
  }

  /// Returns a new [PerfMetricQueryResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PerfMetricQueryResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PerfMetricQueryResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PerfMetricQueryResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PerfMetricQueryResult(
        metrics: PerfMetricValues.listFromJson(json[r'metrics']),
      );
    }
    return null;
  }

  static List<PerfMetricQueryResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PerfMetricQueryResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PerfMetricQueryResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PerfMetricQueryResult> mapFromJson(dynamic json) {
    final map = <String, PerfMetricQueryResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PerfMetricQueryResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PerfMetricQueryResult-objects as value to a dart map
  static Map<String, List<PerfMetricQueryResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PerfMetricQueryResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PerfMetricQueryResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'metrics',
  };
}
