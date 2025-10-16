//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Profile {
  /// Returns a new [Profile] instance.
  Profile({
    required this.age,
    this.attributes = const [],
    this.name,
    this.nameAccepted = true,
    this.ptext,
    this.ptextAccepted = true,
    this.unlimitedLikes = false,
  });

  int age;

  List<ProfileAttributeValue> attributes;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  /// The name has been accepted using allowlist or manual moderation.
  bool nameAccepted;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? ptext;

  /// The profile text has been accepted by bot or human moderator.
  bool ptextAccepted;

  bool unlimitedLikes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Profile &&
    other.age == age &&
    _deepEquality.equals(other.attributes, attributes) &&
    other.name == name &&
    other.nameAccepted == nameAccepted &&
    other.ptext == ptext &&
    other.ptextAccepted == ptextAccepted &&
    other.unlimitedLikes == unlimitedLikes;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (age.hashCode) +
    (attributes.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (nameAccepted.hashCode) +
    (ptext == null ? 0 : ptext!.hashCode) +
    (ptextAccepted.hashCode) +
    (unlimitedLikes.hashCode);

  @override
  String toString() => 'Profile[age=$age, attributes=$attributes, name=$name, nameAccepted=$nameAccepted, ptext=$ptext, ptextAccepted=$ptextAccepted, unlimitedLikes=$unlimitedLikes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'age'] = this.age;
      json[r'attributes'] = this.attributes;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'name_accepted'] = this.nameAccepted;
    if (this.ptext != null) {
      json[r'ptext'] = this.ptext;
    } else {
      json[r'ptext'] = null;
    }
      json[r'ptext_accepted'] = this.ptextAccepted;
      json[r'unlimited_likes'] = this.unlimitedLikes;
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
        age: mapValueOfType<int>(json, r'age')!,
        attributes: ProfileAttributeValue.listFromJson(json[r'attributes']),
        name: mapValueOfType<String>(json, r'name'),
        nameAccepted: mapValueOfType<bool>(json, r'name_accepted') ?? true,
        ptext: mapValueOfType<String>(json, r'ptext'),
        ptextAccepted: mapValueOfType<bool>(json, r'ptext_accepted') ?? true,
        unlimitedLikes: mapValueOfType<bool>(json, r'unlimited_likes') ?? false,
      );
    }
    return null;
  }

  static List<Profile> listFromJson(dynamic json, {bool growable = false,}) {
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
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Profile.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'age',
  };
}

