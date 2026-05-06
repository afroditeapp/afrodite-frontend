//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServerVersion {
  /// Returns a new [ServerVersion] instance.
  ServerVersion({
    required this.serverCodeVersion,
    required this.serverVersion,
  });

  /// Server code version.
  String serverCodeVersion;

  /// Semver version of the server.
  String serverVersion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServerVersion &&
    other.serverCodeVersion == serverCodeVersion &&
    other.serverVersion == serverVersion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (serverCodeVersion.hashCode) +
    (serverVersion.hashCode);

  @override
  String toString() => 'ServerVersion[serverCodeVersion=$serverCodeVersion, serverVersion=$serverVersion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'server_code_version'] = this.serverCodeVersion;
      json[r'server_version'] = this.serverVersion;
    return json;
  }

  /// Returns a new [ServerVersion] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServerVersion? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ServerVersion[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ServerVersion[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServerVersion(
        serverCodeVersion: mapValueOfType<String>(json, r'server_code_version')!,
        serverVersion: mapValueOfType<String>(json, r'server_version')!,
      );
    }
    return null;
  }

  static List<ServerVersion> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ServerVersion>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServerVersion.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServerVersion> mapFromJson(dynamic json) {
    final map = <String, ServerVersion>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServerVersion.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServerVersion-objects as value to a dart map
  static Map<String, List<ServerVersion>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ServerVersion>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ServerVersion.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'server_code_version',
    'server_version',
  };
}

