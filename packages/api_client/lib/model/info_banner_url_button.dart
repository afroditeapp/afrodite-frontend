//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InfoBannerUrlButton {
  /// Returns a new [InfoBannerUrlButton] instance.
  InfoBannerUrlButton({
    required this.text,
    required this.url,
  });

  StringResource text;

  String url;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InfoBannerUrlButton &&
    other.text == text &&
    other.url == url;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (text.hashCode) +
    (url.hashCode);

  @override
  String toString() => 'InfoBannerUrlButton[text=$text, url=$url]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'text'] = this.text;
      json[r'url'] = this.url;
    return json;
  }

  /// Returns a new [InfoBannerUrlButton] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InfoBannerUrlButton? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "InfoBannerUrlButton[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "InfoBannerUrlButton[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InfoBannerUrlButton(
        text: StringResource.fromJson(json[r'text'])!,
        url: mapValueOfType<String>(json, r'url')!,
      );
    }
    return null;
  }

  static List<InfoBannerUrlButton> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InfoBannerUrlButton>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InfoBannerUrlButton.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InfoBannerUrlButton> mapFromJson(dynamic json) {
    final map = <String, InfoBannerUrlButton>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InfoBannerUrlButton.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InfoBannerUrlButton-objects as value to a dart map
  static Map<String, List<InfoBannerUrlButton>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InfoBannerUrlButton>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InfoBannerUrlButton.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'text',
    'url',
  };
}

