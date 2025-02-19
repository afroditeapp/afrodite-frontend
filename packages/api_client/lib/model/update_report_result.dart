//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateReportResult {
  /// Returns a new [UpdateReportResult] instance.
  UpdateReportResult({
    this.errorOutdatedReportContent = false,
    this.errorTooManyReports = false,
  });

  bool errorOutdatedReportContent;

  bool errorTooManyReports;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateReportResult &&
    other.errorOutdatedReportContent == errorOutdatedReportContent &&
    other.errorTooManyReports == errorTooManyReports;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (errorOutdatedReportContent.hashCode) +
    (errorTooManyReports.hashCode);

  @override
  String toString() => 'UpdateReportResult[errorOutdatedReportContent=$errorOutdatedReportContent, errorTooManyReports=$errorTooManyReports]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error_outdated_report_content'] = this.errorOutdatedReportContent;
      json[r'error_too_many_reports'] = this.errorTooManyReports;
    return json;
  }

  /// Returns a new [UpdateReportResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateReportResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateReportResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateReportResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateReportResult(
        errorOutdatedReportContent: mapValueOfType<bool>(json, r'error_outdated_report_content') ?? false,
        errorTooManyReports: mapValueOfType<bool>(json, r'error_too_many_reports') ?? false,
      );
    }
    return null;
  }

  static List<UpdateReportResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateReportResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateReportResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateReportResult> mapFromJson(dynamic json) {
    final map = <String, UpdateReportResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateReportResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateReportResult-objects as value to a dart map
  static Map<String, List<UpdateReportResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateReportResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateReportResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

