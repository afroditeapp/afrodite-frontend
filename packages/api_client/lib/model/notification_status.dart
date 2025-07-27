//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NotificationStatus {
  /// Returns a new [NotificationStatus] instance.
  NotificationStatus({
    required this.id,
    required this.viewed,
  });

  NotificationId id;

  NotificationIdViewed viewed;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NotificationStatus &&
    other.id == id &&
    other.viewed == viewed;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (viewed.hashCode);

  @override
  String toString() => 'NotificationStatus[id=$id, viewed=$viewed]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'viewed'] = this.viewed;
    return json;
  }

  /// Returns a new [NotificationStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NotificationStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NotificationStatus[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NotificationStatus[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NotificationStatus(
        id: NotificationId.fromJson(json[r'id'])!,
        viewed: NotificationIdViewed.fromJson(json[r'viewed'])!,
      );
    }
    return null;
  }

  static List<NotificationStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NotificationStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NotificationStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NotificationStatus> mapFromJson(dynamic json) {
    final map = <String, NotificationStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NotificationStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NotificationStatus-objects as value to a dart map
  static Map<String, List<NotificationStatus>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NotificationStatus>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NotificationStatus.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'viewed',
  };
}

