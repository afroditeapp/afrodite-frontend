//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StringResource {
  /// Returns a new [StringResource] instance.
  StringResource({
    required this.default_,
    this.translations = const {},
  });

  String default_;

  /// Keys are country codes like \"en\".
  Map<String, String> translations;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StringResource &&
    other.default_ == default_ &&
    _deepEquality.equals(other.translations, translations);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (default_.hashCode) +
    (translations.hashCode);

  @override
  String toString() => 'StringResource[default_=$default_, translations=$translations]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'default'] = this.default_;
      json[r'translations'] = this.translations;
    return json;
  }

  /// Returns a new [StringResource] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StringResource? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StringResource[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StringResource[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StringResource(
        default_: mapValueOfType<String>(json, r'default')!,
        translations: mapCastOfType<String, String>(json, r'translations')!,
      );
    }
    return null;
  }

  static List<StringResource> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StringResource>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StringResource.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StringResource> mapFromJson(dynamic json) {
    final map = <String, StringResource>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StringResource.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StringResource-objects as value to a dart map
  static Map<String, List<StringResource>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StringResource>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StringResource.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'default',
    'translations',
  };
}

