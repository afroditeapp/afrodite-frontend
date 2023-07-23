//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BackendVersion {
  /// Returns a new [BackendVersion] instance.
  BackendVersion({
    required this.backendCodeVersion,
    required this.backendVersion,
    required this.protocolVersion,
  });

  /// Backend code version.
  String backendCodeVersion;

  /// Semver version of the backend.
  String backendVersion;

  /// Semver version of the protocol used by the backend.
  String protocolVersion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BackendVersion &&
     other.backendCodeVersion == backendCodeVersion &&
     other.backendVersion == backendVersion &&
     other.protocolVersion == protocolVersion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (backendCodeVersion.hashCode) +
    (backendVersion.hashCode) +
    (protocolVersion.hashCode);

  @override
  String toString() => 'BackendVersion[backendCodeVersion=$backendCodeVersion, backendVersion=$backendVersion, protocolVersion=$protocolVersion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'backend_code_version'] = this.backendCodeVersion;
      json[r'backend_version'] = this.backendVersion;
      json[r'protocol_version'] = this.protocolVersion;
    return json;
  }

  /// Returns a new [BackendVersion] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BackendVersion? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BackendVersion[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BackendVersion[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BackendVersion(
        backendCodeVersion: mapValueOfType<String>(json, r'backend_code_version')!,
        backendVersion: mapValueOfType<String>(json, r'backend_version')!,
        protocolVersion: mapValueOfType<String>(json, r'protocol_version')!,
      );
    }
    return null;
  }

  static List<BackendVersion>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BackendVersion>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BackendVersion.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BackendVersion> mapFromJson(dynamic json) {
    final map = <String, BackendVersion>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BackendVersion.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BackendVersion-objects as value to a dart map
  static Map<String, List<BackendVersion>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BackendVersion>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BackendVersion.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'backend_code_version',
    'backend_version',
    'protocol_version',
  };
}

