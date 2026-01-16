//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomReportsConfig {
  /// Returns a new [CustomReportsConfig] instance.
  CustomReportsConfig({
    required this.reportOrder,
    this.reports = const [],
  });

  CustomReportsOrderMode reportOrder;

  List<CustomReport> reports;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomReportsConfig &&
    other.reportOrder == reportOrder &&
    _deepEquality.equals(other.reports, reports);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (reportOrder.hashCode) +
    (reports.hashCode);

  @override
  String toString() => 'CustomReportsConfig[reportOrder=$reportOrder, reports=$reports]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'report_order'] = this.reportOrder;
      json[r'reports'] = this.reports;
    return json;
  }

  /// Returns a new [CustomReportsConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomReportsConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomReportsConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomReportsConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomReportsConfig(
        reportOrder: CustomReportsOrderMode.fromJson(json[r'report_order'])!,
        reports: CustomReport.listFromJson(json[r'reports']),
      );
    }
    return null;
  }

  static List<CustomReportsConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomReportsConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomReportsConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomReportsConfig> mapFromJson(dynamic json) {
    final map = <String, CustomReportsConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomReportsConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomReportsConfig-objects as value to a dart map
  static Map<String, List<CustomReportsConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomReportsConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomReportsConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'report_order',
  };
}

