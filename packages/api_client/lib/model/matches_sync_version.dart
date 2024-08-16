//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MatchesSyncVersion {
  /// Returns a new [MatchesSyncVersion] instance.
  MatchesSyncVersion({
    required this.version,
  });

  int version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MatchesSyncVersion &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (version.hashCode);

  @override
  String toString() => 'MatchesSyncVersion[version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'version'] = this.version;
    return json;
  }

  /// Returns a new [MatchesSyncVersion] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MatchesSyncVersion? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MatchesSyncVersion[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MatchesSyncVersion[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MatchesSyncVersion(
        version: mapValueOfType<int>(json, r'version')!,
      );
    }
    return null;
  }

  static List<MatchesSyncVersion> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MatchesSyncVersion>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MatchesSyncVersion.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MatchesSyncVersion> mapFromJson(dynamic json) {
    final map = <String, MatchesSyncVersion>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MatchesSyncVersion.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MatchesSyncVersion-objects as value to a dart map
  static Map<String, List<MatchesSyncVersion>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MatchesSyncVersion>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MatchesSyncVersion.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'version',
  };
}

