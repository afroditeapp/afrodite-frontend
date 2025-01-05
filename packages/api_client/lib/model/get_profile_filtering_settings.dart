//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileFilteringSettings {
  /// Returns a new [GetProfileFilteringSettings] instance.
  GetProfileFilteringSettings({
    this.accountCreatedFilter,
    this.filters = const [],
    this.lastSeenTimeFilter,
    this.maxDistanceKmFilter,
    this.profileEditedFilter,
    this.randomProfileOrder = false,
    this.unlimitedLikesFilter,
  });

  AccountCreatedTimeFilter? accountCreatedFilter;

  List<ProfileAttributeFilterValue> filters;

  LastSeenTimeFilter? lastSeenTimeFilter;

  /// Show profiles until this far from current location. The value is in kilometers.  The value must be `None`, 1 or greater number.
  MaxDistanceKm? maxDistanceKmFilter;

  ProfileEditedTimeFilter? profileEditedFilter;

  /// Randomize iterator starting position within the profile index area which current position and [Self::max_distance_km] defines.
  bool randomProfileOrder;

  bool? unlimitedLikesFilter;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileFilteringSettings &&
    other.accountCreatedFilter == accountCreatedFilter &&
    _deepEquality.equals(other.filters, filters) &&
    other.lastSeenTimeFilter == lastSeenTimeFilter &&
    other.maxDistanceKmFilter == maxDistanceKmFilter &&
    other.profileEditedFilter == profileEditedFilter &&
    other.randomProfileOrder == randomProfileOrder &&
    other.unlimitedLikesFilter == unlimitedLikesFilter;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountCreatedFilter == null ? 0 : accountCreatedFilter!.hashCode) +
    (filters.hashCode) +
    (lastSeenTimeFilter == null ? 0 : lastSeenTimeFilter!.hashCode) +
    (maxDistanceKmFilter == null ? 0 : maxDistanceKmFilter!.hashCode) +
    (profileEditedFilter == null ? 0 : profileEditedFilter!.hashCode) +
    (randomProfileOrder.hashCode) +
    (unlimitedLikesFilter == null ? 0 : unlimitedLikesFilter!.hashCode);

  @override
  String toString() => 'GetProfileFilteringSettings[accountCreatedFilter=$accountCreatedFilter, filters=$filters, lastSeenTimeFilter=$lastSeenTimeFilter, maxDistanceKmFilter=$maxDistanceKmFilter, profileEditedFilter=$profileEditedFilter, randomProfileOrder=$randomProfileOrder, unlimitedLikesFilter=$unlimitedLikesFilter]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.accountCreatedFilter != null) {
      json[r'account_created_filter'] = this.accountCreatedFilter;
    } else {
      json[r'account_created_filter'] = null;
    }
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
    if (this.profileEditedFilter != null) {
      json[r'profile_edited_filter'] = this.profileEditedFilter;
    } else {
      json[r'profile_edited_filter'] = null;
    }
      json[r'random_profile_order'] = this.randomProfileOrder;
    if (this.unlimitedLikesFilter != null) {
      json[r'unlimited_likes_filter'] = this.unlimitedLikesFilter;
    } else {
      json[r'unlimited_likes_filter'] = null;
    }
    return json;
  }

  /// Returns a new [GetProfileFilteringSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetProfileFilteringSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetProfileFilteringSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetProfileFilteringSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetProfileFilteringSettings(
        accountCreatedFilter: AccountCreatedTimeFilter.fromJson(json[r'account_created_filter']),
        filters: ProfileAttributeFilterValue.listFromJson(json[r'filters']),
        lastSeenTimeFilter: LastSeenTimeFilter.fromJson(json[r'last_seen_time_filter']),
        maxDistanceKmFilter: MaxDistanceKm.fromJson(json[r'max_distance_km_filter']),
        profileEditedFilter: ProfileEditedTimeFilter.fromJson(json[r'profile_edited_filter']),
        randomProfileOrder: mapValueOfType<bool>(json, r'random_profile_order') ?? false,
        unlimitedLikesFilter: mapValueOfType<bool>(json, r'unlimited_likes_filter'),
      );
    }
    return null;
  }

  static List<GetProfileFilteringSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetProfileFilteringSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetProfileFilteringSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetProfileFilteringSettings> mapFromJson(dynamic json) {
    final map = <String, GetProfileFilteringSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileFilteringSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetProfileFilteringSettings-objects as value to a dart map
  static Map<String, List<GetProfileFilteringSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetProfileFilteringSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetProfileFilteringSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'filters',
  };
}
