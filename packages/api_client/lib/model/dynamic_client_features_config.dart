//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DynamicClientFeaturesConfig {
  /// Returns a new [DynamicClientFeaturesConfig] instance.
  DynamicClientFeaturesConfig({
    this.infoBanners,
  });

  InfoBannersConfig? infoBanners;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DynamicClientFeaturesConfig &&
    other.infoBanners == infoBanners;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (infoBanners == null ? 0 : infoBanners!.hashCode);

  @override
  String toString() => 'DynamicClientFeaturesConfig[infoBanners=$infoBanners]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.infoBanners != null) {
      json[r'info_banners'] = this.infoBanners;
    } else {
      json[r'info_banners'] = null;
    }
    return json;
  }

  /// Returns a new [DynamicClientFeaturesConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DynamicClientFeaturesConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DynamicClientFeaturesConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DynamicClientFeaturesConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DynamicClientFeaturesConfig(
        infoBanners: InfoBannersConfig.fromJson(json[r'info_banners']),
      );
    }
    return null;
  }

  static List<DynamicClientFeaturesConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DynamicClientFeaturesConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DynamicClientFeaturesConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DynamicClientFeaturesConfig> mapFromJson(dynamic json) {
    final map = <String, DynamicClientFeaturesConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DynamicClientFeaturesConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DynamicClientFeaturesConfig-objects as value to a dart map
  static Map<String, List<DynamicClientFeaturesConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DynamicClientFeaturesConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DynamicClientFeaturesConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

