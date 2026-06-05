//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetReportQueuePage {
  /// Returns a new [GetReportQueuePage] instance.
  GetReportQueuePage({
    required this.queueType,
    this.wantedReportTypes = const [],
  });

  ReportQueueType queueType;

  /// Wanted report types. Empty list means all report types.
  List<ReportType> wantedReportTypes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetReportQueuePage &&
    other.queueType == queueType &&
    _deepEquality.equals(other.wantedReportTypes, wantedReportTypes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (queueType.hashCode) +
    (wantedReportTypes.hashCode);

  @override
  String toString() => 'GetReportQueuePage[queueType=$queueType, wantedReportTypes=$wantedReportTypes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'queue_type'] = this.queueType;
      json[r'wanted_report_types'] = this.wantedReportTypes;
    return json;
  }

  /// Returns a new [GetReportQueuePage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetReportQueuePage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetReportQueuePage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetReportQueuePage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetReportQueuePage(
        queueType: ReportQueueType.fromJson(json[r'queue_type'])!,
        wantedReportTypes: ReportType.listFromJson(json[r'wanted_report_types']),
      );
    }
    return null;
  }

  static List<GetReportQueuePage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetReportQueuePage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetReportQueuePage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetReportQueuePage> mapFromJson(dynamic json) {
    final map = <String, GetReportQueuePage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetReportQueuePage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetReportQueuePage-objects as value to a dart map
  static Map<String, List<GetReportQueuePage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetReportQueuePage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetReportQueuePage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'queue_type',
    'wanted_report_types',
  };
}

