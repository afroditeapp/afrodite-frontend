//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileResult {
  /// Returns a new [GetProfileResult] instance.
  GetProfileResult({
    this.lst,
    this.p,
    this.v,
  });

  /// Account's most recent disconnect time.  If the last seen time is not None, then it is Unix timestamp or -1 if the profile is currently online.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lst;

  /// Profile data if it is newer than the version in the query.
  Profile? p;

  /// If empty then profile does not exist or current account does not have access to the profile.
  ProfileVersion? v;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileResult &&
    other.lst == lst &&
    other.p == p &&
    other.v == v;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (lst == null ? 0 : lst!.hashCode) +
    (p == null ? 0 : p!.hashCode) +
    (v == null ? 0 : v!.hashCode);

  @override
  String toString() => 'GetProfileResult[lst=$lst, p=$p, v=$v]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.lst != null) {
      json[r'lst'] = this.lst;
    } else {
      json[r'lst'] = null;
    }
    if (this.p != null) {
      json[r'p'] = this.p;
    } else {
      json[r'p'] = null;
    }
    if (this.v != null) {
      json[r'v'] = this.v;
    } else {
      json[r'v'] = null;
    }
    return json;
  }

  /// Returns a new [GetProfileResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetProfileResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetProfileResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetProfileResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetProfileResult(
        lst: mapValueOfType<int>(json, r'lst'),
        p: Profile.fromJson(json[r'p']),
        v: ProfileVersion.fromJson(json[r'v']),
      );
    }
    return null;
  }

  static List<GetProfileResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetProfileResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetProfileResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetProfileResult> mapFromJson(dynamic json) {
    final map = <String, GetProfileResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetProfileResult-objects as value to a dart map
  static Map<String, List<GetProfileResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetProfileResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetProfileResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

