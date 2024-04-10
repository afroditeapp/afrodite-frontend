//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MapTileX {
  /// Returns a new [MapTileX] instance.
  MapTileX({
    required this.x,
  });

  /// Minimum value: 0
  int x;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MapTileX &&
     other.x == x;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (x.hashCode);

  @override
  String toString() => 'MapTileX[x=$x]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'x'] = this.x;
    return json;
  }

  /// Returns a new [MapTileX] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MapTileX? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MapTileX[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MapTileX[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MapTileX(
        x: mapValueOfType<int>(json, r'x')!,
      );
    }
    return null;
  }

  static List<MapTileX>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MapTileX>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MapTileX.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MapTileX> mapFromJson(dynamic json) {
    final map = <String, MapTileX>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MapTileX.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MapTileX-objects as value to a dart map
  static Map<String, List<MapTileX>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MapTileX>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MapTileX.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'x',
  };
}

