//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomReportTranslation {
  /// Returns a new [CustomReportTranslation] instance.
  CustomReportTranslation({
    required this.key,
    required this.name,
  });

  /// Custom report name.
  String key;

  /// Translated text.
  String name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomReportTranslation &&
    other.key == key &&
    other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (key.hashCode) +
    (name.hashCode);

  @override
  String toString() => 'CustomReportTranslation[key=$key, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'key'] = this.key;
      json[r'name'] = this.name;
    return json;
  }

  /// Returns a new [CustomReportTranslation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomReportTranslation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomReportTranslation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomReportTranslation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomReportTranslation(
        key: mapValueOfType<String>(json, r'key')!,
        name: mapValueOfType<String>(json, r'name')!,
      );
    }
    return null;
  }

  static List<CustomReportTranslation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomReportTranslation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomReportTranslation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomReportTranslation> mapFromJson(dynamic json) {
    final map = <String, CustomReportTranslation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomReportTranslation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomReportTranslation-objects as value to a dart map
  static Map<String, List<CustomReportTranslation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomReportTranslation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomReportTranslation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'key',
    'name',
  };
}

