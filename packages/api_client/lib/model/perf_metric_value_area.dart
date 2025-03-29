//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PerfMetricValueArea {
  /// Returns a new [PerfMetricValueArea] instance.
  PerfMetricValueArea({
    required this.firstTimeValue,
    required this.timeGranularity,
    this.values = const [],
  });

  /// Time value for the first data point. Every next time value is increased with [Self::time_granularity].
  UnixTime firstTimeValue;

  /// Time granularity for values in between start time and time points.
  TimeGranularity timeGranularity;

  List<int> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PerfMetricValueArea &&
    other.firstTimeValue == firstTimeValue &&
    other.timeGranularity == timeGranularity &&
    _deepEquality.equals(other.values, values);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (firstTimeValue.hashCode) +
    (timeGranularity.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'PerfMetricValueArea[firstTimeValue=$firstTimeValue, timeGranularity=$timeGranularity, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'first_time_value'] = this.firstTimeValue;
      json[r'time_granularity'] = this.timeGranularity;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [PerfMetricValueArea] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PerfMetricValueArea? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PerfMetricValueArea[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PerfMetricValueArea[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PerfMetricValueArea(
        firstTimeValue: UnixTime.fromJson(json[r'first_time_value'])!,
        timeGranularity: TimeGranularity.fromJson(json[r'time_granularity'])!,
        values: json[r'values'] is Iterable
            ? (json[r'values'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<PerfMetricValueArea> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PerfMetricValueArea>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PerfMetricValueArea.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PerfMetricValueArea> mapFromJson(dynamic json) {
    final map = <String, PerfMetricValueArea>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PerfMetricValueArea.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PerfMetricValueArea-objects as value to a dart map
  static Map<String, List<PerfMetricValueArea>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PerfMetricValueArea>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PerfMetricValueArea.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'first_time_value',
    'time_granularity',
    'values',
  };
}

