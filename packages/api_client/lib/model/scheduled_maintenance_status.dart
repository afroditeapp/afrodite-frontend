//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ScheduledMaintenanceStatus {
  /// Returns a new [ScheduledMaintenanceStatus] instance.
  ScheduledMaintenanceStatus({
    this.end,
    this.start,
  });

  UnixTime? end;

  /// If None, ignore [Self::end].
  UnixTime? start;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ScheduledMaintenanceStatus &&
    other.end == end &&
    other.start == start;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (end == null ? 0 : end!.hashCode) +
    (start == null ? 0 : start!.hashCode);

  @override
  String toString() => 'ScheduledMaintenanceStatus[end=$end, start=$start]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.end != null) {
      json[r'end'] = this.end;
    } else {
      json[r'end'] = null;
    }
    if (this.start != null) {
      json[r'start'] = this.start;
    } else {
      json[r'start'] = null;
    }
    return json;
  }

  /// Returns a new [ScheduledMaintenanceStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ScheduledMaintenanceStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ScheduledMaintenanceStatus[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ScheduledMaintenanceStatus[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ScheduledMaintenanceStatus(
        end: UnixTime.fromJson(json[r'end']),
        start: UnixTime.fromJson(json[r'start']),
      );
    }
    return null;
  }

  static List<ScheduledMaintenanceStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ScheduledMaintenanceStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ScheduledMaintenanceStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ScheduledMaintenanceStatus> mapFromJson(dynamic json) {
    final map = <String, ScheduledMaintenanceStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ScheduledMaintenanceStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ScheduledMaintenanceStatus-objects as value to a dart map
  static Map<String, List<ScheduledMaintenanceStatus>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ScheduledMaintenanceStatus>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ScheduledMaintenanceStatus.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

