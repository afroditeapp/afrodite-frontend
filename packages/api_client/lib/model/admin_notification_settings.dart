//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminNotificationSettings {
  /// Returns a new [AdminNotificationSettings] instance.
  AdminNotificationSettings({
    required this.dailyEnabledTimeEndSeconds,
    required this.dailyEnabledTimeStartSeconds,
    required this.weekdays,
  });

  int dailyEnabledTimeEndSeconds;

  int dailyEnabledTimeStartSeconds;

  /// Selected weekdays.  The integer is a bitflag.  - const MONDAY = 0x1; - const TUESDAY = 0x2; - const WEDNESDAY = 0x4; - const THURSDAY = 0x8; - const FRIDAY = 0x10; - const SATURDAY = 0x20; - const SUNDAY = 0x40; 
  int weekdays;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminNotificationSettings &&
    other.dailyEnabledTimeEndSeconds == dailyEnabledTimeEndSeconds &&
    other.dailyEnabledTimeStartSeconds == dailyEnabledTimeStartSeconds &&
    other.weekdays == weekdays;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dailyEnabledTimeEndSeconds.hashCode) +
    (dailyEnabledTimeStartSeconds.hashCode) +
    (weekdays.hashCode);

  @override
  String toString() => 'AdminNotificationSettings[dailyEnabledTimeEndSeconds=$dailyEnabledTimeEndSeconds, dailyEnabledTimeStartSeconds=$dailyEnabledTimeStartSeconds, weekdays=$weekdays]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'daily_enabled_time_end_seconds'] = this.dailyEnabledTimeEndSeconds;
      json[r'daily_enabled_time_start_seconds'] = this.dailyEnabledTimeStartSeconds;
      json[r'weekdays'] = this.weekdays;
    return json;
  }

  /// Returns a new [AdminNotificationSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminNotificationSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminNotificationSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminNotificationSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminNotificationSettings(
        dailyEnabledTimeEndSeconds: mapValueOfType<int>(json, r'daily_enabled_time_end_seconds')!,
        dailyEnabledTimeStartSeconds: mapValueOfType<int>(json, r'daily_enabled_time_start_seconds')!,
        weekdays: mapValueOfType<int>(json, r'weekdays')!,
      );
    }
    return null;
  }

  static List<AdminNotificationSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminNotificationSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminNotificationSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminNotificationSettings> mapFromJson(dynamic json) {
    final map = <String, AdminNotificationSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminNotificationSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminNotificationSettings-objects as value to a dart map
  static Map<String, List<AdminNotificationSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminNotificationSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminNotificationSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'daily_enabled_time_end_seconds',
    'daily_enabled_time_start_seconds',
    'weekdays',
  };
}

