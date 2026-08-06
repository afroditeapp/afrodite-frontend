//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomEmailTranslation {
  /// Returns a new [CustomEmailTranslation] instance.
  CustomEmailTranslation({
    required this.body,
    required this.locale,
    required this.subject,
  });

  String body;

  /// \"default\" or 2 letter country code.
  String locale;

  String subject;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomEmailTranslation &&
    other.body == body &&
    other.locale == locale &&
    other.subject == subject;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (body.hashCode) +
    (locale.hashCode) +
    (subject.hashCode);

  @override
  String toString() => 'CustomEmailTranslation[body=$body, locale=$locale, subject=$subject]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'body'] = this.body;
      json[r'locale'] = this.locale;
      json[r'subject'] = this.subject;
    return json;
  }

  /// Returns a new [CustomEmailTranslation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomEmailTranslation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'body'), 'Required key "CustomEmailTranslation[body]" is missing from JSON.');
        assert(json[r'body'] != null, 'Required key "CustomEmailTranslation[body]" has a null value in JSON.');
        assert(json.containsKey(r'locale'), 'Required key "CustomEmailTranslation[locale]" is missing from JSON.');
        assert(json[r'locale'] != null, 'Required key "CustomEmailTranslation[locale]" has a null value in JSON.');
        assert(json.containsKey(r'subject'), 'Required key "CustomEmailTranslation[subject]" is missing from JSON.');
        assert(json[r'subject'] != null, 'Required key "CustomEmailTranslation[subject]" has a null value in JSON.');
        return true;
      }());

      return CustomEmailTranslation(
        body: mapValueOfType<String>(json, r'body')!,
        locale: mapValueOfType<String>(json, r'locale')!,
        subject: mapValueOfType<String>(json, r'subject')!,
      );
    }
    return null;
  }

  static List<CustomEmailTranslation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomEmailTranslation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomEmailTranslation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomEmailTranslation> mapFromJson(dynamic json) {
    final map = <String, CustomEmailTranslation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomEmailTranslation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomEmailTranslation-objects as value to a dart map
  static Map<String, List<CustomEmailTranslation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomEmailTranslation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomEmailTranslation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'body',
    'locale',
    'subject',
  };
}

