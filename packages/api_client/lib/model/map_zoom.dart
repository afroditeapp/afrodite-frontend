//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MapZoom {
  /// Returns a new [MapZoom] instance.
  MapZoom({
    required this.locationNotSelected,
    required this.locationSelected,
    required this.max,
    required this.maxTileDownloading,
    required this.min,
  });

  /// Minimum value: 0
  int locationNotSelected;

  /// Minimum value: 0
  int locationSelected;

  /// Minimum value: 0
  int max;

  /// Minimum value: 0
  int maxTileDownloading;

  /// Minimum value: 0
  int min;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MapZoom &&
    other.locationNotSelected == locationNotSelected &&
    other.locationSelected == locationSelected &&
    other.max == max &&
    other.maxTileDownloading == maxTileDownloading &&
    other.min == min;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (locationNotSelected.hashCode) +
    (locationSelected.hashCode) +
    (max.hashCode) +
    (maxTileDownloading.hashCode) +
    (min.hashCode);

  @override
  String toString() => 'MapZoom[locationNotSelected=$locationNotSelected, locationSelected=$locationSelected, max=$max, maxTileDownloading=$maxTileDownloading, min=$min]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'location_not_selected'] = this.locationNotSelected;
      json[r'location_selected'] = this.locationSelected;
      json[r'max'] = this.max;
      json[r'max_tile_downloading'] = this.maxTileDownloading;
      json[r'min'] = this.min;
    return json;
  }

  /// Returns a new [MapZoom] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MapZoom? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MapZoom[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MapZoom[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MapZoom(
        locationNotSelected: mapValueOfType<int>(json, r'location_not_selected')!,
        locationSelected: mapValueOfType<int>(json, r'location_selected')!,
        max: mapValueOfType<int>(json, r'max')!,
        maxTileDownloading: mapValueOfType<int>(json, r'max_tile_downloading')!,
        min: mapValueOfType<int>(json, r'min')!,
      );
    }
    return null;
  }

  static List<MapZoom> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MapZoom>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MapZoom.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MapZoom> mapFromJson(dynamic json) {
    final map = <String, MapZoom>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MapZoom.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MapZoom-objects as value to a dart map
  static Map<String, List<MapZoom>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MapZoom>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MapZoom.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'location_not_selected',
    'location_selected',
    'max',
    'max_tile_downloading',
    'min',
  };
}

