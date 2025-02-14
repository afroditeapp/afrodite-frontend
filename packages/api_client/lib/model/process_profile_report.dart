//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProcessProfileReport {
  /// Returns a new [ProcessProfileReport] instance.
  ProcessProfileReport({
    required this.content,
    required this.creator,
    required this.target,
  });

  ProfileReportContent content;

  AccountId creator;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProcessProfileReport &&
    other.content == content &&
    other.creator == creator &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (creator.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'ProcessProfileReport[content=$content, creator=$creator, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
      json[r'creator'] = this.creator;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [ProcessProfileReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProcessProfileReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProcessProfileReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProcessProfileReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProcessProfileReport(
        content: ProfileReportContent.fromJson(json[r'content'])!,
        creator: AccountId.fromJson(json[r'creator'])!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<ProcessProfileReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProcessProfileReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProcessProfileReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProcessProfileReport> mapFromJson(dynamic json) {
    final map = <String, ProcessProfileReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProcessProfileReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProcessProfileReport-objects as value to a dart map
  static Map<String, List<ProcessProfileReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProcessProfileReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProcessProfileReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'creator',
    'target',
  };
}

