//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MaintenanceTask {
  /// Returns a new [MaintenanceTask] instance.
  MaintenanceTask({
    required this.notifyBackend,
    required this.time,
  });

  bool notifyBackend;

  UnixTime time;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MaintenanceTask &&
    other.notifyBackend == notifyBackend &&
    other.time == time;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (notifyBackend.hashCode) +
    (time.hashCode);

  @override
  String toString() => 'MaintenanceTask[notifyBackend=$notifyBackend, time=$time]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'notify_backend'] = this.notifyBackend;
      json[r'time'] = this.time;
    return json;
  }

  /// Returns a new [MaintenanceTask] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MaintenanceTask? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MaintenanceTask[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MaintenanceTask[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MaintenanceTask(
        notifyBackend: mapValueOfType<bool>(json, r'notify_backend')!,
        time: UnixTime.fromJson(json[r'time'])!,
      );
    }
    return null;
  }

  static List<MaintenanceTask> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MaintenanceTask>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MaintenanceTask.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MaintenanceTask> mapFromJson(dynamic json) {
    final map = <String, MaintenanceTask>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MaintenanceTask.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MaintenanceTask-objects as value to a dart map
  static Map<String, List<MaintenanceTask>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MaintenanceTask>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MaintenanceTask.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'notify_backend',
    'time',
  };
}

