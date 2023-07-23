//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BuildInfo {
  /// Returns a new [BuildInfo] instance.
  BuildInfo({
    required this.buildInfo,
    required this.commitSha,
    required this.name,
    required this.timestamp,
  });

  /// Build info output from the built binary.  Binary must support --build-info command line argument.
  String buildInfo;

  String commitSha;

  String name;

  String timestamp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BuildInfo &&
     other.buildInfo == buildInfo &&
     other.commitSha == commitSha &&
     other.name == name &&
     other.timestamp == timestamp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (buildInfo.hashCode) +
    (commitSha.hashCode) +
    (name.hashCode) +
    (timestamp.hashCode);

  @override
  String toString() => 'BuildInfo[buildInfo=$buildInfo, commitSha=$commitSha, name=$name, timestamp=$timestamp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'build_info'] = this.buildInfo;
      json[r'commit_sha'] = this.commitSha;
      json[r'name'] = this.name;
      json[r'timestamp'] = this.timestamp;
    return json;
  }

  /// Returns a new [BuildInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BuildInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BuildInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BuildInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BuildInfo(
        buildInfo: mapValueOfType<String>(json, r'build_info')!,
        commitSha: mapValueOfType<String>(json, r'commit_sha')!,
        name: mapValueOfType<String>(json, r'name')!,
        timestamp: mapValueOfType<String>(json, r'timestamp')!,
      );
    }
    return null;
  }

  static List<BuildInfo>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BuildInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BuildInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BuildInfo> mapFromJson(dynamic json) {
    final map = <String, BuildInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BuildInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BuildInfo-objects as value to a dart map
  static Map<String, List<BuildInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BuildInfo>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BuildInfo.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'build_info',
    'commit_sha',
    'name',
    'timestamp',
  };
}

