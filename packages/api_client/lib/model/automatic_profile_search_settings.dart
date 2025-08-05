//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AutomaticProfileSearchSettings {
  /// Returns a new [AutomaticProfileSearchSettings] instance.
  AutomaticProfileSearchSettings({
    required this.attributeFilters,
    required this.distanceFilters,
    required this.newProfiles,
    required this.weekdays,
  });

  bool attributeFilters;

  bool distanceFilters;

  bool newProfiles;

  /// Selected weekdays.  The integer is a bitflag.  - const MONDAY = 0x1; - const TUESDAY = 0x2; - const WEDNESDAY = 0x4; - const THURSDAY = 0x8; - const FRIDAY = 0x10; - const SATURDAY = 0x20; - const SUNDAY = 0x40; 
  int weekdays;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AutomaticProfileSearchSettings &&
    other.attributeFilters == attributeFilters &&
    other.distanceFilters == distanceFilters &&
    other.newProfiles == newProfiles &&
    other.weekdays == weekdays;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (attributeFilters.hashCode) +
    (distanceFilters.hashCode) +
    (newProfiles.hashCode) +
    (weekdays.hashCode);

  @override
  String toString() => 'AutomaticProfileSearchSettings[attributeFilters=$attributeFilters, distanceFilters=$distanceFilters, newProfiles=$newProfiles, weekdays=$weekdays]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'attribute_filters'] = this.attributeFilters;
      json[r'distance_filters'] = this.distanceFilters;
      json[r'new_profiles'] = this.newProfiles;
      json[r'weekdays'] = this.weekdays;
    return json;
  }

  /// Returns a new [AutomaticProfileSearchSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AutomaticProfileSearchSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AutomaticProfileSearchSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AutomaticProfileSearchSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AutomaticProfileSearchSettings(
        attributeFilters: mapValueOfType<bool>(json, r'attribute_filters')!,
        distanceFilters: mapValueOfType<bool>(json, r'distance_filters')!,
        newProfiles: mapValueOfType<bool>(json, r'new_profiles')!,
        weekdays: mapValueOfType<int>(json, r'weekdays')!,
      );
    }
    return null;
  }

  static List<AutomaticProfileSearchSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AutomaticProfileSearchSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AutomaticProfileSearchSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AutomaticProfileSearchSettings> mapFromJson(dynamic json) {
    final map = <String, AutomaticProfileSearchSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AutomaticProfileSearchSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AutomaticProfileSearchSettings-objects as value to a dart map
  static Map<String, List<AutomaticProfileSearchSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AutomaticProfileSearchSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AutomaticProfileSearchSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'attribute_filters',
    'distance_filters',
    'new_profiles',
    'weekdays',
  };
}

