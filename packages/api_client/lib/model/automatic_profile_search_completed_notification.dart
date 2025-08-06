//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AutomaticProfileSearchCompletedNotification {
  /// Returns a new [AutomaticProfileSearchCompletedNotification] instance.
  AutomaticProfileSearchCompletedNotification({
    required this.profileCount,
    required this.profilesFound,
  });

  int profileCount;

  NotificationStatus profilesFound;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AutomaticProfileSearchCompletedNotification &&
    other.profileCount == profileCount &&
    other.profilesFound == profilesFound;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileCount.hashCode) +
    (profilesFound.hashCode);

  @override
  String toString() => 'AutomaticProfileSearchCompletedNotification[profileCount=$profileCount, profilesFound=$profilesFound]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profile_count'] = this.profileCount;
      json[r'profiles_found'] = this.profilesFound;
    return json;
  }

  /// Returns a new [AutomaticProfileSearchCompletedNotification] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AutomaticProfileSearchCompletedNotification? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AutomaticProfileSearchCompletedNotification[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AutomaticProfileSearchCompletedNotification[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AutomaticProfileSearchCompletedNotification(
        profileCount: mapValueOfType<int>(json, r'profile_count')!,
        profilesFound: NotificationStatus.fromJson(json[r'profiles_found'])!,
      );
    }
    return null;
  }

  static List<AutomaticProfileSearchCompletedNotification> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AutomaticProfileSearchCompletedNotification>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AutomaticProfileSearchCompletedNotification.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AutomaticProfileSearchCompletedNotification> mapFromJson(dynamic json) {
    final map = <String, AutomaticProfileSearchCompletedNotification>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AutomaticProfileSearchCompletedNotification.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AutomaticProfileSearchCompletedNotification-objects as value to a dart map
  static Map<String, List<AutomaticProfileSearchCompletedNotification>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AutomaticProfileSearchCompletedNotification>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AutomaticProfileSearchCompletedNotification.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile_count',
    'profiles_found',
  };
}

