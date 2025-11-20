//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ScheduledTasksConfig {
  /// Returns a new [ScheduledTasksConfig] instance.
  ScheduledTasksConfig({
    required this.dailyStartTime,
  });

  /// UTC time value
  String dailyStartTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ScheduledTasksConfig &&
    other.dailyStartTime == dailyStartTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dailyStartTime.hashCode);

  @override
  String toString() => 'ScheduledTasksConfig[dailyStartTime=$dailyStartTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'daily_start_time'] = this.dailyStartTime;
    return json;
  }

  /// Returns a new [ScheduledTasksConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ScheduledTasksConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ScheduledTasksConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ScheduledTasksConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ScheduledTasksConfig(
        dailyStartTime: mapValueOfType<String>(json, r'daily_start_time')!,
      );
    }
    return null;
  }

  static List<ScheduledTasksConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ScheduledTasksConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ScheduledTasksConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ScheduledTasksConfig> mapFromJson(dynamic json) {
    final map = <String, ScheduledTasksConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ScheduledTasksConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ScheduledTasksConfig-objects as value to a dart map
  static Map<String, List<ScheduledTasksConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ScheduledTasksConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ScheduledTasksConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'daily_start_time',
  };
}

