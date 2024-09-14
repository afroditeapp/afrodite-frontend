//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetMyProfileResult {
  /// Returns a new [GetMyProfileResult] instance.
  GetMyProfileResult({
    this.lst,
    required this.p,
    required this.sv,
    required this.v,
  });

  /// Account's most recent disconnect time.  If the last seen time is not None, then it is Unix timestamp or -1 if the profile is currently online.
  int? lst;

  Profile p;

  ProfileSyncVersion sv;

  ProfileVersion v;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetMyProfileResult &&
    other.lst == lst &&
    other.p == p &&
    other.sv == sv &&
    other.v == v;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (lst == null ? 0 : lst!.hashCode) +
    (p.hashCode) +
    (sv.hashCode) +
    (v.hashCode);

  @override
  String toString() => 'GetMyProfileResult[lst=$lst, p=$p, sv=$sv, v=$v]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.lst != null) {
      json[r'lst'] = this.lst;
    } else {
      json[r'lst'] = null;
    }
      json[r'p'] = this.p;
      json[r'sv'] = this.sv;
      json[r'v'] = this.v;
    return json;
  }

  /// Returns a new [GetMyProfileResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetMyProfileResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetMyProfileResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetMyProfileResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetMyProfileResult(
        lst: mapValueOfType<int>(json, r'lst'),
        p: Profile.fromJson(json[r'p'])!,
        sv: ProfileSyncVersion.fromJson(json[r'sv'])!,
        v: ProfileVersion.fromJson(json[r'v'])!,
      );
    }
    return null;
  }

  static List<GetMyProfileResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetMyProfileResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetMyProfileResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetMyProfileResult> mapFromJson(dynamic json) {
    final map = <String, GetMyProfileResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetMyProfileResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetMyProfileResult-objects as value to a dart map
  static Map<String, List<GetMyProfileResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetMyProfileResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetMyProfileResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'p',
    'sv',
    'v',
  };
}

