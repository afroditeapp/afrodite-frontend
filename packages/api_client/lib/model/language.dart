//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Language {
  /// Returns a new [Language] instance.
  Language({
    required this.lang,
    this.values = const [],
  });

  /// Language code.
  String lang;

  List<Translation> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Language &&
     other.lang == lang &&
     other.values == values;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (lang.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'Language[lang=$lang, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'lang'] = this.lang;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [Language] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Language? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Language[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Language[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Language(
        lang: mapValueOfType<String>(json, r'lang')!,
        values: Translation.listFromJson(json[r'values'])!,
      );
    }
    return null;
  }

  static List<Language>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Language>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Language.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Language> mapFromJson(dynamic json) {
    final map = <String, Language>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Language.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Language-objects as value to a dart map
  static Map<String, List<Language>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Language>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Language.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'lang',
    'values',
  };
}

