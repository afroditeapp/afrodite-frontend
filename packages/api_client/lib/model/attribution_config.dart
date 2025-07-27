//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AttributionConfig {
  /// Returns a new [AttributionConfig] instance.
  AttributionConfig({
    this.generic,
    this.ipCountry,
  });

  /// Generic attribution info text displayed in about screen of the app.
  StringResource? generic;

  /// Attribution info text displayed when IP country data is shown.
  StringResource? ipCountry;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AttributionConfig &&
    other.generic == generic &&
    other.ipCountry == ipCountry;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (generic == null ? 0 : generic!.hashCode) +
    (ipCountry == null ? 0 : ipCountry!.hashCode);

  @override
  String toString() => 'AttributionConfig[generic=$generic, ipCountry=$ipCountry]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.generic != null) {
      json[r'generic'] = this.generic;
    } else {
      json[r'generic'] = null;
    }
    if (this.ipCountry != null) {
      json[r'ip_country'] = this.ipCountry;
    } else {
      json[r'ip_country'] = null;
    }
    return json;
  }

  /// Returns a new [AttributionConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AttributionConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AttributionConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AttributionConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AttributionConfig(
        generic: StringResource.fromJson(json[r'generic']),
        ipCountry: StringResource.fromJson(json[r'ip_country']),
      );
    }
    return null;
  }

  static List<AttributionConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AttributionConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AttributionConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AttributionConfig> mapFromJson(dynamic json) {
    final map = <String, AttributionConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AttributionConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AttributionConfig-objects as value to a dart map
  static Map<String, List<AttributionConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AttributionConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AttributionConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

