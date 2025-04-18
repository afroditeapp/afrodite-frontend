//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAppNotificationSettings {
  /// Returns a new [ProfileAppNotificationSettings] instance.
  ProfileAppNotificationSettings({
    required this.automaticProfileSearch,
    required this.automaticProfileSearchDistance,
    required this.automaticProfileSearchFilters,
    required this.automaticProfileSearchNewProfiles,
    required this.automaticProfileSearchWeekdays,
    required this.profileTextModeration,
  });

  bool automaticProfileSearch;

  bool automaticProfileSearchDistance;

  bool automaticProfileSearchFilters;

  bool automaticProfileSearchNewProfiles;

  /// Selected weekdays.  The integer is a bitflag.  - const MONDAY = 0x1; - const TUESDAY = 0x2; - const WEDNESDAY = 0x4; - const THURSDAY = 0x8; - const FRIDAY = 0x10; - const SATURDAY = 0x20; - const SUNDAY = 0x40; 
  int automaticProfileSearchWeekdays;

  bool profileTextModeration;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAppNotificationSettings &&
    other.automaticProfileSearch == automaticProfileSearch &&
    other.automaticProfileSearchDistance == automaticProfileSearchDistance &&
    other.automaticProfileSearchFilters == automaticProfileSearchFilters &&
    other.automaticProfileSearchNewProfiles == automaticProfileSearchNewProfiles &&
    other.automaticProfileSearchWeekdays == automaticProfileSearchWeekdays &&
    other.profileTextModeration == profileTextModeration;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (automaticProfileSearch.hashCode) +
    (automaticProfileSearchDistance.hashCode) +
    (automaticProfileSearchFilters.hashCode) +
    (automaticProfileSearchNewProfiles.hashCode) +
    (automaticProfileSearchWeekdays.hashCode) +
    (profileTextModeration.hashCode);

  @override
  String toString() => 'ProfileAppNotificationSettings[automaticProfileSearch=$automaticProfileSearch, automaticProfileSearchDistance=$automaticProfileSearchDistance, automaticProfileSearchFilters=$automaticProfileSearchFilters, automaticProfileSearchNewProfiles=$automaticProfileSearchNewProfiles, automaticProfileSearchWeekdays=$automaticProfileSearchWeekdays, profileTextModeration=$profileTextModeration]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'automatic_profile_search'] = this.automaticProfileSearch;
      json[r'automatic_profile_search_distance'] = this.automaticProfileSearchDistance;
      json[r'automatic_profile_search_filters'] = this.automaticProfileSearchFilters;
      json[r'automatic_profile_search_new_profiles'] = this.automaticProfileSearchNewProfiles;
      json[r'automatic_profile_search_weekdays'] = this.automaticProfileSearchWeekdays;
      json[r'profile_text_moderation'] = this.profileTextModeration;
    return json;
  }

  /// Returns a new [ProfileAppNotificationSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAppNotificationSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAppNotificationSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAppNotificationSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAppNotificationSettings(
        automaticProfileSearch: mapValueOfType<bool>(json, r'automatic_profile_search')!,
        automaticProfileSearchDistance: mapValueOfType<bool>(json, r'automatic_profile_search_distance')!,
        automaticProfileSearchFilters: mapValueOfType<bool>(json, r'automatic_profile_search_filters')!,
        automaticProfileSearchNewProfiles: mapValueOfType<bool>(json, r'automatic_profile_search_new_profiles')!,
        automaticProfileSearchWeekdays: mapValueOfType<int>(json, r'automatic_profile_search_weekdays')!,
        profileTextModeration: mapValueOfType<bool>(json, r'profile_text_moderation')!,
      );
    }
    return null;
  }

  static List<ProfileAppNotificationSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAppNotificationSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAppNotificationSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAppNotificationSettings> mapFromJson(dynamic json) {
    final map = <String, ProfileAppNotificationSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAppNotificationSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAppNotificationSettings-objects as value to a dart map
  static Map<String, List<ProfileAppNotificationSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAppNotificationSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAppNotificationSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'automatic_profile_search',
    'automatic_profile_search_distance',
    'automatic_profile_search_filters',
    'automatic_profile_search_new_profiles',
    'automatic_profile_search_weekdays',
    'profile_text_moderation',
  };
}

