//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PerfValueArea {
  /// Returns a new [PerfValueArea] instance.
  PerfValueArea({
    required this.startTime,
    required this.timeGranularity,
    this.values = const [],
  });

  UnixTime startTime;

  TimeGranularity timeGranularity;

  List<int> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PerfValueArea &&
     other.startTime == startTime &&
     other.timeGranularity == timeGranularity &&
     other.values == values;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (startTime.hashCode) +
    (timeGranularity.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'PerfValueArea[startTime=$startTime, timeGranularity=$timeGranularity, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'start_time'] = this.startTime;
      json[r'time_granularity'] = this.timeGranularity;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [PerfValueArea] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PerfValueArea? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PerfValueArea[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PerfValueArea[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PerfValueArea(
        startTime: UnixTime.fromJson(json[r'start_time'])!,
        timeGranularity: TimeGranularity.fromJson(json[r'time_granularity'])!,
        values: json[r'values'] is List
            ? (json[r'values'] as List).cast<int>()
            : const [],
      );
    }
    return null;
  }

  static List<PerfValueArea>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PerfValueArea>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PerfValueArea.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PerfValueArea> mapFromJson(dynamic json) {
    final map = <String, PerfValueArea>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PerfValueArea.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PerfValueArea-objects as value to a dart map
  static Map<String, List<PerfValueArea>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PerfValueArea>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PerfValueArea.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'start_time',
    'time_granularity',
    'values',
  };
}

