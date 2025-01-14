//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetMediaContentResult {
  /// Returns a new [GetMediaContentResult] instance.
  GetMediaContentResult({
    required this.profileContent,
    required this.profileContentVersion,
    this.securityContent,
    required this.syncVersion,
  });

  MyProfileContent profileContent;

  ProfileContentVersion profileContentVersion;

  ContentInfoWithFd? securityContent;

  /// Sync version for profile and security content
  SyncVersion syncVersion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetMediaContentResult &&
    other.profileContent == profileContent &&
    other.profileContentVersion == profileContentVersion &&
    other.securityContent == securityContent &&
    other.syncVersion == syncVersion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileContent.hashCode) +
    (profileContentVersion.hashCode) +
    (securityContent == null ? 0 : securityContent!.hashCode) +
    (syncVersion.hashCode);

  @override
  String toString() => 'GetMediaContentResult[profileContent=$profileContent, profileContentVersion=$profileContentVersion, securityContent=$securityContent, syncVersion=$syncVersion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profile_content'] = this.profileContent;
      json[r'profile_content_version'] = this.profileContentVersion;
    if (this.securityContent != null) {
      json[r'security_content'] = this.securityContent;
    } else {
      json[r'security_content'] = null;
    }
      json[r'sync_version'] = this.syncVersion;
    return json;
  }

  /// Returns a new [GetMediaContentResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetMediaContentResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetMediaContentResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetMediaContentResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetMediaContentResult(
        profileContent: MyProfileContent.fromJson(json[r'profile_content'])!,
        profileContentVersion: ProfileContentVersion.fromJson(json[r'profile_content_version'])!,
        securityContent: ContentInfoWithFd.fromJson(json[r'security_content']),
        syncVersion: SyncVersion.fromJson(json[r'sync_version'])!,
      );
    }
    return null;
  }

  static List<GetMediaContentResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetMediaContentResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetMediaContentResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetMediaContentResult> mapFromJson(dynamic json) {
    final map = <String, GetMediaContentResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetMediaContentResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetMediaContentResult-objects as value to a dart map
  static Map<String, List<GetMediaContentResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetMediaContentResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetMediaContentResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile_content',
    'profile_content_version',
    'sync_version',
  };
}

