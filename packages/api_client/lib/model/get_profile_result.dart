//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileResult {
  /// Returns a new [GetProfileResult] instance.
  GetProfileResult({
    this.profile,
    this.version,
  });

  Profile? profile;

  ProfileVersion? version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileResult &&
     other.profile == profile &&
     other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profile == null ? 0 : profile!.hashCode) +
    (version == null ? 0 : version!.hashCode);

  @override
  String toString() => 'GetProfileResult[profile=$profile, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.profile != null) {
      json[r'profile'] = this.profile;
    } else {
      json[r'profile'] = null;
    }
    if (this.version != null) {
      json[r'version'] = this.version;
    } else {
      json[r'version'] = null;
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
        profile: Profile.fromJson(json[r'profile']),
        version: ProfileVersion.fromJson(json[r'version']),
      );
    }
    return null;
  }

  static List<GetProfileResult>? listFromJson(dynamic json, {bool growable = false,}) {
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
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileResult.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

