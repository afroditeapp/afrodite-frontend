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
    this.contentVersion,
    required this.id,
    this.lastSeenTime,
    required this.version,
  });

  /// This is optional because media component owns it.
  ProfileContentVersion? contentVersion;

  AccountId id;

  /// Account's most recent disconnect time.  If the last seen time is not None, then it is Unix timestamp or -1 if the profile is currently online.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lastSeenTime;

  ProfileVersion version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileLink &&
    other.contentVersion == contentVersion &&
    other.id == id &&
    other.lastSeenTime == lastSeenTime &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentVersion == null ? 0 : contentVersion!.hashCode) +
    (id.hashCode) +
    (lastSeenTime == null ? 0 : lastSeenTime!.hashCode) +
    (version.hashCode);

  @override
  String toString() => 'ProfileLink[contentVersion=$contentVersion, id=$id, lastSeenTime=$lastSeenTime, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.contentVersion != null) {
      json[r'content_version'] = this.contentVersion;
    } else {
      json[r'content_version'] = null;
    }
      json[r'id'] = this.id;
    if (this.lastSeenTime != null) {
      json[r'last_seen_time'] = this.lastSeenTime;
    } else {
      json[r'last_seen_time'] = null;
    }
      json[r'version'] = this.version;
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
        contentVersion: ProfileContentVersion.fromJson(json[r'content_version']),
        id: AccountId.fromJson(json[r'id'])!,
        lastSeenTime: mapValueOfType<int>(json, r'last_seen_time'),
        version: ProfileVersion.fromJson(json[r'version'])!,
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
    'id',
    'version',
  };
}

