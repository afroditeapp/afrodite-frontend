//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeFilterListUpdate {
  /// Returns a new [ProfileAttributeFilterListUpdate] instance.
  ProfileAttributeFilterListUpdate({
    this.filters = const [],
  });

  List<ProfileAttributeFilterValueUpdate> filters;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeFilterListUpdate &&
     other.filters == filters;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (filters.hashCode);

  @override
  String toString() => 'ProfileAttributeFilterListUpdate[filters=$filters]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'filters'] = this.filters;
    return json;
  }

  /// Returns a new [ProfileAttributeFilterListUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributeFilterListUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributeFilterListUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributeFilterListUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributeFilterListUpdate(
        filters: ProfileAttributeFilterValueUpdate.listFromJson(json[r'filters'])!,
      );
    }
    return null;
  }

  static List<ProfileAttributeFilterListUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributeFilterListUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributeFilterListUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributeFilterListUpdate> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributeFilterListUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeFilterListUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributeFilterListUpdate-objects as value to a dart map
  static Map<String, List<ProfileAttributeFilterListUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributeFilterListUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeFilterListUpdate.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'filters',
  };
}

