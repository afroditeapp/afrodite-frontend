//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServerConfig {
  /// Returns a new [ServerConfig] instance.
  ServerConfig({
    this.scheduledTasks,
  });

  ScheduledTasksConfig? scheduledTasks;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServerConfig &&
    other.scheduledTasks == scheduledTasks;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (scheduledTasks == null ? 0 : scheduledTasks!.hashCode);

  @override
  String toString() => 'ServerConfig[scheduledTasks=$scheduledTasks]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.scheduledTasks != null) {
      json[r'scheduled_tasks'] = this.scheduledTasks;
    } else {
      json[r'scheduled_tasks'] = null;
    }
    return json;
  }

  /// Returns a new [ServerConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServerConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ServerConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ServerConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServerConfig(
        scheduledTasks: ScheduledTasksConfig.fromJson(json[r'scheduled_tasks']),
      );
    }
    return null;
  }

  static List<ServerConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ServerConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServerConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServerConfig> mapFromJson(dynamic json) {
    final map = <String, ServerConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServerConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServerConfig-objects as value to a dart map
  static Map<String, List<ServerConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ServerConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ServerConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

