//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MapTileZ {
  /// Returns a new [MapTileZ] instance.
  MapTileZ({
    required this.z,
  });

  /// Minimum value: 0
  int z;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MapTileZ &&
     other.z == z;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (z.hashCode);

  @override
  String toString() => 'MapTileZ[z=$z]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'z'] = this.z;
    return json;
  }

  /// Returns a new [MapTileZ] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MapTileZ? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MapTileZ[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MapTileZ[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MapTileZ(
        z: mapValueOfType<int>(json, r'z')!,
      );
    }
    return null;
  }

  static List<MapTileZ>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MapTileZ>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MapTileZ.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MapTileZ> mapFromJson(dynamic json) {
    final map = <String, MapTileZ>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MapTileZ.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MapTileZ-objects as value to a dart map
  static Map<String, List<MapTileZ>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MapTileZ>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MapTileZ.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'z',
  };
}

