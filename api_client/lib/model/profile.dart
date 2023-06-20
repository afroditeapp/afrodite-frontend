//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Profile {
  /// Returns a new [Profile] instance.
  Profile({
    required this.name,
    required this.profileText,
    required this.version,
  });

  String name;

  String profileText;

  ProfileVersion version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Profile &&
     other.name == name &&
     other.profileText == profileText &&
     other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (profileText.hashCode) +
    (version.hashCode);

  @override
  String toString() => 'Profile[name=$name, profileText=$profileText, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'profile_text'] = this.profileText;
      json[r'version'] = this.version;
    return json;
  }

  /// Returns a new [Profile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Profile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Profile[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Profile[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Profile(
        name: mapValueOfType<String>(json, r'name')!,
        profileText: mapValueOfType<String>(json, r'profile_text')!,
        version: ProfileVersion.fromJson(json[r'version'])!,
      );
    }
    return null;
  }

  static List<Profile>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Profile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Profile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Profile> mapFromJson(dynamic json) {
    final map = <String, Profile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Profile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Profile-objects as value to a dart map
  static Map<String, List<Profile>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Profile>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Profile.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'profile_text',
    'version',
  };
}

