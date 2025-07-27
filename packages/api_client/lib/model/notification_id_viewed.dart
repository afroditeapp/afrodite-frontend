//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NotificationIdViewed {
  /// Returns a new [NotificationIdViewed] instance.
  NotificationIdViewed({
    required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NotificationIdViewed &&
    other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode);

  @override
  String toString() => 'NotificationIdViewed[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
    return json;
  }

  /// Returns a new [NotificationIdViewed] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NotificationIdViewed? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NotificationIdViewed[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NotificationIdViewed[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NotificationIdViewed(
        id: mapValueOfType<int>(json, r'id')!,
      );
    }
    return null;
  }

  static List<NotificationIdViewed> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NotificationIdViewed>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NotificationIdViewed.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NotificationIdViewed> mapFromJson(dynamic json) {
    final map = <String, NotificationIdViewed>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NotificationIdViewed.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NotificationIdViewed-objects as value to a dart map
  static Map<String, List<NotificationIdViewed>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NotificationIdViewed>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NotificationIdViewed.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
  };
}

