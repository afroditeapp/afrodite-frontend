//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileUpdate {
  /// Returns a new [ProfileUpdate] instance.
  ProfileUpdate({
    this.image1,
    this.image2,
    this.image3,
    required this.profileText,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ContentId? image1;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ContentId? image2;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ContentId? image3;

  String profileText;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileUpdate &&
     other.image1 == image1 &&
     other.image2 == image2 &&
     other.image3 == image3 &&
     other.profileText == profileText;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (image1 == null ? 0 : image1!.hashCode) +
    (image2 == null ? 0 : image2!.hashCode) +
    (image3 == null ? 0 : image3!.hashCode) +
    (profileText.hashCode);

  @override
  String toString() => 'ProfileUpdate[image1=$image1, image2=$image2, image3=$image3, profileText=$profileText]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.image1 != null) {
      json[r'image1'] = this.image1;
    } else {
      json[r'image1'] = null;
    }
    if (this.image2 != null) {
      json[r'image2'] = this.image2;
    } else {
      json[r'image2'] = null;
    }
    if (this.image3 != null) {
      json[r'image3'] = this.image3;
    } else {
      json[r'image3'] = null;
    }
      json[r'profile_text'] = this.profileText;
    return json;
  }

  /// Returns a new [ProfileUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileUpdate(
        image1: ContentId.fromJson(json[r'image1']),
        image2: ContentId.fromJson(json[r'image2']),
        image3: ContentId.fromJson(json[r'image3']),
        profileText: mapValueOfType<String>(json, r'profile_text')!,
      );
    }
    return null;
  }

  static List<ProfileUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileUpdate> mapFromJson(dynamic json) {
    final map = <String, ProfileUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileUpdate-objects as value to a dart map
  static Map<String, List<ProfileUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileUpdate.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile_text',
  };
}

