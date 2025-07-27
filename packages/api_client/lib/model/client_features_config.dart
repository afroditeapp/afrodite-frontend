//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClientFeaturesConfig {
  /// Returns a new [ClientFeaturesConfig] instance.
  ClientFeaturesConfig({
    required this.attribution,
    required this.features,
    required this.limits,
    required this.map,
    this.news,
  });

  AttributionConfig attribution;

  FeaturesConfig features;

  LimitsConfig limits;

  MapConfig map;

  /// Enable news UI
  NewsConfig? news;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClientFeaturesConfig &&
    other.attribution == attribution &&
    other.features == features &&
    other.limits == limits &&
    other.map == map &&
    other.news == news;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (attribution.hashCode) +
    (features.hashCode) +
    (limits.hashCode) +
    (map.hashCode) +
    (news == null ? 0 : news!.hashCode);

  @override
  String toString() => 'ClientFeaturesConfig[attribution=$attribution, features=$features, limits=$limits, map=$map, news=$news]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'attribution'] = this.attribution;
      json[r'features'] = this.features;
      json[r'limits'] = this.limits;
      json[r'map'] = this.map;
    if (this.news != null) {
      json[r'news'] = this.news;
    } else {
      json[r'news'] = null;
    }
    return json;
  }

  /// Returns a new [ClientFeaturesConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClientFeaturesConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClientFeaturesConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClientFeaturesConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClientFeaturesConfig(
        attribution: AttributionConfig.fromJson(json[r'attribution'])!,
        features: FeaturesConfig.fromJson(json[r'features'])!,
        limits: LimitsConfig.fromJson(json[r'limits'])!,
        map: MapConfig.fromJson(json[r'map'])!,
        news: NewsConfig.fromJson(json[r'news']),
      );
    }
    return null;
  }

  static List<ClientFeaturesConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientFeaturesConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientFeaturesConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClientFeaturesConfig> mapFromJson(dynamic json) {
    final map = <String, ClientFeaturesConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClientFeaturesConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClientFeaturesConfig-objects as value to a dart map
  static Map<String, List<ClientFeaturesConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClientFeaturesConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClientFeaturesConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'attribution',
    'features',
    'limits',
    'map',
  };
}

