//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfilePage {
  /// Returns a new [ProfilePage] instance.
  ProfilePage({
    this.latitude = const [],
  });

  List<ProfileLink> latitude;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfilePage &&
     other.latitude == latitude;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (latitude.hashCode);

  @override
  String toString() => 'ProfilePage[latitude=$latitude]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'latitude'] = this.latitude;
    return json;
  }

  /// Returns a new [ProfilePage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfilePage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfilePage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfilePage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfilePage(
        latitude: ProfileLink.listFromJson(json[r'latitude'])!,
      );
    }
    return null;
  }

  static List<ProfilePage>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfilePage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfilePage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfilePage> mapFromJson(dynamic json) {
    final map = <String, ProfilePage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfilePage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfilePage-objects as value to a dart map
  static Map<String, List<ProfilePage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfilePage>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfilePage.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'latitude',
  };
}

