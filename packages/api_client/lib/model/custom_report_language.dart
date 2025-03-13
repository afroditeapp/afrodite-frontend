//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomReportLanguage {
  /// Returns a new [CustomReportLanguage] instance.
  CustomReportLanguage({
    required this.lang,
    this.values = const [],
  });

  /// Language code.
  String lang;

  List<CustomReportTranslation> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomReportLanguage &&
    other.lang == lang &&
    _deepEquality.equals(other.values, values);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (lang.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'CustomReportLanguage[lang=$lang, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'lang'] = this.lang;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [CustomReportLanguage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomReportLanguage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomReportLanguage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomReportLanguage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomReportLanguage(
        lang: mapValueOfType<String>(json, r'lang')!,
        values: CustomReportTranslation.listFromJson(json[r'values']),
      );
    }
    return null;
  }

  static List<CustomReportLanguage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomReportLanguage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomReportLanguage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomReportLanguage> mapFromJson(dynamic json) {
    final map = <String, CustomReportLanguage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomReportLanguage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomReportLanguage-objects as value to a dart map
  static Map<String, List<CustomReportLanguage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomReportLanguage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomReportLanguage.listFromJson(entry.value, growable: growable,);
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

