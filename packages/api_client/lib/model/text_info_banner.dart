//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TextInfoBanner {
  /// Returns a new [TextInfoBanner] instance.
  TextInfoBanner({
    required this.body,
    this.icon,
    this.urlButton,
  });

  StringResource body;

  String? icon;

  InfoBannerUrlButton? urlButton;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TextInfoBanner &&
    other.body == body &&
    other.icon == icon &&
    other.urlButton == urlButton;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (body.hashCode) +
    (icon == null ? 0 : icon!.hashCode) +
    (urlButton == null ? 0 : urlButton!.hashCode);

  @override
  String toString() => 'TextInfoBanner[body=$body, icon=$icon, urlButton=$urlButton]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'body'] = this.body;
    if (this.icon != null) {
      json[r'icon'] = this.icon;
    } else {
      json[r'icon'] = null;
    }
    if (this.urlButton != null) {
      json[r'url_button'] = this.urlButton;
    } else {
      json[r'url_button'] = null;
    }
    return json;
  }

  /// Returns a new [TextInfoBanner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TextInfoBanner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TextInfoBanner[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TextInfoBanner[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TextInfoBanner(
        body: StringResource.fromJson(json[r'body'])!,
        icon: mapValueOfType<String>(json, r'icon'),
        urlButton: InfoBannerUrlButton.fromJson(json[r'url_button']),
      );
    }
    return null;
  }

  static List<TextInfoBanner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TextInfoBanner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TextInfoBanner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TextInfoBanner> mapFromJson(dynamic json) {
    final map = <String, TextInfoBanner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TextInfoBanner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TextInfoBanner-objects as value to a dart map
  static Map<String, List<TextInfoBanner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TextInfoBanner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TextInfoBanner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'body',
  };
}

