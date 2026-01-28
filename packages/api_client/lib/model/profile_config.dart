//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileConfig {
  /// Returns a new [ProfileConfig] instance.
  ProfileConfig({
    this.firstImage,
    this.profileNameRegex,
  });

  FirstImageConfig? firstImage;

  String? profileNameRegex;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileConfig &&
    other.firstImage == firstImage &&
    other.profileNameRegex == profileNameRegex;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (firstImage == null ? 0 : firstImage!.hashCode) +
    (profileNameRegex == null ? 0 : profileNameRegex!.hashCode);

  @override
  String toString() => 'ProfileConfig[firstImage=$firstImage, profileNameRegex=$profileNameRegex]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.firstImage != null) {
      json[r'first_image'] = this.firstImage;
    } else {
      json[r'first_image'] = null;
    }
    if (this.profileNameRegex != null) {
      json[r'profile_name_regex'] = this.profileNameRegex;
    } else {
      json[r'profile_name_regex'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileConfig(
        firstImage: FirstImageConfig.fromJson(json[r'first_image']),
        profileNameRegex: mapValueOfType<String>(json, r'profile_name_regex'),
      );
    }
    return null;
  }

  static List<ProfileConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileConfig> mapFromJson(dynamic json) {
    final map = <String, ProfileConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileConfig-objects as value to a dart map
  static Map<String, List<ProfileConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

