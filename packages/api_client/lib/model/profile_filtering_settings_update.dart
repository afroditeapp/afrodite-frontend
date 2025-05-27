//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileFilteringSettingsUpdate {
  /// Returns a new [ProfileFilteringSettingsUpdate] instance.
  ProfileFilteringSettingsUpdate({
    this.filters = const [],
    this.lastSeenTimeFilter,
    this.maxDistanceKmFilter,
    this.minDistanceKmFilter,
    this.profileCreatedFilter,
    this.profileEditedFilter,
    this.profileTextMaxCharactersFilter,
    this.profileTextMinCharactersFilter,
    this.randomProfileOrder = false,
    this.unlimitedLikesFilter,
  });

  List<ProfileAttributeFilterValueUpdate> filters;

  LastSeenTimeFilter? lastSeenTimeFilter;

  MaxDistanceKm? maxDistanceKmFilter;

  MinDistanceKm? minDistanceKmFilter;

  ProfileCreatedTimeFilter? profileCreatedFilter;

  ProfileEditedTimeFilter? profileEditedFilter;

  ProfileTextMaxCharactersFilter? profileTextMaxCharactersFilter;

  ProfileTextMinCharactersFilter? profileTextMinCharactersFilter;

  bool randomProfileOrder;

  bool? unlimitedLikesFilter;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileFilteringSettingsUpdate &&
    _deepEquality.equals(other.filters, filters) &&
    other.lastSeenTimeFilter == lastSeenTimeFilter &&
    other.maxDistanceKmFilter == maxDistanceKmFilter &&
    other.minDistanceKmFilter == minDistanceKmFilter &&
    other.profileCreatedFilter == profileCreatedFilter &&
    other.profileEditedFilter == profileEditedFilter &&
    other.profileTextMaxCharactersFilter == profileTextMaxCharactersFilter &&
    other.profileTextMinCharactersFilter == profileTextMinCharactersFilter &&
    other.randomProfileOrder == randomProfileOrder &&
    other.unlimitedLikesFilter == unlimitedLikesFilter;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (filters.hashCode) +
    (lastSeenTimeFilter == null ? 0 : lastSeenTimeFilter!.hashCode) +
    (maxDistanceKmFilter == null ? 0 : maxDistanceKmFilter!.hashCode) +
    (minDistanceKmFilter == null ? 0 : minDistanceKmFilter!.hashCode) +
    (profileCreatedFilter == null ? 0 : profileCreatedFilter!.hashCode) +
    (profileEditedFilter == null ? 0 : profileEditedFilter!.hashCode) +
    (profileTextMaxCharactersFilter == null ? 0 : profileTextMaxCharactersFilter!.hashCode) +
    (profileTextMinCharactersFilter == null ? 0 : profileTextMinCharactersFilter!.hashCode) +
    (randomProfileOrder.hashCode) +
    (unlimitedLikesFilter == null ? 0 : unlimitedLikesFilter!.hashCode);

  @override
  String toString() => 'ProfileFilteringSettingsUpdate[filters=$filters, lastSeenTimeFilter=$lastSeenTimeFilter, maxDistanceKmFilter=$maxDistanceKmFilter, minDistanceKmFilter=$minDistanceKmFilter, profileCreatedFilter=$profileCreatedFilter, profileEditedFilter=$profileEditedFilter, profileTextMaxCharactersFilter=$profileTextMaxCharactersFilter, profileTextMinCharactersFilter=$profileTextMinCharactersFilter, randomProfileOrder=$randomProfileOrder, unlimitedLikesFilter=$unlimitedLikesFilter]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'filters'] = this.filters;
    if (this.lastSeenTimeFilter != null) {
      json[r'last_seen_time_filter'] = this.lastSeenTimeFilter;
    } else {
      json[r'last_seen_time_filter'] = null;
    }
    if (this.maxDistanceKmFilter != null) {
      json[r'max_distance_km_filter'] = this.maxDistanceKmFilter;
    } else {
      json[r'max_distance_km_filter'] = null;
    }
    if (this.minDistanceKmFilter != null) {
      json[r'min_distance_km_filter'] = this.minDistanceKmFilter;
    } else {
      json[r'min_distance_km_filter'] = null;
    }
    if (this.profileCreatedFilter != null) {
      json[r'profile_created_filter'] = this.profileCreatedFilter;
    } else {
      json[r'profile_created_filter'] = null;
    }
    if (this.profileEditedFilter != null) {
      json[r'profile_edited_filter'] = this.profileEditedFilter;
    } else {
      json[r'profile_edited_filter'] = null;
    }
    if (this.profileTextMaxCharactersFilter != null) {
      json[r'profile_text_max_characters_filter'] = this.profileTextMaxCharactersFilter;
    } else {
      json[r'profile_text_max_characters_filter'] = null;
    }
    if (this.profileTextMinCharactersFilter != null) {
      json[r'profile_text_min_characters_filter'] = this.profileTextMinCharactersFilter;
    } else {
      json[r'profile_text_min_characters_filter'] = null;
    }
      json[r'random_profile_order'] = this.randomProfileOrder;
    if (this.unlimitedLikesFilter != null) {
      json[r'unlimited_likes_filter'] = this.unlimitedLikesFilter;
    } else {
      json[r'unlimited_likes_filter'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileFilteringSettingsUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileFilteringSettingsUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileFilteringSettingsUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileFilteringSettingsUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileFilteringSettingsUpdate(
        filters: ProfileAttributeFilterValueUpdate.listFromJson(json[r'filters']),
        lastSeenTimeFilter: LastSeenTimeFilter.fromJson(json[r'last_seen_time_filter']),
        maxDistanceKmFilter: MaxDistanceKm.fromJson(json[r'max_distance_km_filter']),
        minDistanceKmFilter: MinDistanceKm.fromJson(json[r'min_distance_km_filter']),
        profileCreatedFilter: ProfileCreatedTimeFilter.fromJson(json[r'profile_created_filter']),
        profileEditedFilter: ProfileEditedTimeFilter.fromJson(json[r'profile_edited_filter']),
        profileTextMaxCharactersFilter: ProfileTextMaxCharactersFilter.fromJson(json[r'profile_text_max_characters_filter']),
        profileTextMinCharactersFilter: ProfileTextMinCharactersFilter.fromJson(json[r'profile_text_min_characters_filter']),
        randomProfileOrder: mapValueOfType<bool>(json, r'random_profile_order') ?? false,
        unlimitedLikesFilter: mapValueOfType<bool>(json, r'unlimited_likes_filter'),
      );
    }
    return null;
  }

  static List<ProfileFilteringSettingsUpdate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileFilteringSettingsUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileFilteringSettingsUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileFilteringSettingsUpdate> mapFromJson(dynamic json) {
    final map = <String, ProfileFilteringSettingsUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileFilteringSettingsUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileFilteringSettingsUpdate-objects as value to a dart map
  static Map<String, List<ProfileFilteringSettingsUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileFilteringSettingsUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileFilteringSettingsUpdate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'filters',
  };
}

