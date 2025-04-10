//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProcessReport {
  /// Returns a new [ProcessReport] instance.
  ProcessReport({
    required this.content,
    required this.creator,
    required this.reportType,
    required this.target,
  });

  ReportContent content;

  AccountId creator;

  ReportTypeNumber reportType;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProcessReport &&
    other.content == content &&
    other.creator == creator &&
    other.reportType == reportType &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (creator.hashCode) +
    (reportType.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'ProcessReport[content=$content, creator=$creator, reportType=$reportType, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
      json[r'creator'] = this.creator;
      json[r'report_type'] = this.reportType;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [ProcessReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProcessReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProcessReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProcessReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProcessReport(
        content: ReportContent.fromJson(json[r'content'])!,
        creator: AccountId.fromJson(json[r'creator'])!,
        reportType: ReportTypeNumber.fromJson(json[r'report_type'])!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<ProcessReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProcessReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProcessReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProcessReport> mapFromJson(dynamic json) {
    final map = <String, ProcessReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProcessReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProcessReport-objects as value to a dart map
  static Map<String, List<ProcessReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProcessReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProcessReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'creator',
    'report_type',
    'target',
  };
}

