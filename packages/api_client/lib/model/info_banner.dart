//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InfoBanner {
  /// Returns a new [InfoBanner] instance.
  InfoBanner({
    required this.mode,
    required this.platform,
    this.text,
    this.version = 0,
    required this.visibility,
  });

  InfoBannerMode mode;

  BannerPlatform platform;

  TextInfoBanner? text;

  /// Server increments this field when banner is changed. It wraps, so use \"not equal\" comparison when checking version changes.
  ///
  /// Minimum value: 0
  int version;

  BannerVisibility visibility;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InfoBanner &&
    other.mode == mode &&
    other.platform == platform &&
    other.text == text &&
    other.version == version &&
    other.visibility == visibility;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mode.hashCode) +
    (platform.hashCode) +
    (text == null ? 0 : text!.hashCode) +
    (version.hashCode) +
    (visibility.hashCode);

  @override
  String toString() => 'InfoBanner[mode=$mode, platform=$platform, text=$text, version=$version, visibility=$visibility]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mode'] = this.mode;
      json[r'platform'] = this.platform;
    if (this.text != null) {
      json[r'text'] = this.text;
    } else {
      json[r'text'] = null;
    }
      json[r'version'] = this.version;
      json[r'visibility'] = this.visibility;
    return json;
  }

  /// Returns a new [InfoBanner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InfoBanner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "InfoBanner[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "InfoBanner[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InfoBanner(
        mode: InfoBannerMode.fromJson(json[r'mode'])!,
        platform: BannerPlatform.fromJson(json[r'platform'])!,
        text: TextInfoBanner.fromJson(json[r'text']),
        version: mapValueOfType<int>(json, r'version') ?? 0,
        visibility: BannerVisibility.fromJson(json[r'visibility'])!,
      );
    }
    return null;
  }

  static List<InfoBanner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InfoBanner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InfoBanner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InfoBanner> mapFromJson(dynamic json) {
    final map = <String, InfoBanner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InfoBanner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InfoBanner-objects as value to a dart map
  static Map<String, List<InfoBanner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InfoBanner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InfoBanner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mode',
    'platform',
    'visibility',
  };
}

