//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomReportContent {
  /// Returns a new [CustomReportContent] instance.
  CustomReportContent({
    this.booleanValue,
  });

  bool? booleanValue;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomReportContent &&
    other.booleanValue == booleanValue;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (booleanValue == null ? 0 : booleanValue!.hashCode);

  @override
  String toString() => 'CustomReportContent[booleanValue=$booleanValue]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.booleanValue != null) {
      json[r'boolean_value'] = this.booleanValue;
    } else {
      json[r'boolean_value'] = null;
    }
    return json;
  }

  /// Returns a new [CustomReportContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomReportContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomReportContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomReportContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomReportContent(
        booleanValue: mapValueOfType<bool>(json, r'boolean_value'),
      );
    }
    return null;
  }

  static List<CustomReportContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomReportContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomReportContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomReportContent> mapFromJson(dynamic json) {
    final map = <String, CustomReportContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomReportContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomReportContent-objects as value to a dart map
  static Map<String, List<CustomReportContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomReportContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomReportContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

