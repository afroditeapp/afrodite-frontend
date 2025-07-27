//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AutomaticProfileSearchCompletedNotificationViewed {
  /// Returns a new [AutomaticProfileSearchCompletedNotificationViewed] instance.
  AutomaticProfileSearchCompletedNotificationViewed({
    required this.profilesFound,
  });

  NotificationIdViewed profilesFound;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AutomaticProfileSearchCompletedNotificationViewed &&
    other.profilesFound == profilesFound;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profilesFound.hashCode);

  @override
  String toString() => 'AutomaticProfileSearchCompletedNotificationViewed[profilesFound=$profilesFound]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profiles_found'] = this.profilesFound;
    return json;
  }

  /// Returns a new [AutomaticProfileSearchCompletedNotificationViewed] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AutomaticProfileSearchCompletedNotificationViewed? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AutomaticProfileSearchCompletedNotificationViewed[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AutomaticProfileSearchCompletedNotificationViewed[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AutomaticProfileSearchCompletedNotificationViewed(
        profilesFound: NotificationIdViewed.fromJson(json[r'profiles_found'])!,
      );
    }
    return null;
  }

  static List<AutomaticProfileSearchCompletedNotificationViewed> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AutomaticProfileSearchCompletedNotificationViewed>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AutomaticProfileSearchCompletedNotificationViewed.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AutomaticProfileSearchCompletedNotificationViewed> mapFromJson(dynamic json) {
    final map = <String, AutomaticProfileSearchCompletedNotificationViewed>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AutomaticProfileSearchCompletedNotificationViewed.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AutomaticProfileSearchCompletedNotificationViewed-objects as value to a dart map
  static Map<String, List<AutomaticProfileSearchCompletedNotificationViewed>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AutomaticProfileSearchCompletedNotificationViewed>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AutomaticProfileSearchCompletedNotificationViewed.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profiles_found',
  };
}

