//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomReport {
  /// Returns a new [CustomReport] instance.
  CustomReport({
    required this.id,
    required this.key,
    required this.name,
    required this.orderNumber,
    required this.reportType,
    this.translations = const [],
    this.visible = true,
  });

  /// Minimum value: 0
  int id;

  String key;

  String name;

  /// Client should order custom reports with this number when [CustomReportsOrderMode::OrderNumber] is selected.
  ///
  /// Minimum value: 0
  int orderNumber;

  CustomReportType reportType;

  List<CustomReportLanguage> translations;

  /// Client should show the report type when making a new report.
  bool visible;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomReport &&
    other.id == id &&
    other.key == key &&
    other.name == name &&
    other.orderNumber == orderNumber &&
    other.reportType == reportType &&
    _deepEquality.equals(other.translations, translations) &&
    other.visible == visible;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (key.hashCode) +
    (name.hashCode) +
    (orderNumber.hashCode) +
    (reportType.hashCode) +
    (translations.hashCode) +
    (visible.hashCode);

  @override
  String toString() => 'CustomReport[id=$id, key=$key, name=$name, orderNumber=$orderNumber, reportType=$reportType, translations=$translations, visible=$visible]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'key'] = this.key;
      json[r'name'] = this.name;
      json[r'order_number'] = this.orderNumber;
      json[r'report_type'] = this.reportType;
      json[r'translations'] = this.translations;
      json[r'visible'] = this.visible;
    return json;
  }

  /// Returns a new [CustomReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomReport(
        id: mapValueOfType<int>(json, r'id')!,
        key: mapValueOfType<String>(json, r'key')!,
        name: mapValueOfType<String>(json, r'name')!,
        orderNumber: mapValueOfType<int>(json, r'order_number')!,
        reportType: CustomReportType.fromJson(json[r'report_type'])!,
        translations: CustomReportLanguage.listFromJson(json[r'translations']),
        visible: mapValueOfType<bool>(json, r'visible') ?? true,
      );
    }
    return null;
  }

  static List<CustomReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomReport> mapFromJson(dynamic json) {
    final map = <String, CustomReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomReport-objects as value to a dart map
  static Map<String, List<CustomReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'key',
    'name',
    'order_number',
    'report_type',
  };
}

