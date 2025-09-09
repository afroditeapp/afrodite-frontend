//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileLink {
  /// Returns a new [ProfileLink] instance.
  ProfileLink({
    required this.a,
    required this.c,
    required this.l,
    required this.p,
  });

  AccountId a;

  ProfileContentVersion c;

  /// Account's most recent disconnect time.  If the last seen time is not None, then it is Unix timestamp or -1 if the profile is currently online.
  int l;

  ProfileVersion p;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileLink &&
    other.a == a &&
    other.c == c &&
    other.l == l &&
    other.p == p;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (a.hashCode) +
    (c.hashCode) +
    (l.hashCode) +
    (p.hashCode);

  @override
  String toString() => 'ProfileLink[a=$a, c=$c, l=$l, p=$p]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'a'] = this.a;
      json[r'c'] = this.c;
      json[r'l'] = this.l;
      json[r'p'] = this.p;
    return json;
  }

  /// Returns a new [ProfileLink] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileLink? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileLink[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileLink[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileLink(
        a: AccountId.fromJson(json[r'a'])!,
        c: ProfileContentVersion.fromJson(json[r'c'])!,
        l: mapValueOfType<int>(json, r'l')!,
        p: ProfileVersion.fromJson(json[r'p'])!,
      );
    }
    return null;
  }

  static List<ProfileLink> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileLink>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileLink.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileLink> mapFromJson(dynamic json) {
    final map = <String, ProfileLink>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileLink.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileLink-objects as value to a dart map
  static Map<String, List<ProfileLink>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileLink>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileLink.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'a',
    'c',
    'l',
    'p',
  };
}

