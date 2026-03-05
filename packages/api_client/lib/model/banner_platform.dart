//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BannerPlatform {
  /// Returns a new [BannerPlatform] instance.
  BannerPlatform({
    this.android = false,
    this.ios = false,
    this.web = false,
  });

  bool android;

  bool ios;

  bool web;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BannerPlatform &&
    other.android == android &&
    other.ios == ios &&
    other.web == web;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (android.hashCode) +
    (ios.hashCode) +
    (web.hashCode);

  @override
  String toString() => 'BannerPlatform[android=$android, ios=$ios, web=$web]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'android'] = this.android;
      json[r'ios'] = this.ios;
      json[r'web'] = this.web;
    return json;
  }

  /// Returns a new [BannerPlatform] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BannerPlatform? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BannerPlatform[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BannerPlatform[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BannerPlatform(
        android: mapValueOfType<bool>(json, r'android') ?? false,
        ios: mapValueOfType<bool>(json, r'ios') ?? false,
        web: mapValueOfType<bool>(json, r'web') ?? false,
      );
    }
    return null;
  }

  static List<BannerPlatform> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BannerPlatform>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BannerPlatform.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BannerPlatform> mapFromJson(dynamic json) {
    final map = <String, BannerPlatform>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BannerPlatform.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BannerPlatform-objects as value to a dart map
  static Map<String, List<BannerPlatform>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BannerPlatform>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BannerPlatform.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

