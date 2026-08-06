//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SoftwareInfo {
  /// Returns a new [SoftwareInfo] instance.
  SoftwareInfo({
    required this.name,
    required this.sha256,
  });

  String name;

  String sha256;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SoftwareInfo &&
    other.name == name &&
    other.sha256 == sha256;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (sha256.hashCode);

  @override
  String toString() => 'SoftwareInfo[name=$name, sha256=$sha256]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'sha256'] = this.sha256;
    return json;
  }

  /// Returns a new [SoftwareInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SoftwareInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'name'), 'Required key "SoftwareInfo[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "SoftwareInfo[name]" has a null value in JSON.');
        assert(json.containsKey(r'sha256'), 'Required key "SoftwareInfo[sha256]" is missing from JSON.');
        assert(json[r'sha256'] != null, 'Required key "SoftwareInfo[sha256]" has a null value in JSON.');
        return true;
      }());

      return SoftwareInfo(
        name: mapValueOfType<String>(json, r'name')!,
        sha256: mapValueOfType<String>(json, r'sha256')!,
      );
    }
    return null;
  }

  static List<SoftwareInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SoftwareInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SoftwareInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SoftwareInfo> mapFromJson(dynamic json) {
    final map = <String, SoftwareInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SoftwareInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SoftwareInfo-objects as value to a dart map
  static Map<String, List<SoftwareInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SoftwareInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SoftwareInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'sha256',
  };
}

