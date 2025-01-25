//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClientVersion {
  /// Returns a new [ClientVersion] instance.
  ClientVersion({
    required this.major,
    required this.minor,
    required this.patch_,
  });

  /// Minimum value: 0
  int major;

  /// Minimum value: 0
  int minor;

  /// Minimum value: 0
  int patch_;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClientVersion &&
    other.major == major &&
    other.minor == minor &&
    other.patch_ == patch_;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (major.hashCode) +
    (minor.hashCode) +
    (patch_.hashCode);

  @override
  String toString() => 'ClientVersion[major=$major, minor=$minor, patch_=$patch_]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'major'] = this.major;
      json[r'minor'] = this.minor;
      json[r'patch'] = this.patch_;
    return json;
  }

  /// Returns a new [ClientVersion] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClientVersion? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClientVersion[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClientVersion[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClientVersion(
        major: mapValueOfType<int>(json, r'major')!,
        minor: mapValueOfType<int>(json, r'minor')!,
        patch_: mapValueOfType<int>(json, r'patch')!,
      );
    }
    return null;
  }

  static List<ClientVersion> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientVersion>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientVersion.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClientVersion> mapFromJson(dynamic json) {
    final map = <String, ClientVersion>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClientVersion.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClientVersion-objects as value to a dart map
  static Map<String, List<ClientVersion>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClientVersion>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClientVersion.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'major',
    'minor',
    'patch',
  };
}

