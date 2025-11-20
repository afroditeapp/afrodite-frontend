//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MapConfig {
  /// Returns a new [MapConfig] instance.
  MapConfig({
    this.bounds,
    this.initialLocation,
    this.tileDataVersion = 0,
    this.zoom,
  });

  /// Limit viewable map area
  MapBounds? bounds;

  MapCoordinate? initialLocation;

  /// Increase this version number to make client to redownload cached map tiles.
  ///
  /// Minimum value: 0
  int tileDataVersion;

  MapZoom? zoom;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MapConfig &&
    other.bounds == bounds &&
    other.initialLocation == initialLocation &&
    other.tileDataVersion == tileDataVersion &&
    other.zoom == zoom;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (bounds == null ? 0 : bounds!.hashCode) +
    (initialLocation == null ? 0 : initialLocation!.hashCode) +
    (tileDataVersion.hashCode) +
    (zoom == null ? 0 : zoom!.hashCode);

  @override
  String toString() => 'MapConfig[bounds=$bounds, initialLocation=$initialLocation, tileDataVersion=$tileDataVersion, zoom=$zoom]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.bounds != null) {
      json[r'bounds'] = this.bounds;
    } else {
      json[r'bounds'] = null;
    }
    if (this.initialLocation != null) {
      json[r'initial_location'] = this.initialLocation;
    } else {
      json[r'initial_location'] = null;
    }
      json[r'tile_data_version'] = this.tileDataVersion;
    if (this.zoom != null) {
      json[r'zoom'] = this.zoom;
    } else {
      json[r'zoom'] = null;
    }
    return json;
  }

  /// Returns a new [MapConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MapConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MapConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MapConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MapConfig(
        bounds: MapBounds.fromJson(json[r'bounds']),
        initialLocation: MapCoordinate.fromJson(json[r'initial_location']),
        tileDataVersion: mapValueOfType<int>(json, r'tile_data_version') ?? 0,
        zoom: MapZoom.fromJson(json[r'zoom']),
      );
    }
    return null;
  }

  static List<MapConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MapConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MapConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MapConfig> mapFromJson(dynamic json) {
    final map = <String, MapConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MapConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MapConfig-objects as value to a dart map
  static Map<String, List<MapConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MapConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MapConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

